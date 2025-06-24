<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<link rel="stylesheet" href="${cpath}/resources/css/customMakeFrame.css?after">

<div class="custom-main-container">

  <h1 class="make-title">카드 프레임 선택</h1>

  <div class="make-frame-box">
    
    <!-- 좌측 카드 미리보기 -->
    <div class="card-preview">
      <div class="card-bg">
        <img id="card-preview-img" src="${cpath}/resources/images/cardsize/b1.png" alt="카드 미리보기">
      </div>
    </div>

    <!-- 우측 옵션 영역 -->
    <div class="frame-options">
      <p class="option-title">사이즈 선택</p>
      <div class="size-btn-group">
        <button class="size-btn" data-img="largechip.png">Large Chip</button>
        <button class="size-btn" data-img="smallchip.png">Small Chip</button>
        <button class="size-btn" data-img="largechip-wide.png">Large Chip Wide</button>
        <button class="size-btn" data-img="smallchipwide.png">Small Chip Wide</button>
        <button class="size-btn" data-img="withoutchip.png">Without Chip</button>
      </div>

      <p class="option-title">보기 방향 선택</p>
      <div class="view-btn-group">
        <button class="view-btn" data-direction="portrait">세로보기</button>
        <button class="view-btn" data-direction="landscape">가로보기</button>
      </div>
    </div>

  </div>

  <!-- 하단 넓은 큰 버튼 영역 -->
  <div class="bottom-btn-area">
    <a href="${cpath}/custom/main" class="big-btn back-btn">← 커스텀 홈으로</a>
    <button id="next-btn" class="big-btn next-btn">다음 단계로</button>
  </div>

</div>

<script>
let selectedType = "largechip";
let selectedDirection = "portrait";

// 사이즈 버튼 클릭
document.querySelectorAll(".size-btn").forEach(btn => {
    btn.addEventListener("click", () => {
        selectedType = btn.dataset.img;

        // 모든 버튼 active 제거
        document.querySelectorAll(".size-btn").forEach(b => b.classList.remove("active"));
        
        // 선택 버튼만 active 부여
        btn.classList.add("active");

        // 이미지 변경
        document.getElementById("card-preview-img").src = `${cpath}/resources/images/custom/${selectedType}`;
    });
});

// 방향 버튼 클릭
document.querySelectorAll(".view-btn").forEach(btn => {
    btn.addEventListener("click", () => {
        selectedDirection = btn.dataset.direction;

        // 모든 버튼 active 제거
        document.querySelectorAll(".view-btn").forEach(b => b.classList.remove("active"));
        
        // 선택 버튼만 active 부여
        btn.classList.add("active");

        const preview = document.querySelector(".card-bg");
        if (selectedDirection === "portrait") {
            preview.classList.remove("landscape");
        } else {
            preview.classList.add("landscape");
        }
    });
});

document.getElementById("next-btn").addEventListener("click", () => {
    location.href = `${cpath}/make/image?img=${selectedType}&direction=${selectedDirection}`;
});

</script>