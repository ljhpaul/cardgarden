<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<!-- 빈 파비콘 (브라우저 요청 방지) -->
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<!---->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/ec9dd02254.js" crossorigin="anonymous"></script>
<script src="${cpath}/resources/js/header.js?after"></script>

<link rel="stylesheet" href="${cpath}/resources/css/common.css?after">
<link rel="stylesheet" href="${cpath}/resources/css/header.css?after">

<div class="header-wrapper">
<header class="main-header">
  <div class="header-container">

    <!-- 로그인/회원가입 -->
      <!--  로그인세션후에 만질예정   
      <c:choose>
        <c:when test="${not empty loginEmp}">
          <a href="${cpath}/mypage/main.do">마이페이지</a>
          <a href="${cpath}/auth/logout.do">로그아웃</a>
        </c:when>
        <c:otherwise>
          <a href="${cpath}/auth/signup.do">회원가입</a>
          <a href="${cpath}/auth/login.do">로그인</a>
        </c:otherwise>
      </c:choose>-->
    <div class="header-left">
      <a href="${cpath}/user/join/method">회원가입</a>
      <a href="${cpath}/auth/login.do">로그인</a>
    </div>

    <!--로고 -->
    <div class="header-logo">
      <a href="${cpath}/main">
        <img class="mascot" src="${cpath}/resources/images/mascot/flower/Mascot_flower_1.png"">
        <img class="logo" src="${cpath}/resources/images/common/logo.png" ">
      </a>
    </div>

    <!--검색 -->
    <div class="header-right">
      <form action="${cpath}/card/cardsearch"" method="get">
        <input type="text" name="keyword" class="text1" placeholder="검색어를 입력하세요">
      </form>
      <a href="${cpath}/mypage/likes.do">
        <img class="mascot" src="${cpath}/resources/images/common/like.png" width="27">
      </a>
    </div>
  </div>

  <!-- 하단 메뉴 -->
  <div class="header-bottom">
    <a href="${cpath}/card/list">카드&nbsp;
      <img class="mascot" src="${cpath}/resources/images/common/caretDown.png" width="15">
    </a>
    <a href="${cpath}/recommend/ai">AI 카드추천</a>
    <a href="${cpath}/custom">카드 커스터마이징&nbsp;
	  <img class="mascot" src="${cpath}/resources/images/common/caretDown.png" width="15">
	</a>
    <a href="${cpath}/event/list">이벤트&nbsp;
      <img class="mascot" src="${cpath}/resources/images/common/caretDown.png" width="15">
	</a>
  </div>
</header>
</div>

<%-- 
<!-- sticky -->
<nav class="sticky-menu">
  <div class="menu-inner">
    
    <!-- 왼쪽 로고 -->
    <div class="menu-left">
      <a href="${cpath}/main">
        <img class="mascot" src="${cpath}/resources/images/mascot/flower/Mascot_flower_1.png" style="height: 36px;">
        <img class="logo" src="${cpath}/resources/images/common/logo.png" style="height: 26px;">
      </a>
    </div>

    <!-- 가운데 메뉴 -->
    <div class="menu-center">
      <a href="${cpath}/card/list">카드</a>
      <a href="${cpath}/recommend/ai">AI 추천</a>
      <a href="${cpath}/custome/main">커스터마이징</a>
      <a href="${cpath}/event/list">이벤트</a>
    </div>

    <!-- 오른쪽 검색 + 하트 -->
    <div class="menu-right">
      <form action="${cpath}/card/search" method="get">
        <input type="text" name="keyword" placeholder="검색어">
      </form>
      <a href="${cpath}/mypage/likes.do">
        <img class="mascot" src="${cpath}/resources/images/common/like.png" width="27">
      </a>
    </div>

  </div>
</nav>
 --%>
