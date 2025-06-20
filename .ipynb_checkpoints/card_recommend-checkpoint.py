import sys
import pandas as pd
from sqlalchemy import create_engine
import pymysql
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score
import numpy as np
import json
import collections


def get_recommend_result(pattern_id):
    arr_key2 = ['모든가맹점','모빌리티','대중교통','통신','생활','쇼핑','외식/카페','뷰티/피트니스','금융/포인트','병원/약국','문화/취미','숙박/항공']
    categories_small = arr_key2
    
    # DB 연결
    engine = create_engine("mysql+pymysql://cardgarden:1234@192.168.0.13/cardgarden?charset=utf8mb4")
    
    sql_pattern = "SELECT pattern_id, user_id FROM UserConsumptionPattern ORDER BY CREATED_AT DESC"
    sql_detail = "SELECT pattern_id, benefitcategory_id, amount FROM UserConsumptionPatternDetail"
    sql_detail_patternid = f"SELECT pattern_id, benefitcategory_id, amount FROM UserConsumptionPatternDetail where pattern_id = {pattern_id}"
    sql_benefitCategoryid = "SELECT * FROM BenefitCategory"
    
    df_pattern_all = pd.read_sql(sql_pattern, engine)
    df_detail = pd.read_sql(sql_detail, engine)
    df_detail_patternid = pd.read_sql(sql_detail_patternid, engine)
    df_category = pd.read_sql(sql_benefitCategoryid, engine)
    engine.dispose()
    
    df_detail = pd.merge(df_detail, df_category, on="benefitcategory_id", how="left")
    df_detail_patternid = pd.merge(df_detail_patternid, df_category, on="benefitcategory_id", how="left")
    
    customer = {}
    for i in range(len(df_detail_patternid)):
        customer[df_detail_patternid['benefitcategory_name'][i]] = df_detail_patternid['amount'][i]
    
    for i in categories_small:
        if i not in customer:
            customer[i] = 0
    
    df_wide = pd.DataFrame(columns=["고객번호"] + arr_key2)
    id_to_category = dict(zip(df_category['benefitcategory_id'], df_category['benefitcategory_name']))
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
    
    df_wide_list = df_wide[arr_key2].values.tolist()
    
    conn = pymysql.connect(
        host='192.168.0.13',
        user='cardgarden',
        password='1234',
        db='cardgarden',
        charset='utf8mb4',
        cursorclass=pymysql.cursors.DictCursor
    )
    
    try:
        with conn.cursor() as cursor:
            sql = """
            SELECT
                cbd.card_id,
                bc.benefitcategory_id
            FROM
                CardBenefitDetail cbd
            INNER JOIN BenefitDetail bd
                            ON
                cbd.benefitdetail_id = bd.benefitdetail_id
            INNER JOIN BenefitCategory bc
                            ON
                bd.benefitcategory_id = bc.benefitcategory_id
            INNER JOIN Card c
                            ON 
                c.card_id = cbd.card_id
            where
                c.card_like > 20
            """
            cursor.execute(sql)
            benefitDetail = cursor.fetchall()
            cardId_dic = list({row["card_id"] for row in benefitDetail})
    finally:
        conn.close()
    
    df = pd.DataFrame(columns=["카드번호"] + arr_key2)
    rows = []
    for card_id in cardId_dic:
        arr = [card_id] + [0] * len(arr_key2)
        for item in benefitDetail:
            if item["card_id"] == card_id:
                benefit_id = item["benefitcategory_id"]
                if benefit_id in id_to_category:
                    cat_name = id_to_category[benefit_id]
                    if cat_name in arr_key2:
                        idx = arr_key2.index(cat_name)
                        arr[idx + 1] = 1
        rows.append(arr)
    
    df = pd.DataFrame(rows, columns=["카드번호"] + arr_key2)
    
    card_list = []
    card_numbers = df['카드번호']
    benefit_columns = df.columns[1:]
    benefit_lists = df[benefit_columns].values.tolist()
    for i in range(len(card_numbers)):
        card_list.append({
            "card_name": card_numbers[i],
            "benefit_vec": benefit_lists[i]
        })
    
    X_train = []
    y_train = []
    for card in card_list:
        for i in range(1500): 
            fake_customer = df_wide_list[i]
            card_vec = card['benefit_vec']
            features = fake_customer + card_vec
            X_train.append(features)
            match = sum([c > 20000 and v == 1 for c, v in zip(fake_customer, card_vec)])
            y_train.append(match)
    
    X_test = []
    for card in card_list:
        customer_vec = [customer[cat] for cat in categories_small]
        card_vec = card['benefit_vec']
        features = customer_vec + card_vec
        X_test.append(features)
    
    rf = RandomForestClassifier(n_estimators=100, random_state=42)
    rf.fit(X_train, y_train)
    probs = rf.predict_proba(X_test)[:, 1]
    
    # JSON 결과용 recommend만 남김
    expected_matches = [np.dot(prob, np.arange(rf.n_classes_)) for prob in rf.predict_proba(X_test)]
    recommend = sorted(
        zip([card['card_name'] for card in card_list], expected_matches),
        key=lambda x: x[1], reverse=True
    )
    result_list = [
        {"card_id": int(name), "expected_match": float(f"{score:.2f}")}
        for name, score in recommend[:10]
    ]
    X_tr, X_te, y_tr, y_te = train_test_split(
        X_train, y_train, test_size=0.2, random_state=42, stratify=y_train)
    rf.fit(X_tr, y_tr)
    y_pred = rf.predict(X_te)
    acc = accuracy_score(y_te, y_pred)

    print("고객 소비패턴 샘플 수:", len(df_wide_list), file=sys.stderr)
    print("추천 카드 상위 10개 (카드번호, 적합도):", file=sys.stderr)
    for name, score in recommend[:10]:
        print(f"{name} {round(score, 4)}", file=sys.stderr)
    
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