<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>카드가든 : 좋아요한 카드</title>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
  <link rel="stylesheet" href="${cpath}/resources/css/common.css">
  <link rel="stylesheet" href="${cpath}/resources/css/header.css">
  <link rel="stylesheet" href="${cpath}/resources/css/font-awesome.min.css">
  <link rel="stylesheet" href="${cpath}/resources/css/userStyle.css">
  <script src="${cpath}/resources/js/header.js"></script>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  
<style>
.wrap {
    display: flex;
    flex-direction: row;
    align-items: flex-start;
    justify-content: center;
    width: 100%;
    gap: 30px;
    padding: 20px;
}

.tab {
    width: 90%;
    max-width: 1100px;
    padding: 30px;
    background: white;
    border-radius: 16px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
    display: flex;
    flex-direction: column;
    gap: 60px;
    margin: 15px;
	flex-direction: row;
	align-items: center;
}

.container {
  width: 1000px;
  padding: 15px 10px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  border-radius: 24px;
  background-color : rgb(255,255,255,0.4);
}

.like-count-box {
  padding: 10px 150px;
  margin: 10px;
  background: #fff;
}

.card-btn {
	width: 100%;
	background-color: #8FB098;
	border-radius: 12px;
	border: none;
	padding: 14px;
	text-align: center;
	cursor: pointer;
	font-size: 18px;
	font-weight: bold;
	color: white;
	transition: background-color 0.3s;
}

.card-btn:hover {
	background-color: #7ca688;
}

.card_img {
  width: 250px;
  height: 200px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 20px auto;
  background-color: #F5F5F5;
  border-radius: 50%; /* 원형 */
/*   box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15); /* 부드러운 그림자 */ */
}

.card-thumbnail {
  width: 90%;
  height: auto;
  object-fit: contain;
}

.card-content {
	width: 100%;
	display: flex;
	flex-direction: column;
	gap: 10px;
}

.card-content ul {
	list-style: none;
	padding-left: 0;
	margin: 0;
}

.card-content ul li {
	margin-bottom: 8px;
	font-size: 16px;
	line-height: 1.5;
	white-space: pre-line;
}

.card-right {
	width: 30%;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: flex-end;
	gap: 10px;
	margin-top: 15px;
	margin-right: 20px;
}

.card-right p {
	font-size: 18px;
	color: #444;
	margin: 4px 0;
}

.card-left span, p {
	font-size: 18px;
	font : bold;
}

.card-content {
	flex-direction: row;
	justify-content: space-between;
	align-items: flex-start;
	gap: 20px;
}
.card-left {
	width: 70%;
}

.card-thumbnail {
	width: 100%;
	height: 180px;
}

/* 조건 선택 영역 스타일 개선 */

#condition {
	display: flex;
	flex-wrap: wrap;
	gap: 16px;
	margin-bottom : 5px;
	margin-top : 30px;
	justify-content: center;
}

#condition > div {
	padding: 10px 16px;
	background-color: #DFEED8;
	border-radius: 12px;
	font-weight: bold;
	text-align: center;
	min-width: 120px;
	flex: 1 1 200px;
}

.condition-section {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 24px;
  padding: 24px;
  margin-bottom: 40px;
  background-color: #ffffff;
  border-radius: 16px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
}

.condition-item {
  flex: 1 1 250px;
  display: flex;
  flex-direction: column;
  gap: 10px;
  padding: 16px;
  background-color: #DFEED8;
  border-radius: 12px;
  font-size: 14px;
}

.condition-item label {
  font-weight: bold;
  color: #333;
}

.condition-item input[type="text"] {
  padding: 8px 10px;
  border: none;
  border-radius: 8px;
  background: #f8f8f8;
  font-weight: bold;
  color: #8FB098;
  text-align: center;
}

.condition-item select {
  padding: 10px;
  border-radius: 8px;
  border: 1px solid #ccc;
  background-color: #fff;
  font-size: 14px;
  color: #333;
}

.slider {
  margin-top: 4px;
  background: #F0F3F1;
  border-radius: 6px;
  height: 8px;
}

#btnarea {
  width: 1100px;
  margin-bottom: 25px;
}

#btnarea .card-btn {
  width: 150px;
  font-size: 15px;
}
</style>

</head>
<body class="bg-main">
<div class="wrap">
  <!-- 사이드바 네비게이터 -->
  <jsp:include page="/WEB-INF/views/mypage/sidebar.jsp" />

  <div class="container">
    <div class="inner-box like-count-box">
      <span style="font-size: 20px;">
	    총 <strong>${myLikeCardList.size()}</strong>개의 카드를 좋아합니다
	  </span>
    </div>
	
  <!-- 카드 리스트 출력 -->
  <c:forEach var="card" items="${myLikeCardList}">
    <div class="tab"
         data-company="${card.company}"
         data-like="${card.card_like}"
         data-fee_domestic="${card.fee_domestic}"
         data-card_views="${card.card_views}"
         data-prev_month_cost="${card.prev_month_cost}">

      <!-- 카드 이미지 -->
      <div class="card_img">
        <img src="${card.card_image}" alt="${card.card_name}" class="card-thumbnail">
      </div>

      <!-- 카드 정보 -->
      <div class="card-content">

        <!-- 왼쪽: 이름, 회사, 혜택 -->
        <div class="card-left">
          <h2>${card.card_name}</h2>
          <h3>${card.company}</h3>
          <br>
          <ul>
            <c:forEach var="benefit" items="${card.benefits}" varStatus="bs">
                <c:if test="${bs.index < 3}">
                <li><h4>[혜택 ${bs.index + 1}]</h4> <span> ${benefit}</span></li>
              </c:if>
            </c:forEach>
          </ul>
        </div>

        <!-- 오른쪽: 버튼, 연회비, 전월실적 -->
        <div class="card-right">
          <a href="${cpath}/card/detail?cardid=${card.card_id}" class="btn card-btn">카드 보러가기</a>
          <br><br><br><br>
		  <h3>연회비</h3>
		  <c:choose>
		    <c:when test="${card.fee_domestic == 0}">
		      <span>없음</span>
		    </c:when>
		    <c:otherwise>
		      <span>${card.fee_domestic} 원</span>
		    </c:otherwise>
		  </c:choose>
          <h3>전월실적</h3>
          <c:choose>
          	<c:when test="${card.prev_month_cost == 0}">
          	 <span> 없음</span>
          	</c:when>
          	<c:otherwise>
          	 <span> ${card.prev_month_cost} 만원</span>
          	</c:otherwise>
          </c:choose>
          
        </div>
      </div>
    </div>
  </c:forEach>
</div>
</div>
<script>

  
</script>

</body>
</html>
