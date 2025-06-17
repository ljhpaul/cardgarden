<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="cpath" value="${pageContext.servletContext.contextPath}"></c:set>

<!-- 빈 파비콘 (브라우저 요청 방지) -->
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="${cpath}/resources/css/common.css?after">
<link rel="stylesheet" href="${cpath}/resources/css/header.css?after">

<header class="main-header">
<script src="https://kit.fontawesome.com/ec9dd02254.js" crossorigin="anonymous"></script>
<script src="${cpath}/resources/js/header.js"></script>
 
  <div class="header-top">
  <div class="header-left">
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
      <a href="${cpath}/auth/signup.do">회원가입</a>
          <a href="${cpath}/auth/login.do">로그인</a>
    </div>
    

    <!-- 마스코트 + 로고 -->
    <div class="header-logo">
      <img class="mascot" src="${cpath}/resources/images/mascot/flower/Mascot_flower_1.png">
      <img class="logo" src="${cpath}/resources/images/common/logo.png" >
    </div>

	<!-- 검색창 -->
	<div class="header-right">
	  <form action="${cpath}/search.do" method="get">
	    <input type="text" name="question" class="text1" placeholder="검색어를 입력하세요">
	  </form>
	  <a  href="${cpath}/mypage/likes.do" >
	   <i class="fa-regular fa-heart"></i>
	  </a>
	</div>
  </div>

  <!-- 메뉴 -->
  <div class="header-bottom">
    <a href="${cpath}/card/list.do">카드&nbsp;&nbsp;<i class="fa fa-caret-down" aria-hidden="true"></i></a>
    <a href="${cpath}/recommend/ai.do">AI 카드추천</a>
    <a href="${cpath}/customizing.do">카드 커스터마이징&nbsp;&nbsp;<i class="fa fa-caret-down" aria-hidden="true"></i></a>
    <a href="${cpath}/event/list.do">이벤트&nbsp;&nbsp;<i class="fa fa-caret-down" aria-hidden="true"></i></a>
  </div>
  
</header>
