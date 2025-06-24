<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${cpath}/resources/css/common.css">
<link rel="stylesheet" href="${cpath}/resources/css/header.css">
<link rel="stylesheet" href="${cpath}/resources/css/font-awesome.min.css">
<link rel="stylesheet" href="${cpath}/resources/css/style.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${cpath}/resources/js/header.js"></script>

<head>
    <title>카드가든 : 회원가입</title>
</head>

<body class="bg-main">
<div class="container">
<div class="box">
  <h2 class="title-lg">약관 동의</h2>
<!--   <div class="term-step-nav">
    <span class="step current">약관 동의</span>
    <span class="step">&nbsp;|&nbsp;이메일 인증</span>
    <span class="step">&nbsp;|&nbsp;회원 정보 입력</span>
    <span class="step">&nbsp;|&nbsp;회원가입 완료</span>
  </div> -->
  <form id="termForm" action="${cpath}/user/join/term" method="post">
    <label class="term-all-check">
      <input type="checkbox" id="all-agree">
      전체 동의하기
    </label>
    <div class="term-desc">
      위치기반 서비스 이용약관, 광고성 정보 수신 동의를 포함합니다.
    </div>
    <div class="term-list">
      <c:forEach var="term" items="${termList}">
        <div class="term-item">
          <input
            type="checkbox"
            id="term${term.term_id}"
            name="checkedTermList"
            value="${term.term_id}"
            class="term-chk ${term.is_required == 'Y' ? 'required' : 'optional'}">
          <span class="term-label">
            <span class="${term.is_required == 'Y' ? 'essential' : 'optional'}">
              [${term.is_required == 'Y' ? '필수' : '선택'}]
            </span>
            ${term.term_name}
          </span>
          <c:if test="${not empty term.term_content}">
            <button type="button" class="term-detail-btn" data-term-id="${term.term_id}">자세히 &gt;</button>
          </c:if>
        </div>
      </c:forEach>
    </div>
    <button type="submit" id="next-btn" class="btn" disabled>다음</button>
  </form>
</div>
</div>

<!-- 약관 모달 -->
<div class="term-modal-bg" id="termModalBg">
  <div class="term-modal" role="dialog" aria-modal="true" aria-labelledby="modalTitle">
    <div class="term-modal-title" id="modalTitle">약관 제목</div>
    <div class="term-modal-content" id="modalContent" style="white-space: pre-wrap;"></div>
    <div class="term-modal-btns">
      <button type="button" class="btn term-modal-btn" id="agreeBtn">동의</button>
      <button type="button" class="btn term-modal-btn" id="closeBtn">닫기</button>
    </div>
  </div>
</div>

<style>
.box {
  max-width: 520px;
  margin: 70px auto 80px;
  padding: 44px 50px 32px;
}

.term-step-nav {
  display: flex;
  justify-content: center;
  gap: 18px;
  margin-bottom: 36px;
}
.term-step-nav .step {
  font-weight: bold;
  font-size: 16px;
  color: var(--m3);
}
.term-step-nav .current {
  color: var(--m1);
  border-bottom: 2px solid var(--m1);
  padding-bottom: 2px;
}
.term-all-check {
  display: flex;
  align-items: center;
  font-weight: 600;
  font-size: 19px;
  margin-bottom: 7px;
  gap: 8px;
}
.term-all-check input[type=checkbox] {
  width: 22px; height: 22px; accent-color: var(--m1);
}
.term-desc {
  color: #888;
  font-size: 14px;
  margin-bottom: 19px;
  margin-left: 26px;
}
.term-list { margin-bottom: 38px; }
.term-item {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 17px;
}
.term-item input[type=checkbox] {
  width: 20px; height: 20px; accent-color: var(--m1);
}
.term-label { font-size: 16px; font-weight: 500; }
.term-label .essential { color: #eb4d4b; font-size: 13px; margin-right: 2px;}
.term-label .optional { color: var(--m1); font-size: 13px; margin-right: 2px;}
.term-detail-btn {
  background: none;
  border: none;
  color: var(--m3);
  font-size: 14px;
  cursor: pointer;
  font-weight: 600;
  margin-left: 8px;
  transition: color 0.2s;
}
.term-detail-btn:hover { color: var(--m1);}
#next-btn {
  width: 100%; height: 46px;
  background: var(--m1);
  color: #fff; font-size: 18px;
  border: none; border-radius: 10px;
  font-weight: 700; margin-top: 20px;
  transition: background 0.2s;
  cursor: pointer;
  box-shadow: 0 2px 16px rgba(100,130,120,0.08);
}
#next-btn:disabled, #next-btn:disabled:hover { background: #eee; color: #aaa; cursor: not-allowed; }
#next-btn:hover { 
  background-color: var(--m3);
  box-shadow: 0 3px 24px rgba(84, 118, 106, 0.142);
}

