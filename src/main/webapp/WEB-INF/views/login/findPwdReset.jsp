<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<!-- 공통 헤더/스타일/스크립트 -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${cpath}/resources/css/common.css">
<link rel="stylesheet" href="${cpath}/resources/css/header.css">
<link rel="stylesheet" href="${cpath}/resources/css/font-awesome.min.css">
<link rel="stylesheet" href="${cpath}/resources/css/userStyle.css">
<script src="${cpath}/resources/js/header.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<head>
    <title>카드가든 : 비밀번호 찾기</title>
</head>

<style>

.container {
  width: 80%;
  height: 120%;
  display: flex;
  justify-content: center;
  align-items: flex-start;
  border-radius: 24px;
  margin: 0 auto;
  gap: 28px;
}

.box {
  width: 650px;
  border-radius: 24px;
  padding: 44px 0px 32px;
}

.title-lg {
  margin-bottom: 30px;
}

.inner-box {
  padding: 25px 25px;
  font-size: 20px;
  gap: 5px;
  margin-bottom: 20px;
}

.form-group {
  position: relative;
  margin-top: 22px;
  display: flex;
  align-items: center;
}
.form-group:first-child {
  margin-top: 0px;
}

.form-group label {
  display: inline-block;
  width: 20%;
  min-width: 110px;
  margin-right: 10px;
  font-weight: bold;
  font-size: 16px;
  color: #3e4e42;
}

.input {
  flex: 1;
  width: 70.5%;
  min-width: 150px;
}
.input[readonly] {
  background-color: #f8fbf8;
}
#user_password_check {
  padding-right: 200px;
}
.check-msg {
  font-size:13px; 
  font-weight:600;
  color: var(--m1);
  position: absolute; 
  right: 15px; 
  top: 50%; 
  transform: translateY(-50%);
}

.btn {
  width: 20%;
  min-width: 110px;
  height: 44px;
  margin-left: 12px;
  cursor: pointer;
}
#enrollBtn {
  width:90%; 
  height:50px; 
  font-size:19px;
  margin: 30px auto 0 auto;
  display: block;
}

#enroll-form {
  width:90%; 
  padding: 0px 12px;
}
</style>

<body class="bg-main">
  <div class="container">
    <!-- 회원정보 -->
    <div class="box">
      <h2 class="title-lg">비밀번호 재설정</h2>
      <form id="enroll-form" action="${cpath}/user/find-password/reset" method="post" autocomplete="off">
		
		<div class="inner-box">
	        <div class="form-group">
	          <label for="prevPwd">현재 비밀번호</label>
	          <input type="password" id=prevPwd name="prevPwd" class="input" required maxlength="15">
	          <span id="checkPwdMsg1" class="check-msg"></span>
	        </div>
			
	        <div class="form-group">
	          <label for="user_password">새 비밀번호</label>
	          <input type="password" id="user_password" name="user_password" class="input" required placeholder="영문자, 숫자, 특수문자 포함 8~15자" maxlength="15">
	          <span id="checkPwdMsg2" class="check-msg"></span>
	        </div>
	        
	        <div class="form-group">
	          <label for="user_password_check">비밀번호 확인</label>
	          <input type="password" id="user_password_check" class="input" required>
	          <span id="checkPwdMsg3" class="check-msg"></span>
	        </div>
	    </div>

        <button id="enrollBtn" type="submit" class="btn" disabled>비밀번호 재설정</button>
      </form>
    </div>
  </div>
</body>

<script>
$(function() {
	var msg = "${alertMsg}";
    if(msg) { alert(msg); }
});

let checkPrevPwd = false, checkPwd = false;

// 현재 비밀번호 입력값 검증
$("#prevPwd").on("input blur keyup", function() {
  return;
  let pwd = $("#prevPwd").val();
  let msg = $("#checkPwdMsg1");
  if(pwd.length == 0) {
	msg.html("");
	$("#prevPwd").css({"background-color": "", "border": "", "outline": ""});
	checkPrevPwd = false; updateEnrollBtn();
  } else if(pwdCheck(pwd)) {
	msg.html("");
	$("#prevPwd").css({"background-color": "", "border": "", "outline": ""});
	checkPrevPwd = true; updateEnrollBtn();
  } else {
	msg.html("올바르지 않은 입력 형식입니다.").css("color", "#E44E37");
	$("#prevPwd").css({"background-color": "#fff8f8", "border": "1px solid #e7624d", "outline": "0.5px solid #e7624d"});
	checkPrevPwd = false; updateEnrollBtn();
  }
});

// 새 비밀번호 입력값 검증
$("#user_password").on("input blur keyup", function() {
  let pwd = $("#user_password").val();
  let msg = $("#checkPwdMsg2");
  if(pwd.length == 0 || pwdCheck(pwd)) {
	msg.html("");
	$("#user_password").css({"background-color": "", "border": "", "outline": ""});
  } else {
	msg.html("올바르지 않은 입력 형식입니다.").css("color", "#E44E37");
	$("#user_password").css({"background-color": "#fff8f8", "border": "1px solid #e7624d", "outline": "0.5px solid #e7624d"});
  }
});

// 새 비밀번호 일치 체크
$('#user_password, #user_password_check').on("input blur keyup", function() {
  let a = $("#user_password").val();
  let b = $("#user_password_check").val();
  let msg = $("#checkPwdMsg3");
  if(a.length == 0) {
	msg.html("");
	$("#user_password_check").css({"background-color": "", "border": "", "outline": ""});
	checkPwd = false; updateEnrollBtn();
  } else if(b.length == 0) {
	msg.html("");
	$("#user_password_check").css({"background-color": "", "border": "", "outline": ""});
	checkPwd = false; updateEnrollBtn();
  } else if(a != b) {
	msg.html("비밀번호 불일치").css("color", "#E44E37");//#f8fbf8
	$("#user_password").css("background-color", "");
	$("#user_password_check").css({"background-color": "#fff8f8", "border": "1px solid #e7624d", "outline": "0.5px solid #e7624d"});
	checkPwd = false; updateEnrollBtn();
  } else {
	msg.html("<i class='fa fa-check-circle' style='font-size: 12px'></i>&nbsp;&nbsp;비밀번호 일치").css("color", "");
	$("#user_password").css("background-color", "#f8fbf8");
	$("#user_password_check").css({"background-color": "#f8fbf8", "border": "", "outline": ""});
	checkPwd = true; updateEnrollBtn();
  }
});

// 기존 비밀번호와 일치 여부 확인
$("#enrollBtn").on("click", function(e) {
  let prevPwd = $("#prevPwd").val();
  let newPwd = $("#user_password").val();
  if(prevPwd == newPwd) {
	alert("기존 비밀번호와 새 비밀번호가 같습니다.");
	e.preventDefault();
	return;
  }
});

// 가입버튼 활성화 함수
function updateEnrollBtn() {
  if(checkPwd) {
    $("#enrollBtn").prop("disabled", false);
  }	else {
	$("#enrollBtn").prop("disabled", true);  
  }
}

// 비밀번호 입력값 검증 함수
function pwdCheck(pwd) {
  return /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]).{8,}$/.test(pwd);
}
</script> 
</body>