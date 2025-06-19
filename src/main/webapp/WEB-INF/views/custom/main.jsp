<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="custom-main">




  <!-- 전체 TOP5 -->
  <section class="top5-section">
    <h2 class="section-title">전체 TOP5</h2>
    <div class="top5-list">
      <c:forEach var="item" items="${allTop5}">
        <div class="top5-item">
          <img src="/assets/${item.asset_type}_${item.asset_brand}_${item.asset_no}_${item.asset_name}.png" alt="top image">
          <p class="item-name">${item.asset_name}</p>
          <p class="item-brand">${item.asset_brand}</p>
        </div>
      </c:forEach>
    </div>
  </section>

  <!-- 스티커 TOP5 -->
  <section class="top5-section dark">
    <h2 class="section-title">스티커 TOP5 <span class="powered">Powered by Gufi</span></h2>
    <div class="top5-list">
      <c:forEach var="item" items="${stickerTop5}">
        <div class="top5-item dark-box">
          <div class="rank"> ${item.rank} </div>
          <img src="/assets/${item.asset_type}_${item.asset_brand}_${item.asset_no}_${item.asset_name}.png" alt="sticker image">
          <p class="item-name">${item.asset_name}</p>
        </div>
      </c:forEach>
    </div>
  </section>

  <!-- 배경 TOP5 -->
  <section class="top5-section dark">
    <h2 class="section-title">배경 TOP5 <span class="powered">Powered by Gufi</span></h2>
    <div class="top5-list">
      <c:forEach var="item" items="${backgroundTop5}">
        <div class="top5-item dark-box">
          <div class="rank"> ${item.rank} </div>
          <img src="/assets/${item.asset_type}_${item.asset_brand}_${item.asset_no}_${item.asset_name}.png" alt="background image">
          <p class="item-name">${item.asset_name}</p>
        </div>
      </c:forEach>
    </div>
  </section>

</div>