.term-modal-bg {
  position: fixed; left: 0; top: 0; width: 100vw; height: 100vh;
  background: rgba(0,0,0,0.30); z-index: 1111; display: none;
}
.term-modal {
  position: fixed; left: 50%; top: 50%; transform: translate(-50%, -50%);
  background: #fff; width: 95vw; max-width: 520px;
  border-radius: 18px; padding: 36px 32px 28px;
  z-index: 1200;
  box-shadow: 0 4px 32px 0 rgba(0,0,0,0.13);
}
.term-modal-title {
  font-size: 20px; font-weight: bold; color: var(--m3); margin-bottom: 18px;
}
.term-modal-content {
  font-size: 15px; color: #333; line-height: 1.7; max-height: 340px; overflow-y: auto; margin-bottom: 22px;
  background-color: #f9faf9;
  padding: 10px;
}
.term-modal-btns {
  display: flex; justify-content: flex-end; gap: 10px;
}
.term-modal-btn {
  padding: 8px 20px; border: none; border-radius: 6px;
  font-size: 15px; font-weight: 600;
  background: var(--m1); color: #fff; cursor: pointer;
}
.term-modal-btn[disabled], .term-modal-btn.disabled {
  background: #eee; color: #aaa; cursor: not-allowed;
}
@media (max-width: 600px) {
  .box { padding: 24px 7vw 20px; }
  .term-modal { padding: 19px 5vw 17px; }
}
</style>


<script>
// 1. 약관 본문 매핑
const termsText = {};
<c:forEach var="term" items="${termList}">
  termsText["${term.term_id}"] = `<c:out value="${term.term_content}" escapeXml="false"/>`;
</c:forEach>

// 2. 전체 동의 체크/해제
$('#all-agree').on('change', function() {
  const checked = $(this).prop('checked');
  $('.term-chk').each(function() {
    if (!$(this).prop('disabled')) {
      $(this).prop('checked', checked).trigger('change');
    }
  });
  updateNextBtn();
});

// 3. 개별 체크 → 전체동의 체크/해제 연동
$('.term-chk').on('change', function() {
  const allCnt = $('.term-chk').length;
  const checkedCnt = $('.term-chk:checked').length;
  $('#all-agree').prop('checked', allCnt === checkedCnt);
  updateNextBtn();
});

// 4. 필수 모두 체크시 버튼 활성화
function updateNextBtn() {
  const allRequiredChecked = $('.term-chk.required').length === $('.term-chk.required:checked').length;
  $('#next-btn').prop('disabled', !allRequiredChecked);
}
updateNextBtn();

// 5. 약관 모달 열기
let currentTermId = '';
$('.term-detail-btn').on('click', function() {
  currentTermId = $(this).data('term-id');
  const $item = $('#term' + currentTermId).closest('.term-item');
  $('#modalTitle').html($item.find('.term-label').text().trim());
  $('#modalContent').html(termsText[currentTermId] || '약관 내용이 없습니다.');
  $('#termModalBg').fadeIn(120);

  if ($('#term' + currentTermId).prop('checked')) {
    $('#agreeBtn').text('동의하셨습니다').prop('disabled', true).addClass('disabled');
  } else {
    $('#agreeBtn').text('동의').prop('disabled', false).removeClass('disabled');
  }
  $('#agreeBtn').focus();
});

// 6. 약관 동의 버튼(체크/모달닫기)
$('#agreeBtn').on('click', function() {
  if (currentTermId) {
    $('#term' + currentTermId).prop('checked', true).trigger('change');
    $('#termModalBg').fadeOut(100);
  }
});

// 7. 모달 닫기
$('#closeBtn, #termModalBg').on('click', function(e) {
  if (e.target.id === 'termModalBg' || e.target.id === 'closeBtn') {
    $('#termModalBg').fadeOut(80);
  }
});

// 8. 동의 후 다시 "자세히" 클릭 → "동의하셨습니다"
$('.term-chk').on('change', function() {
  const termId = $(this).attr('id').replace('term', '');
  if ($(this).prop('checked')) {
    $(`.term-detail-btn[data-term-id="${termId}"]`).each(function() {
      if ($('#termModalBg').is(':visible') && currentTermId == termId) {
        $('#agreeBtn').text('동의하셨습니다').prop('disabled', true).addClass('disabled');
      }
    });
  }
});

// 9. submit 방지 (필수 체크 미완료시)
$('#termForm').on('submit', function() {
  if ($('.term-chk.required').length !== $('.term-chk.required:checked').length) {
    alert('필수 약관에 모두 동의해 주세요.');
    return false;
  }
  return true;
});
</script>