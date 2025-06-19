<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<!-- 헤더와 공통 스타일/스크립트 -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${cpath}/resources/css/common.css">
<link rel="stylesheet" href="${cpath}/resources/css/header.css">
<link rel="stylesheet" href="${cpath}/resources/css/font-awesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${cpath}/resources/js/header.js"></script>

<div class="join-method-section">
  <div class="join-method-box">
    <h2 class="join-method-title">카드가든 회원가입</h2>

    <!-- 일반 회원가입 버튼 -->
    <a href="${cpath}/user/join/term" class="join-method-btn">
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
      <a href="${cpath}/auth/login.do" class="login-link">로그인</a>
    </div>
  </div>
</div>

<style>
.join-method-section {
  width: 100%;
  min-height: 600px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #f9faf9;
  padding-top: 10px;
  font-family: var(--font);
}
.join-method-box {
  background: #fff;
  padding: 40px 36px 36px 36px;
  border-radius: 20px;
  box-shadow: 0 2px 16px rgba(100,130,120,0.08);
  min-width: 340px;
  max-width: 360px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}
.join-method-title {
  font-size: 2.0rem;
  font-weight: 700;
  color: var(--m1);
  margin-bottom: 45px;
}
.join-method-btn {
  width: 80%;
  height: 52px;
  border-radius: 6px;
  border-bottom: 16px;
  box-shadow: 0 2px 16px rgba(100,130,120,0.08);
  background: var(--m1);
  color: #fff;
  font-size: 1.18rem;
  font-weight: 600;
  border: none;
  margin-top: 18px;
  margin: 0 auto;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 12px;
  transition: background 0.2s;
}
.join-method-btn:hover {
  background: var(--m3);
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
.social-btn { 
  box-shadow: 0 2px 16px rgba(100,130,120,0.08);
  border-radius: 10%;     /* ← 꼭 추가! */
  overflow: hidden;       /* ← 꼭 추가! */
 }
.social-btn:hover { box-shadow: 0 3px 24px rgba(84, 118, 106, 0.142); }
.social-btn.google:hover { border: 2px; border-color: #e5482e; color: #e5482e; }
.social-btn.naver:hover { border: 2px; border-color: #03c75a; color: #03c75a; }
.social-btn.kakao:hover { border: 2px; border-color: #fee500; color: #fee500; }
.social-btn .fa { font-size: 1.2em; }
.join-method-login {
  margin-top: 24px;
  font-size: 0.97rem;
  color: #666;
  text-align: center;
}
.login-link {
  color: var(--m1);
  font-weight: 600;
  margin-left: 5px;
  text-decoration: underline;
}
.login-link:hover {
  color: var(--m3);
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


