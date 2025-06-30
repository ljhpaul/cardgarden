from flask import Flask, request, jsonify
from sklearn.metrics.pairwise import cosine_similarity
import pandas as pd
import traceback
from sqlalchemy import create_engine

# 1. DB 연결
engine = create_engine("mysql+pymysql://cardgarden:1234@localhost/cardgarden?charset=utf8mb4")

# 2. CSV 대신 SQL로 데이터 읽기
def load_data():
    sql_card = "SELECT * FROM Card"
    sql_detail = "SELECT * FROM CardBenefitDetail"
    sql_benefitdetail = "SELECT * FROM BenefitDetail"
    sql_benefitcategory = "SELECT * FROM BenefitCategory"

    df_card = pd.read_sql(sql_card, engine)
    df_card_benefit_detail = pd.read_sql(sql_detail, engine)
    df_benefit_detail = pd.read_sql(sql_benefitdetail, engine)
    df_benefit_category = pd.read_sql(sql_benefitcategory, engine)
    return df_card, df_card_benefit_detail, df_benefit_detail, df_benefit_category

df_card, df_card_benefit_detail, df_benefit_detail, df_benefit_category = load_data()

arr_key2 = ['모든가맹점', '모빌리티', '대중교통', '통신', '생활', '쇼핑', '외식/카페',
            '뷰티/피트니스', '금융/포인트', '병원/약국', '문화/취미', '숙박/항공']

def make_card_vec():
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

app = Flask(__name__)

@app.route('/recommendCosine', methods=['GET'])
def recommendCosine():
    try:
        card_id = int(request.args.get('card_id', 1))
        result_list = find_cosine_card5(card_id)
        return jsonify(result_list)
    except Exception as e:
        print("에러 발생:", e)
        traceback.print_exc()
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5003, debug=True)
