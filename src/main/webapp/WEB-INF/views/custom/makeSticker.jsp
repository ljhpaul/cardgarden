<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<link rel="stylesheet" href="${cpath}/resources/css/customMakeSticker.css?ver=1">
<style>
.save-modal {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%; height: 100%;
  background: rgba(0,0,0,0.4);
  display: flex;
  justify-content: center;
  align-items: center;
  visibility: hidden;
}
.save-modal .modal-content {
  background: white;
  padding: 30px;
  border-radius: 10px;
  text-align: center;
}
</style>

<div class="background-page-container">

  <h1 class="page-title">스티커 선택</h1>

  <div class="background-content-box">

    <!-- 왼쪽 카드 미리보기 -->
    <div class="preview-area">
      <div class="preview-toolbar">
        <button class="tool-btn" data-tool="pen">펜</button>
        <button class="tool-btn" data-tool="select">선택</button>
      </div>
      
      <div class="pen-setting-bar" style="visibility: hidden;">
        <label>두께:
          <input type="range" id="penWidth" min="1" max="20" value="3">
        </label>
        <label>색상:
          <input type="color" id="penColor" value="#000000">
        </label> 
      </div>

      <div class="card-bg">
        <div id="cardFrame" class="card-frame ${type}">
          <canvas id="canvas"></canvas>
          <div class="chip"></div>
          <div class="wide-overlay"></div>
        </div>
      </div>
    </div>

    <!-- 오른쪽 스티커 선택 영역 -->
    <div class="bg-select-area">
      <div class="brand-filter">
        <button class="brand-btn active" data-brand="all">전체</button>
        <button class="brand-btn" data-brand="대충그린">대충그린</button>
        <button class="brand-btn" data-brand="마리오">마리오</button>
        <button class="brand-btn" data-brand="산리오">산리오</button>
        <button class="brand-btn" data-brand="지브리">지브리</button>
      </div>

      <div class="bg-list">
        <c:forEach var="item" items="${stickerList}">
          <div class="bg-item">
            <div class="img-box">
              <img 
                src="${cpath}/resources/images/asset/${item.asset_type}/${item.asset_brand}/${item.asset_type}_${item.asset_brand}_${item.asset_no}_${item.asset_name}.png" 
                alt="${item.asset_name}" 
                class="bg-option ${item.own ? '' : 'locked-img'}" 
                data-img="${cpath}/resources/images/asset/${item.asset_type}/${item.asset_brand}/${item.asset_type}_${item.asset_brand}_${item.asset_no}_${item.asset_name}.png" 
                data-brand="${item.asset_brand}"
                data-id="${item.asset_id}"
                ${item.own ? '' : 'data-locked="true"'} >
              <c:if test="${!item.own}">
                <i class="fa fa-lock lock-icon" aria-hidden="true"></i>
              </c:if>
            </div>
          </div>
        </c:forEach>
      </div>
    </div>
  </div>

  <div class="bottom-btn-area">
    <button id="backBtn" class="big-btn back-btn">배경 선택으로</button>
    <button id="completeBtn" class="big-btn next-btn">완성하기</button>
  </div>

</div>

<!-- 저장 모달 -->
<div class="save-modal" id="saveModal">
  <div class="modal-content">
    <h2>카드 이름을 입력하세요</h2>
    <input type="text" id="cardName" placeholder="카드 이름" style="padding:10px; width:80%; margin:20px 0;">
    <div>
      <button id="saveBtn" style="padding:10px 20px;">저장</button>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/fabric@5.3.0/dist/fabric.min.js"></script>

