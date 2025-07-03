<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />
<link rel="stylesheet" href="${cpath}/resources/css/customDetail.css?ver=4">

<%@ include file="../common/header.jsp" %>
<title>카드가든 : 오늘의 무료 스티커</title>
<div class="custom-detail-container">

  <div class="detail-content-box">
    
    <div class="path-section">
      <a href="${cpath}/custom/main">Custom</a> &gt;
      <span>무료 스티커</span>
    </div>

    <div class="detail-main-section">
      
      <div class="detail-image-box">
        <div class="image-bg">
          <img src="${cpath}/resources/images/asset/${asset.asset_type}/${asset.asset_brand}/${asset.asset_type}_${asset.asset_brand}_${asset.asset_no}_${asset.asset_name}.png" alt="${asset.asset_name}">
        </div>
      </div>

      <div class="detail-info-box">
        <h2>${asset.asset_name}</h2>
        <p>${asset.used}명 사용</p>
        <p>#${asset.asset_brand} (brand)</p>

        <div class="price-heart-box">
          <p class="discount-point">무료</p>

          <div class="like-section">
            <c:choose>
              <c:when test="${liked == -1}">
                <a href="${cpath}/user/login" class="like-btn">
                  <img src="${cpath}/resources/images/common/like.png" alt="좋아요"> ${asset.asset_like}
                </a>
              </c:when>
              <c:when test="${liked == 0}">
                <button type="button" class="like-btn" id="like-btn">
                  <img src="${cpath}/resources/images/common/like.png" alt="좋아요"> 
                  <span id="like-count">${asset.asset_like}</span>
                </button>
              </c:when>
              <c:when test="${liked == 1}">
                <button type="button" class="unlike-btn" id="like-btn">
                  <img src="${cpath}/resources/images/common/melike.png" alt="좋아요 취소"> 
                  <span id="like-count">${asset.asset_like}</span>
                </button>
              </c:when>
            </c:choose>
          </div>
        </div>

        <div class="btn-group">
          <c:choose>
            <c:when test="${owned == -1 || owned == 0}">
              <form action="${cpath}/custom/getfree" method="post">
                <input type="hidden" name="asset_id" value="${asset.asset_id}" />
                <button type="submit" class="buy-btn">무료로 받기</button>
              </form>
            </c:when>
            <c:when test="${owned == 1}">
              <span class="owned-text">이미 보유중</span>
            </c:when>
          </c:choose>
          
          <a href="${cpath}/make/frame" class="make-btn">제작하러 가기</a>
        </div>

      </div>
    </div>
    <div class="related-section-inner">
      <h3>${asset.asset_brand}의 다른 제품</h3>
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
