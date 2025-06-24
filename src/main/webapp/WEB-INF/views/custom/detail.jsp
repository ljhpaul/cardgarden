<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<script src="${cpath}/resources/js/assetlike.js"></script>
<link rel="stylesheet" href="${cpath}/resources/css/customDetail.css?ver=4">

<%@ include file="../common/header.jsp" %>

<div class="custom-detail-container">

  <div class="detail-content-box">
    
    <!-- 경로 표시 -->
    <div class="path-section">
      <a href="${cpath}/custom/main">Custom</a> &gt;
      <a href="${cpath}/custom/top?type=${asset.asset_type}">
        <c:choose>
          <c:when test="${asset.asset_type == 'sticker'}">Sticker</c:when>
          <c:when test="${asset.asset_type == 'background'}">Background</c:when>
        </c:choose>
      </a>
    </div>

    <!-- 상세 본문 -->
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
          
		<c:choose>
		  <c:when test="${asset.final_price < asset.point_needed}">
		    <p><del>${asset.point_needed}Point</del> → <span class="discount-point">${asset.final_price}Point</span></p>
		  </c:when>
		  <c:otherwise>
		    <p>${asset.point_needed}Point</p>
		  </c:otherwise>
		</c:choose>


          <div class="like-section">
            <c:choose>
              <c:when test="${liked == -1}">
                <a href="${cpath}/login" class="like-btn">
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
            <c:when test="${owned == -1}">
		      <button type="button" class="buy-btn" onclick="alertAndGoLogin()">구매하기</button>
		    </c:when>
            <c:when test="${owned == 1}">
              <span class="owned-text">이미 보유중</span>
            </c:when>
            <c:when test="${owned == 0}">
              <c:choose>
                <c:when test="${userPoint < asset.point_needed}">
                  <button type="button" class="buy-btn" disabled>포인트 부족</button>
                </c:when>
                <c:otherwise>
                  <a href="${cpath}/custom/buy?asset_id=${asset.asset_id}" class="buy-btn">구매하기</a>
                </c:otherwise>
              </c:choose>
            </c:when>
          </c:choose>
          
          <a href="${cpath}/make/frame" class="make-btn">제작하러 가기</a>
        </div>

      </div>
    </div>

    <!-- 관련 상품 영역 -->
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
<script>
function alertAndGoLogin() {
  alert("로그인 후 이용 가능합니다.");
  location.href = "${cpath}/login";
}
</script>
