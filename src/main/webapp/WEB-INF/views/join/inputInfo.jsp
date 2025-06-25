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
  <script>alert('${msg}');</script>
</c:if>

<head>
    <title>카드가든 : 회원가입</title>
</head>

<body class="bg-main">
  <div class="container">
    <div class="box">
      <h2 class="title-lg">회원정보 입력</h2>
      <form id="enroll-form" action="${cpath}/user/join/info" method="post" onsubmit="combineAddress();" autocomplete="off" style="width:100%;">
        
        <!-- 아이디 -->
        <div class="form-group" style="margin-bottom:17px;">
          <label for="user_name" style="font-weight:600;">아이디 <span style="color:#dc3545">*</span></label>
          <div style="display: flex; gap: 10px;">
            <input type="text" id="user_name" name="user_name" class="input" required placeholder="영문, 숫자 포함 4~12자" maxlength="12" style="flex:1;">
            <button type="button" class="btn" onclick="idCheck();" style="min-width:90px; height:40px;">중복확인</button>
          </div>
        </div>

        <!-- 비밀번호 -->
        <div class="form-group" style="margin-bottom:17px;">
          <label for="user_password" style="font-weight:600;">비밀번호 <span style="color:#dc3545">*</span></label>
          <input type="password" id="user_password" name="user_password" class="input" required placeholder="영문, 숫자, 특수문자 6~15자" maxlength="15">
        </div>
        <!-- 비밀번호 확인 -->
        <div class="form-group" style="margin-bottom:10px;">
          <label for="user_password_check" style="font-weight:600;">비밀번호 확인</label>
          <input type="password" id="user_password_check" class="input" required>
          <span id="checkPwdMsg" style="font-size:13px; font-weight:600; margin-left:5px;"></span>
        </div>
        
        <!-- 닉네임 -->
        <div class="form-group" style="margin-bottom:17px;">
          <label for="nickname" style="font-weight:600;">닉네임</label>
          <input type="text" id="nickname" name="nickname" class="input" required placeholder="총 8글자" maxlength="8" style="flex:1;">
          <button type="button" class="btn" onclick="nicknameCheck();" style="min-width:90px; height:40px;">중복확인</button>
        </div>
        
        <!-- 이메일 -->
        <div class="form-group" style="margin-bottom:25px;">
          <label for="email" style="font-weight:600;">이메일 <span style="color:#dc3545">*</span></label>
          <div style="display: flex; gap: 10px;">
            <input type="email" id="email" name="email" class="input" required placeholder="${verifiedEmail}" readonly style="flex:1;">
          </div>
        </div>

        <!-- 이름 -->
        <div class="form-group" style="margin-bottom:17px;">
          <label for="name" style="font-weight:600;">이름 <span style="color:#dc3545">*</span></label>
          <input type="text" id="name" name="name" class="input" required placeholder="한글 2~5글자" maxlength="5">
        </div>

        <!-- 성별 -->
        <div class="form-group" style="margin-bottom:17px;">
          <label for="gender" style="font-weight:600;">성별</label>
          <select name="gender" class="input" required>
            <option value="M">남</option>
            <option value="F">여</option>
          </select>
        </div>
        
		<!-- 생년월일 -->
        <div class="form-group" style="margin-bottom:17px;">
          <label for="birth" style="font-weight:600;">생년월일 </label>
          <div style="display: flex; gap: 10px;">
            <input type="text" id="birth" name="birth" class="input" required placeholder="2000-01-01" maxlength="10" style="flex:1;">
          </div>
        </div>
        
        <!-- 휴대폰번호 -->
        <div class="form-group" style="margin-bottom:17px;">
          <label for="phone" style="font-weight:600;">휴대폰번호 <span style="color:#dc3545">*</span></label>
          <div style="display: flex; gap: 10px;">
            <input type="text" id="phone" name="phone" class="input" required placeholder="010-0000-0000" maxlength="13" style="flex:1;">
          </div>
        </div>
        
        <!-- 주소 -->
        <div class="form-group" style="margin-bottom:10px;">
          <label style="font-weight:600;">주소</label>
          <input type="hidden" id="address" name="address">
          <div style="display:flex; gap:10px; margin-bottom:8px;">
            <input type="text" id="postcode" name="postcode" class="input" placeholder="우편번호" readonly style="flex:1;">
            <button type="button" class="btn" onclick="execDaumPostcode();" style="min-width:110px; height:40px;">우편번호 찾기</button>
          </div>
          <input type="text" id="roadAddress" name="roadAddress" class="input" placeholder="도로명주소" readonly style="margin-bottom:8px;">
          <input type="text" id="extraAddress" name="extraAddress" class="input" readonly style="margin-bottom:8px;">
          <div style="display:flex; gap:10px;">
            <input type="text" id="detailAddress" name="detailAddress" class="input" placeholder="상세주소" style="flex:1;">
          </div>
        </div>

        <!-- 가입 버튼 -->
        <button id="enrollBtn" type="submit" class="btn" style="width:100%; height:50px; font-size:19px; margin-top:10px;">가입하기</button>
      </form>
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
  max-width: 520px;
  margin: 70px auto 80px;
  background: #fff;
  border-radius: 24px;
  padding: 44px 50px 32px;
  font-family: var(--font);
}

</style>

