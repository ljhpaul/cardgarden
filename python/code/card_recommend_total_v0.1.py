import sys
import pandas as pd
import numpy as np
from sqlalchemy import create_engine
from flask import Flask, request, jsonify
from flask_cors import CORS
from sklearn.ensemble import RandomForestClassifier
from sklearn.cluster import KMeans
from scipy.spatial.distance import cdist
from sklearn.metrics.pairwise import cosine_similarity
import traceback
import time

# --- 설정 ---
arr_key2 = [
    '모든가맹점','모빌리티','대중교통','통신','생활','쇼핑',
    '외식/카페','뷰티/피트니스','금융/포인트','병원/약국','문화/취미','숙박/항공'
]
N_CAT = len(arr_key2)

# --- 전역 캐시 변수 ---
cached_data = {}
rf_model = None
kmeans_model = None

# --- DB 연결 ---
def get_engine():
    return create_engine("mysql+pymysql://cardgarden:1234@db/cardgarden?charset=utf8mb4")

# --- 초기 데이터 및 모델 로딩 ---
def load_all_data_and_models():
    global cached_data, rf_model, kmeans_model
    engine = get_engine()

    df_user = pd.read_sql("SELECT user_id, gender, birth FROM UserInfo WHERE user_id > 1", engine)
    df_pattern_all = pd.read_sql("SELECT pattern_id, user_id FROM UserConsumptionPattern WHERE user_id > 1 ORDER BY CREATED_AT DESC", engine)
    df_detail = pd.read_sql("SELECT pattern_id, benefitcategory_id, amount FROM UserConsumptionPatternDetail", engine)
    df_category = pd.read_sql("SELECT * FROM BenefitCategory", engine)
    df_card_detail = pd.read_sql("""
        SELECT cbd.card_id, bc.benefitcategory_id
        FROM CardBenefitDetail cbd
        INNER JOIN BenefitDetail bd ON cbd.benefitdetail_id = bd.benefitdetail_id
        INNER JOIN BenefitCategory bc ON bd.benefitcategory_id = bc.benefitcategory_id
        INNER JOIN Card c ON c.card_id = cbd.card_id
    """, engine)
    engine.dispose()

    id_to_category = dict(zip(df_category['benefitcategory_id'], df_category['benefitcategory_name']))

    # 사용자 전처리
    df_user['gender'] = df_user['gender'].astype(str)
    df_user['birth'] = pd.to_datetime(df_user['birth'])
    today = pd.Timestamp("today")
    df_user['age'] = (today.year - df_user['birth'].dt.year) + 1
    bins = [0, 19, 29, 39, 49, 59, 150]
    labels = ['10대이하', '20대', '30대', '40대', '50대', '60대이상']
    df_user['age_group'] = pd.cut(df_user['age'], bins=bins, labels=labels, right=True)
    df_user = pd.get_dummies(df_user, columns=['gender', 'age_group'])

    # 카드 벡터 생성
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
    df_card_vec = pd.DataFrame(rows, columns=["card_id"] + arr_key2)

    # 소비 데이터 정리
    df_detail['benefitcategory_name'] = df_detail['benefitcategory_id'].map(id_to_category)
    df_wide = df_detail.pivot_table(index='pattern_id', columns='benefitcategory_name', values='amount', fill_value=0)
    pid_to_uid = dict(zip(df_pattern_all['pattern_id'], df_pattern_all['user_id']))
    df_wide['user_id'] = df_wide.index.map(pid_to_uid)
    df_wide = df_wide[['user_id'] + arr_key2].fillna(0).reset_index(drop=True)

    max_amt = np.max(df_wide[arr_key2].values)
    df_wide_norm = df_wide.copy()
    for cat in arr_key2:
        df_wide_norm[cat] = df_wide[cat] / max_amt

    # KMeans 클러스터링
    benefit_vectors = df_card_vec[arr_key2].values
    kmeans_model = KMeans(n_clusters=18, random_state=42)
    kmeans_model.fit(benefit_vectors)

    # RandomForest 모델 학습
    X_train = []
    y_train = []
    gender_cols = [col for col in df_user.columns if col.startswith('gender_')]
    age_cols = [col for col in df_user.columns if col.startswith('age_group_')]
    for i in range(min(1500, len(df_wide_norm))):
        fake_customer = df_wide[arr_key2].values[i].tolist()
        fake_user_id = df_wide.iloc[i]['user_id']
        fake_user = df_user[df_user['user_id'] == fake_user_id]
        fake_user_vec = fake_user[gender_cols + age_cols].values[0].tolist() if not fake_user.empty else [0]*(len(gender_cols)+len(age_cols))
        for _, row in df_card_vec.iterrows():
            card_vec = row[arr_key2].tolist()
            features = fake_customer + fake_user_vec + card_vec
            match = sum([c > 5000 and v == 1 for c, v in zip(fake_customer, card_vec)])
            y_train.append(min(match, 4))
            X_train.append(features)

    rf_model = RandomForestClassifier(n_estimators=100, random_state=42)
    rf_model.fit(X_train, y_train)

    # 캐시 저장
    cached_data = {
        "df_user": df_user,
        "df_pattern_all": df_pattern_all,
        "df_detail": df_detail,
        "df_category": df_category,
        "df_card_vec": df_card_vec,
        "df_wide": df_wide,
        "df_wide_norm": df_wide_norm,
        "max_amt": max_amt,
        "id_to_category": id_to_category,
        "gender_cols": gender_cols,
        "age_cols": age_cols
    }

