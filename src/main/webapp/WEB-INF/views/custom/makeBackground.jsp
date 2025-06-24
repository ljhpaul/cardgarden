<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<link rel="stylesheet" href="${cpath}/resources/css/customMakeBackground.css?ver=2">

<div class="background-page-container">

  <h1 class="page-title">배경 선택</h1>

  <div class="background-content-box">
    
    <!-- 왼쪽 카드 미리보기 -->
    <div class="preview-area">
      <div class="card-bg ${direction}">
        <div id="cardFrame" class="card-frame ${type}">
          <div class="chip"></div>
          <div class="wide-overlay"></div>
        </div>
      </div>
    </div>

    <!-- 오른쪽 배경 선택 영역 -->
    <div class="bg-select-area">
      <div class="brand-filter">
        <button class="brand-btn active" data-brand="all">전체</button>
        <button class="brand-btn" data-brand="마리오">마리오</button>
        <button class="brand-btn" data-brand="산리오">산리오</button>
        <button class="brand-btn" data-brand="지브리">지브리</button>
      </div>

      <div class="bg-list">
		<c:forEach var="item" items="${backgroundList}">
		  <img 
		    src="${cpath}/resources/images/asset/${item.asset_type}/${item.asset_brand}/${item.asset_type}_${item.asset_brand}_${item.asset_no}_${item.asset_name}.png" 
		    alt="${item.asset_name}" 
		    class="bg-option" 
		    data-img="${cpath}/resources/images/asset/${item.asset_type}/${item.asset_brand}/${item.asset_type}_${item.asset_brand}_${item.asset_no}_${item.asset_name}.png" 
		    data-brand="${item.asset_brand}">
		</c:forEach>
     </div>
    </div>

  </div>

  <div class="bottom-btn-area">
    <a href="${cpath}/make/frame" class="big-btn back-btn">카드 세팅 변경하기</a>
    <a href="${cpath}/make/sticker?type=${type}&direction=${direction}" class="big-btn next-btn">스티커 붙이러 가기</a>
  </div>

</div>

<script>
const cpath = '${cpath}';
const type = '${type}';
const direction = '${direction}';

document.querySelectorAll(".bg-option").forEach(img => {
	 console.log(img.dataset.img);
	  img.addEventListener("click", () => {
	    const cardFrame = document.getElementById("cardFrame");
	    cardFrame.style.backgroundImage = `url('${img.dataset.img}')`;
	  });
	});


document.querySelectorAll(".brand-btn").forEach(btn => {
  btn.addEventListener("click", () => {
    const selectedBrand = btn.dataset.brand;

    document.querySelectorAll(".brand-btn").forEach(b => b.classList.remove("active"));
    btn.classList.add("active");

    document.querySelectorAll(".bg-option").forEach(img => {
      if (selectedBrand === "all" || img.dataset.brand === selectedBrand) {
        img.style.display = "block";
      } else {
        img.style.display = "none";
      }
    });
  });
});
</script>
