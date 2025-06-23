import pandas as pd
from sqlalchemy import create_engine
from flask import Flask, request, jsonify

app = Flask(__name__)

def get_consum_pattern(pattern_id, card_id):
    # 파케이 파일 경로와 DB 연결 설정
    df_parquet = pd.read_parquet("/Users/isanghyeon/Documents/workspace-sts-3.9.18.RELEASE/cardgarden/q_table.parquet")
    engine = create_engine("mysql+pymysql://cardgarden:1234@192.168.0.13/cardgarden?charset=utf8mb4")
    
    # 패턴과 카테고리 쿼리
    sql_detail_patternid = f"SELECT pattern_id, benefitcategory_id, amount FROM UserConsumptionPatternDetail WHERE pattern_id = {pattern_id}"
    sql_benefitCategoryid = "SELECT * FROM BenefitCategory"
   
    df_detail_patternid = pd.read_sql(sql_detail_patternid, engine)
    df_category = pd.read_sql(sql_benefitCategoryid, engine)
    engine.dispose()
    
    # merge 후 amount 이진화
    df_category_patternid = pd.merge(df_category, df_detail_patternid, on="benefitcategory_id", how="left")
    df_category_patternid = df_category_patternid[['benefitcategory_name', 'amount']]
    df_category_patternid['amount'] = df_category_patternid['amount'].fillna(0)
    df_category_patternid['amount'] = df_category_patternid['amount'].apply(lambda x: 1 if x != 0 else 0)

    amount_list = df_category_patternid['amount'].astype(str).tolist()
    amount_str = ",".join(amount_list)
    
    card_id = str(card_id)
    print("pattern_id:", pattern_id)
    print("df_detail_patternid:", df_detail_patternid)
    print("amount_list:", amount_list)
    print("amount_str:", amount_str)
    print("df_parquet['user_state'] == amount_str:", (df_parquet['user_state'] == amount_str).sum())
    # parquet에서 값을 찾는 부분
    if (df_parquet['user_state'] == amount_str).any():
        result = df_parquet[df_parquet['user_state'] == amount_str][card_id]
        if not result.empty:
            return float(result.values[0])  # 단일 float 값 반환
        else:
            return None
    else:
        return None


@app.route('/recommendDetail', methods=['GET'])
def recommendDetail():
    pattern_id = request.args.get('pattern_id')
    card_id = request.args.get('card_id')
    print(f"pattern_id: {pattern_id}, card_id: {card_id}")
    if not pattern_id or not card_id:
        return jsonify({'error': 'pattern_id와 card_id를 모두 입력해야 합니다.'}), 400

    try:
        pattern_id = int(pattern_id)
        card_id = int(card_id)
    except ValueError:
        return jsonify({'error': 'pattern_id와 card_id는 숫자여야 합니다.'}), 400
        
    result = get_consum_pattern(pattern_id, card_id)
    print(f"result: {result}")
    return jsonify({'result': result})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5002, debug=True)
