<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<script>
const cpath = '${cpath}';
const isLogin = ${isLogin ? 'true' : 'false'};
</script>

<link rel="stylesheet" href="${cpath}/resources/css/customMakeFrame.css?ver=4">

<div class="custom-main-container">

  <h1 class="make-title">카드 프레임 선택</h1>

  <div class="make-frame-box">
    
    <!-- 카드 미리보기 -->
    <div class="card-preview">
      <div class="card-bg ${selectedDirection}">
        <div id="card-frame" class="card-frame ${selectedType}" style="background-image: url('${cpath}/resources/images/cardsize/b1.png');">
          <div class="chip"></div>
          <div class="wide-overlay"></div>
        </div>
      </div>
    </div>

    <!-- 옵션 영역 -->
    <div class="frame-options">
      <p class="option-title">사이즈 선택</p>
      <div class="size-btn-group">
        <button type="button" class="size-btn ${selectedType eq 'largechip' ? 'active' : ''}" data-type="largechip">Large Chip</button>
        <button type="button" class="size-btn ${selectedType eq 'smallchip' ? 'active' : ''}" data-type="smallchip">Small Chip</button>
        <button type="button" class="size-btn ${selectedType eq 'largechipwide' ? 'active' : ''}" data-type="largechipwide">Large Chip Wide</button>
        <button type="button" class="size-btn ${selectedType eq 'smallchipwide' ? 'active' : ''}" data-type="smallchipwide">Small Chip Wide</button>
        <button type="button" class="size-btn ${selectedType eq 'withoutchip' ? 'active' : ''}" data-type="withoutchip">Without Chip</button>
      </div>

      <p class="option-title">보기 방향</p>
      <div class="view-btn-group">
        <button type="button" class="view-btn ${selectedDirection eq 'portrait' ? 'active' : ''}" data-direction="portrait">가로보기</button>
        <button type="button" class="view-btn ${selectedDirection eq 'landscape' ? 'active' : ''}" data-direction="landscape">세로보기</button>
      </div>
    </div>

  </div>

  <div class="bottom-btn-area">
    
    <div class="btnn">
      <a href="${cpath}/custom/main">커스텀 홈으로</a>
    </div>
    
    <div class="btnn">
      <form id="makeForm" action="${cpath}/make/background" method="get" style="flex:1; display:flex; width:100%; height:100%;">
        <input type="hidden" name="type" id="typeInput" value="${selectedType}">
        <button type="submit">제작하러 가기</button>
      </form>
    </div>
  </div>
</div>

<script>
document.querySelectorAll(".size-btn").forEach(btn => {
    btn.addEventListener("click", () => {
        document.getElementById("typeInput").value = btn.dataset.type;

        const frame = document.getElementById("card-frame");
        frame.classList.remove("largechip", "smallchip", "largechipwide", "smallchipwide", "withoutchip");
        frame.classList.add(btn.dataset.type);

        document.querySelectorAll(".size-btn").forEach(b => b.classList.remove("active"));
        btn.classList.add("active");
    });
});

document.querySelectorAll(".view-btn").forEach(btn => {
    btn.addEventListener("click", () => {
        const cardBg = document.querySelector(".card-bg");
        cardBg.classList.remove("portrait", "landscape");
        cardBg.classList.add(btn.dataset.direction);

        document.querySelectorAll(".view-btn").forEach(b => b.classList.remove("active"));
        btn.classList.add("active");
    });
});

document.getElementById("makeForm").addEventListener("submit", (e) => {
    if (isLogin === false) {
        e.preventDefault();
        alert("로그인을 해야합니다.");
        location.href = `${cpath}/user/login`;
    }
});

</script>
