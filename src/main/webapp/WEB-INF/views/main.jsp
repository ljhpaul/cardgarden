<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<!-- 공통 헤더/스타일/스크립트 -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${cpath}/resources/css/common.css">
<link rel="stylesheet" href="${cpath}/resources/css/header.css">
<link rel="stylesheet" href="${cpath}/resources/css/font-awesome.min.css">
<link rel="stylesheet" href="https://unpkg.com/swiper@9/swiper-bundle.min.css" />
<script src="https://unpkg.com/swiper@9/swiper-bundle.min.js"></script>
<head>
    <title>CARD GARDEN</title>
</head>

<body>
    <div class="main-all">
        <div class="swiper-container slideshow-container" style="width:1000px;">
		  <div class="swiper-wrapper">
		    <div class="swiper-slide">
		      <a href="${cpath}/main">
		        <img src="${cpath}/resources/images/slide/slide_main.png" class="slide-img" alt="메인" />
		      </a>
		    </div>
		    <div class="swiper-slide">
		      <a href="${cpath}/custom/main">
		        <img src="${cpath}/resources/images/slide/slide_ghibli.png" class="slide-img" alt="지브리" />
		      </a>
		    </div>
		    <div class="swiper-slide">
		      <a href="${cpath}/event/mascot">
		        <img src="${cpath}/resources/images/slide/slide_mascot.png" class="slide-img" alt="마스코트상점" />
		      </a>
		    </div>
		    <div class="swiper-slide">
		      <a href="${cpath}/event/attendance">
		        <c:choose>
		          <c:when test="${dayOfWeek == 4}">
		            <img src="${cpath}/resources/images/slide/slide_attendance_wed.png" class="slide-img" alt="수요일 출석" />
		          </c:when>
		          <c:otherwise>
		            <img src="${cpath}/resources/images/slide/slide_attendance.png" class="slide-img" alt="출석" />
		          </c:otherwise>
		        </c:choose>
		      </a>
		    </div>
		    <div class="swiper-slide">
		      <a href="${cpath}/card/detail?cardid=111">
		        <img src="${cpath}/resources/images/slide/slide_kbo.png" class="slide-img" alt="KBO" />
		      </a>
		    </div>
		  </div>
		
		  <!-- 좌우 버튼 -->
		  <div class="swiper-button-prev"></div>
		  <div class="swiper-button-next"></div>
		
		  <!-- 점(dot) 네비게이션 -->
		  <div class="swiper-pagination"></div>
		</div>
        <div class="bottom-banner">
            <a href="${cpath}/recommend/ai">
                <img src="${cpath}/resources/images/golink/recommend.png" style="width:500px;">
            </a>
            <a href="${cpath}/make/frame">
                <img src="${cpath}/resources/images/golink/custom.png" style="width:500px;">
            </a>
        </div>
        <div id="fairy-card-container">
		  <div class="fairy-wrapper">
		    <img src="${cpath}/resources/images/mascot/fairy/mascot_fairy_4.png" class="fairy-img" />
		    <img id="card-img-inside" src="" class="card-overlay" />
		  </div>
		  <div class="card-name-text" id="card-name-inside"></div>
		</div>
        
        
		<div class="popup-card-list" id="cardPopup">
		  <div class="popup-fixed-header">
		    <h1>🐥카드사별 베스트셀러 모음🐥</h1>
		    <button class="popup-close-btn" onclick="closeCardPopup()">✕</button>
		  </div>
		
		  <div class="card-slider">
		    <c:forEach var="card" items="${topCards}">
		      <div class="card-slide">
		        <a href="${cpath}/card/detail?cardid=${card.card_id}">
		          <div class="card-image-box">
		            <img src="${card.card_image}" alt="${card.card_name}" />
		          </div>
		          <div class="card-name">${card.card_name}</div>
		          <div class="card-company">${card.company}</div>
		        </a>
		      </div>
		    </c:forEach>
		  </div>
		</div>
		
		
    </div>
</body>
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function () {
    const swiper = new Swiper('.swiper-container', {
      loop: true,
      autoplay: {
        delay: 4000,
        disableOnInteraction: false,
      },
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
      pagination: {
        el: '.swiper-pagination',
        clickable: true,
      },
      grabCursor: true,
    });
  });



document.getElementById("card-img-inside").addEventListener("click", function() {
    document.getElementById("cardPopup").classList.add("show");
    document.getElementById("cardPopupOverlay").classList.add("show");
});

function closeCardPopup() {
    document.getElementById("cardPopup").classList.remove("show");
    document.getElementById("cardPopupOverlay").classList.remove("show");
}




