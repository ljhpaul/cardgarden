<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<link rel="stylesheet" href="${cpath}/resources/css/customMain.css?after">

<!-- 스페셜 콜라보 이미지 -->
<div class="special-banner">
  <img class="banner-bg" src="${cpath}/resources/images/custom/special_banner1.png" alt="배경 배너">
  <div class="wp1">
  <div class="banner-content">
    <div class="banner-head">
      <h1>스페셜 콜라보</h1>
      <a href="${cpath}/custom/main" class="btn-top">← 콜라보 홈</a>
    </div>
    
    <div class="banner-body">
      <img class="banner-card" src="${cpath}/resources/images/asset/background/지브리/background_지브리_5_토토로배경.png" alt="카드 이미지">
      <div class="banner-text">
        <h2>카드가든<br>X 지브리</h2>
        <p class="p1">대폭 할인중</p>
        <p>6/20 ~ 7/20</p>
      </div>
    </div>
    <a href="${cpath}/custom/detail?id=123" class="btn-bottom">보러가기</a>
    </div>
  </div>
</div>

	<!-- 상단 1단 버튼 -->
	<div class="top-buttons">
	    <a href="${cpath}/custom/make" class="btn-custom-make">
	        <div class="pink-box1">
			  <div class="pink-box1-text">
			    나만의 커스텀 카드<br>만들러 가기
			  </div>
			  <img src="${cpath}/resources/images/custom/makecard/main.png" alt="추후 넣을예정">
			</div>
	    </a>
	</div>

	<!-- 상단 2단 버튼 -->
	<div class="bottom-buttons">
	  <a href="${cpath}/custom/discount" class="btn-discount">
	    <div class="pink-box">
	      <div class="pink-box-text">
	        오늘의 할인품목<br>보러가기
	      </div>
	      <img src="${cpath}/resources/images/custom/discount.png" alt="할인">
	    </div>
	  </a>
	  <a href="${cpath}/custom/detail" class="btn-free">
	    <div class="pink-box">
	      <div class="pink-box-text">
	        오늘의 무료 스티커<br>받아가기
	      </div>
	      <img src="${cpath}/resources/images/custom/gift.png" alt="무료">
	    </div>
	  </a>
	</div>


	<!-- 전체 TOP5 -->
	<div class="section-wide-wrapper">
	<div class="section-top5 wide">
	    <h3>전체 TOP5</h3>
	    <div class="top-all-list">
	        <c:forEach var="item" items="${topAllList}">
	            <div class="top-all-card">
	                <img src="${cpath}/resources/images/asset/${item.asset_type}/${item.asset_brand}/${item.asset_type}_${item.asset_brand}_${item.asset_no}_${item.asset_name}.png">
	                <p class="rank-name">${item.asset_name}</p>
	                <p class="rank-brand">${item.asset_brand}</p>
	            </div>
	        </c:forEach>
	    </div>
	</div>
 </div>

	<!-- 스티커 TOP5 -->
	<div class="section-top5 dark">
	  <div class="top5-header">
	    <h3>스티커 TOP5</h3>
	    <a href="${cpath}/custom/top?type=sticker" class="more">〈 스티커 홈</a>
	  </div>
	  <div class="rank-list">
	    <c:forEach var="item" items="${topStickerList}" varStatus="loop">
	      <div class="rank-card">
	        <div class="rank-num">${loop.index + 1}<span>위</span></div>
	        <img class="rank-image"
	             src="${cpath}/resources/images/asset/${item.asset_type}/${item.asset_brand}/${item.asset_type}_${item.asset_brand}_${item.asset_no}_${item.asset_name}.png" />
	        <div class="rank-name">${item.asset_name}</div>
	        <div class="rank-brand">${item.asset_brand}</div>
	      </div>
	    </c:forEach>
	  </div>
	</div>
	
	<!-- 배경 TOP5 -->
	<div class="section-top5 dark">
	  <div class="top5-header">
	    <h3>배경 TOP5</h3>
	    <a href="${cpath}/custom/top?type=background" class="more">〈 배경 홈</a>
	  </div>
	  <div class="rank-list">
	    <c:forEach var="item" items="${topBgList}" varStatus="loop">
	      <div class="rank-card">
	        <div class="rank-num">${loop.index + 1}<span>위</span></div>
	        <img class="rank-image"
	             src="${cpath}/resources/images/asset/${item.asset_type}/${item.asset_brand}/${item.asset_type}_${item.asset_brand}_${item.asset_no}_${item.asset_name}.png" />
	        <div class="rank-name">${item.asset_name}</div>
	        <div class="rank-brand">${item.asset_brand}</div>
	      </div>
	    </c:forEach>
	  </div>
	</div>
