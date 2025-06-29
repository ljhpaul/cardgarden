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

<c:if test="${not empty msg}">
  <script>
    alert('${msg}');
  </script>
</c:if>

<head>
    <title>카드가든 : 회원가입</title>
</head>

<style>

body {
  font-family: 'NanumSquareRound', sans-serif;
  padding: 0;
  margin: 0;
}

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
      <h2 class="title-lg">회원정보 입력</h2>
      <form id="enroll-form" action="${cpath}/user/join/info" method="post" onsubmit="combineAddress();" autocomplete="off">
		
		<div class="inner-box">
	        <div class="form-group">
	          <label for="user_name">아이디 <span style="color:#dc3545">*</span></label>
	          <input type="text" id="user_name" name="user_name" class="input">
	          <span id="checkLoginIdMsg" class="check-msg"></span>
	          <div id="loginIdCheckArea">
	            <button type="button" class="btn" onclick="loginIdCheck();">중복확인</button>
	          </div>
	        </div>
			
	        <div class="form-group">
	          <label for="user_password">비밀번호 <span style="color:#dc3545">*</span></label>
	          <input type="password" id="user_password" name="user_password" class="input" required placeholder="영문자, 숫자, 특수문자 포함 8~15자" maxlength="15">
	          <span id="checkPwdMsg1" class="check-msg"></span>
	        </div>
	        
	        <div class="form-group">
	          <label for="user_password_check">비밀번호 확인</label>
	          <input type="password" id="user_password_check" class="input" required>
	          <span id="checkPwdMsg2" class="check-msg"></span>
	        </div>
	
	        <div class="form-group">
	          <label for="nickname">닉네임 <span style="color:#dc3545">*</span></label>
	          <input type="text" id="nickname" name="nickname" class="input">
	          <span id="checkNicknameMsg" class="check-msg"></span>
	          <div id="nicknameCheckArea">
	            <button type="button" class="btn" onclick="nicknameCheck();">중복확인</button>
	          </div>
	        </div>
	
	        <div class="form-group">
	          <label for="email">이메일 <span style="color:#dc3545">*</span></label>
	          <input type="email" id="email" name="email" value="${user.email}" class="input" readonly>
	        </div>
        </div>
        
		<div class="inner-box">
	        <div class="form-group">
	          <label for="name">이름</label>
	          <input type="text" id="name" name="name" class="input" maxlength="5">
	        </div>
	
	        <div class="form-group">
	          <label for="gender">성별 <span style="color:#dc3545">*</span></label>
	          <select name="gender" class="input">
	            <option value="M" ${user.gender == 'M' ? 'selected' : ''}>남</option>
	            <option value="F" ${user.gender == 'F' ? 'selected' : ''}>여</option>
	          </select>
	        </div>
	
	        <div class="form-group">
	          <label for="birth">생년월일 <span style="color:#dc3545">*</span></label>
	          <input type="text" id="birth" name="birth" class="input" placeholder="2000-01-01" maxlength="10">
	          <span id="checkBirthMsg" class="check-msg"></span>
	        </div>
	
	        <div class="form-group">
	          <label for="phone">휴대폰번호</label>
	          <input type="text" id="phone" name="phone" class="input" placeholder="010-0000-0000" maxlength="13">
	          <span id="checkPhoneMsg" class="check-msg"></span>
	        </div>
	        
	        <div class="form-group">
	          <label>주소</label>
	          <input type="hidden" id="address" name="address">
		      <div class="address-fields" style="flex:1; display: flex; flex-direction: column; gap: 8px;">
		        <div class="addr-row" style="display: flex;">
		          <input type="text" id="postcode" name="postcode" class="input" placeholder="우편번호" readonly>
		          <button type="button" class="btn" onclick="execDaumPostcode();">우편번호 찾기</button>
		        </div>
		        
		        <input type="text" id="roadAddress" name="roadAddress" class="input" placeholder="도로명주소" readonly>
		        <input type="text" id="extraAddress" name="extraAddress" class="input" readonly>
		        <input type="text" id="detailAddress" name="detailAddress" class="input" placeholder="상세주소">
		      </div>
	        </div>
		</div>

        <button id="enrollBtn" type="submit" class="btn" disabled>가입하기</button>
      </form>
    </div>
  </div>
