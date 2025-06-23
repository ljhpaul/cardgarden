<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${cpath}/resources/css/common.css">
<link rel="stylesheet" href="${cpath}/resources/css/join.css">
<link rel="stylesheet" href="${cpath}/resources/css/font-awesome.min.css">

<head>
    <title>카드가든 : 회원가입</title>
</head>

<div class="join-bg">
  <div class="join-container">
    <div class="join-box">
      <h2 class="join-title">이메일 인증</h2>
      
      <form id="email-form" action="${cpath}/user/join/email" method="POST" autocomplete="off" style="width:100%;">
        <div style="width:100%; margin-bottom:16px;">
          <label for="email" class="email-form-label">이메일 입력</label>
          <div class="email-input-row">
            <input
              type="email"
              id="email"
              name="email"
              required
              class="input-form"
              placeholder="cardgarden@email.com"
              oninput="resetStatus();"
            />
            <button type="button" id="email-request-btn" class="join-btn btn-sub">
              인증요청
            </button>
          </div>
          <div id="email-msg" class="email-msg">
            ・ 입력할 이메일로 인증번호가 발송됩니다.<br>・ 인증메일을 받을 수 있도록 자주 쓰는 이메일을 입력해 주세요.
          </div>
        </div>
        
        <!-- 인증번호 입력란(인증요청 후에만 보이도록) -->
        <div id="code-area">
          <label for="code" class="email-form-label">인증번호</label>
          <div class="email-input-row">
            <input
              type="text"
              id="code"
              name="code"
              maxlength="6"
              class="input-form code-input"
              placeholder="6자리"
              autocomplete="off"
            />
            <button type="button" id="code-check-btn" class="join-btn btn-sub">
              인증확인
            </button>
          </div>
          <div id="code-timer" class="code-timer"></div>
        </div>
        
        <!-- 인증성공 메시지 -->
        <div id="success-msg" class="success-msg">
          <i class="fa fa-check-circle"></i> 인증성공
        </div>
        
        <button type="submit" id="next-btn" class="join-btn" disabled >
          다음
        </button>
      </form>
    </div>
  </div>
</div>

<style>
  .join-container {
    padding-top: 135px;
  }
  .join-box {
    max-width: 440px;
    width: 100%;
    padding: 40px 32px;
    box-sizing: border-box;
  }
  .email-form-label {
    font-weight: 600;
    color: var(--m1);
    font-size: 16px;
  }
  .email-input-row {
    display: flex;
    gap: 8px;
    margin-top: 10px;
    width: 100%;
  }
  .code-input {
    letter-spacing: 2px;
  }
  .email-msg {
    min-height: 35px;
    margin-top: 8px;
    color: #999;
    font-size: 14px;
  }
  .code-timer {
    margin-top: 8px;
    color: #E44E37;
    font-size: 14px;
  }
  .success-msg {
    margin-bottom: 12px;
    color: var(--m1);
    font-weight: 600;
    display: none;
    text-align: center;
  }
  .btn-sub {
    min-width:96px;
    font-size:15px;
    height:44px;
  }
  #next-btn {
    width: 100%;
    height: 48px;
    font-size: 18px;
    margin-top: 40px;
  }
  #code-area {
    width: 100%;
    margin-bottom: 16px;
    display: none;
  }
</style>

<script>
  // 중복체크 및 인증메일 요청
  $('#email-request-btn').on('click', function() {
    const email = $('#email').val().trim();
    if (!email) {
      $('#email-msg').css('color','#E44E37').text('・ 이메일을 입력하세요.');
      return;
    } else if (!validateEmail(email)) {
    	  $('#email-msg').css('color', '#E44E37').text('・ 올바르지 않은 이메일 형식입니다.');
    	  return;
    }
    // 이메일 중복여부 및 유효성 검사
    $.ajax({
      url: '${cpath}/auth/email/check',
      type: 'POST',
      data: {email: email},
      success: function(res) {
        if(res.duplicate) {
          $('#email-msg').css('color','#E44E37').text('・ 이미 사용 중인 이메일입니다.');
        } else {
          // 인증코드 발송
          $.ajax({
            url: '${cpath}/auth/email/send',
            type: 'POST',
            data: {email: email},
            success: function() {
              $('#email-msg').css('color','#8FB098').text('・ 인증번호가 발송되었습니다. (유효시간 3분)');
              $('#code-area').show();
              startTimer(180);
            }
          });
        }
      }
    });
  });

  // 인증번호 확인
  $('#code-check-btn').on('click', function() {
    const code = $('#code').val().trim();
    if (!code) return;
    $.ajax({
      url: '${cpath}/auth/email/verify',
      type: 'POST',
      data: {code: code},
      success: function(res) {
        if(res.valid) {
          $('#success-msg').show();
          $('#next-btn').prop('disabled', false);
          $('#code-timer').hide();
        } else {
          $('#code-timer').css('color','#E44E37').text('・ 인증번호가 올바르지 않거나 만료되었습니다.');
        }
      }
    });
  });

  // 타이머
  let timer = null, remain = 0;
  function startTimer(sec) {
    clearInterval(timer);
    remain = sec;
    $('#code-timer').show();
    timer = setInterval(function() {
      if(remain > 0) {
        let m = Math.floor(remain/60), s = remain%60;
        $('#code-timer').css('color','#8FB098').text('・ 남은 시간: '+m+'분 '+s+'초');
        remain--;
      } else {
        clearInterval(timer);
        $('#code-timer').css('color','#E44E37').text('・ 인증번호가 만료되었습니다.');
      }
    },1000);
  }

  // 상태 초기화
  function resetStatus() {
    $('#email-msg').css('color','#999').html('・ 입력할 이메일로 인증번호가 발송됩니다.<br>・ 인증메일을 받을 수 있도록 자주 쓰는 이메일을 입력해 주세요.');
    $('#code-area').hide();
    $('#success-msg').hide();
    $('#next-btn').prop('disabled', true);
    clearInterval(timer);
    $('#code-timer').hide();
  }
  
  // 이메일 형식 검증
  function validateEmail(email) {
	  const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	  return re.test(email);
  }
  
  // 인증번호 형식 검증
  function validateCode(code) {
	  const re = /^\d{6}$/;
	  return re.test(code);
  }
</script>
