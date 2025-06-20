import pandas as pd
import numpy as np
import pymysql
from sqlalchemy import create_engine
from sklearn.cluster import KMeans
from sklearn.ensemble import RandomForestClassifier
import json

def get_all_customer_vectors(engine, arr_key2, id_to_category):
    # 모든 고객 소비 데이터 DataFrame 반환 (index=고객ID, columns=arr_key2)
    sql_pattern = "SELECT pattern_id, user_id FROM UserConsumptionPattern"
    sql_detail = "SELECT pattern_id, benefitcategory_id, amount FROM UserConsumptionPatternDetail"
    df_pattern_all = pd.read_sql(sql_pattern, engine)
    df_detail = pd.read_sql(sql_detail, engine)
    df_detail["benefitcategory_name"] = df_detail["benefitcategory_id"].map(id_to_category)

    df_wide = pd.DataFrame(columns=["고객번호"] + arr_key2)
    for pid in df_detail["pattern_id"].unique():
        user_id = df_pattern_all[df_pattern_all["pattern_id"] == pid]["user_id"].values[0]
        subset = df_detail[df_detail["pattern_id"] == pid]
        arr1 = [user_id] + [0] * len(arr_key2)
        for _, row in subset.iterrows():
            bid = row["benefitcategory_id"]
            amt = row["amount"]
            if bid in id_to_category:
                cat_name = id_to_category[bid]
                idx = arr_key2.index(cat_name)
                arr1[idx + 1] += amt
        df_wide.loc[len(df_wide)] = arr1
    df_wide = df_wide.set_index("고객번호")
    return df_wide

def kmeans_representative_customers(df_customers, n_clusters=300):
    X = df_customers.values
    kmeans = KMeans(n_clusters=n_clusters, random_state=42)
    labels = kmeans.fit_predict(X)
    from scipy.spatial.distance import cdist
    centers = kmeans.cluster_centers_
    closest = cdist(centers, X).argmin(axis=1)
    sampled_customer_ids = df_customers.index[closest]
    sampled_customers = df_customers.loc[sampled_customer_ids]
    return sampled_customers

def get_card_benefit_df(arr_key2, conn):
    sql = """
    SELECT cbd.card_id, bc.benefitcategory_id
    FROM CardBenefitDetail cbd
        INNER JOIN BenefitDetail bd
            ON cbd.benefitdetail_id = bd.benefitdetail_id
        INNER JOIN BenefitCategory bc
            ON bd.benefitcategory_id = bc.benefitcategory_id;
    """
    with conn.cursor() as cursor:
        cursor.execute(sql)
        benefitDetail = cursor.fetchall()
        cardId_dic = list({row["card_id"] for row in benefitDetail})
    rows = []
    for card_id in cardId_dic:
        arr = [card_id] + [0] * len(arr_key2)
        for item in benefitDetail:
            if item["card_id"] == card_id:
                benefit_index = item["benefitcategory_id"]
                if 0 <= benefit_index < len(arr_key2):
                    arr[benefit_index] = 1
        rows.append(arr)
    df = pd.DataFrame(rows, columns=["카드번호"] + arr_key2)
    return df

def prepare_training_data(customers, card_list, threshold=20000):
    X_train, y_train = [], []
    arr_key2 = customers.columns.tolist()
    for idx, row in customers.iterrows():
        customer_vec = row.values.tolist()
        for card in card_list:
            card_vec = card['benefit_vec']
            feature = customer_vec + card_vec
            match = sum([c > threshold and v == 1 for c, v in zip(customer_vec, card_vec)])
            label = 1 if match >= 2 else 0
            X_train.append(feature)
            y_train.append(label)
    return np.array(X_train), np.array(y_train)

def main():
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('--db_json', type=str, required=True)
    parser.add_argument('--output_model', type=str, default='rf_model.pkl')
    args = parser.parse_args()
    db_config = json.loads(args.db_json)

    arr_key2 = ['모든가맹점','모빌리티','대중교통','통신','생활','쇼핑','외식/카페','뷰티/피트니스','금융/포인트','병원/약국','문화/취미','숙박/항공']
    category_id_map = {cat: i+1 for i, cat in enumerate(arr_key2)}
    id_to_category = {v: k for k, v in category_id_map.items()}

    engine = create_engine(f"mysql+pymysql://{db_config['user']}:{db_config['password']}@{db_config['host']}/{db_config['db1']}?charset=utf8mb4")
    conn = pymysql.connect(
        host=db_config['host'],
        user=db_config['user'],
        password=db_config['password'],
        db=db_config['db2'],
        charset='utf8mb4',
        cursorclass=pymysql.cursors.DictCursor
    )

    # 1. 전체 고객 데이터
    df_customers = get_all_customer_vectors(engine, arr_key2, id_to_category)
    print("고객 전체 shape:", df_customers.shape)

    # 2. KMeans로 대표 고객 300명
    rep_customers = kmeans_representative_customers(df_customers, n_clusters=300)
    print("대표 고객:", rep_customers.shape)

    # 3. 카드 데이터
    df_card = get_card_benefit_df(arr_key2, conn)
    card_numbers = df_card['카드번호']
    benefit_columns = df_card.columns[1:]
    benefit_lists = df_card[benefit_columns].values.tolist()
    card_list = []
    for i in range(len(card_numbers)):
        card_list.append({
            "card_name": card_numbers[i],
            "benefit_vec": benefit_lists[i]
        })

    # 4. 학습 데이터 생성
    X_train, y_train = prepare_training_data(rep_customers, card_list)
    print("학습 데이터:", X_train.shape, y_train.shape)

    # 5. RandomForest 학습
    clf = RandomForestClassifier(n_estimators=100, random_state=42)
    clf.fit(X_train, y_train)
    print("RandomForest 학습 완료!")

    # 6. 모델 저장 (joblib)
    import joblib
    joblib.dump(clf, args.output_model)
    print("모델 저장:", args.output_model)

    conn.close()
    engine.dispose()

if __name__ == '__main__':
    main()
