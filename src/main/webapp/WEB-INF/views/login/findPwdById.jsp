<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${cpath}/resources/css/common.css">
<link rel="stylesheet" href="${cpath}/resources/css/userStyle.css">
<link rel="stylesheet"
	href="${cpath}/resources/css/font-awesome.min.css">

<head>
<title>카드가든 : 비밀번호 찾기</title>
</head>

<div class="bg-main">
	<div class="container">
		<div class="box">
			<h2 class="title-lg">비밀번호 찾기</h2>

			<div class="inner-box">
				<form id="find-form" action="${cpath}/user/find-password" method="POST"
					autocomplete="off" style="width: 100%;">
					<div>
						<!-- 이름 입력 -->
						<label for="loginId" class="form-label">아이디 입력</label>
						<div class="input-row">
							<input type="text" id="loginId" name="loginId" class="input" />
							<button type="button" id="loginId-check-btn" class="btn btn-sub">
              					확인
            				</button>
						</div>
						
						<!-- 안내 메시지 출력 -->
						<div id="msg-area" class="msg-area">・ </div>
						
						<!-- 다음 버튼 -->
						<button type="submit" id="next-btn" class="btn" disabled>
							다음
						</button>	
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<style>
  body {
	font-family: 'NanumSquareRound', sans-serif;
	background-color: #F0F3F1;
	padding: 0;
	margin: 0;
  }
  .container {
    padding-top: 110px;
  }
  .box {
    max-width: 440px;
    width: 100%;
    padding: 40px 32px;
    box-sizing: border-box;
  }
  .inner-box {
    min-width: 380px;
	padding: 36px 30px 20px;
	font-size: 16px;
  }
  .form-label {
    font-weight: 600;
    color: var(--m1);
    font-size: 16px;
  }
  .input-row {
    display: flex;
    gap: 8px;
    margin-top: 10px;
    width: 100%;
  }
  .btn-sub {
    min-width:80px;
    font-size:16px;
    height:44px;
  }
  .msg-area {
    margin-top: 8px;
    color: #999;
    font-size: 14px;
  }
  #next-btn {
    width: 100%;
    height: 48px;
    font-size: 18px;
    margin-top: 25px;
  }
</style>

<script>
  $(function() {
	var msg = "${alertMsg}";
    if(msg) { alert(msg); }
  });

  // 기본 안내 메시지 출력
  $(function() { resetMessage(); });
  $("#loginId").on("input", resetMessage);

  // 중복체크 및 인증메일 요청
  $('#loginId-check-btn').on('click', function() {
    const loginId = $("#loginId").val();
    
    if (!loginId) {
      $('#msg-area').html('・ 아이디를 입력하세요.')
      $("#msg-area").css('color','#E44E37');
      return;
    }
    
    $.ajax({
      url: '${cpath}/auth/loginId/check',
      type: 'POST',
      data: {loginId: loginId},
      success: function(res) {
    	if(res.duplicate) {
      	  /* $("#loginId").prop("readonly", true); */
          $("#loginId").css("background-color", "var(--main)");
    	  $('#msg-area').html('<i class="fa fa-check-circle"></i> 확인완료')
      	  $("#msg-area").css('color','var(--m1)').css('text-align', 'center');
    	  $('#next-btn').prop('disabled', false);
    	} else {
    	  $('#msg-area').html('・ 존재하지 않는 아이디입니다.')
    	  $("#msg-area").css('color','#E44E37');
    	}
      }
    });
  });
  
  // 안내 메시지 초기화
  function resetMessage() {
	const message = "・ 회원정보에 등록한 아이디와 입력한 아이디가 같아야,<br>&nbsp;&nbsp;&nbsp;비밀번호 찾기를 진행할 수 있습니다.";
	$("#msg-area").html(message);
	$("#msg-area").css('color','#999').css('text-align', '');
	$("#loginId").css('background-color', '');
	$('#next-btn').prop('disabled', true);
  }
</script>
