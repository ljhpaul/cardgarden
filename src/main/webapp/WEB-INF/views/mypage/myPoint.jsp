<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>카드가든 : 포인트관리</title>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
  <link rel="stylesheet" href="${cpath}/resources/css/common.css">
  <link rel="stylesheet" href="${cpath}/resources/css/header.css">
  <link rel="stylesheet" href="${cpath}/resources/css/font-awesome.min.css">
  <link rel="stylesheet" href="${cpath}/resources/css/userStyle.css">
  <script src="${cpath}/resources/js/header.js"></script>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style>
.wrap {
  width: 100%;
  min-height: 100vh;
  display: flex;
  justify-content: center;
  flex-direction: row;
  gap: 20px;
  margin-bottom: 50px;
}

.title-lg {
  font-size: 2.6rem;
  font-size: 32px;
  font-weight: bold;
  margin-bottom: 30px;
}

.main-container {
  width: 730px;
  background-color: #ffffff;
  padding: 40px;
  border-radius: 20px;
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
  display: flex;
  flex-direction: column;
  align-items: center;
}

.point-container {
  max-height: 190px;
  margin-bottom: 30px;
  padding: 20px 30px;
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-between;
  gap: 20px;
}

.point-area {
  width: 500px;
  height: 120px;
  padding: 30px 40px;
  font-weight: bold;
  font-size: 16px;
  color: #3e4e42;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.point {
  color: var(--m1);
  font-size: 3rem;
  font-weight: bold;
  margin-bottom: 7px;
}

.event-area a img {
  height: 115px;
  margin-left: 10px;
  border-radius: 12.5px;
  box-shadow: 0 0.5px 4px rgba(100,130,120,0.08);
}

.event-area a img:hover {
  box-shadow: 0 2px 16px rgba(180, 140, 90, 0.22);
  cursor: url("");
}


</style>
</head>
<body class="bg-main">
<div class="wrap">
  <!-- 사이드바 네비게이터 -->
  <jsp:include page="/WEB-INF/views/mypage/sidebar.jsp" />
  
  <!-- 패턴 선택 드롭다운 -->
  <div class="main-container">
  	<h2 class="title-lg">내 포인트관리</h2>
  
    <div class="inner-box point-container">
      <div class="inner-box point-area">내 포인트 : <span class="point">${loginUserPoint} P</span></div>
      <div class="event-area">
        <a href="${cpath}/event/attendance">
          <img alt="출석체크" src="${cpath}/resources/images/mypage/attendance.png">
        </a>
        <a href="${cpath}/event/mascot">
          <img alt="마스코트" src="${cpath}/resources/images/mypage/mascot.png">
        </a>
      </div>
    </div>
  </div>
</div>

</body>
</html>
