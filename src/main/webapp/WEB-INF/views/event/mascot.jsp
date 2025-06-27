<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<%@ include file="../common/header.jsp" %>
<link rel="stylesheet" href="${cpath}/resources/css/mascotShop.css?after">

<div class="custom-top-container">

  <div class="custom-top-header">
    <h2>마스코트 상점</h2>
  </div>

  <div class="mascot-list">

    <c:forEach var="mascot" items="${mascotList}">
      <div class="mascot-card">

        <div class="mascot-image-grid">
          <div class="mascot-image-box">
            <img src="${cpath}/resources/images/mascot/${mascot.asset_brand}/mascot_${mascot.asset_brand}_1.png" alt="마스코트1">
          </div>
          <div class="mascot-image-box">
            <img src="${cpath}/resources/images/mascot/${mascot.asset_brand}/mascot_${mascot.asset_brand}_2.png" alt="마스코트2">
          </div>
          <div class="mascot-image-box">
            <img src="${cpath}/resources/images/mascot/${mascot.asset_brand}/mascot_${mascot.asset_brand}_3.png" alt="마스코트3">
          </div>
        </div>

        <div class="price-btn-row">
          <div class="box">
            <div class="price-box">
              ${mascot.point_needed}P
            </div>
          </div>
          <div class="box">
            <c:choose>
              <c:when test="${ownedMap[mascot.asset_id] == 1}">
                <span class="owned-text">보유중</span>
              </c:when>
              <c:otherwise>
                <button type="button" class="buy-btn" style="height: 70px;" onclick="openBuyModal(${mascot.asset_id}, ${mascot.point_needed})">구매하기</button>
              </c:otherwise>
            </c:choose>
          </div>
        </div>

      </div>
    </c:forEach>

  </div>
</div>

<!-- 구매 모달 -->
<div class="buy-modal" id="buyModal">
  <div class="buy-modal-content">
    <p id="buyText">구매하시겠습니까?</p>
    <div class="btn-group">
      <button type="button" class="buy-btn" id="buyConfirmBtn">확인</button>
      <button type="button" class="cancel-btn" onclick="closeBuyModal()">취소</button>
    </div>
  </div>
</div>


<script>
let selectedAssetId = 0;

function openBuyModal(assetId, price) {
    selectedAssetId = assetId;
    document.getElementById("buyText").innerText = price + "P로 구매하시겠습니까?";
    document.getElementById("buyModal").style.display = "flex";
}

function closeBuyModal() {
    document.getElementById("buyModal").style.display = "none";
}

document.getElementById("buyConfirmBtn").addEventListener("click", function() {
    fetch("${cpath}/event/buy", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "asset_id=" + selectedAssetId
    })
    .then(res => res.text())
    .then(result => {
        result = result.trim();
        console.log("서버응답:", result);

        if (result === "notlogin") {
            alert("로그인이 필요합니다.");
            location.href = "${cpath}/user/login";
        } else if (result === "nopoint") {
            alert("포인트가 부족합니다.");
            closeBuyModal();
        } else if (result === "success") {
            location.href = "${cpath}/event/result";
        } else {
            alert("오류가 발생했습니다.");
        }
    });
});

</script>
