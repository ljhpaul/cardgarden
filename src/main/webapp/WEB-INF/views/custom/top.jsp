<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />
<link rel="stylesheet" href="${cpath}/resources/css/customTop.css?ver=2">

<div class="custom-top-container">

  <!-- 제목 -->
  <div class="custom-top-header">
    <h2>
      <c:choose>
        <c:when test="${type == 'sticker'}">스티커</c:when>
        <c:when test="${type == 'background'}">배경</c:when>
        <c:otherwise>전체</c:otherwise>
      </c:choose>
      TOP List
    </h2>
    
	      <div class="go-other-btn-wrapper">
	    <c:choose>
	      <c:when test="${type == 'background'}">
	        <a href="${cpath}/custom/top?type=sticker" class="go-other-btn">스티커 보러가기</a>
	      </c:when>
	      <c:otherwise>
	        <a href="${cpath}/custom/top?type=background" class="go-other-btn">배경화면 보러가기</a>
	      </c:otherwise>
	    </c:choose>
	  </div>
  </div>

  <!-- 필터 영역 -->
  <div class="filter-section">
    <div class="filter-group">
      <p>정렬 기준</p>
      <a href="?type=${type}&sortBy=used&brand=${brand}" class="filter-btn ${sortBy == 'used' ? 'active' : ''}">사용순</a>
      <a href="?type=${type}&sortBy=pricehigh&brand=${brand}" class="filter-btn ${sortBy == 'pricehigh' ? 'active' : ''}">가격높은순</a>
      <a href="?type=${type}&sortBy=pricelow&brand=${brand}" class="filter-btn ${sortBy == 'pricelow' ? 'active' : ''}">가격낮은순</a>
<%--       <a href="?type=${type}&sortBy=like&brand=${brand}" class="filter-btn ${sortBy == 'like' ? 'active' : ''}">좋아요순</a> --%>
    </div>
    <div class="filter-group">
      <p>브랜드</p>
      <a href="?type=${type}&sortBy=${sortBy}&brand=" class="filter-btn ${empty brand ? 'active' : ''}">전체</a>
      <a href="?type=${type}&sortBy=${sortBy}&brand=대충그린" class="filter-btn ${brand == '대충그린' ? 'active' : ''}">대충 그린</a>
      <a href="?type=${type}&sortBy=${sortBy}&brand=마리오" class="filter-btn ${brand == '마리오' ? 'active' : ''}">마리오</a>
      <a href="?type=${type}&sortBy=${sortBy}&brand=산리오" class="filter-btn ${brand == '산리오' ? 'active' : ''}">산리오</a>
      <a href="?type=${type}&sortBy=${sortBy}&brand=지브리" class="filter-btn ${brand == '지브리' ? 'active' : ''}">지브리</a>
    </div>
  </div>

  <!-- TOP 5 영역 -->
  <div class="section-wide-wrapper">
    <div class="section-top5 wide">
      <h3>
        <c:choose>
          <c:when test="${type == 'sticker'}">스티커</c:when>
          <c:when test="${type == 'background'}">배경</c:when>
          <c:otherwise>전체</c:otherwise>
        </c:choose>
        TOP 5
      </h3>
      <div class="top-all-list">
        <c:forEach var="item" items="${top5List}" varStatus="loop">
          <div class="top-all-card">
            <div class="rank-num">${loop.index + 1}<span>위</span></div>
            <img src="${cpath}/resources/images/asset/${item.asset_type}/${item.asset_brand}/${item.asset_type}_${item.asset_brand}_${item.asset_no}_${item.asset_name}.png" alt="${item.asset_name}">
            <p class="rank-name">${item.asset_name}</p>
            <p class="rank-brand">${item.asset_brand}</p>
            <a href="${cpath}/custom/detail?asset_id=${item.asset_id}" class="link-layer"></a>
          </div>
        </c:forEach>
      </div>
    </div>
  </div>

  <!-- 전체 랭킹 리스트 -->
  <div class="asset-grid">
    <c:forEach var="item" items="${rankedList}" varStatus="loop">
      <div class="asset-card">
        <div class="rank-number">${loop.index + 6}<span>위</span></div>
        <img src="${cpath}/resources/images/asset/${item.asset_type}/${item.asset_brand}/${item.asset_type}_${item.asset_brand}_${item.asset_no}_${item.asset_name}.png" alt="${item.asset_name}">
        <p class="asset-name">${item.asset_name}</p>
        <p class="asset-brand">${item.asset_brand}</p>
        <a href="${cpath}/custom/detail?asset_id=${item.asset_id}" class="link-layer"></a>
      </div>
    </c:forEach>
  </div>
</div>

