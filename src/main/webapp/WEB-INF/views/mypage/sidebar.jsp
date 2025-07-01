<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<style>
.sidebar {
  display: flex;
  flex-direction: column;
  gap: 40px;
  min-width: 240px;
  max-width: 280px;
  margin-top: 40px;
}
.title-lg-nav {
  font-size: 24px;
  font-weight: bold;
  margin-bottom: 10px;
}
.inner-box-nav {
  width: 100%;
  padding: 25px 30px;
  font-size: 12px;
  margin-top: 10px;
}

.inner-box-nav a {
  display: block;
  color: #3e4e42;
  font-size: 16px;
  font-weight: bold;
  margin-bottom: 16px;
  transition: color 0.15s;
}
.inner-box-nav a:last-child {
  margin-bottom: 0;
}
.inner-box-nav a:hover {
  color: var(--m1);
  text-shadow: 0 0 1px rgba(100,130,120,0.08);
}

.box-nav {
  width: 220px; /* 왼쪽 메뉴 폭 고정 */
  min-width: 180px;
  max-width: 240px;
  border-radius: 24px;
  padding: 20px 20px;
  box-sizing: border-box;
}
</style>

<div class="sidebar">
	<!-- 마이페이지 네비게이터 -->
	<div class="box box-nav">
		<h2 class="title-lg title-lg-nav">마이페이지</h2>
		<div class="inner-box inner-box-nav">
			<a href="${cpath}/user/mypage">회원정보관리</a><br>
			<a href="${cpath}/user/point">포인트관리</a><br>
			<a href="${cpath}/user/customcard">커스텀 카드 보기</a><br>
			<a href="${cpath}/user/card">좋아요한 카드</a><br>
			<a href="${cpath}/user/consumptionPattern">소비패턴관리</a>
		</div>
	</div>

	<!-- 관리자페이지 네비게이터 -->
	<div class="box box-nav">
		<h2 class="title-lg title-lg-nav">관리자페이지</h2>
		<div class="inner-box inner-box-nav">
			<a href="${cpath}/user/mypage">내 정보관리</a><br> <a
				href="${cpath}/user/point">포인트관리</a><br> <a
				href="${cpath}/user/card">내 카드관리</a><br> <a
				href="${cpath}/user/consumptionPattern">소비패턴관리</a>
		</div>
	</div>
</div>