# --- 추천 함수 ---
def get_recommend_result(pattern_id):
    df_user = cached_data['df_user']
    df_pattern_all = cached_data['df_pattern_all']
    df_detail = cached_data['df_detail']
    df_category = cached_data['df_category']
    df_card_vec = cached_data['df_card_vec']
    df_wide = cached_data['df_wide']
    df_wide_norm = cached_data['df_wide_norm']
    max_amt = cached_data['max_amt']
    id_to_category = cached_data['id_to_category']
    gender_cols = cached_data['gender_cols']
    age_cols = cached_data['age_cols']

    pattern_user_id = df_pattern_all[df_pattern_all['pattern_id'] == pattern_id]['user_id'].values[0]
    user_vector = df_user[df_user['user_id'] == pattern_user_id]
    user_vec = user_vector[gender_cols + age_cols].values[0].tolist() if not user_vector.empty else [0]*(len(gender_cols)+len(age_cols))

    customer = {k: 0 for k in arr_key2}
    pattern_detail = df_detail[df_detail['pattern_id'] == pattern_id]
    pattern_detail['benefitcategory_name'] = pattern_detail['benefitcategory_id'].map(id_to_category)
    for _, row in pattern_detail.iterrows():
        if row['benefitcategory_name'] in customer:
            customer[row['benefitcategory_name']] = row['amount']

    customer_vec = np.array([customer[cat] for cat in arr_key2])
    distances = cdist([customer_vec], kmeans_model.cluster_centers_)
    closest_cluster = distances.argmin()
    benefit_vectors = df_card_vec[arr_key2].values
    clusters = kmeans_model.predict(benefit_vectors)
    target_cards = df_card_vec[clusters == closest_cluster]

    card_list = []
    for _, row in target_cards.iterrows():
        card_list.append({
            "card_name": row['card_id'],
            "benefit_vec": row[arr_key2].tolist()
        })

    X_test = []
    for card in card_list:
        customer_vec_norm = [customer[cat]/max_amt for cat in arr_key2]
        features = customer_vec_norm + user_vec + card['benefit_vec']
        X_test.append(features)

    probs = rf_model.predict_proba(X_test)
    expected_matches = [np.dot(prob, np.arange(rf_model.n_classes_)) for prob in probs]
    result = sorted(zip([card['card_name'] for card in card_list], expected_matches), key=lambda x: x[1], reverse=True)

    def softmax(x):
        x = np.array(x)
        e_x = np.exp(x - np.max(x))
        return e_x / e_x.sum()

    top10 = result[:10]
    top10_scores = [score for _, score in top10]
    top10_softmax = softmax(top10_scores)
    result_list = [
        {"card_id": int(cid), "expected_match": float(f"{score:.2f}"), "softmax_expected_match": float(f"{top10_softmax[i]:.2f}")}
        for i, (cid, score) in enumerate(top10)
    ]
    return result_list

# --- Flask 앱 구성 ---
app = Flask(__name__)
CORS(app)
load_all_data_and_models()

@app.route('/recommend', methods=['GET'])
def recommend_route():
    try:
        pattern_id = int(request.args.get('pattern_id', 1))
        start = time.time()
        result = get_recommend_result(pattern_id)
        print(f"처리 시간: {time.time() - start:.2f}초")
        return jsonify(result)
    except Exception as e:
        print("에러 발생:", e)
        traceback.print_exc()
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5004, debug=True)