<script>
window.addEventListener("DOMContentLoaded", () => {

  const cpath = '${cpath}';
  const type = '${type}';
  const background = '${background}';

  const cardFrame = document.getElementById("cardFrame");
  const canvasEl = document.getElementById("canvas");
  const saveModal = document.getElementById("saveModal");

  cardFrame.style.backgroundImage = `url("${background}")`;

  const frameRect = cardFrame.getBoundingClientRect();
  canvasEl.width = frameRect.width;
  canvasEl.height = frameRect.height;
  canvasEl.style.position = 'absolute';
  canvasEl.style.top = '0';
  canvasEl.style.left = '0';

  const canvas = new fabric.Canvas('canvas');
  let currentMode = "select";
  let lastLockedAssetId = null;

  document.querySelectorAll(".bg-option").forEach(img => {
    img.addEventListener("click", () => {
      const url = img.dataset.img;
      const assetId = img.dataset.id;
      const isLocked = img.dataset.locked ? true : false;

      if (isLocked) {
        lastLockedAssetId = assetId;
        alert("없는 아이템입니다.");
        return;
      }

      lastLockedAssetId = null;

      fabric.Image.fromURL(url, function(oImg) {
        oImg.set({
          left: 50,
          top: 50,
          scaleX: 0.3,
          scaleY: 0.3
        });
        canvas.add(oImg).setActiveObject(oImg);
      });
    });
  });

  document.querySelectorAll(".tool-btn").forEach(btn => {
    btn.addEventListener("click", () => {
      const tool = btn.dataset.tool;
      currentMode = tool;

      if (tool === "pen") {
        canvas.isDrawingMode = true;
        canvas.freeDrawingBrush = new fabric.PencilBrush(canvas);
        canvas.freeDrawingBrush.color = document.getElementById("penColor").value;
        canvas.freeDrawingBrush.width = document.getElementById("penWidth").value;
        document.querySelector(".pen-setting-bar").style.visibility = "visible";
      } else if (tool === "select") {
        canvas.isDrawingMode = false;
        document.querySelector(".pen-setting-bar").style.visibility = "hidden";
      }
    });
  });

  document.getElementById("penWidth").addEventListener("input", (e) => {
    if (currentMode === "pen") {
      canvas.freeDrawingBrush.width = e.target.value;
    }
  });

  document.getElementById("penColor").addEventListener("input", (e) => {
    if (currentMode === "pen") {
      canvas.freeDrawingBrush.color = e.target.value;
    }
  });

  document.addEventListener("keydown", (e) => {
    if ((e.key === "Delete" || e.key === "Backspace") && currentMode === "select") {
      const activeObj = canvas.getActiveObject();
      if (activeObj) {
        canvas.remove(activeObj);
      }
    }
  });

  document.querySelectorAll(".brand-btn").forEach(btn => {
    btn.addEventListener("click", () => {
      const selectedBrand = btn.dataset.brand;
      document.querySelectorAll(".brand-btn").forEach(b => b.classList.remove("active"));
      btn.classList.add("active");

      document.querySelectorAll(".bg-item").forEach(item => {
        const img = item.querySelector(".bg-option");
        item.style.display = (selectedBrand === "all" || img.dataset.brand === selectedBrand) ? "block" : "none";
      });
    });
  });

  document.getElementById("backBtn").addEventListener("click", () => {
    window.location.href = `${cpath}/make/background?type=${type}`;
  });

  document.getElementById("completeBtn").addEventListener("click", () => {
    if (lastLockedAssetId) {
      alert("없는 아이템이 있습니다. 상점으로 이동합니다.");
      window.location.href = `/cardgarden/custom/detail?asset_id=${lastLockedAssetId}`;
      return;
    }
    saveModal.style.visibility = "visible";
  });

  document.getElementById("saveBtn").addEventListener("click", () => {
    const cardName = document.getElementById("cardName").value.trim();
    if (!cardName) {
      alert("이름을 입력하세요.");
      return;
    }

    const tempCanvas = document.createElement("canvas");
    tempCanvas.width = canvasEl.width;
    tempCanvas.height = canvasEl.height;
    const ctx = tempCanvas.getContext("2d");

    const bgImg = new Image();
    bgImg.src = background;
    bgImg.onload = () => {
      ctx.drawImage(bgImg, 0, 0, tempCanvas.width, tempCanvas.height);

      canvas.renderAll();
      const stickerDataUrl = canvas.toDataURL({ format: 'png' });
      const stickerImg = new Image();
      stickerImg.src = stickerDataUrl;
      stickerImg.onload = () => {
        ctx.drawImage(stickerImg, 0, 0);

        const finalDataUrl = tempCanvas.toDataURL('image/png');

        console.log("카드이름:", cardName);
        console.log("최종이미지:", finalDataUrl);

        alert("카드가 저장되었습니다.");
        saveModal.style.visibility = "hidden";
      };
    };
  });

});
</script>
