<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<!-- 헤더와 공통 스타일/스크립트 -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${cpath}/resources/css/common.css">
<link rel="stylesheet" href="${cpath}/resources/css/font-awesome.min.css">
<link rel="stylesheet" href="${cpath}/resources/css/header.css">
<link rel="stylesheet" href="${cpath}/resources/css/join.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${cpath}/resources/js/header.js"></script>

<head>
    <title>카드가든 : 회원가입</title>
</head>

<body class="join-bg">
<div class="join-container">
  <div class="join-box">
    <h2 class="join-title">카드가든 회원가입</h2>

    <!-- 일반 회원가입 버튼 -->
    <a href="${cpath}/user/join/term" class="join-btn">
 	  <img src="${cpath}/resources/images/auth/joinUser.png" width="18"/> 일반 회원가입
	</a>

    <div class="join-method-divider">또는</div>

    <!-- 소셜 계정 회원가입 버튼 -->
    <div class="join-method-socials">
      <a class="social-btn google" href="${cpath}/oauth2/authorization/google">
        <img class="googleLogo" src="${cpath}/resources/images/auth/google.png"
         data-default="${cpath}/resources/images/auth/google.png"
         data-hover="${cpath}/resources/images/auth/google_hover.png"
         width="50">
      </a>
      <a class="social-btn naver" href="${cpath}/oauth2/authorization/naver">
        <img class="naverLogo" src="${cpath}/resources/images/auth/naver.png"
         data-default="${cpath}/resources/images/auth/naver.png"
         data-hover="${cpath}/resources/images/auth/naver_hover.png"
         width="50">
      </a>
      <a class="social-btn kakao" href="${cpath}/oauth2/authorization/kakao">
        <img class="kakaoLogo" src="${cpath}/resources/images/auth/kakao.png"
         data-default="${cpath}/resources/images/auth/kakao.png"
         data-hover="${cpath}/resources/images/auth/kakao_hover.png"
         width="50">
      </a>
    </div>
    <div class="join-method-login">
      이미 계정이 있으신가요?
      <a href="${cpath}/auth/login.do" class="join-text-hover">로그인</a>
    </div>
  </div>
</div>
</body>

<style>
.join-container {
  padding-top: 120px;
}
.join-box {
  padding: 40px 36px 36px 36px;
  min-width: 340px;
  max-width: 360px;

}
.join-title {
  font-size: 2.0rem;
  margin-top: 20px;
  margin-bottom: 35px;
}
.join-btn {
  width: 80%;
  height: 52px;
  font-size: 1.18rem;
  font-weight: 600;
  margin-top: 18px;
  gap: 12px;
  margin: 0 auto;
}
.join-method-divider {
  color: #999;
  margin-top: 16px;
  margin-bottom: 18px;
  font-size: 1.07rem;
}
.join-method-socials {
  width: 100%;
  display: flex;
  gap: 25px;
  justify-content: center;
  margin-bottom: 18px;
}
.join-method-login {
  margin-top: 24px;
  font-size: 0.97rem;
  color: #666;
  text-align: center;
}
</style>

<script>
$(function() {
  $(".social-btn").hover(
    function() {
      // 소셜 로그인 버튼에 마우스 올릴 때
      var img = $(this).find("img");
      img.attr("src", img.data("hover"));
    }, 
    function() {
      // 소셜 로그인 버튼에서 마우스 벗어날 때
      var img = $(this).find("img");
      img.attr("src", img.data("default"));
    });
});
</script>


