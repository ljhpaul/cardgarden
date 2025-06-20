<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<link rel="stylesheet" href="${cpath}/resources/css/customMain.css?after">

<!-- 스페셜 콜라보 이미지 -->
<div class="special-banner">
    <img src="${cpath}/resources/images/custom/special_banner.png" alt="스페셜 콜라보 배너" style="width:100%; height:auto;">
</div>

<!-- 상단 1단 버튼 -->
<div class="top-buttons">
    <a href="${cpath}/custom/make" class="btn-custom-make">
        <div class="pink-box">
            <p>나만의 커스텀 카드<br>만들러 가기</p>
            <img src="${cpath}/resources/images/custom/makecard.png" alt="만들기 예시">
        </div>
    </a>
</div>

<!-- 상단 2단 버튼 -->
<div class="bottom-buttons">
    <a href="${cpath}/card/discount" class="btn-discount">
        <div class="pink-box">
            <p>오늘의 할인품목<br>보러가기</p>
            <img src="${cpath}/resources/images/custom/discount.png">
        </div>
    </a>
    <a href="${cpath}/card/free" class="btn-free">
        <div class="pink-box">
            <p>오늘의 무료 스티커<br>받아가기</p>
            <img src="${cpath}/resources/images/custom/gift.png">
        </div>
    </a>
</div>

<!-- 전체 TOP5 -->
<div class="section-top5">
    <h3>전체 TOP5</h3>
    <div class="asset-list">
        <c:forEach var="item" items="${topAllList}">
            <div class="asset-item">
                <img src="${cpath}/resources/images/asset/${item.asset_type}/${item.asset_brand}/${item.asset_type}_${item.asset_brand}_${item.asset_no}_${item.asset_name}.png">
                <p>${item.asset_name}</p>
                <small>${item.asset_brand}</small>
            </div>
        </c:forEach>
    </div>
</div>

<!-- 스티커 TOP5 -->
<div class="section-top5 dark">
    <div class="top5-header">
        <h3>스티커 TOP5</h3>
        <a href="${cpath}/custom/top?type=sticker" class="more">스티커 홈</a>
    </div>
    <div class="asset-list">
        <c:forEach var="item" items="${topStickerList}">
            <div class="asset-item">
                <img src="${cpath}/resources/images/asset/${item.asset_type}/${item.asset_brand}/${item.asset_type}_${item.asset_brand}_${item.asset_no}_${item.asset_name}.png">
                <p>${item.asset_name}</p>
                <small>${item.asset_brand}</small>
            </div>
        </c:forEach>
    </div>
</div>

<!-- 배경 TOP5 -->
<div class="section-top5 dark">
    <div class="top5-header">
        <h3>배경 TOP5</h3>
        <a href="${cpath}/images/custom/top?type=background" class="more">스티커 홈</a>
    </div>
    <div class="asset-list">
        <c:forEach var="item" items="${topBgList}">
            <div class="asset-item">
                <img src="${cpath}/resources/images/asset/${item.asset_type}/${item.asset_brand}/${item.asset_type}_${item.asset_brand}_${item.asset_no}_${item.asset_name}.png">
                <p>${item.asset_name}</p>
                <small>${item.asset_brand}</small>
            </div>
        </c:forEach>
    </div>
</div>
