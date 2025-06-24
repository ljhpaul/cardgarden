<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../common/header.jsp" %>

<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<link rel="stylesheet" href="${cpath}/resources/css/customDetail.css?ver=4">

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
        <h2>무료 스티커 받기 완료!</h2>
        <p>남은 포인트: ${userPoint}Point</p>

        <div class="btn-group">
          <a href="${cpath}/custom/top?type=sticker" class="buy-btn">다른 스티커 보러가기</a>
          <a href="${cpath}/make/frame" class="make-btn">제작하러 가기</a>
        </div>
      </div>
    </div>

  </div>
</div>
