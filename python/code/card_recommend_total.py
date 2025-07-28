import sys
import pandas as pd
import numpy as np
from sqlalchemy import create_engine
from collections import Counter
from flask import Flask, request, jsonify
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score
from sklearn.cluster import KMeans
from scipy.spatial.distance import cdist
from sklearn.metrics.pairwise import cosine_similarity
import traceback
from flask_cors import CORS

# Softmax 함수
def softmax(x):
    x = np.array(x)
    e_x = np.exp(x - np.max(x))
    return e_x / e_x.sum()

# 카테고리 목록 (공통 사용)
arr_key2 = [
    '모든가맹점','모빌리티','대중교통','통신','생활','쇼핑',
    '외식/카페','뷰티/피트니스','금융/포인트','병원/약국','문화/취미','숙박/항공'
]
N_CAT = len(arr_key2)

# DB 연결
def get_engine():
    return create_engine("mysql+pymysql://cardgarden:1234@localhost/cardgarden?charset=utf8mb4")

# --- 추천 1 ---
def get_recommend_result(pattern_id):
    engine = get_engine()
    sql_user = "SELECT user_id, gender, birth FROM userInfo WHERE user_id > 1"
    sql_pattern = "SELECT pattern_id, user_id FROM UserConsumptionPattern WHERE user_id > 1 ORDER BY CREATED_AT DESC"
    sql_detail = "SELECT pattern_id, benefitcategory_id, amount FROM UserConsumptionPatternDetail"
    sql_detail_patternid = f"SELECT pattern_id, benefitcategory_id, amount FROM UserConsumptionPatternDetail WHERE pattern_id = {pattern_id}"
    sql_benefitCategoryid = "SELECT * FROM BenefitCategory"
    sql_card_detail = """
        SELECT cbd.card_id, bc.benefitcategory_id
        FROM CardBenefitDetail cbd
        INNER JOIN BenefitDetail bd ON cbd.benefitdetail_id = bd.benefitdetail_id
        INNER JOIN BenefitCategory bc ON bd.benefitcategory_id = bc.benefitcategory_id
        INNER JOIN Card c ON c.card_id = cbd.card_id
    """
    df_user = pd.read_sql(sql_user, engine)
    df_pattern_all = pd.read_sql(sql_pattern, engine)
    df_detail = pd.read_sql(sql_detail, engine)
    df_detail_patternid = pd.read_sql(sql_detail_patternid, engine)
    df_category = pd.read_sql(sql_benefitCategoryid, engine)
    df_card_detail = pd.read_sql(sql_card_detail, engine)
    engine.dispose()
    id_to_category = dict(zip(df_category['benefitcategory_id'], df_category['benefitcategory_name']))

    # 성별/연령대 인코딩
    df_user['gender'] = df_user['gender'].astype(str)
    df_user['birth'] = pd.to_datetime(df_user['birth'])
    today = pd.Timestamp("today")
    df_user['age'] = (today.year - df_user['birth'].dt.year) + 1
    bins = [0, 19, 29, 39, 49, 59, 150]
    labels = ['10대이하', '20대', '30대', '40대', '50대', '60대이상']
    df_user['age_group'] = pd.cut(df_user['age'], bins=bins, labels=labels, right=True)
    df_user = pd.get_dummies(df_user, columns=['gender', 'age_group'])
    # 사용자 추출
    pattern_user_id = df_pattern_all[df_pattern_all['pattern_id'] == pattern_id]['user_id'].values[0]
    user_vector = df_user[df_user['user_id'] == pattern_user_id]
    gender_cols = [col for col in df_user.columns if col.startswith('gender_')]
    age_cols = [col for col in df_user.columns if col.startswith('age_group_')]
    if user_vector.empty:
        user_vec = [0]*(len(gender_cols)+len(age_cols))
    else:
        user_vec = user_vector[gender_cols + age_cols].values[0].tolist()
    # 소비 패턴 벡터
    customer = {k: 0 for k in arr_key2}
    df_detail_patternid['benefitcategory_name'] = df_detail_patternid['benefitcategory_id'].map(id_to_category)
    for _, row in df_detail_patternid.iterrows():
        if row['benefitcategory_name'] in customer:
            customer[row['benefitcategory_name']] = row['amount']
    # wide화 및 정규화
    df_detail['benefitcategory_name'] = df_detail['benefitcategory_id'].map(id_to_category)
    df_wide = df_detail.pivot_table(index='pattern_id', columns='benefitcategory_name', values='amount', fill_value=0)
    pid_to_uid = dict(zip(df_pattern_all['pattern_id'], df_pattern_all['user_id']))
    df_wide['user_id'] = df_wide.index.map(pid_to_uid)
    df_wide = df_wide[['user_id'] + arr_key2].fillna(0).reset_index(drop=True)
    max_amt = np.max(df_wide[arr_key2].values)
    df_wide_norm = df_wide.copy()
    for cat in arr_key2:
        df_wide_norm[cat] = df_wide[cat] / max_amt
    df_wide_list = df_wide[arr_key2].values.tolist()
    df_wide_list_norm = df_wide_norm[arr_key2].values.tolist()
    # 카드 벡터
    card_ids = df_card_detail["card_id"].unique()
    rows = []
    for card_id in card_ids:
        arr = [card_id] + [0] * len(arr_key2)
        for _, item in df_card_detail[df_card_detail["card_id"] == card_id].iterrows():
            benefit_id = item["benefitcategory_id"]
            if benefit_id in id_to_category:
                cat_name = id_to_category[benefit_id]
                if cat_name in arr_key2:
                    idx = arr_key2.index(cat_name)
                    arr[idx + 1] = 1
        rows.append(arr)
    df = pd.DataFrame(rows, columns=["카드번호"] + arr_key2)
    # KMeans 클러스터링
    K = 12
    benefit_vectors = df[arr_key2].values
    kmeans = KMeans(n_clusters=K, random_state=42)
    clusters = kmeans.fit_predict(benefit_vectors)
    customer_vec = np.array([customer[cat] for cat in arr_key2])
    distances = cdist([customer_vec], kmeans.cluster_centers_)
    closest_cluster = distances.argmin()
    cluster_indices = np.where(clusters == closest_cluster)[0]
    target_cards = df.iloc[cluster_indices]
    card_list = []
    benefit_lists = target_cards[arr_key2].values.tolist()
    card_numbers = target_cards['카드번호'].values
    for i in range(len(card_numbers)):
        card_list.append({
            "card_name": card_numbers[i],
            "benefit_vec": benefit_lists[i]
        })
    # 훈련 데이터 생성 (소비+성별+연령)
    X_train = []
    y_train = []
    for card in card_list:
        for i in range(min(1500, len(df_wide_list_norm))):
            fake_customer = df_wide_list[i]
            card_vec = card['benefit_vec']
            fake_user_id = df_wide.iloc[i]['user_id']
            fake_user = df_user[df_user['user_id'] == fake_user_id]
            if not fake_user.empty:
                fake_user_vec = fake_user[gender_cols + age_cols].values[0].tolist()
            else:
                fake_user_vec = [0]*(len(gender_cols)+len(age_cols))
            features = fake_customer + fake_user_vec + card_vec
            match = sum([c > 5000 and v == 1 for c, v in zip(fake_customer, card_vec)])
            if match > 4:
                match = 4
            y_train.append(match)
            X_train.append(features)
    # 테스트 데이터 생성 (실제고객)
    X_test = []
    for card in card_list:
        customer_vec_norm = [customer[cat]/max_amt for cat in arr_key2]
        features = customer_vec_norm + user_vec + card['benefit_vec']
        X_test.append(features)
    # 모델 훈련 및 예측
    rf = RandomForestClassifier(n_estimators=100, random_state=42)
    rf.fit(X_train, y_train)
    probs = rf.predict_proba(X_test)[:, 1]
    expected_matches = [np.dot(prob, np.arange(rf.n_classes_)) for prob in rf.predict_proba(X_test)]
    recommend = sorted(
        zip([card['card_name'] for card in card_list], expected_matches),
        key=lambda x: x[1], reverse=True
    )
    result_list = [
        {"card_id": int(name), "expected_match": float(f"{score:.2f}")}
        for name, score in recommend[:10]
    ]
    top10_scores = [score for _, score in recommend[:10]]
    top10_softmax_scores = softmax(top10_scores)
    for i, rec in enumerate(result_list):
        rec["softmax_expected_match"] = float(f"{top10_softmax_scores[i]:.2f}")
    return result_list

