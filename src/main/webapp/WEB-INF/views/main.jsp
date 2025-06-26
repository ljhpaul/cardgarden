<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<!-- 공통 헤더/스타일/스크립트 -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${cpath}/resources/css/common.css">
<link rel="stylesheet" href="${cpath}/resources/css/header.css">
<link rel="stylesheet" href="${cpath}/resources/css/font-awesome.min.css">
<link rel="stylesheet" href="${cpath}/resources/css/style.css">

<head>
	<title>CARD GARDEN</title>
</head>

<body>
<h1 id="main">
	카드가든 메인화면
</h1>
</body>

<style>
body {
	font-family: 'NanumSquareRound', sans-serif;
	background-color: #F0F3F1;
	padding: 0;
	margin: 0;
}
#main {
	text-align: center;
}
</style>
