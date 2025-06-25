<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<!-- 공통 헤더/스타일/스크립트 -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${cpath}/resources/css/common.css">
<link rel="stylesheet" href="${cpath}/resources/css/header.css">
<link rel="stylesheet" href="${cpath}/resources/css/font-awesome.min.css">
<link rel="stylesheet" href="${cpath}/resources/css/userStyle.css">

<head>
    <title>카드가든 : 회원가입</title>
</head>

<body class="bg-main">
  <div class="container">
    <div class="box">
      <i class="fa fa-check-circle complete-icon"></i>
      <div class="title-lg">회원가입 완료</div>
      <div class="complete-message">
        카드가든의 다양한 서비스를<br>
        지금 바로 이용하실 수 있습니다.<br>
        <span class="complete-welcome">
          <i class="fa fa-smile-o"></i> 환영합니다!
        </span>
      </div>
      <a href="${cpath}/user/login" id="login-btn" class="btn">
        <i class="fa fa-sign-in" style="margin-right: 8px;"></i> 로그인하기
      </a>
      <a href="${cpath}/main" id="main-btn" class="btn">
        <i class="fa fa-home" style="margin-right: 7px;"></i> 메인으로 이동
      </a>
    </div>
  </div>
</body>

<style>
body {
	font-family: 'NanumSquareRound', sans-serif;
	background-color: #F0F3F1;
	padding: 0;
	margin: 0;
}
.box {
  max-width: 480px;
  width: 100%;
  padding: 48px 36px;
  box-sizing: border-box;
  display: flex;
  flex-direction: column;
  align-items: center;
}
.complete-icon {
  font-size: 60px;
  color: var(--m1);
  margin-bottom: 18px;
}
.title-lg {
  margin-bottom: 18px;
}
.complete-message {
  font-size: 17px;
  color: #444;
  text-align: center;
  margin-bottom: 36px;
  line-height: 1.7;
}
.complete-welcome {
  color: var(--m3);
  font-size: 15px;
}
#login-btn {
  width: 100%;
  font-size: 18px;
  padding: 15px 0;
  font-weight: 600;
  margin-bottom: 10px;
  display: block;
  text-align: center;
}
#main-btn {
  width: 100%;
  background: var(--m2);
  color: var(--m3);
  font-size: 16px;
  padding: 12px 0;
  font-weight: 600;
  display: block;
  text-align: center;
}
</style>
