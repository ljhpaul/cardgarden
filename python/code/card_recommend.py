# 필수 패키지 정리
import sys
import pandas as pd
from sqlalchemy import create_engine
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score
from sklearn.cluster import KMeans
from scipy.spatial.distance import cdist
import numpy as np
from collections import Counter
# 결과 안정을 위한 softmax 함수 구현 추천의 강도 표현
def softmax(x):
    x = np.array(x)
    e_x = np.exp(x - np.max(x))
    return e_x / e_x.sum()
# 가공 시작
def get_recommend_result(pattern_id):
    # 카테고리 설정 해당 부분은 Table이 구현 됐다면 그 과정을 통해 진행
    arr_key2 = ['모든가맹점','모빌리티','대중교통','통신','생활','쇼핑','외식/카페','뷰티/피트니스','금융/포인트','병원/약국','문화/취미','숙박/항공']

    # DB 연결 및 데이터 로딩
    engine = create_engine("mysql+pymysql://cardgarden:1234@localhost/cardgarden?charset=utf8mb4")

    sql_user = "SELECT user_id, gender, birth FROM userInfo WHERE user_id > 1"
    sql_pattern = "SELECT pattern_id, user_id FROM UserConsumptionPattern WHERE user_id > 1 ORDER BY CREATED_AT DESC"
    sql_detail = "SELECT pattern_id, benefitcategory_id, amount FROM UserConsumptionPatternDetail"
    sql_detail_patternid = f"SELECT pattern_id, benefitcategory_id, amount FROM UserConsumptionPatternDetail WHERE pattern_id = {pattern_id}"
    sql_benefitCategoryid = "SELECT * FROM BenefitCategory"
    # DB에서 얻어온 값을 DataFrame 형태로 저장
    df_user = pd.read_sql(sql_user, engine)
    df_pattern_all = pd.read_sql(sql_pattern, engine)
    df_detail = pd.read_sql(sql_detail, engine)
    df_detail_patternid = pd.read_sql(sql_detail_patternid, engine)
    df_category = pd.read_sql(sql_benefitCategoryid, engine)

    sql_card_detail = """
        SELECT cbd.card_id, bc.benefitcategory_id
        FROM CardBenefitDetail cbd
        INNER JOIN BenefitDetail bd ON cbd.benefitdetail_id = bd.benefitdetail_id
        INNER JOIN BenefitCategory bc ON bd.benefitcategory_id = bc.benefitcategory_id
        INNER JOIN Card c ON c.card_id = cbd.card_id
    """
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
    
    # 사용자의 pattern_id에 해당하는 user_id 추출
    pattern_user_id = df_pattern_all[df_pattern_all['pattern_id'] == pattern_id]['user_id'].values[0]
    # 해당 사용자의 성별/연령 원핫벡터 추출
    user_vector = df_user[df_user['user_id'] == pattern_user_id]
    if user_vector.empty:
        # 예외 처리: user_vector 없을 때 0 벡터 생성
        gender_cols = [col for col in df_user.columns if col.startswith('gender_')]
        age_cols = [col for col in df_user.columns if col.startswith('age_group_')]
        user_vec = [0]*(len(gender_cols)+len(age_cols))
    else:
        gender_cols = [col for col in df_user.columns if col.startswith('gender_')]
        age_cols = [col for col in df_user.columns if col.startswith('age_group_')]
        user_vec = user_vector[gender_cols + age_cols].values[0].tolist()
    
    # 고객 소비 패턴 벡터 생성
    customer = {k: 0 for k in arr_key2}
    df_detail_patternid['benefitcategory_name'] = df_detail_patternid['benefitcategory_id'].map(id_to_category)
    for _, row in df_detail_patternid.iterrows():
        if row['benefitcategory_name'] in customer:
            customer[row['benefitcategory_name']] = row['amount']

    # 전체 wide화 및 정규화
    df_detail['benefitcategory_name'] = df_detail['benefitcategory_id'].map(id_to_category)
    df_wide = df_detail.pivot_table(index='pattern_id', columns='benefitcategory_name', values='amount', fill_value=0)
    pid_to_uid = dict(zip(df_pattern_all['pattern_id'], df_pattern_all['user_id']))
    df_wide['user_id'] = df_wide.index.map(pid_to_uid)
    df_wide = df_wide[['user_id'] + arr_key2].fillna(0).reset_index(drop=True)
    max_amt = np.max(df_wide[arr_key2].values)
    mean_amt = np.mean(df_wide[arr_key2].values)
    df_wide_norm = df_wide.copy()
    for cat in arr_key2:
        df_wide_norm[cat] = df_wide[cat] / max_amt
    df_wide_list = df_wide[arr_key2].values.tolist()
    df_wide_list_norm = df_wide_norm[arr_key2].values.tolist()

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
    df = pd.DataFrame(rows, columns=["카드번호"] + arr_key2)

    # KMeans 클러스터링을 통해 비슷한 혜택을 가진 값들로 군집화를 진행
    # 해당 과정을 통해 결과 도출 시간 조절 진행
    # 원래 실루엣 계수 혹은 엘보우 기법을 통해 설정 예정이었음
    K = 10
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
        customer_vec_norm = [customer[cat]/max_amt for cat in arr_key2]   # 소비 패턴 정규화
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
    print("y_train class 분포:", Counter(y_train))
    

    X_tr, X_te, y_tr, y_te = train_test_split(X_train, y_train, test_size=0.2, random_state=42)
    rf.fit(X_tr, y_tr)
    y_pred = rf.predict(X_te)
    acc = accuracy_score(y_te, y_pred)
    for name, score in recommend[:10]:
        print(f"{name} {round(score, 4)}", file=sys.stderr)
    

    return result_list


from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/recommend', methods=['GET'])
def recommend():
    try:
        pattern_id = int(request.args.get('pattern_id', 1))
        result_list = get_recommend_result(pattern_id)
        return jsonify(result_list)
    except Exception as e:
        import traceback
        print("에러 발생:", e)
        traceback.print_exc()
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=True) 