<script>
  // 이메일 자동 완성
  let verifiedEmail = "${sessionScope.verifiedEmail}";
  if(verifiedEmail == "") {
	  alert("세션이 만료되었습니다.")
  } else {
	  $("#email").val(verifiedEmail);
	  $("#email").css("background-color", "var(--main)");
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
  
  // 생년월일 입력 검증
  $("#birth").on("input", function() {
	// 입력값 숫자만 남기기
    let birth = $(this).val();
    let birthNums = birth.replace(/\D/g, '');
    
	// 숫자 사이에 바(-) 삽입
	if(birth + "-" == prevBirth) {
		birth = birth.slice(0, -1);
	} else if(birth.length == 4) {
		birth = birthNums.slice(0, 4) + "-";
	} else if(birth.length > 4 && birth.length < 6) {
		birth = birthNums.slice(0, 4) + "-" + birthNums.slice(4);
    } else if(birth.length == 6) {
    	birth = birthNums.slice(0, 4) + "-" + birthNums.slice(4, 6) + "-";
    } else if(birth.length > 6) {
    	birth = birthNums.slice(0, 4) + "-" + birthNums.slice(4, 6) + "-" + birthNums.slice(6);
    }
    
	// 입력창에 최신화
	$(this).val(birth);
  });
  
  // 휴대폰번호 입력 검증
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
/*         $('#extraAddress').val(roadAddr !== '' ? extraRoadAddr : ''); */
        $('#detailAddress').focus();
      }
    }).open();
  }
  
  // 주소 결합 : address = (postcode) roadAddress (detailAddress), extraAddress
  // (03143) 서울 종로구 율곡로2길 7 (수송동), 532호
  function combineAddress() {
	let postcode = $("#postcode").val();
	let roadAddress = $("#roadAddress").val();
	let detailAddress = $("#detailAddress").val();
	let extraAddress = $("#extraAddress").val();
	let address = postcode + "/" +  roadAddress + "/" + (extraAddress ? extraAddress : " ") + "/" + detailAddress;
	$("#address").val(address);
  }

  // 비밀번호 일치 체크
  $('#user_password, #user_password_check').keyup(function() {
    let a = $("#user_password").val();
    let b = $("#user_password_check").val();
    let msg = $("#checkPwdMsg");
    if (a === b) {
      msg.text("일치").css("color", "#46b36c");
    } else {
      msg.text("불일치").css("color", "#b24444");
    }
  });

  // 중복확인 로직 (실제 서버 주소/파라미터 맞게 수정)
  let checkId = false, checkNickname = false;

  function idCheck() {
    let $user_name = $("#user_name");
    $.ajax({
      url: "${cpath}/user/checkId",
      type: "post",
      data: { user_name: $user_name.val() },
      success: function(result) {
        if (result > 0) {
          alert("이미 사용중인 아이디입니다.");
          $user_name.focus();
        } else {
          if (confirm("사용 가능한 아이디입니다. 사용하시겠습니까?")) {
            $user_name.attr("readonly", true);
            checkId = true;
          } else {
            $user_name.focus();
            checkId = false;
          }
        }
      }
    });
  }
  
  function nicknameCheck() {
	    let $user_name = $("#user_name");
	    $.ajax({
	      url: "${cpath}/user/checkId",
	      type: "post",
	      data: { user_name: $user_name.val() },
	      success: function(result) {
	        if (result > 0) {
	          alert("이미 사용중인 아이디입니다.");
	          $user_name.focus();
	        } else {
	          if (confirm("사용 가능한 아이디입니다. 사용하시겠습니까?")) {
	            $user_name.attr("readonly", true);
	            checkId = true;
	          } else {
	            $user_name.focus();
	            checkId = false;
	          }
	        }
	      }
	    });
	  }
/*
  // 가입 가능 조건 체크 (버튼 enable)
  setInterval(checkInfo, 500);
  function checkInfo() {
    if (checkId && checkNickname) {
      $("#enrollBtn").removeAttr("disabled");
    } else {
      $("#enrollBtn").attr("disabled", true);
    }
  }

  // 필수 유효성 검사
  $('#enroll-form').on('submit', function() {
    let id = $("#user_name").val();
    let pwd = $("#user_password").val();
    let pwd2 = $("#user_password_check").val();
    let name = $("#name").val();
    let phone = $("#phone").val();
    let email = $("#email").val();
    let idRegex = /^[a-zA-Z0-9]{4,12}$/;
    let pwdRegex = /^\S{6,15}$/;
    let nameRegex = /^[가-힣]{2,5}$/;
    let phoneRegex = /^[0-9]{11}$/;

    if(!idRegex.test(id)) { alert("아이디 형식 오류"); $("#user_name").focus(); return false; }
    if(!pwdRegex.test(pwd)) { alert("비밀번호 형식 오류"); $("#user_password").focus(); return false; }
    if(pwd !== pwd2) { alert("비밀번호가 일치하지 않습니다."); $("#user_password_check").focus(); return false; }
    if(!nameRegex.test(name)) { alert("이름 형식 오류"); $("#name").focus(); return false; }
    if(!phoneRegex.test(phone)) { alert("전화번호 형식 오류"); $("#phone").focus(); return false; }
    if(!email) { alert("이메일을 입력하세요."); $("#email").focus(); return false; }
    return true;
  });
  */
</script>
