<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<link rel="stylesheet" href="${cpath}/resources/css/customTop.css?ver=2">

<div class="custom-top-container">

  <div class="custom-top-header" >
    <h2>오늘의 할인 상품</h2>
  </div>

  <div class="section-wide-wrapper">
    <div class="section-top5 wide" >
      <h3>랜덤 5개 할인 리스트</h3>
      <div class="top-all-list">
        <c:forEach var="item" items="${discountList}" varStatus="loop">
          <div class="top-all-card">
            <div class="rank-num">${loop.index + 1}<span>위</span></div>
            <img src="${cpath}/resources/images/asset/${item.asset_type}/${item.asset_brand}/${item.asset_type}_${item.asset_brand}_${item.asset_no}_${item.asset_name}.png" alt="${item.asset_name}">
            
            <p class="rank-name">${item.asset_name}</p>
            <p class="rank-brand">${item.asset_brand}</p>
            
            <!-- 할인 표시 -->
            <p class="discount-info">
              <del>${item.point_needed} Point</del> → <span class="discount-point">${item.discount} Point</span>
            </p>
            
            <a href="${cpath}/custom/detail?asset_id=${item.asset_id}" class="link-layer"></a>
          </div>
        </c:forEach>
      </div>
    </div>
  </div>

</div>
