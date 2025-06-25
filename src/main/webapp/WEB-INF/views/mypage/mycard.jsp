<%@ include file="../common/mypageheader.jsp"%>
<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>카드조회</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding&family=Nanum+Square+Round&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css" />
<link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
  <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<style>
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	font-family: 'Nanum Square Round', sans-serif;
	background-color: #F0F3F1;
}

.wrap {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	width: 100%;
	gap: 30px;
	padding: 20px;
}

.tab {
	width: 100%;
	max-width: 1100px;
	padding: 30px;
	background: white;
	border-radius: 16px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
	display: flex;
	flex-direction: column;
	gap: 20px;
	margin-bottom: 25px;
}
	.container {
	  width: 100%;       /* container 너비는 꽉 채우고 */
	  max-width: 1000px;  /* 최대 너비 제한 */
	  padding: 20px;
	  display: flex;
	  flex-direction: column;
	  justify-content: center;
	  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
	  border-radius: 24px;
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

input[type="submit"] {
	width: 100%;
	padding: 14px;
	font-size: 16px;
	font-weight: bold;
	background-color: #4CAF50;
	color: white;
	border: none;
	border-radius: 8px;
	cursor: pointer;
	transition: background-color 0.3s;
}

input[type="submit"]:hover {
	background-color: #388E3C;
}

/* .ticks {
	display: flex;
	justify-content: space-between;
	margin-top: 4px;
	font-size: 12px;
	color: #444;
} */

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

.card_content {
	width: 100%;
	display: flex;
	flex-direction: column;
	gap: 10px;
}

.card_content ul {
	list-style: none;
	padding-left: 0;
	margin: 0;
}

.card_content ul li {
	  margin-bottom: 8px;
	  font-size: 16px;
	  line-height: 1.5;
	  white-space: pre-line;
}


.left, .right {
	width: 100%;
}


.right{
	margin-right: 20px;
}

.right p {
	font-size: 18px;
	color: #444;
	margin: 4px 0;
}

.left span,p{
		font-size: 18px;
		font : bold;
}

/* 반응형 구조 */
@media (min-width: 768px) {
.tab {
	flex-direction: row;
	align-items: center;
}
.card_content {
	flex-direction: row;
	justify-content: space-between;
	align-items: flex-start;
	gap: 20px;
}
.left {
	width: 70%;
}

.right {
	width: 30%;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: flex-end;
	gap: 10px;
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

#btnarea{
  width: 1100px;
  margin-bottom: 25px;
}

#btnarea .card-btn {
  width: 150px;
  font-size: 15px;
}
</style>

</head>
<body>
<div class="wrap">
	<div style="text-align: left; width: 1100px;">
	  <span style="font-size: 20px;">총 <strong>${myLikeCardList.size()}</strong>개의 카드를 좋아합니다</span>
	</div>
  <div class="container">
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
      <div class="card_content">

        <!-- 왼쪽: 이름, 회사, 혜택 -->
        <div class="left">
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
        <div class="right">
          <a href="${cpath}/card/detail?cardid=${card.card_id}" class="card-btn">카드 보러가기</a>
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
