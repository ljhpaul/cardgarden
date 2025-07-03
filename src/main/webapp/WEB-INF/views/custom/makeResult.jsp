<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<style>
body {
  background-color: var(--main);
  font-family: var(--font);
  padding: 0;
  margin: 0;
  background-color: #F0F3F1;
}

.result-container {
  background-color: white;
  padding: 100px;
  border-radius: 20px;
  margin: 20px auto;
  max-width: 1100px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.result-container h1 {
  font-size: 36px;
  color: var(--m3);
  margin-bottom: 20px;
}
.result-container img {
  width: 300px;
  height: auto;
  margin-bottom: 30px;
  border: 2px solid var(--m1);
  border-radius: 10px;
  cursor: pointer;
}
.result-container .btn-group {
  display: flex;
  gap: 20px;
}
.result-container .btn {
  padding: 15px 30px;
  font-size: 20px;
  background-color: var(--m1);
  color: white;
  border: none;
  border-radius: 10px;
  cursor: pointer;
  text-decoration: none;
  font-weight: bold;
}
.result-container .btn:hover {
  background-color: var(--m2);
  color: var(--m3);
}

/* 로딩 팝업 추가 */
.loading-popup-mask {
  position: fixed; left: 0; top: 0; width: 100vw; height: 100vh;
  background: rgba(0,0,0,0.4); z-index: 9999;
  display: flex; align-items: center; justify-content: center;
  display: none;
}
.loading-popup-inner {
  background: white; border-radius: 24px; padding: 40px 60px 32px;
  box-shadow: 0 2px 18px rgba(0,0,0,0.17); text-align: center;
  min-width: 260px;
}
.loading-run {
  width: 120px; height: 120px; margin: 0 auto 16px;
  position: relative;
}
.loading-run img {
  position: absolute; left: 0; top: 0; width: 120px; height: 120px;
  object-fit: contain;
  user-select: none;
  pointer-events: none;
}
.loading-text {
  font-size: 1.25em; color: #2B362D; font-weight: bold; letter-spacing: 1.5px;
  margin-top: 12px;
}
</style>

<div class="result-container">
  <h1>카드가 성공적으로 저장되었습니다!</h1>

  <img id="fakeImg" src="${cpath}/resources/images/custom/gotocustomcard.png" alt="대기 이미지">

  <div class="btn-group">
    <a href="${cpath}/custom/main" class="btn">커스텀 홈으로</a>
    <a href="${cpath}/make/frame" class="btn">새로 만들기</a>
  </div>
</div>

<!-- 로딩 팝업 영역 -->
<div class="loading-popup-mask">
  <div class="loading-popup-inner">
    <div class="loading-run">
      <img class="run-frame" src="${cpath}/resources/images/consumpattern/baseball1.png" alt="1" style="display:block;">
      <img class="run-frame" src="${cpath}/resources/images/consumpattern/baseball2.png" alt="2" style="display:none;">
      <img class="run-frame" src="${cpath}/resources/images/consumpattern/baseball3.png" alt="3" style="display:none;">
      <img class="run-frame" src="${cpath}/resources/images/consumpattern/base2.png" alt="2" style="display:none;">
      <img class="run-frame" src="${cpath}/resources/images/consumpattern/base3.png" alt="3" style="display:none;">
      <img class="run-frame" src="${cpath}/resources/images/consumpattern/base1.png" alt="1" style="display:none;">
      <img class="run-frame" src="${cpath}/resources/images/consumpattern/base4.png" alt="3" style="display:none;">
    </div>
    <div class="loading-text">페이지 이동중입니다</div>
  </div>
</div>

<script>
let frameIdx = 0;
let runInterval = null;
let loadingTextInterval = null;

function startLoadingText() {
  const loadingText = document.querySelector('.loading-text');
  const baseMsg = "페이지 이동중입니다";
  let dotCount = 0;
  if (loadingTextInterval) clearInterval(loadingTextInterval);
  loadingTextInterval = setInterval(() => {
    let dots = '.'.repeat(dotCount);
    loadingText.textContent = baseMsg + dots;
    dotCount = (dotCount + 1) % 4;
  }, 350);
}

function stopLoadingText() {
  if (loadingTextInterval) clearInterval(loadingTextInterval);
  const loadingText = document.querySelector('.loading-text');
  if (loadingText) loadingText.textContent = "페이지 이동중입니다";
}

function showLoadingPopup() {
  document.querySelector('.loading-popup-mask').style.display = 'flex';
  frameIdx = 0;
  const frames = document.querySelectorAll('.run-frame');
  if (runInterval) clearInterval(runInterval);
  runInterval = setInterval(() => {
    frames.forEach((img, i) => img.style.display = i === frameIdx ? 'block' : 'none');
    frameIdx = (frameIdx + 1) % frames.length;
  }, 1000);
  startLoadingText();
}

document.getElementById('fakeImg')?.addEventListener('click', function() {
  showLoadingPopup();
  setTimeout(() => {
    location.href = "${cpath}/user/customcard";
  }, 5000);
});
</script>