//카드 보이는 부분
const cards = [
	  <c:forEach items="${topCards}" var="card" varStatus="status">
	    {
	      image: "${card.card_image}",
	      name: "${card.card_name}",
	      url: "${cpath}/card/detail?cardid=${card.card_id}"
	    }<c:if test="${!status.last}">,</c:if>
	  </c:forEach>
	];

	let index = 0;

	function updateCardDisplay() {
	    const card = cards[index];
	    const cardImg = document.getElementById("card-img-inside");
	    const cardName = document.getElementById("card-name-inside");

	    cardImg.src = card.image;
	    cardName.textContent = card.name;

	    index = (index + 1) % cards.length;
	}

	document.addEventListener("DOMContentLoaded", () => {
	    if (cards.length === 0) return;
	    updateCardDisplay();
	    setInterval(updateCardDisplay, 2000); // 2초마다 변경
	});


</script>
<style>
body {
    font-family: 'NanumSquareRound', sans-serif;
    background-color: #F0F3F1;
    padding: 0;
    margin: 0;
}

#main {
    text-align: center;
}
.swiper-container {
  width: 100%;
  max-width: 1200px;
  height: 500px;
  position: relative;
  margin: auto;
  border-radius: 12px;
  overflow: hidden;
}

.swiper-slide {
  text-align: center;
  cursor: default;
}
.swiper-slide a {
  display: inline-block;
  max-width: 1000px;
  max-height: 500px;
}

.swiper-slide img {
  width: 1000px;
  height: 500px;
  object-fit: cover;
  border-radius: 12px;
}

.swiper-button-prev,
.swiper-button-next {
    color: #b5cfa0;
    text-shadow: 0 0 6px rgb(166 172 140 / 80%);
}

.swiper-pagination-bullet-active {
  background: #333 !important;
}
.bottom-banner {
    display: flex;
    justify-content: center;
    align-items: flex-start;
    gap: 40px;
    margin-top: 32px;
}
.bottom-banner a img {
    border-radius: 16px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
    transition: transform 0.2s;
}
.bottom-banner a img:hover {
    transform: translateY(-6px) scale(1.03);
}
.slide-img {
    width: 1000px;
    height: 500px;
    max-width: 1200px;
    display: block;
    margin: 0 auto;
    border-radius: 10px;
    box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
}
.mySlideDiv {
    max-width: 1200px;
    margin: 0 auto;
    text-align: center;  /* 추가: a태그 inline-block 중앙정렬 */
}

.mySlideDiv a {
    display: inline-block;   /* a태그 크기를 이미지와 동일하게 */
    width: auto;
    margin: 0 auto;
    /* 블록이 아니라 인라인블록! */
}
.main-all {
    max-width: 1200px;
    margin: -10px auto 0 auto;
    background: rgba(255, 255, 255, 0.93);
    border-radius: 22px;
    box-shadow: 0 12px 40px rgba(60, 70, 90, 0.13);
    padding: 48px 32px 56px;
    box-sizing: border-box;
    transition: box-shadow 0.2s;
   	
}
@media (max-width: 900px) {
    .main-all {
        padding: 20px 5vw 28px 5vw;
        border-radius: 16px;
        max-width: 98vw;
    }
}



.card-name {
  padding: 8px 4px 4px 4px;
  font-size: 16px;
  font-weight: 700;
  color: #333;
  font-family: 'Pretendard', 'NanumSquareRound', 'Apple SD Gothic Neo', sans-serif;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.card-company {
  font-size: 13px;
  font-weight: 500;
  color: #777;
  font-family: 'Pretendard', 'NanumSquareRound', 'Apple SD Gothic Neo', sans-serif;
  padding-bottom: 8px;
}

.card-slider {
    display: flex;
    overflow-x: auto;
    gap: 16px;
    padding: 20px 0;
    scroll-snap-type: x mandatory;
    flex-wrap: wrap;
}
.card-slide {
  flex: 0 0 auto;
  width: 160px;
  text-align: center;
  background: white;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  transition: transform 0.2s;

}
.card-slide img {
    width: 100%;
    border-top-left-radius: 12px;
    border-top-right-radius: 12px;
}
.card-name {
    padding: 8px;
    font-weight: bold;
    font-size: 14px;
}





#fairy-card-container {
  text-align: center;
  margin: 48px 0;
}

.fairy-wrapper {
  position: relative;
  display: inline-block;
}

.fairy-img {
  width: 1040px;
  border-radius: 14px;
  box-shadow: 0 6px 24px rgba(0,0,0,0.08);
  transition: transform 0.2s;
}