</body>

<script>
// 입력값 검증 및 가입버튼 활성화 조건
let checkId = false, checkPwd = false, checkNickname = false, checkEmail = false, checkBirth = false, checkPhone = true;

// 이메일 자동 완성
let verifiedEmail = "${sessionScope.verifiedEmail}";
if(verifiedEmail == "") {
	  alert("세션이 만료되었습니다.");
	  /* window.location.href = '${cpath}/user/join'; */
} else {
	  $("#email").val(verifiedEmail);
	  checkEmail = true;
}


// [생년월일, 휴대폰번호] 백스페이스시 이전값 저장
let prevBirth = "";
$("#birth").on("keydown", function() {
	  prevBirth = $(this).val();
});
let prevPhone = "";
$("#phone").on("keydown", function() {
	  prevPhone = $(this).val();
});

// 생년월일 '-' 자동완성
$("#birth").on("input", function() {
	// 입력값 숫자만 남기기
  let birth = $(this).val();
  let birthNums = birth.replace(/\D/g, '');
  
	// 숫자 사이에 바(-) 삽입
	if(birth + "-" == prevBirth) {
		birth = birth.slice(0, -1);
	} else if(birthNums.length == 4) {
		birth = birthNums.slice(0, 4) + "-";
	} else if(birthNums.length > 4 && birth.length < 6) {
		birth = birthNums.slice(0, 4) + "-" + birthNums.slice(4);
  } else if(birthNums.length == 6) {
  	birth = birthNums.slice(0, 4) + "-" + birthNums.slice(4, 6) + "-";
  } else if(birthNums.length > 6) {
  	birth = birthNums.slice(0, 4) + "-" + birthNums.slice(4, 6) + "-" + birthNums.slice(6);
  }
  
  // 입력창에 최신화
  $(this).val(birth);
});

// 휴대폰번호 '-' 자동완성
$("#phone").on("input", function() {
	// 입력값 숫자만 남기기
  let phone = $(this).val();
  let phoneNums = phone.replace(/\D/g, '');
  
	// 숫자 사이에 바(-) 삽입
	if(phone + "-" == prevPhone) {
		phone = phone.slice(0, -1);
	} else if(phoneNums.length == 3) {
		phone = phoneNums.slice(0, 3) + "-";
	} else if(phoneNums.length > 3 && phoneNums.length < 7) {
		phone = phoneNums.slice(0, 3) + "-" + phoneNums.slice(3);
  } else if(phoneNums.length == 7) {
  	phone = phoneNums.slice(0, 3) + "-" + phoneNums.slice(3, 7) + "-";
  } else if(phoneNums.length > 7) {
  	phone = phoneNums.slice(0, 3) + "-" + phoneNums.slice(3, 7) + "-" + phoneNums.slice(7);
  }
  
  // 입력창에 최신화
  $(this).val(phone);
});

//입력값 검증
$("#birth").on("blur", birthCheck);
$("#phone").on("blur", phoneCheck);

// 주소 찾기(Daum)
function execDaumPostcode() {
  new daum.Postcode({
    oncomplete: function(data) {
      var roadAddr = data.roadAddress;
      var extraRoadAddr = '';
      if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
        extraRoadAddr += data.bname;
      }
      if (data.buildingName !== '' && data.apartment === 'Y') {
        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
      }
      if (extraRoadAddr !== '') {
        extraRoadAddr = ' (' + extraRoadAddr + ')';
      }
      $('#postcode').val(data.zonecode);
      $('#roadAddress').val(roadAddr);
      $('#extraAddress').val(data.buildingName);
      $('#detailAddress').focus();
    }
  }).open();
}

