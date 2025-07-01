<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>카드가든 : 내 커스텀 카드</title>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${cpath}/resources/css/common.css?after">
<link rel="stylesheet" href="${cpath}/resources/css/userStyle.css?after">
<link rel="stylesheet" href="${cpath}/resources/css/font-awesome.min.css?after">
<script src="${cpath}/resources/js/header.js"></script>

<style>
.wrap {
    display: flex;
    flex-direction: row;
    align-items: flex-start;
    justify-content: center;
    width: 100%;
    gap: 30px;
}

.tab {
    width: 90%;
    max-width: 1100px;
    padding: 30px;
    background: white;
    border-radius: 16px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
    display: flex;
    flex-direction: row;
    align-items: center;
    gap: 30px;
    margin: 15px;
}

.container {
  width: 1000px;
  padding: 15px 10px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  border-radius: 24px;
  background-color : rgba(255,255,255,0.4);
}

.like-count-box {
  padding: 10px 150px;
  margin: 10px;
  background: #fff;
}

.card_img {
  width: 400px;
  height: 200px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.card-thumbnail {
  width: 90%;
  height: auto;
  object-fit: contain;
}

.card-content {
    width: 100%;
    display: flex;
    justify-content: flex-start;
    align-items: center;
}

.card-left {
    display: flex;
    flex-direction: column;
    gap: 8px;
}

.card-left p {
    font-size: 25px;
    color: #333;
    margin: 0;
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
	text-decoration: none;
	display: inline-block;
}

.card-btn:hover {
	background-color: #7ca688;
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
        총 <strong>${myCustomCardList.size()}</strong>개의 커스텀 카드를 만들었습니다
      </span>
    </div>

    <!-- 커스텀 카드 리스트 출력 -->
    <c:forEach var="card" items="${myCustomCardList}">
      <div class="tab">
        
        <!-- 카드 이미지 -->
        <div class="card_img">
          <img src="${cpath}/resources/images/custom/customcard/${card.user_id}_${card.customcard_name}.png" alt="${card.customcard_name}" class="card-thumbnail">
        </div>

        <!-- 카드 정보 -->
        <div class="card-content">
          <div class="card-left">
            <p><strong>커스텀명:</strong> ${card.customcard_name}</p>
            <p><strong>생성날짜:</strong> ${card.created_at}</p>
            
            <!-- 다운로드 버튼 추가 -->
            <a href="${cpath}/resources/images/custom/customcard/${card.user_id}_${card.customcard_name}.png" 
               download="${card.customcard_name}.png" 
               class="card-btn" 
               style="width: 150px; font-size: 16px; padding: 10px; margin-top: 10px;">
               다운로드
            </a>
          </div>
        </div>

      </div>
    </c:forEach>

    <!-- 생성하러 가기 버튼 -->
    <div style="display: flex; justify-content: center; margin: 20px;">
      <a href="${cpath}/make/frame" class="card-btn" style="width: 200px; font-size:25px; text-align: center;">
        생성하러 가기
      </a>
    </div>

  </div>

</div>
</body>
</html>
