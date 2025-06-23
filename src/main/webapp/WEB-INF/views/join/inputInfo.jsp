<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<!-- 공통 헤더/스타일/스크립트 -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${cpath}/resources/css/common.css">
<link rel="stylesheet" href="${cpath}/resources/css/header.css">
<link rel="stylesheet" href="${cpath}/resources/css/font-awesome.min.css">
<link rel="stylesheet" href="${cpath}/resources/css/join.css">
<script src="${cpath}/resources/js/header.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<head>
    <title>카드가든 : 회원가입</title>
</head>

<div class="join-bg">
  <div class="join-container">
    <div class="join-box" style="padding: 40px 40px; min-width:370px; max-width:480px;">
      <h2 style="font-size: 26px; font-weight: 700; margin-bottom: 28px;">회원정보 입력</h2>
      <form id="enroll-form" action="${cpath}/user/join/submitInfo" method="post" autocomplete="off" style="width:100%;">
        
        <!-- 이름 -->
        <div class="form-group" style="margin-bottom:17px;">
          <label for="memberName" style="font-weight:600;">이름 <span style="color:#dc3545">*</span></label>
          <input type="text" id="memberName" name="memberName" class="form-control" required placeholder="한글 2~5글자" maxlength="5">
        </div>

        <!-- 닉네임 -->
        <div class="form-group" style="margin-bottom:17px;">
          <label for="memberNickName" style="font-weight:600;">닉네임</label>
          <input type="text" id="memberNickName" name="memberNickName" class="form-control" required placeholder="총 8글자" maxlength="8">
        </div>

        <!-- 아이디 -->
        <div class="form-group" style="margin-bottom:17px;">
          <label for="memberId" style="font-weight:600;">아이디 <span style="color:#dc3545">*</span></label>
          <div style="display: flex; gap: 10px;">
            <input type="text" id="memberId" name="memberId" class="form-control" required placeholder="영문, 숫자 포함 4~12자" maxlength="12" style="flex:1;">
            <button type="button" class="join-btn" onclick="idCheck();" style="min-width:90px; height:40px;">중복확인</button>
          </div>
        </div>

        <!-- 비밀번호 -->
        <div class="form-group" style="margin-bottom:17px;">
          <label for="memberPwd" style="font-weight:600;">비밀번호 <span style="color:#dc3545">*</span></label>
          <input type="password" id="memberPwd" name="memberPwd" class="form-control" required placeholder="영문, 숫자, 특수문자 6~15자" maxlength="15">
        </div>
        <!-- 비밀번호 확인 -->
        <div class="form-group" style="margin-bottom:10px;">
          <label for="memberPwd_check" style="font-weight:600;">비밀번호 확인</label>
          <input type="password" id="memberPwd_check" class="form-control" required>
          <span id="checkPwdMsg" style="font-size:13px; font-weight:600; margin-left:5px;"></span>
        </div>

        <!-- 나이 -->
        <div class="form-group" style="margin-bottom:17px;">
          <label for="age" style="font-weight:600;">나이</label>
          <input type="number" min="14" max="100" name="age" class="form-control" placeholder="만 14세 이상">
        </div>

        <!-- 성별 -->
        <div class="form-group" style="margin-bottom:17px;">
          <label for="gender" style="font-weight:600;">성별</label>
          <select name="gender" class="form-control" required>
            <option value="M">남</option>
            <option value="F">여</option>
          </select>
        </div>

        <!-- 주소 -->
        <div class="form-group" style="margin-bottom:10px;">
          <label style="font-weight:600;">주소</label>
          <div style="display:flex; gap:10px; margin-bottom:8px;">
            <input type="text" id="postcode" name="postcode" class="form-control" placeholder="우편번호" readonly style="flex:1;">
            <button type="button" class="join-btn" onclick="execDaumPostcode();" style="min-width:110px; height:40px;">우편번호 찾기</button>
          </div>
          <input type="text" id="roadAddress" name="roadAddress" class="form-control" placeholder="도로명주소" readonly style="margin-bottom:8px;">
          <input type="text" id="jibunAddress" name="jibunAddress" class="form-control" placeholder="지번주소" readonly style="margin-bottom:8px;">
          <div style="display:flex; gap:10px;">
            <input type="text" id="detailAddress" name="detailAddress" class="form-control" placeholder="상세주소" style="flex:1;">
            <input type="text" id="extraAddress" name="extraAddress" class="form-control" placeholder="참고항목" readonly style="flex:1;">
          </div>
        </div>

        <!-- 전화번호 -->
        <div class="form-group" style="margin-bottom:17px;">
          <label for="phone" style="font-weight:600;">전화번호 <span style="color:#dc3545">*</span></label>
          <div style="display: flex; gap: 10px;">
            <input type="text" id="phone" name="phone" class="form-control" required placeholder="숫자만 11글자" maxlength="11" style="flex:1;">
            <button type="button" class="join-btn" onclick="phoneCheck();" style="min-width:90px; height:40px;">중복확인</button>
          </div>
        </div>

        <!-- 이메일 -->
        <div class="form-group" style="margin-bottom:25px;">
          <label for="email" style="font-weight:600;">이메일 <span style="color:#dc3545">*</span></label>
          <div style="display: flex; gap: 10px;">
            <input type="email" id="email" name="email" class="form-control" required placeholder="이메일 입력" maxlength="50" style="flex:1;">
            <button type="button" class="join-btn" onclick="emailCheck();" style="min-width:90px; height:40px;">중복확인</button>
          </div>
        </div>

        <!-- 가입 버튼 -->
        <button id="enrollBtn" type="submit" class="join-btn" style="width:100%; height:50px; font-size:19px; margin-top:10px;" disabled>가입하기</button>
      </form>
    </div>
  </div>