/* //비밀번호 일치 체크
$('#user_password, #user_password_check').on("input blur keyup", function() {
  let a = $("#user_password").val();
  let b = $("#user_password_check").val();
  let msg1 = $("#checkPwdMsg1");
  let msg2 = $("#checkPwdMsg2");
  
  if(a.length == 0 || b.length == 0) {
	msg1.html("");
	msg2.html("");
	$("#user_password").css({"background-color": "", "border": "", "outline": ""});
	$("#user_password_check").css({"background-color": "", "border": "", "outline": ""});
	checkPwd = false; updateEnrollBtn();
  } else if (!pwdCheck(a)) {
	msg1.html("올바르지 않은 입력 형식입니다.").css("color", "#E44E37");
	$("#user_password").css({"background-color": "#fff8f8", "border": "1px solid #e7624d", "outline": "0.5px solid #e7624d"});
	$("#user_password_check").css({"background-color": "", "border": "", "outline": ""});
	checkPwd = false; updateEnrollBtn();
  } else if (a != b) {
	msg2.html("비밀번호 불일치").css("color", "#E44E37");//#f8fbf8
	$("#user_password").css("background-color", "");
	$("#user_password_check").css({"background-color": "#fff8f8", "border": "1px solid #e7624d", "outline": "0.5px solid #e7624d"});
	checkPwd = false; updateEnrollBtn();
  } else {
	msg.html("<i class='fa fa-check-circle' style='font-size: 12px'></i>&nbsp;&nbsp;비밀번호 일치").css("color", "");
	$("#user_password").css("background-color", "#f8fbf8");
	$("#user_password_check").css({"background-color": "#f8fbf8", "border": "", "outline": ""});
	checkPwd = true; updateEnrollBtn();
  }
}); */

// 비밀번호 입력값 검증
$("#user_password").on("input blur keyup", function() {
  let pwd = $("#user_password").val();
  let msg = $("#checkPwdMsg1");
  if(pwd.length == 0 || pwdCheck(pwd)) {
	msg.html("");
	$("#user_password").css({"background-color": "", "border": "", "outline": ""});
  } else {
	msg.html("올바르지 않은 입력 형식입니다.").css("color", "#E44E37");
	$("#user_password").css({"background-color": "#fff8f8", "border": "1px solid #e7624d", "outline": "0.5px solid #e7624d"});
  }
});

// 비밀번호 일치 체크
$('#user_password, #user_password_check').on("input blur keyup", function() {
  let a = $("#user_password").val();
  let b = $("#user_password_check").val();
  let msg = $("#checkPwdMsg2");
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

//주소 결합 : address = postcode/roadAddress/extraAddress/detailAddress
function combineAddress() {
	let postcode = $("#postcode").val();
	let roadAddress = $("#roadAddress").val();
	let detailAddress = $("#detailAddress").val();
	let extraAddress = $("#extraAddress").val();
	let address = postcode + "/" +  roadAddress + "/" + (extraAddress ? extraAddress : " ") + "/" + detailAddress;
	$("#address").val(address);
}

// 가입버튼 활성화 함수
function updateEnrollBtn() {
  if(checkId && checkPwd && checkNickname && checkEmail && checkBirth && checkPhone) {
    $("#enrollBtn").prop("disabled", false);
  }	else {
	$("#enrollBtn").prop("disabled", true);  
  }
}

// 아이디 중복확인
function loginIdCheck() {
  let user_name = $("#user_name").val();
  if(user_name.length == 0) {
	alert("아이디를 입력해주세요.");
	$("#user_name").focus();
	checkId = false; updateEnrollBtn();
	return;
  }
  $.ajax({
    url: "${cpath}/auth/loginId/check",
    type: "POST",
    data: { user_name: user_name },
    success: function(res) {
      if (res.duplicate) {
        alert("이미 사용중인 아이디입니다.");
        $("#user_name").focus();
        checkId = false; updateEnrollBtn();
      } else {
        if (confirm("사용 가능한 아이디입니다. 사용하시겠습니까?")) {
      	  $("#user_name").attr("readonly", true);
          checkId = true; updateEnrollBtn();
          $("#loginIdCheckArea").html("");
          $("#checkLoginIdMsg").html("<i class='fa fa-check-circle' style='font-size: 12px'></i>&nbsp;&nbsp;확인완료");
        } else {
      	  $("#user_name").focus();
          checkId = false; updateEnrollBtn();
        }
      }
    }
  });
}

// 닉네임 중복확인
function nicknameCheck() {
  let nickname = $("#nickname").val();
  if(nickname.length == 0) {
	alert("닉네임을 입력해주세요.");
	$("#nickname").focus();
	checkNickname = false; updateEnrollBtn();
	return;
  }
  $.ajax({
	url: "${cpath}/auth/nickname/check",
	type: "POST",
	data: { nickname: nickname },
	success: function(res) {
	  if (res.duplicate) {
	    alert("이미 사용중인 닉네임입니다.");
	    $("#nickname").focus();
	    checkNickname = false; updateEnrollBtn();
	  } else {
	    if (confirm("사용 가능한 닉네임입니다. 사용하시겠습니까?")) {
	      $("#nickname").attr("readonly", true);
	      checkNickname = true; updateEnrollBtn();
	      $("#nicknameCheckArea").html("");
	      $("#checkNicknameMsg").html("<i class='fa fa-check-circle' style='font-size: 12px'></i>&nbsp;&nbsp;확인완료");
	    } else {
	      $("#nickname").focus();
	      checkNickname = false; updateEnrollBtn();
	    }
	  }
	}
  });
}

// 비밀번호 입력값 검증 함수
function pwdCheck(pwd) {
  return /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]).{8,}$/.test(pwd);
}