# --- 추천 2 (코사인 유사도) ---
def load_card_vec_data():
    engine = get_engine()
    sql_card = "SELECT * FROM Card"
    sql_detail = "SELECT * FROM CardBenefitDetail"
    sql_benefitdetail = "SELECT * FROM BenefitDetail"
    sql_benefitcategory = "SELECT * FROM BenefitCategory"
    df_card = pd.read_sql(sql_card, engine)
    df_card_benefit_detail = pd.read_sql(sql_detail, engine)
    df_benefit_detail = pd.read_sql(sql_benefitdetail, engine)
    df_benefit_category = pd.read_sql(sql_benefitcategory, engine)
    engine.dispose()
    return df_card, df_card_benefit_detail, df_benefit_detail, df_benefit_category

def make_card_vec():
    df_card, df_card_benefit_detail, df_benefit_detail, df_benefit_category = load_card_vec_data()
    benefitDetail = pd.merge(df_card_benefit_detail, df_benefit_detail, on='benefitdetail_id')
    benefitDetail = pd.merge(benefitDetail, df_benefit_category, on='benefitcategory_id')
    cardId_dic = benefitDetail['card_id'].unique()
    rows = []
    for cid in cardId_dic:
        arr = [cid] + [0] * len(arr_key2)
        for _, item in benefitDetail[benefitDetail['card_id'] == cid].iterrows():
            benefit_index = item["benefitcategory_id"] - 1
            if 0 <= benefit_index < len(arr_key2):
                arr[benefit_index + 1] = 1
        rows.append(arr)
    df_card_vec = pd.DataFrame(rows, columns=["card_id"] + arr_key2)
    return df_card_vec