.card-overlay {
  position: absolute;
  top: 430px; /* 손 중앙 기준 y좌표 */
  left: 520px; /* 손 중앙 기준 x좌표 */
  max-width: 250px;
  max-height: 200px;
  transform: translate(-50%, -50%); /* 중심 정렬 */
  object-fit: contain;
  border-radius: 8px;
  background: white;
    box-shadow: 
    0 0 24px 8px rgba(255,254,222,0.8),   /* 강한 흰색 광채 */
    0 0 32px 12px rgba(255, 220, 120, 0.7), /* 노란빛 광채 */
    0 4px 20px rgba(0,0,0,0.08);           /* 약한 그림자 */
  transition: transform 1s;
  cursor: pointer;
}
.card-overlay:hover {
	animation: shakeCard 0.4s ease-in-out;
}
@keyframes shakeCard {
  0% { transform: translate(-50%, -50%) rotate(0deg); }
  25% { transform: translate(-50%, -50%) rotate(4deg); }
  50% { transform: translate(-50%, -50%) rotate(-4deg); }
  75% { transform: translate(-50%, -50%) rotate(1deg); }
  100% { transform: translate(-50%, -50%) rotate(0deg); }
}
.card-name-text {
  margin-top: 32px;
  font-size: 32px;
  font-weight: 800;
  color: #444;
}

.popup-card-list {
  text-align: center;
  display: none;
  position: fixed;
  top: 50%;
  left: 50%;
  width: 80vw;
  max-width: 800px;
  max-height: 80vh;
  overflow-y: auto;
  background: white;
  border-radius: 20px;
  transform: translate(-50%, -50%);
  z-index: 9999;
  box-shadow: 0 4px 30px rgba(0,0,0,0.3);
}
.popup-fixed-header {
  position: sticky;
  top: 0;
  background: white;
  height: 90px;
  display: flex;
  align-items: center;
  justify-content: center; /* 중앙 기준 */
  border-bottom: 1px solid #ddd;
  z-index: 10;
  position: sticky;
}

.popup-fixed-header h1 {
  position: absolute;
  left: 50%;
  transform: translateX(-50%);
  font-size: 28px;
  font-weight: 800;
  margin: 0;
  color: #333;
}

.popup-close-btn {
  position: absolute;
  top: 12px;
  right: 12px;
  font-size: 20px;
  font-weight: bold;
  width: 32px;
  height: 32px;
  line-height: 30px;
  border: none;
  border-radius: 50%;
  background-color: #f2f2f2;
  color: #333;
  cursor: pointer;
  box-shadow: 0 2px 6px rgba(0,0,0,0.15);
  transition: background-color 0.2s ease, transform 0.2s ease;
  z-index: 10000;
}
.popup-close-btn:hover {
  background-color: #ffe6e6;
  transform: scale(1.1);
}
.popup-card-list .card-slider {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between; /* 또는 center */
  gap: 16px;
  padding: 20px 0;
  overflow-x: hidden;
}

.popup-card-list .card-slide {
  flex: 0 0 calc(33.333% - 16px);
  box-sizing: border-box;
  width: calc(33.333% - 16px);
  background: white;
  border-radius: 12px;
  text-align: center;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

@keyframes popupFadeIn {
  0% {
    opacity: 0;
    transform: translate(-50%, -50%) scale(0.8);
  }
  100% {
    opacity: 1;
    transform: translate(-50%, -50%) scale(1);
  }
}

.popup-card-list.show {
  display: block;
  animation: popupFadeIn 0.3s ease-out;
}

@keyframes overlayFadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

.popup-overlay.show {
  display: block;
  animation: overlayFadeIn 0.3s ease-out;
}


.popup-overlay {
  display: none;
  position: fixed;
  top: 0; left: 0; right: 0; bottom: 0;
  background: rgba(0,0,0,0.5);
  z-index: 9998;
}

.card-image-box {
  width: 100%;
  height: 220px; /* 카드 고정 높이 */
  background-color: #fff;
  border-top-left-radius: 12px;
  border-top-right-radius: 12px;
  overflow: hidden;
  display: flex;
  align-items: center;
  justify-content: center;
}

.card-image-box img {
  max-width: 90%;
  max-height: 90%;
  object-fit: contain;
}

/* 스크롤바 css */

/* 스크롤바 너비 */
.popup-card-list::-webkit-scrollbar {
  width: 12px;
}

/* 스크롤바 색상 + radius 조정*/
.popup-card-list::-webkit-scrollbar-thumb {
  background: #ccc;
  border-radius: 8px;
}
/* 트랙 색상 + 트랙 위치  */
.popup-card-list::-webkit-scrollbar-track {
  background: #f0f0f0;
  margin-top: 125px; /* 트랙 시작 여백 */
}


</style>