</div>

<script>
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
        $('#jibunAddress').val(data.jibunAddress);
        $('#extraAddress').val(roadAddr !== '' ? extraRoadAddr : '');
        $('#detailAddress').focus();
      }
    }).open();
  }

  // 약관 전체동의
  $('#checkAll').on('change', function() {
    $('.checkbox').prop('checked', $(this).prop('checked'));
  });

  // 비밀번호 일치 체크
  $('#memberPwd, #memberPwd_check').keyup(function() {
    let a = $("#memberPwd").val();
    let b = $("#memberPwd_check").val();
    let msg = $("#checkPwdMsg");
    if (a === b) {
      msg.text("일치").css("color", "#46b36c");
    } else {
      msg.text("불일치").css("color", "#b24444");
    }
  });

  // 중복확인 로직 (실제 서버 주소/파라미터 맞게 수정)
  let checkId = false, checkPhone = false, checkEmail = false;

  function idCheck() {
    let $memberId = $("#memberId");
    $.ajax({
      url: "${cpath}/user/checkId",
      type: "post",
      data: { memberId: $memberId.val() },
      success: function(result) {
        if (result > 0) {
          alert("이미 사용중인 아이디입니다.");
          $memberId.focus();
        } else {
          if (confirm("사용 가능한 아이디입니다. 사용하시겠습니까?")) {
            $memberId.attr("readonly", true);
            checkId = true;
          } else {
            $memberId.focus();
            checkId = false;
          }
        }
      }
    });
  }
  function phoneCheck() {
    let $phone = $("#phone");
    $.ajax({
      url: "${cpath}/user/checkPhone",
      type: "post",
      data: { phone: $phone.val() },
      success: function(result) {
        if (result > 0) {
          alert("이미 사용중인 번호입니다.");
          $phone.focus();
        } else {
          if (confirm("사용 가능한 번호입니다. 사용하시겠습니까?")) {
            $phone.attr("readonly", true);
            checkPhone = true;
          } else {
            $phone.focus();
            checkPhone = false;
          }
        }
      }
    });
  }
  function emailCheck() {
    let $email = $("#email");
    $.ajax({
      url: "${cpath}/user/checkEmail",
      type: "post",
      data: { email: $email.val() },
      success: function(result) {
        if (result > 0) {
          alert("이미 사용중인 이메일입니다.");
          $email.focus();
        } else {
          if (confirm("사용 가능한 이메일입니다. 사용하시겠습니까?")) {
            $email.attr("readonly", true);
            checkEmail = true;
          } else {
            $email.focus();
            checkEmail = false;
          }
        }
      }
    });
  }

  // 가입 가능 조건 체크 (버튼 enable)
  setInterval(checkInfo, 500);
  function checkInfo() {
    if (checkId && checkPhone && checkEmail) {
      $("#enrollBtn").removeAttr("disabled");
    } else {
      $("#enrollBtn").attr("disabled", true);
    }
  }

  // 필수 유효성 검사
  $('#enroll-form').on('submit', function() {
    let id = $("#memberId").val();
    let pwd = $("#memberPwd").val();
    let pwd2 = $("#memberPwd_check").val();
    let name = $("#memberName").val();
    let phone = $("#phone").val();
    let email = $("#email").val();
    let idRegex = /^[a-zA-Z0-9]{4,12}$/;
    let pwdRegex = /^\S{6,15}$/;
    let nameRegex = /^[가-힣]{2,5}$/;
    let phoneRegex = /^[0-9]{11}$/;

    if(!idRegex.test(id)) { alert("아이디 형식 오류"); $("#memberId").focus(); return false; }
    if(!pwdRegex.test(pwd)) { alert("비밀번호 형식 오류"); $("#memberPwd").focus(); return false; }
    if(pwd !== pwd2) { alert("비밀번호가 일치하지 않습니다."); $("#memberPwd_check").focus(); return false; }
    if(!nameRegex.test(name)) { alert("이름 형식 오류"); $("#memberName").focus(); return false; }
    if(!phoneRegex.test(phone)) { alert("전화번호 형식 오류"); $("#phone").focus(); return false; }
    if(!email) { alert("이메일을 입력하세요."); $("#email").focus(); return false; }
    return true;
  });
</script>
