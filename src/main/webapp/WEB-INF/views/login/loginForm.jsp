<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />
<c:if test="${not empty sessionScope.msg}">
  <script>alert('${sessionScope.msg}');</script>
  <c:remove var="msg" scope="session"/>
</c:if>

<!-- 헤더와 공통 스타일/스크립트 -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${cpath}/resources/css/common.css">
<link rel="stylesheet" href="${cpath}/resources/css/font-awesome.min.css">
<link rel="stylesheet" href="${cpath}/resources/css/header.css">
<link rel="stylesheet" href="${cpath}/resources/css/userStyle.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${cpath}/resources/js/header.js"></script>

<head>
<title>카드가든 : 로그인</title>
</head>

<body class="bg-main">
	<div class="container">
		<div class="box">
			<h2 class="title-lg">카드가든 로그인</h2>
			<div class="inner-box">
				<form id="login-form" action="${cpath}/user/login" 
					method="POST" autocomplete="off">
					<!-- 아이디/비밀번호 입력창 -->
					<div class="input-area">
						<input type="text" id="user_name" name="user_name"
							class="input" placeholder="아이디" />
						<input type="password" id="user_password" name="user_password" 
							class="input" placeholder="비밀번호" />
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
					<span id="login-msg"></span>
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
body {
	font-family: 'NanumSquareRound', sans-serif;
	background-color: #F0F3F1;
	padding: 0;
	margin: 0;
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

.inner-box {
	padding: 36px 30px 20px;
	font-size: 16px;
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
	display: none;
	text-align: center;
	font-style: 
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
		/* 쿠키에서 저장된 아이디 불러오기 및 체크 유지 */
		var savedLoginId = getCookie("savedLoginId");
		if(savedLoginId) {
			$("#user_name").css("background-color", "#f8fbf8").val(savedLoginId);
			$("#remember").prop("checked", true);
		}
		
		$("#user_name").on("focus", function() {
			$("#user_name").css("background-color", "");
		});
		
		/* 소셜 로그인 버튼 hover 이미지 변경 */
		$(".social-btn").hover(function() {
			// 소셜 로그인 버튼에 마우스 올릴 때
			var img = $(this).find("img");
			img.attr("src", img.data("hover"));
		}, function() {
			// 소셜 로그인 버튼에서 마우스 벗어날 때
			var img = $(this).find("img");
			img.attr("src", img.data("default"));
		});
		
		/* 로그인 검증(Ajax) */
		$("#login-form").on("submit", function(e) {
			e.preventDefault();	// submit 기본동작 막기
			
			/* 아이디 및 비밀번호 입력 여부 */
			if(!isInputData()) return;
			
			/* 입력데이터 String으로 받기 : serialize() */
			var formData = $(this).serialize();
			
			/* 서버에 AJAX로 갔다오기 : $.ajax({ url, method, data, success }); */
			$.ajax({
				url: '${cpath}/user/login',
				method: 'POST',
				data: formData,
				success: function(res) {
					console.log("ajax success!", res);
					$(".msg-area").show();
					if(res.success) {
						/* 아이디 저장 체크 여부 */
						isRemeberChecked();
						
						$("#user_name").css("background-color", "#f8fbf8");
						$("#user_password").css("background-color", "#f8fbf8");
						$("#login-msg").css("color", "#27AE60").text(res.message);
						window.location.href = '${cpath}' + res.redirectAfterLogin;
					} else {
						$("#login-msg").css("color", "#E44E37").text(res.message);
					}
				}
			});
		});
		
	});
	
	// 아이디 및 비밀번호 입력 여부 확인
	function isInputData() {
		var id = $("#user_name").val().trim();
		var pw = $("#user_password").val().trim();
		if(!id) {
			$(".msg-area").show();
			$("#login-msg").css("color", "#E44E37").text("아이디를 입력하세요.");
	        $("#user_name").focus();
	        return false;
		}
		if(!pw) {
	        $(".msg-area").show();
	        $("#login-msg").css("color", "#E44E37").text("비밀번호를 입력하세요.");
	        $("#user_password").focus();
	        return false;
	    }
		return true;
	}
	
	// 아이디 저장 체크 여부
	function isRemeberChecked() {
		var checked = $("#remember").is(":checked");
		if(checked) {
			setCookie("savedLoginId", $("#user_name").val(), 30);
			return true;
		} else {
			setCookie("savedLoginId", "", -1);
			return false;
		}
	}
	
	// 쿠키 저장 함수
	function setCookie(name, value, days) {
	    var expires = "";
	    if(days) {
	        var date = new Date();
	        date.setTime(date.getTime() + (days*24*60*60*1000));
	        expires = "; expires=" + date.toUTCString();
	    }
	    document.cookie = name + "=" + encodeURIComponent(value) + expires + "; path=/";
	}

	// 쿠키 읽기 함수
	function getCookie(name) {
	    var nameEQ = name + "=";
	    var ca = document.cookie.split(';');
	    for(var i=0;i<ca.length;i++) {
	        var c = ca[i];
	        while(c.charAt(0)==' ') c = c.substring(1,c.length);
	        if(c.indexOf(nameEQ) == 0) return decodeURIComponent(c.substring(nameEQ.length,c.length));
	    }
	    return null;
	}
</script>