df_card_vec = make_card_vec()

def find_cosine_card5(card_id):
    X = df_card_vec[arr_key2].values
    sim_matrix = cosine_similarity(X)
    card_idx = df_card_vec[df_card_vec['card_id'] == card_id].index[0]
    target_vec = X[card_idx].reshape(1, -1)
    sim_scores = cosine_similarity(target_vec, X).flatten()
    top_n = 10
    similar_card_indices = sim_scores.argsort()[::-1][1:top_n+1]
    similar_card_ids = df_card_vec.iloc[similar_card_indices]['card_id'].tolist()
    similarities = sim_scores[similar_card_indices].tolist()
    return [{"card_id": cid, "similarity": sim} for cid, sim in zip(similar_card_ids, similarities)]

# --- 추천 3 (Q Table 방식) ---
def get_consum_pattern_continuous(pattern_id, card_id, q_cutoff=0.75, min_matched=2):
    result = None
    # Q Table 불러오기 (parquet 경로 실제 서버 경로로 수정 필요!)
    DF_PARQUET = pd.read_parquet(
        "/Users/isanghyeon/Documents/workspace-sts-3.9.18.RELEASE/cardgarden/python/result/q_table_final.parquet"
    )
    # DB에서 패턴/카테고리 정보
    engine = get_engine()
    sql_detail_patternid = f"""
        SELECT pattern_id, benefitcategory_id, amount 
        FROM UserConsumptionPatternDetail 
        WHERE pattern_id = {pattern_id}
    """
    sql_benefitCategoryid = "SELECT benefitcategory_id, benefitcategory_name FROM BenefitCategory"
    df_detail_patternid = pd.read_sql(sql_detail_patternid, engine)
    df_category = pd.read_sql(sql_benefitCategoryid, engine)
    engine.dispose()
    benefit_id_to_name = {
        row['benefitcategory_id']: row['benefitcategory_name']
        for idx, row in df_category.iterrows()
    }
    pattern_amt_dict = {
        benefit_id_to_name[row['benefitcategory_id']]: row['amount']
        for idx, row in df_detail_patternid.iterrows()
        if row['benefitcategory_id'] in benefit_id_to_name
    }
    total_amt = sum(pattern_amt_dict.get(cat, 0.0) for cat in arr_key2)
    if total_amt > 0:
        amount_list = [pattern_amt_dict.get(cat, 0.0) / total_amt for cat in arr_key2]
    else:
        amount_list = [0.0] * N_CAT
    max_amt = 1000000
    total_amt_norm = np.log1p(total_amt) / np.log1p(max_amt)
    feature_vector = amount_list + [total_amt_norm]
    amount_str = ",".join([f"{x:.3f}" for x in feature_vector])
    column_key = str(card_id)
    if column_key not in DF_PARQUET.columns:
        return None
    # 카드 혜택 카테고리(benefitcategory_id set) 조회
    engine = get_engine()
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
    consumed_cats = set()
    for idx, ratio in enumerate(amount_list):
        if ratio > 0:
            cat_kor = arr_key2[idx]
            for row in df_category.itertuples():
                if row.benefitcategory_name == cat_kor:
                    consumed_cats.add(row.benefitcategory_id)
    matched_count = len(card_benefit_cats & consumed_cats)
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
    # 추천 조건
    if qval >= q_cutoff and matched_count >= min_matched:
        return {
            "q_value": qval,
            "matched_category_count": matched_count,
            "recommend": True
        }
    else:
        return {
            "q_value": qval,
            "matched_category_count": matched_count,
            "recommend": False
        }


app = Flask(__name__)
CORS(app)

@app.route('/recommend', methods=['GET'])
def recommend_route():
    try:
        pattern_id = int(request.args.get('pattern_id', 1))
        result_list = get_recommend_result(pattern_id)
        return jsonify(result_list)
    except Exception as e:
        print("에러 발생:", e)
        traceback.print_exc()
        return jsonify({"error": str(e)}), 500

@app.route('/recommendCosine', methods=['GET'])
def recommend_cosine_route():
    try:
        card_id = int(request.args.get('card_id', 1))
        result_list = find_cosine_card5(card_id)
        return jsonify(result_list)
    except Exception as e:
        print("에러 발생:", e)
        traceback.print_exc()
        return jsonify({"error": str(e)}), 500

@app.route('/recommendDetail', methods=['GET'])
def recommend_detail_route():
    pattern_id = request.args.get('pattern_id')
    card_id = request.args.get('card_id')
    if not pattern_id or not card_id:
        return jsonify({'error': 'pattern_id와 card_id를 모두 입력해야 합니다.'}), 400
    pattern_id = int(pattern_id)
    card_id = int(card_id)
    result = get_consum_pattern_continuous(pattern_id, card_id)
    return jsonify(result)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5004, debug=True)
