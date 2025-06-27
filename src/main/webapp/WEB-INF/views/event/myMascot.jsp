<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<%@ include file="../common/header.jsp" %>
<link rel="stylesheet" href="${cpath}/resources/css/mymascot.css?after">

<div class="custom-top-container">

  <div class="custom-top-header">
    <h2>내 마스코트</h2>
  </div>

  <div class="mascot-list">
    <c:forEach var="mascot" items="${ownedList}">
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

        <c:choose>
          <c:when test="${selectedMascot != null && selectedMascot.asset_id == mascot.asset_id}">
            <div class="selected-text">선택된 마스코트</div>
          </c:when>
          <c:otherwise>
            <button type="button" class="buy-btn" onclick="selectMascot(${mascot.asset_id})">선택하기</button>
          </c:otherwise>
        </c:choose>

      </div>
    </c:forEach>
  </div>
</div>

<script>
function selectMascot(assetId) {
    fetch("${cpath}/event/mascot/select", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "asset_id=" + assetId
    })
    .then(res => res.text())
    .then(result => {
        if (result === "success") {
            alert("마스코트가 선택되었습니다!");
            location.reload();
        } else {
            alert("오류가 발생했습니다.");
        }
    });
}
</script>
