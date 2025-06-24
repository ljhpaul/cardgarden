<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<link rel="stylesheet" href="${cpath}/resources/css/customMakeFrame.css?after">

<div class="custom-main-container">

  <h1 class="make-title">카드 프레임 선택</h1>

  <div class="make-frame-box">
    
    <!-- 카드 미리보기 -->
    <div class="card-preview">
      <div id="card-frame" class="card-frame largechip" style="background-image: url('${cpath}/resources/images/cardsize/b1.png');">
        <div class="chip"></div>
      </div>
    </div>

    <!-- 옵션 영역 -->
    <div class="frame-options">
      <p class="option-title">사이즈 선택</p>
      <div class="size-btn-group">
        <button class="size-btn" data-type="largechip" style="">Large Chip</button>
        <button class="size-btn" data-type="smallchip">Small Chip</button>
        <button class="size-btn" data-type="largechipwide">Large Chip Wide</button>
        <button class="size-btn" data-type="smallchipwide">Small Chip Wide</button>
        <button class="size-btn" data-type="withoutchip">Without Chip</button>
      </div>

      <p class="option-title">보기 방향 선택</p>
      <div class="view-btn-group">
        <button class="view-btn" data-direction="portrait">세로보기</button>
        <button class="view-btn" data-direction="landscape">가로보기</button>
      </div>
    </div>

  </div>

  <div class="bottom-btn-area">
    <a href="${cpath}/custom/main" class="big-btn back-btn">← 커스텀 홈으로</a>
    <button id="next-btn" class="big-btn next-btn">다음 단계로</button>
  </div>

</div>

<script>
document.querySelectorAll(".size-btn").forEach(btn => {
    btn.addEventListener("click", () => {
        const type = btn.dataset.type;
        const frame = document.getElementById("card-frame");

        // 기존 사이즈 관련 클래스만 제거
        frame.classList.remove("largechip", "smallchip", "largechipwide", "smallchipwide", "withoutchip");

        // 새 클래스 추가
        frame.classList.add(type);

        // 배경 이미지 유지
        frame.style.backgroundImage = `url('${cpath}/resources/images/cardsize/b1.png')`;
    });
});

document.querySelectorAll(".view-btn").forEach(btn => {
    btn.addEventListener("click", () => {
        const direction = btn.dataset.direction;
        const frame = document.getElementById("card-frame");

        if (direction === "portrait") {
            frame.classList.remove("landscape");
        } else {
            frame.classList.add("landscape");
        }
    });
});

document.getElementById("next-btn").addEventListener("click", () => {
    location.href = `${cpath}/make/image`;
});
</script>
