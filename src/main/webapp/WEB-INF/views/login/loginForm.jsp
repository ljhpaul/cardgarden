<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<!-- 헤더와 공통 스타일/스크립트 -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${cpath}/resources/css/common.css">
<link rel="stylesheet"
	href="${cpath}/resources/css/font-awesome.min.css">
<link rel="stylesheet" href="${cpath}/resources/css/header.css">
<link rel="stylesheet" href="${cpath}/resources/css/style.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${cpath}/resources/js/header.js"></script>

<head>
<title>카드가든 : 로그인</title>
</head>

<body class="bg-main">
	<div class="container">
		<div class="box">
			<h2 class="title-lg">카드가든 로그인</h2>
			<div class="login-area">
				<form id="login-form" action="${cpath}/user/login" 
					method="POST" autocomplete="off">
					<!-- 아이디/비밀번호 입력창 -->
					<div class="input-area">
						<input type="text" id="user_name" name="user_name"
							class="input" required placeholder="아이디" />
						<input type="password" id="user_password" name="user_password" 
							class="input" required placeholder="비밀번호" />
					</div>
					
					<!-- 아이디 저장 체크박스 -->
					<div class="checkbox-area">
						<input type="checkbox" id="remember" name="remember" />
						<label for="remember">&nbsp;아이디 저장</label>
					</div>
					
					<!-- 로그인 버튼 -->
					<div class="login-btn-area">
						<button type="submit" id="login-btn" class="btn">로그인</button>
					</div>
				</form>
				
				<!-- 안내 메시지 출력 -->
				<div class="msg-area">
					<!-- <span style="color: #E44E37;">존재하지 않는 아이디입니다.</span> -->
					<span style="color: #E44E37;">비밀번호가 일치하지 않습니다.</span>
				</div>
			</div>
			<div class="login-find">
				<a href="${cpath}/user/find-id" class="text-link">아이디 찾기</a>
				&nbsp;&nbsp;|&nbsp;&nbsp;
				<a href="${cpath}/user/find-password" class="text-link">비밀번호 찾기</a>
				&nbsp;&nbsp;|&nbsp;&nbsp;
				<a href="${cpath}/user/join" class="text-link">회원가입</a>
			</div>
			<!-- 
			<hr class="login-hr">
			 -->
			<div class="login-divider">소셜 로그인</div>

			<!-- 소셜 계정 로그인 버튼 -->
			<div class="login-socials">
				<a class="social-btn google"
					href="${cpath}/oauth2/authorization/google"> <img
					class="googleLogo" src="${cpath}/resources/images/auth/google.png"
					data-default="${cpath}/resources/images/auth/google.png"
					data-hover="${cpath}/resources/images/auth/google_hover.png"
					width="50">
				</a> <a class="social-btn naver"
					href="${cpath}/oauth2/authorization/naver"> <img
					class="naverLogo" src="${cpath}/resources/images/auth/naver.png"
					data-default="${cpath}/resources/images/auth/naver.png"
					data-hover="${cpath}/resources/images/auth/naver_hover.png"
					width="50">
				</a> <a class="social-btn kakao"
					href="${cpath}/oauth2/authorization/kakao"> <img
					class="kakaoLogo" src="${cpath}/resources/images/auth/kakao.png"
					data-default="${cpath}/resources/images/auth/kakao.png"
					data-hover="${cpath}/resources/images/auth/kakao_hover.png"
					width="50">
				</a>
			</div>
		</div>
	</div>
</body>

<style>
.container {
	padding-top: 40px;
}

.box {
	padding: 40px 36px 36px 36px;
	min-width: 340px;
	max-width: 360px;
}

.title-lg {
	font-size: 2.3rem;
	margin-top: 20px;
	margin-bottom: 35px;
}

.login-area {
	flex: 1;
	border: 1px solid #eee;
	border-radius: 16px;
	padding: 36px 30px 20px;
	font-size: 16px;
	font-family: var(--font);
	box-sizing: border-box;
	box-shadow: 0 1.5px 12px rgba(100,130,120,0.08);
}

.input {
	width: 100%;
	height: 44px;
	margin-bottom: 6px;
}

.checkbox-area {
	display: flex;
	align-items: center;
}

.login-btn-area {
	margin-top: 15px;
}

#login-btn {
	width: 100%;
	height: 44px;
	font-size: 1.18rem;
	font-weight: 600;
	gap: 12px;
	margin: 0 auto;
}

.msg-area {
	text-align: center;
}

.login-find {
	margin-top: 15px;
	margin-bottom: 32px;
	font-size: 0.97rem;
	color: #666;
	text-align: center;
}

.login-divider {
	color: #999;
	margin-top: 18px;
	margin-bottom: 18px;
	font-size: 1.07rem;
	display: flex;
}

.login-socials {
	width: 100%;
	display: flex;
	gap: 25px;
	justify-content: center;
	margin-bottom: 18px;
}
</style>

<script>
	$(function() {
		$(".social-btn").hover(function() {
			// 소셜 로그인 버튼에 마우스 올릴 때
			var img = $(this).find("img");
			img.attr("src", img.data("hover"));
		}, function() {
			// 소셜 로그인 버튼에서 마우스 벗어날 때
			var img = $(this).find("img");
			img.attr("src", img.data("default"));
		});
	});
</script>