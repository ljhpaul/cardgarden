<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />
<c:if test="${not empty msg}">
  <script>alert('${msg}');</script>
</c:if>

<jsp:include page="/WEB-INF/views/common/mypageheader.jsp" />
<link rel="stylesheet" href="${cpath}/resources/css/common.css">
<link rel="stylesheet" href="${cpath}/resources/css/header.css">
<link rel="stylesheet" href="${cpath}/resources/css/font-awesome.min.css">
<link rel="stylesheet" href="${cpath}/resources/css/userStyle.css">
<script src="${cpath}/resources/js/header.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<title>회원정보수정</title>

<style>
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}
.wrap {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 90vh;
  background-color: #f0f3f1;
}

.container {
  width: 100%;
  max-width: 900px;
  display: flex;
  justify-content: center;
  border-radius: 24px;
  margin-top: 80px;
}

.box {
  width: 70%;
  background: #fff;
  border-radius: 24px;
  padding: 44px 50px 32px;
  font-family: var(--font);
}

.form-group {
  margin-bottom: 30px;
  display: flex;
  align-items: center;
}

label {
  display: inline-block;
  width: 120px;
  margin-right: 10px;
  font-weight: bold;
  font-size: 16px;
  color: #3e4e42;
}

.input {
  flex: 1;
  min-width: 150px;
}

.btn {
  min-width: 110px;
  height: 40px;
  margin-left: 10px;
  cursor: pointer;
}

.title-lg {
  font-size: 22px;
  font-weight: bold;
  margin-bottom: 20px;
}

#enroll-form{
padding-left: 20px;
padding-right: 20px;
}
</style>

<body>
<div class="wrap">
  <div class="container">
    <div class="box">
      <h2 class="title-lg">${user.name}님의 회원정보</h2>
      <form id="enroll-form" action="${cpath}/user/mypage" method="post" onsubmit="combineAddress();" autocomplete="off">
        <input type="hidden" name="user_id" value="${user.user_id}">

        <div class="form-group">
          <label for="user_name">아이디</label>
          <input type="text" id="user_name" name="user_name" class="input" readonly placeholder="${user.user_name}">
        </div>

        <div class="form-group">
          <label for="user_password">비밀번호</label>
          <input type="password" id="user_password" readonly name="user_password" class="input" value="${user.user_password}">
          <button type="button" class="btn" onclick="nicknameCheck();">비밀번호 재설정</button>
        </div>

        <div class="form-group">
          <label for="nickname">닉네임</label>
          <input type="text" id="nickname" name="nickname" class="input" value="${user.nickname}">
          <button type="button" class="btn" onclick="nicknameCheck();">중복확인</button>
        </div>

        <div class="form-group">
          <label for="email">이메일</label>
          <input type="email" id="email" name="email" value="${user.email}" class="input">
        </div>

        <div class="form-group">
          <label for="name">이름</label>
          <input type="text" id="name" name="name" class="input" value="${user.name}" maxlength="5">
        </div>

        <div class="form-group">
          <label for="gender">성별</label>
          <select name="gender" class="input">
            <option value="M" ${user.gender == 'M' ? 'selected' : ''}>남</option>
            <option value="F" ${user.gender == 'F' ? 'selected' : ''}>여</option>
          </select>
        </div>

        <div class="form-group">
          <label for="birth">생년월일</label>
          <input type="text" id="birth" name="birth" class="input" placeholder="${user.birth}" readonly maxlength="10">
        </div>

        <div class="form-group">
          <label for="phone">휴대폰번호</label>
          <input type="text" id="phone" name="phone" class="input" value="${user.phone}" maxlength="13">
        </div>

        <div class="form-group">
          <label>주소</label>
          <input type="hidden" id="address" name="address">
          <input type="text" id="detailAddress" name="detailAddress" class="input" style="width: 350px;" value="${user.address}">
          <button type="button" id="addressbtn" class="btn" onclick="execDaumPostcode();">주소 변경하기</button>
        </div>

        <button id="enrollBtn" type="submit" class="btn" style="width:100%; height:50px; font-size:19px; margin-top:10px;">수정하기</button>
      </form>
    </div>
  </div>
</div>

<script>
</script>
</body>

<script>

let prevPhone = "";
$("#phone").on("keydown", function() {
	  prevPhone = $(this).val();
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

//주소변경 버튼 누를 시 회원가입폼에 있는 주소입력창 생성
document.addEventListener("DOMContentLoaded", function () {
  document.getElementById("addressbtn").addEventListener("click", function () {
    const formGroup = this.closest(".form-group");

    formGroup.innerHTML = `
      <label>주소</label>
      <div class="address-fields" style="flex:1; display: flex; flex-direction: column; gap: 8px;">
        <input type="hidden" id="address" name="address">
        
        <div class="addr-row" style="display: flex; gap: 10px;">
          <input type="text" id="postcode" name="postcode" class="input" placeholder="우편번호" readonly>
          <button type="button" class="btn" onclick="execDaumPostcode();" style="min-width:110px; height:40px;">우편번호 찾기</button>
        </div>
        
        <input type="text" id="roadAddress" name="roadAddress" class="input" placeholder="도로명주소" readonly>
        <input type="text" id="extraAddress" name="extraAddress" class="input" readonly>
        <input type="text" id="detailAddress" name="detailAddress" class="input" placeholder="상세주소">
      </div>
    `;
  });
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
</script> 
</body>