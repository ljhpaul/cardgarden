<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<link rel="stylesheet" href="${cpath}/resources/css/customMakeBackground.css?ver=3">
<title>카드가든 : 커스텀 디자인 제작</title>
<div class="background-page-container">

  <h1 class="page-title">배경 선택</h1>

  <div class="background-content-box">
    
    <!-- 왼쪽 카드 미리보기 -->
    <div class="preview-area">
      <div class="card-bg">
        <div id="cardFrame" class="card-frame ${type}">
          <div class="chip"></div>
          <div class="wide-overlay"></div>
        </div>
      </div>
    </div>

    <!-- 오른쪽 배경 선택 영역 -->
    <div class="bg-select-area">
      <div class="brand-filter">
        <button class="brand-btn active" data-brand="all">전체</button>
        <button class="brand-btn" data-brand="마리오">마리오</button>
        <button class="brand-btn" data-brand="산리오">산리오</button>
        <button class="brand-btn" data-brand="지브리">지브리</button>
      </div>

      <div class="bg-list">
		<c:forEach var="item" items="${backgroundList}">
		  <div class="bg-item">
		    <div class="img-wrap">
		      <img 
		        src="${cpath}/resources/images/asset/${item.asset_type}/${item.asset_brand}/${item.asset_type}_${item.asset_brand}_${item.asset_no}_${item.asset_name}.png" 
		        alt="${item.asset_name}" 
		        class="bg-option ${item.own ? '' : 'locked-img'}" 
		        data-img="${cpath}/resources/images/asset/${item.asset_type}/${item.asset_brand}/${item.asset_type}_${item.asset_brand}_${item.asset_no}_${item.asset_name}.png" 
		        data-brand="${item.asset_brand}"
		        data-id="${item.asset_id}"
		        ${item.own ? '' : 'data-locked="true"'} >
		    </div>
		    
		    <c:if test="${!item.own}">
		      <i class="fa fa-lock lock-icon" aria-hidden="true"></i>
		    </c:if>
		  </div>
		</c:forEach>
      </div>
    </div>
  </div>

  <div class="bottom-btn-area">
    <button id="backBtn" class="big-btn back-btn">카드 세팅 변경하기</button>
    <button id="nextBtn" class="big-btn next-btn">스티커 붙이러 가기</button>
  </div>

</div>

<!-- 확인 모달 -->
<div class="confirm-modal" id="confirmModal">
  <div class="modal-content">
    <p>아무 배경도 선택하지 않았습니다.<Br> 계속 진행할까요?</p>
    <div class="btn-area">
      <button id="confirmYes" class="big-btn">예</button>
      <button id="confirmNo" class="big-btn">아니오</button>
    </div>
  </div>
</div>

<style>
.confirm-modal {
  position: fixed;
  top: 0; left: 0;
  width: 100%; height: 100%;
  background: rgba(0,0,0,0.4);
  display: flex;
  justify-content: center;
  align-items: center;
  visibility: hidden;
}

.confirm-modal .modal-content {
  background: white;
  padding: 40px;
  border-radius: 12px;
  text-align: center;
  font-family: var(--font);
  width: 400px;
}

.confirm-modal .btn-area {
  margin-top: 20px;
  display: flex;
  gap: 10px;
}
</style>

<script>
const cpath = '${cpath}';
const type = '${type}';

let selectedBackgroundId = null;
let selectedBackgroundLocked = false;

const confirmModal = document.getElementById("confirmModal");

document.querySelectorAll(".bg-option").forEach(function(img) {
  img.addEventListener("click", function() {
    const cardFrame = document.getElementById("cardFrame");
    const url = img.dataset.img;
    const assetId = img.dataset.id;
    const isLocked = img.dataset.locked ? true : false;

    selectedBackgroundId = assetId;
    selectedBackgroundLocked = isLocked;

    cardFrame.style.backgroundImage = "url('" + url + "')";
  });
});

document.querySelectorAll(".brand-btn").forEach(function(btn) {
  btn.addEventListener("click", function() {
    const selectedBrand = btn.dataset.brand;

    document.querySelectorAll(".brand-btn").forEach(function(b) {
      b.classList.remove("active");
    });
    btn.classList.add("active");

    document.querySelectorAll(".bg-item").forEach(function(item) {
      const img = item.querySelector(".bg-option");
      if (selectedBrand === "all" || img.dataset.brand === selectedBrand) {
        item.style.display = "block";
      } else {
        item.style.display = "none";
      }
    });
  });
});

document.getElementById("backBtn").addEventListener("click", function() {
  window.location.href = cpath + "/make/frame";
});

document.getElementById("nextBtn").addEventListener("click", function() {
  if (selectedBackgroundLocked) {
    alert("이 아이템이 없습니다. 상점으로 이동합니다.");
    window.location.href = "/cardgarden/custom/detail?asset_id=" + selectedBackgroundId;
    return;
  }
  const cardFrame = document.getElementById("cardFrame");
  const backgroundImage = cardFrame.style.backgroundImage;

  if (!backgroundImage || backgroundImage === "none") {
    confirmModal.style.visibility = "visible";
    return;
  }

  proceedToNext(backgroundImage);
});

document.getElementById("confirmYes").addEventListener("click", function() {
  confirmModal.style.visibility = "hidden";
  proceedToNext(null);
});

document.getElementById("confirmNo").addEventListener("click", function() {
  confirmModal.style.visibility = "hidden";
});

function proceedToNext(backgroundImage) {
  let url = "";
  if (backgroundImage) {
    url = backgroundImage.slice(5, -2);
  }
  const encodedUrl = encodeURIComponent(url);

  window.location.href = cpath + "/make/sticker?type=" + type + "&background=" + encodedUrl;
}
</script>
