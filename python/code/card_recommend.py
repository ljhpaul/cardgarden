import sys
import pandas as pd
from sqlalchemy import create_engine
import pymysql
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score
from sklearn.cluster import KMeans
from scipy.spatial.distance import cdist  # 이거 필요!
import numpy as np
import json
import collections

def get_recommend_result(pattern_id):
    arr_key2 = ['모든가맹점','모빌리티','대중교통','통신','생활','쇼핑','외식/카페','뷰티/피트니스','금융/포인트','병원/약국','문화/취미','숙박/항공']
    categories_small = arr_key2
    
    # DB 연결
    engine = create_engine("mysql+pymysql://cardgarden:1234@192.168.0.9/cardgarden?charset=utf8mb4")
    
    sql_pattern = "SELECT pattern_id, user_id FROM UserConsumptionPattern ORDER BY CREATED_AT DESC"
    sql_detail = "SELECT pattern_id, benefitcategory_id, amount FROM UserConsumptionPatternDetail"
    sql_detail_patternid = f"SELECT pattern_id, benefitcategory_id, amount FROM UserConsumptionPatternDetail WHERE pattern_id = {pattern_id}"
    sql_benefitCategoryid = "SELECT * FROM BenefitCategory"
    
    df_pattern_all = pd.read_sql(sql_pattern, engine)
    df_detail = pd.read_sql(sql_detail, engine)
    df_detail_patternid = pd.read_sql(sql_detail_patternid, engine)
    df_category = pd.read_sql(sql_benefitCategoryid, engine)
    engine.dispose()
    
    # 1. 소비패턴 wide pivot
    id_to_category = dict(zip(df_category['benefitcategory_id'], df_category['benefitcategory_name']))
    df_detail['benefitcategory_name'] = df_detail['benefitcategory_id'].map(id_to_category)
    df_detail_patternid['benefitcategory_name'] = df_detail_patternid['benefitcategory_id'].map(id_to_category)
    
    # 입력 고객 벡터
    customer = {k:0 for k in arr_key2}
    for _, row in df_detail_patternid.iterrows():
        if row['benefitcategory_name'] in customer:
            customer[row['benefitcategory_name']] = row['amount']

    # 전체 소비패턴 wide화
    df_wide = df_detail.pivot_table(index='pattern_id', columns='benefitcategory_name', values='amount', fill_value=0)
    # index를 user_id로 변경
    pid_to_uid = dict(zip(df_pattern_all['pattern_id'], df_pattern_all['user_id']))
    df_wide['고객번호'] = df_wide.index.map(pid_to_uid)
    df_wide = df_wide[['고객번호'] + arr_key2].fillna(0).reset_index(drop=True)
    
    df_wide_list = df_wide[arr_key2].values.tolist()
    
    # 2. 카드 벡터 로드 (여기서는 예시, 실제 카드 benefit 벡터 테이블에서 불러오기)
    # 아래는 임시 예시: "카드번호" 컬럼과 12 benefit 벡터가 있다고 가정
    # 실제로는 SQL에서 카드 벡터 테이블을 읽어와야 합니다
    # 예: SELECT * FROM CardBenefitVector; (카드번호 + arr_key2)
    # 여기선 랜덤 생성
    np.random.seed(42)
    num_cards = 100  # 카드 개수 (실제는 db에서 가져와야)
    card_numbers = np.arange(1001, 1001+num_cards)
    benefit_matrix = np.random.randint(0, 2, size=(num_cards, len(arr_key2)))  # 임의의 0/1 벡터
    df = pd.DataFrame(benefit_matrix, columns=arr_key2)
    df.insert(0, "카드번호", card_numbers)
    
    # 3. KMeans로 카드 클러스터링(유사 카드 대표 추출)
    K = 10
    benefit_vectors = df[arr_key2].values
    kmeans = KMeans(n_clusters=K, random_state=42)
    clusters = kmeans.fit_predict(benefit_vectors)
    clustered_card_ids = []
    for cluster_num in range(K):
        cluster_indices = np.where(clusters == cluster_num)[0]
        cluster_cards = df.iloc[cluster_indices]
        if len(cluster_cards) == 0:
            continue
        centroid = kmeans.cluster_centers_[cluster_num]
        dists = cdist(cluster_cards[arr_key2], [centroid])
        closest_idx = dists.argmin()
        card_id = cluster_cards.iloc[closest_idx]["카드번호"]
        clustered_card_ids.append(card_id)
    df_clustered = df[df["카드번호"].isin(clustered_card_ids)]
    
    # 4. 카드 + 고객 소비 패턴 조합으로 학습 데이터 생성
    card_list = []
    benefit_lists = df_clustered[arr_key2].values.tolist()
    card_numbers = df_clustered['카드번호'].values
    for i in range(len(card_numbers)):
        card_list.append({
            "card_name": card_numbers[i],
            "benefit_vec": benefit_lists[i]
        })
    # 5. 인위적 X_train/y_train (랜덤 샘플링)
    X_train = []
    y_train = []
    for card in card_list:
        for i in range(min(1500, len(df_wide_list))):  # 실제 샘플수 고려
            fake_customer = df_wide_list[i]
            card_vec = card['benefit_vec']
            features = fake_customer + card_vec
            X_train.append(features)
            match = sum([c > 20000 and v == 1 for c, v in zip(fake_customer, card_vec)])
            y_train.append(match)
    
    # 6. 실제 고객+카드 조합으로 예측 벡터 생성
    X_test = []
    for card in card_list:
        customer_vec = [customer[cat] for cat in categories_small]
        card_vec = card['benefit_vec']
        features = customer_vec + card_vec
        X_test.append(features)
    
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
    from collections import Counter
    print("y_train class 분포:", Counter(y_train))

    # acc 체크 (샘플)
    X_tr, X_te, y_tr, y_te = train_test_split(
        X_train, y_train, test_size=0.2, random_state=42
    )

    rf.fit(X_tr, y_tr)
    y_pred = rf.predict(X_te)
    acc = accuracy_score(y_te, y_pred)

    print("고객 소비패턴 샘플 수:", len(df_wide_list), file=sys.stderr)
    print("추천 카드 상위 10개 (카드번호, 적합도):", file=sys.stderr)
    for name, score in recommend[:10]:
        print(f"{name} {round(score, 4)}", file=sys.stderr)
    print("RandomForest Accuracy (for debug):", acc, file=sys.stderr)
    return result_list



from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/recommend', methods=['GET'])
def recommend():
    pattern_id = int(request.args.get('pattern_id', 1))
    result_list = get_recommend_result(pattern_id)
    return jsonify(result_list)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=True)