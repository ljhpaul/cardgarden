import pandas as pd
from sqlalchemy import create_engine
from flask import Flask, request, jsonify

def get_consum_pattern_continuous(pattern_id, card_id):
    print("🚩 함수 시작")
    result = None
    
    DF_PARQUET = pd.read_parquet("/Users/isanghyeon/Documents/workspace-sts-3.9.18.RELEASE/cardgarden/python/result/q_table_continuous1.parquet")

    engine = create_engine("mysql+pymysql://cardgarden:1234@localhost/cardgarden?charset=utf8mb4")
    sql_detail_patternid = f"SELECT pattern_id, benefitcategory_id, amount FROM UserConsumptionPatternDetail WHERE pattern_id = {pattern_id}"
    sql_benefitCategoryid = "SELECT * FROM BenefitCategory"
    df_detail_patternid = pd.read_sql(sql_detail_patternid, engine)
    df_category = pd.read_sql(sql_benefitCategoryid, engine)
    engine.dispose()

    max_amt = 500000  
    df_category_patternid = pd.merge(df_category, df_detail_patternid, on="benefitcategory_id", how="left")
    df_category_patternid = df_category_patternid[['benefitcategory_name', 'amount']]
    df_category_patternid['amount'] = df_category_patternid['amount'].fillna(0)
    df_category_patternid['amount'] = df_category_patternid['amount'].apply(lambda x: x / max_amt if max_amt != 0 else 0)

    category_count = len(DF_PARQUET.iloc[0]['user_state'].split(','))  # 예: 12
    amount_list = df_category_patternid['amount'].tolist()
    if len(amount_list) < category_count:
        amount_list += [0.0] * (category_count - len(amount_list))
    elif len(amount_list) > category_count:
        amount_list = amount_list[:category_count]

    def custom_round(x):
        return 0.0 if x <= 0.25 else 1.0

    amount_list = [custom_round(x) for x in amount_list]
    amount_str = ",".join([f"{x:.3f}" for x in amount_list])
    print("라운딩 후 amount_str:", amount_str)

    column_key = str(card_id)
    if column_key not in DF_PARQUET.columns:
        print(f"card_id {card_id} (as '{column_key}')가 컬럼에 없습니다.")
        return None  # 카드 ID가 Q테이블에 없으면 None 반환

    # 정확 매칭
    matches = DF_PARQUET[DF_PARQUET['user_state'] == amount_str]
    if not matches.empty:
        value = matches[column_key].values
        if len(value) > 0:
            result = float(value[0])
            print(f"정확 매칭 Q값: {result}")
            # Penalty Q zone이면 None 반환 (추천 제외)
            if result <= 0.05:
                print("⚠️ penalty zone(Q<=0.05)이므로 추천 제외")
                return None
            print("🚩 함수 마지막까지 실행")
            return result

    # fallback: 가장 가까운 user_state 행의 Q값 사용
    input_vec = [float(x) for x in amount_str.split(',')]
    DF_PARQUET['distance'] = DF_PARQUET['user_state'].apply(
        lambda s: sum(abs(float(a)-float(b)) for a, b in zip(s.split(','), amount_str.split(',')))
    )
    nearest_row = DF_PARQUET.loc[DF_PARQUET['distance'].idxmin()]
    if column_key in nearest_row:
        result = float(nearest_row[column_key])
        print(f"Fallback Q값(가장 가까운 행): {result}")
        if result <= 0.05:
            print("⚠️ penalty zone(Q<=0.05)이므로 추천 제외")
            return None
    else:
        print(f"card_id {card_id} (as '{column_key}')가 fallback에서도 없음.")
    print("🚩 함수 마지막까지 실행")
    return result


app = Flask(__name__)

@app.route('/recommendDetail', methods=['GET'])
def recommendDetail():
    pattern_id = request.args.get('pattern_id')
    card_id = request.args.get('card_id')
    if not pattern_id or not card_id:
        return jsonify({'error': 'pattern_id와 card_id를 모두 입력해야 합니다.'}), 400

    pattern_id = int(pattern_id)
    card_id = int(card_id)

    # get_consum_pattern_continuous에서 모든 print 처리!
    result = get_consum_pattern_continuous(pattern_id, card_id)
    print("pattern", pattern_id, card_id)
    print("Flask 최종 반환값:", result)

    return jsonify({'result': result})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5002, debug=False)
