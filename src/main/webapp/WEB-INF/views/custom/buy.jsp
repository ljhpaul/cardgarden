<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../common/header.jsp" %>

<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<link rel="stylesheet" href="${cpath}/resources/css/customDetail.css?ver=3">

<div class="custom-detail-container">

  <div class="detail-content-box">

    <div class="path-section">
      <a href="${cpath}/custom/main">Custom</a> &gt;
      <a href="${cpath}/custom/top?type=${asset.asset_type}">
        <c:choose>
          <c:when test="${asset.asset_type == 'sticker'}">Sticker</c:when>
          <c:when test="${asset.asset_type == 'background'}">Background</c:when>
        </c:choose>
      </a>
    </div>

    <div class="detail-main-section">
      
      <div class="detail-image-box">
        <div class="image-bg">
          <img src="${cpath}/resources/images/asset/${asset.asset_type}/${asset.asset_brand}/${asset.asset_type}_${asset.asset_brand}_${asset.asset_no}_${asset.asset_name}.png" alt="${asset.asset_name}">
        </div>
      </div>

      <div class="detail-info-box">
        <h2>진짜 구매할건가요?</h2>
        <p>가격: ${asset.final_price}Point</p>
        <p>내 잔액: ${userPoint}Point</p>

        <div class="btn-group">
          <form action="${cpath}/custom/buy" method="post">
            <input type="hidden" name="asset_id" value="${asset.asset_id}">
            <button type="submit" class="buy-btn">네</button>
          </form>
          <a href="${cpath}/custom/detail?asset_id=${asset.asset_id}" class="make-btn">아니요</a>
        </div>

      </div>
    </div>

  </div>
</div>
