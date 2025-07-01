import pandas as pd
import numpy as np
from sqlalchemy import create_engine
from flask import Flask, request, jsonify

def get_consum_pattern_continuous(pattern_id, card_id, q_cutoff=0.8, min_matched=2):
    print("🚩 함수 시작")
    result = None

    # 1. 카테고리(순서 고정)
    arr_key2 = [
        '모든가맹점','모빌리티','대중교통','통신','생활','쇼핑',
        '외식/카페','뷰티/피트니스','금융/포인트','병원/약국','문화/취미','숙박/항공'
    ]
    N_CAT = len(arr_key2)

    # 2. 파케이 Q테이블(13차원: 소비비율12 + 총액1)
    DF_PARQUET = pd.read_parquet(
        "/Users/isanghyeon/Documents/workspace-sts-3.9.18.RELEASE/cardgarden/python/result/q_table_final.parquet"
    )

    # 3. DB에서 패턴/카테고리 정보
    engine = create_engine("mysql+pymysql://cardgarden:1234@localhost/cardgarden?charset=utf8mb4")
    sql_detail_patternid = f"""
        SELECT pattern_id, benefitcategory_id, amount 
        FROM UserConsumptionPatternDetail 
        WHERE pattern_id = {pattern_id}
    """
    sql_benefitCategoryid = "SELECT benefitcategory_id, benefitcategory_name FROM BenefitCategory"
    df_detail_patternid = pd.read_sql(sql_detail_patternid, engine)
    df_category = pd.read_sql(sql_benefitCategoryid, engine)
    engine.dispose()

    # 4. 카테고리명 <-> ID 매핑
    benefit_id_to_name = {
        row['benefitcategory_id']: row['benefitcategory_name']
        for idx, row in df_category.iterrows()
    }
    # 5. 카테고리별 소비금액 딕셔너리 (카테고리명 -> 금액)
    pattern_amt_dict = {
        benefit_id_to_name[row['benefitcategory_id']]: row['amount']
        for idx, row in df_detail_patternid.iterrows()
        if row['benefitcategory_id'] in benefit_id_to_name
    }
    # 6. 총 소비금액 계산
    total_amt = sum(pattern_amt_dict.get(cat, 0.0) for cat in arr_key2)
    # 7. 카테고리별 소비 비율
    if total_amt > 0:
        amount_list = [pattern_amt_dict.get(cat, 0.0) / total_amt for cat in arr_key2]
    else:
        amount_list = [0.0] * N_CAT

    # 8. 총액 feature (정규화 or 로그정규화)
    max_amt = 1000000  # 실데이터 최대 소비금액(1,000,000원 예시)
    # 로그 변환 추천: 분포 완화, 비대칭 방지
    total_amt_norm = np.log1p(total_amt) / np.log1p(max_amt)
    # total_amt_norm = min(total_amt / max_amt, 1.0)  # 단순 정규화

    # 9. feature_vector = [카테고리 비율 12] + [총액 정규화] = 13차원
    feature_vector = amount_list + [total_amt_norm]

    # 10. Q테이블 조회용 user_state 문자열 포맷 (자리수 반드시 일치!)
    amount_str = ",".join([f"{x:.3f}" for x in feature_vector])
    print("amount_str (feature_vector, 13차원):", amount_str)

    column_key = str(card_id)
    if column_key not in DF_PARQUET.columns:
        print(f"card_id {card_id} (as '{column_key}')가 Q테이블에 없습니다.")
        return None

    # 11. 카드 혜택 카테고리(benefitcategory_id set) 조회
    engine = create_engine("mysql+pymysql://cardgarden:1234@localhost/cardgarden?charset=utf8mb4")
    sql_card_benefit = f"""
        SELECT cbd.card_id, bc.benefitcategory_id
        FROM CardBenefitDetail cbd
        INNER JOIN BenefitDetail bd ON cbd.benefitdetail_id = bd.benefitdetail_id
        INNER JOIN BenefitCategory bc ON bd.benefitcategory_id = bc.benefitcategory_id
        WHERE cbd.card_id = {card_id}
    """
    benefitDetail = pd.read_sql(sql_card_benefit, engine)
    engine.dispose()
    card_benefit_cats = set(benefitDetail['benefitcategory_id'].values)

    # 12. 사용자 패턴에서 소비한 카테고리(benefitcategory_id set) 추출
    consumed_cats = set()
    for idx, ratio in enumerate(amount_list):
        if ratio > 0:
            cat_kor = arr_key2[idx]
            for row in df_category.itertuples():
                if row.benefitcategory_name == cat_kor:
                    consumed_cats.add(row.benefitcategory_id)

    # 13. 카드-소비패턴 혜택 교집합 개수
    matched_count = len(card_benefit_cats & consumed_cats)

    # 14. Q값 조회
    matches = DF_PARQUET[DF_PARQUET['user_state'] == amount_str]
    if not matches.empty:
        value = matches[column_key].values
        qval = float(value[0]) if len(value) > 0 else 0.0
    else:
        # fallback: 가장 가까운 user_state(13차원) Q값 사용
        DF_PARQUET['distance'] = DF_PARQUET['user_state'].apply(
            lambda s: sum(abs(float(a)-float(b)) for a, b in zip(s.split(','), amount_str.split(',')))
        )
        nearest_row = DF_PARQUET.loc[DF_PARQUET['distance'].idxmin()]
        qval = float(nearest_row[column_key]) if column_key in nearest_row else 0.0

    print(f"Q값: {qval}, 혜택 겹침 카테고리 수: {matched_count}")

    # 15. 추천 조건(적합도 Q값, 혜택 겹침 개수 기준)
    if qval >= q_cutoff and matched_count >= min_matched:
        print("✅ 추천 조건 만족")
        return {
            "q_value": qval,
            "matched_category_count": matched_count,
            "recommend": True
        }
    else:
        print("❌ 추천 조건 불만족")
        return {
            "q_value": qval,
            "matched_category_count": matched_count,
            "recommend": False
        }

# --- Flask API ---
app = Flask(__name__)

@app.route('/recommendDetail', methods=['GET'])
def recommendDetail():
    pattern_id = request.args.get('pattern_id')
    card_id = request.args.get('card_id')
    if not pattern_id or not card_id:
        return jsonify({'error': 'pattern_id와 card_id를 모두 입력해야 합니다.'}), 400

    pattern_id = int(pattern_id)
    card_id = int(card_id)

    result = get_consum_pattern_continuous(pattern_id, card_id)
    print("pattern", pattern_id, card_id)
    print("Flask 최종 반환값:", result)
    return jsonify(result)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5002, debug=True)