// 생년월일 입력값 검증 함수
function birthCheck() {
  let birth = $("#birth").val().trim();
  let msg = $("#checkBirthMsg");

  if (birth.length === 0) {
    msg.html(""); // 아무것도 입력 안 했으면 메시지 없음
    $("#birth").css({"background-color": "", "border": "", "outline": ""});
    checkBirth = false; updateEnrollBtn();
    return;
  }
  if (!isValidDate(birth)) {
    msg.html("올바르지 않은 입력입니다.").css("color", "#E44E37");
    $("#birth").css({
      "background-color": "#fff8f8",
      "border": "1px solid #e7624d",
      "outline": "0.5px solid #e7624d"
    });
    checkBirth = false; updateEnrollBtn();
  } else {
    msg.html("<i class='fa fa-check-circle' style='font-size: 12px'></i>").css("color", "");;
    $("#birth").css({
      "background-color": "#f8fbf8",
      "border": "",
      "outline": ""
    });
    checkBirth = true; updateEnrollBtn();
  }
}

// 휴대폰번호 입력값 검증 함수
function phoneCheck() {
  let phone = $("#phone").val().trim();
  let msg = $("#checkPhoneMsg");

  // 010-0000-0000 형식인지 정규표현식으로 체크
  let isValid = /^\d{3}-\d{4}-\d{4}$/.test(phone);
  

  if (phone.length === 0) {
    msg.html(""); // 아무것도 입력 안 했으면 메시지 없음
    $("#phone").css({"background-color": "", "border": "", "outline": ""});
    checkPhone = true; updateEnrollBtn();
    return;
  }
  if (!isValid) {
    msg.html("올바르지 않은 입력입니다.").css("color", "#E44E37");
    $("#phone").css({
      "background-color": "#fff8f8",
      "border": "1px solid #e7624d",
      "outline": "0.5px solid #e7624d"
    });
    checkPhone = false; updateEnrollBtn();
  } else {
    msg.html("<i class='fa fa-check-circle' style='font-size: 12px'></i>").css("color", "");;
    $("#phone").css({
      "background-color": "#f8fbf8",
      "border": "",
      "outline": ""
    });
    checkPhone = true; updateEnrollBtn();
  }
}

function isValidDate(str) {
  // 1. 정규식으로 기본 형식 검사 (YYYY-MM-DD)
  if(!/^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])$/.test(str)) {
	return false;
  }
  // 2. Date 객체로 진짜 날짜인지 체크
  let [year, month, day] = str.split('-').map(Number);
  let date = new Date(year, month - 1, day); // month는 0~11
  // 날짜를 다시 문자열로 만들어서 비교
  return (
	year > 1900 &&
    date.getFullYear() === year &&
    date.getMonth() + 1 === month &&
    date.getDate() === day
  );
}
</script> 
</body>