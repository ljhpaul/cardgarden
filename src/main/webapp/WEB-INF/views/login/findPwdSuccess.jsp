<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<!-- 공통 헤더/스타일/스크립트 -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${cpath}/resources/css/common.css">
<link rel="stylesheet" href="${cpath}/resources/css/header.css">
<link rel="stylesheet"
	href="${cpath}/resources/css/font-awesome.min.css">
<link rel="stylesheet" href="${cpath}/resources/css/userStyle.css">

<head>
<title>카드가든 : 비밀번호 찾기</title>
</head>

<body class="bg-main">
	<div class="container">
		<div class="box">
			<i class="fa fa-check-circle complete-icon"></i>
			<div class="title-lg">비밀번호 재설정 성공</div>
			
<%-- 			<div class="inner-box">
			<div class="pwd-area">
				비밀번호&nbsp;&nbsp;:&nbsp;&nbsp;<span id="found-id">${foundPwd}</span>
			</div>
			</div> --%>
			<a href="${cpath}/user/login" id="login-btn" class="btn">
				<i class="fa fa-sign-in" style="margin-right: 8px;"></i> 로그인
			</a> 
<%-- 			<a href="${cpath}/user/find-password" id="pwd-btn" class="btn">
				<i class="fa fa-lock" style="margin-right: 7px;"></i> 비밀번호 찾기
			</a> --%>
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
	margin-bottom: 30px;
}

.inner-box {
    width: 90%;
	padding: 18px 30px;
	font-size: 16px;
}

.pwd-area {
	font-size: 22px;
	color: #444;
	text-align: center;
	line-height: 1.7;
}

#login-btn {
	width: 100%;
	font-size: 18px;
	padding: 15px 0;
	font-weight: 600;
	margin-top: 30px;
	margin-bottom: 10px;
	display: block;
	text-align: center;
}
#login-btn:hover {
	background: #80a58a;
}

#pwd-btn {
	width: 100%;
	background: var(--m2);
	color: var(--m3);
	font-size: 16px;
	padding: 15px 0;
	font-weight: 600;
	display: block;
	text-align: center;
}
#pwd-btn:hover {
	background: #d0e6c6;
}
</style>