<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />
<c:if test="${not empty msg}">
  <script>alert('${msg}');</script>
</c:if>

<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${cpath}/resources/css/common.css">
<link rel="stylesheet" href="${cpath}/resources/css/header.css">
<link rel="stylesheet" href="${cpath}/resources/css/font-awesome.min.css">
<link rel="stylesheet" href="${cpath}/resources/css/userStyle.css">
<script src="${cpath}/resources/js/header.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<head>
  <title> 카드가든 : 회원정보수정</title>
<head>

<style>
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

body {
  font-family: 'NanumSquareRound', sans-serif;
  background-color: #F0F3F1;
  padding: 0;
  margin: 0;
}

.container {
  width: 100%;
  max-width: 1000px;
  height: 120%;
  display: flex;
  justify-content: center;
  align-items: flex-start;
  border-radius: 24px;
  margin: 0 auto;
  padding-top: 0px;
  gap: 28px;
}

.sidebar {display: flex;
  flex-direction: column;
  gap: 40px;
  min-width: 240px;
  max-width: 280px;
  margin-top: 40px;
}

.box-nav {
  width: 220px; /* 왼쪽 메뉴 폭 고정 */
  min-width: 180px;
  max-width: 240px;
  border-radius: 24px;
  padding: 20px 20px;
  box-sizing: border-box;
}

.box-content {
  width: 70%;
  border-radius: 24px;
  padding: 44px 50px 32px;
  margin-right: 50px;
}

.title-lg-nav {
  font-size: 24px;
  font-weight: bold;
  margin-bottom: 10px;
}

.title-lg-content {
  font-size: 32px;
  font-weight: bold;
  margin-bottom: 30px;
}

.inner-box-nav {
  width: 100%;
  padding: 25px 30px;
  font-size: 12px;
  margin-top: 10px;
}

.inner-box-nav a {
  display: block;
  color: #3e4e42;
  font-size: 16px;
  font-weight: bold;
  margin-bottom: 16px;
  transition: color 0.2s;
}
.inner-box-nav a:last-child {
  margin-bottom: 0;
}
.inner-box-nav a:hover {
  color: var(--m1);
  text-shadow: 0 0 1px rgba(100,130,120,0.08);
}

.inner-box-content {
  padding: 25px 25px;
  font-size: 20px;
  gap: 5px;
  margin-bottom: 20px;
}

.form-group {
  margin-bottom: 30px;
  display: flex;
  align-items: center;
}
.form-group-end {
  margin-bottom: 0px;
}


label {
  display: inline-block;
  width: 90px;
  margin-right: 10px;
  font-weight: bold;
  font-size: 16px;
  color: #3e4e42;
}

.input {
  flex: 1;
  width: 350px;
  min-width: 150px;
}
.input-readonly {
  background-color: #f8fbf8;
}
.btn {
  min-width: 110px;
  height: 40px;
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

#enroll-form{
  padding: 0px 12px;
}
</style>

