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
        <h2>구매가 완료되었습니다!</h2>
        <p>가격: ${asset.final_price}Point</p>
        <p>남은 포인트: ${userPoint}Point</p>

        <div class="btn-group">
          <a href="${cpath}/custom/top?type=sticker" class="buy-btn">다른 꾸미기템 보러가기</a>
        </div>
      </div>
    </div>

	    <div class="related-section-inner">
	      <h3>다른 태그의 제품들 ... (${asset.asset_brand}의 제품들)</h3>
	      <div class="related-inner-box">
	        <div class="related-list">
	          <c:forEach var="item" items="${relatedList}">
	            <a href="${cpath}/custom/detail?asset_id=${item.asset_id}" class="related-card">
	              <div class="related-image-bg">
	                <img src="${cpath}/resources/images/asset/${item.asset_type}/${item.asset_brand}/${item.asset_type}_${item.asset_brand}_${item.asset_no}_${item.asset_name}.png" alt="${item.asset_name}">
	              </div>
	              <p class="related-name">${item.asset_name}</p>
	            </a>
	          </c:forEach>
	        </div>
	      </div>
	    </div>
  </div>
</div>