<body class="bg-main">
  <div class="container">
    <div class="sidebar">
  	  <!-- 마이페이지 네비게이터 -->
      <div class="box box-nav">
        <h2 class="title-lg title-lg-nav">마이페이지</h2>
        <div class="inner-box inner-box-nav">
    	  <a href="${cpath}/user/mypage">내 정보관리</a><br>
    	  <a href="${cpath}/user/point">포인트관리</a><br>
    	  <a href="${cpath}/user/card">내 카드관리</a><br>
    	  <a href="${cpath}/user/consumptionPattern">소비패턴관리</a>
        </div>
      </div>
    
      <!-- 관리자페이지 네비게이터 -->
      <div class="box box-nav">
        <h2 class="title-lg title-lg-nav">관리자페이지</h2>
        <div class="inner-box inner-box-nav">
    	  <a href="${cpath}/user/mypage">내 정보관리</a><br>
    	  <a href="${cpath}/user/point">포인트관리</a><br>
    	  <a href="${cpath}/user/card">내 카드관리</a><br>
    	  <a href="${cpath}/user/consumptionPattern">소비패턴관리</a>
        </div>
      </div>
    </div>
    
    <!-- 회원정보 -->
    <div class="box box-content">
      <h2 class="title-lg title-lg-content">${user.name}님의 회원정보</h2>
      <form id="enroll-form" action="${cpath}/user/mypage" method="post" onsubmit="combineAddress();" autocomplete="off">
        <input type="hidden" name="user_id" value="${user.user_id}">
        <input type="hidden" name="user_password" value="${user.user_password}">
		
		<div class="inner-box inner-box-content">
	        <div class="form-group">
	          <label for="user_name">아이디</label>
	          <input type="text" id="user_name" name="user_name" class="input input-readonly" readonly value="${user.user_name}">
	        </div>
	
	        <div class="form-group">
	          <label for="nickname">닉네임</label>
	          <input type="text" id="nickname" name="nickname" class="input" value="${user.nickname}">
	          <button type="button" class="btn" onclick="nicknameCheck();">중복확인</button>
	        </div>
	
	        <div class="form-group form-group-end">
	          <label for="email">이메일</label>
	          <input type="email" id="email" name="email" value="${user.email}" class="input input-readonly" readonly>
	        </div>
        </div>
        
		<div class="inner-box inner-box-content">
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
	          <input type="text" id="birth" name="birth" class="input input-readonly" value="${user.birth}" readonly maxlength="10" readonly>
	        </div>
	
	        <div class="form-group">
	          <label for="phone">휴대폰번호</label>
	          <input type="text" id="phone" name="phone" class="input" value="${user.phone}" maxlength="13">
	        </div>
	        
	        <div class="form-group form-group-end">
	          <label>주소</label>
	          <input type="hidden" id="address" name="address">
	          <input type="text" id="addressView" name="addressView" class="input input-readonly" value="${user.address}" readonly>
	          <button type="button" id="addressbtn" class="btn" onclick="execDaumPostcode();">주소 변경하기</button>
	        </div>
		</div>

        <button id="enrollBtn" type="submit" class="btn">수정하기</button>
      </form>
    </div>
  </div>
</body>

<script>
$(function() {
  const address = "${user.address}";
  const addressParts = address.split("/");

  const roadAddress = addressParts[1] || '';
  const detailAddress = addressParts[3] || '';
  
  if(addressParts.length == 1) {
	var addressView = addressParts[0];
  } else {
	var addressView = roadAddress + (detailAddress!=""?", "+detailAddress:"");  
  }
  
  $("#addressView").val(addressView);
});

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
    const address = "${user.address}";
    const addressParts = address.split('/');
    console.log(addressParts);

    const postcode = addressParts[0] || '';
    const roadAddress = addressParts[1] || '';
    const extraAddress = addressParts[2] || '';
    const detailAddress = addressParts[3] || '';
    console.log(postcode, roadAddress, extraAddress, detailAddress);

    formGroup.innerHTML = `
      <label>주소</label>
      <div class="address-fields" style="flex:1; display: flex; flex-direction: column; gap: 8px;">
        <input type="hidden" id="address" name="address">
        
        <div class="addr-row" style="display: flex; gap: 10px;">
          <input type="text" id="postcode" name="postcode" class="input input-readonly" placeholder="우편번호" readonly value="\${postcode}">
          <button type="button" class="btn" onclick="execDaumPostcode();" style="min-width:110px; height:40px;">우편번호 찾기</button>
        </div>
        
        <input type="text" id="roadAddress" name="roadAddress" class="input input-readonly" placeholder="도로명주소" readonly value="\${roadAddress}">
        <input type="text" id="extraAddress" name="extraAddress" class="input input-readonly" readonly value="\${extraAddress}">
        <input type="text" id="detailAddress" name="detailAddress" class="input" placeholder="상세주소" value="\${detailAddress}">
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

// 주소 결합 : address = postcode/roadAddress/extraAddress/detailAddress
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