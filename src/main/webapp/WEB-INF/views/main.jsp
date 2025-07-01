<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<!-- 공통 헤더/스타일/스크립트 -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${cpath}/resources/css/common.css">
<link rel="stylesheet" href="${cpath}/resources/css/header.css">
<link rel="stylesheet" href="${cpath}/resources/css/font-awesome.min.css">

<head>
    <title>CARD GARDEN</title>
</head>

<body>
    <div class="main-all">
        <div class="slideshow-container">
        	<!-- 메인 슬라이드 -->
            <div class="mySlideDiv fade active">
                <a href="${cpath}/main">
                    <img src="${cpath}/resources/images/slide/slide_main.png" class="slide-img link-slide" alt="메인">
                </a>
            </div>
        	<!-- 지브리 콜라보 -->
            <div class="mySlideDiv fade active">
                <a href="${cpath}/custom/main">
                    <img src="${cpath}/resources/images/slide/slide_ghibli.png" class="slide-img link-slide" alt="지브리x카드가든">
                </a>
            </div>
            <!-- 마스코트 상점 -->
            <div class="mySlideDiv fade">
                <a href="${cpath}/event/mascot">
                    <img src="${cpath}/resources/images/slide/slide_mascot.png" class="slide-img link-slide" alt="마스코트상점">
                </a>
            </div>
            <!-- 출석체크 이벤트 -->
            <div class="mySlideDiv fade">
                <a href="${cpath}/event/attendance">
                	<c:choose>
					  <c:when test="${dayOfWeek == 4}">
					    <img src="${cpath}/resources/images/slide/slide_attendance_wed.png" class="slide-img link-slide" alt="출석체크">
					  </c:when>
					  <c:otherwise>
					    <img src="${cpath}/resources/images/slide/slide_attendance.png" class="slide-img link-slide" alt="출석체크_수요일">
					  </c:otherwise>
					</c:choose>
                </a>
            </div>
            <!-- KBO 콜라보 -->
            <div class="mySlideDiv fade">
                <a href="${cpath}/card/detail?cardid=111">
                    <img src="${cpath}/resources/images/slide/slide_kbo.png" class="slide-img link-slide" alt="마스코트상점">
                </a>
            </div>
            <button type="button" class="prev" onclick="prevSlide(event)">&#10094;</button>
            <button type="button" class="next" onclick="nextSlide(event)">&#10095;</button>
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
        
        
        <div class="popup-overlay" id="cardPopupOverlay" onclick="closeCardPopup()"></div>
		<div class="bottom-card-list popup-card-list" id="cardPopup">
		    <h1>🐥카드사별 베스트셀러 모음🐥</h1>
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

$(document).ready(function () {
    $(".mySlideDiv").not(".active").hide(); // 첫번째 div를 제외한 나머지 숨김
    setInterval(nextSlide, 4000); // 4초마다 자동 슬라이드
});

function prevSlide(event) {
    if(event) event.stopPropagation(); // a태그 클릭 버블링 차단
    $(".mySlideDiv").hide();
    var allSlide = $(".mySlideDiv");
    var currentIndex = 0;
    $(".mySlideDiv").each(function(index, item){
        if($(this).hasClass("active")) {
            currentIndex = index;
        }
    });
    var newIndex = (currentIndex <= 0) ? allSlide.length-1 : currentIndex-1;
    $(".mySlideDiv").removeClass("active");
    $(".mySlideDiv").eq(newIndex).addClass("active").show();
}

function nextSlide(event) {
    if(event) event.stopPropagation(); // a태그 클릭 버블링 차단
    $(".mySlideDiv").hide();
    var allSlide = $(".mySlideDiv");
    var currentIndex = 0;
    $(".mySlideDiv").each(function(index, item){
        if($(this).hasClass("active")) {
            currentIndex = index;
        }
    });
    var newIndex = (currentIndex >= allSlide.length-1) ? 0 : currentIndex+1;
    $(".mySlideDiv").removeClass("active");
    $(".mySlideDiv").eq(newIndex).addClass("active").show();
}



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
.slideshow-container {
    max-width: 1200px;
    margin: auto;
    text-align: center;
    overflow: hidden;
    position: relative;
    height: 500px;
}
.prev, .next {
    cursor: pointer;
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    width: 50px;
    height: 80px;
    padding: 0;
    color: white;
    font-weight: bold;
    font-size: 48px;
    border-radius: 10%;
    background: rgba(0,0,0,0.23); 
    z-index: 2;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 2px 12px rgba(0,0,0,0.14);
    transition: background 0.18s, box-shadow 0.18s;
    border: none;
    outline: none;
}
.prev {
    left: 32px;
}
.next {
    right: 32px;
}
.prev:hover, .next:hover {
    background-color: rgba(0,0,0,0.4);
    box-shadow: 0 4px 20px rgba(0,0,0,0.25);
}
@media (max-width: 900px) {
    .slideshow-container {
        height: 35vw;
        min-height: 220px;
    }
    .prev, .next {
        width: 40px;
        height: 60px;
        font-size: 32px;
        left: 8px;
        right: 8px;
    }
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
    max-width: 1280px;
    margin: -10px auto 0 auto;
    background: rgba(255, 255, 255, 0.93);
    border-radius: 32px;
    box-shadow: 0 12px 40px rgba(60,70,90,0.13);
    padding: 48px 32px 56px 32px;
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
  width: 600px;
}

.card-overlay {
  position: absolute;
  top: 430px; /* 손 중앙 기준 y좌표 */
  left: 300px; /* 손 중앙 기준 x좌표 */
  max-width: 200px;
  max-height: 200px;
  transform: translate(-50%, -50%); /* 중심 정렬 */
  object-fit: contain;
  border-radius: 8px;
  background: white;
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
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
  padding: 20px;
  transform: translate(-50%, -50%);
  z-index: 9999;
  box-shadow: 0 4px 30px rgba(0,0,0,0.3);
}

.popup-card-list .card-slider {
  display: flex;
  flex-wrap: wrap; /* 줄바꿈 허용 */
  justify-content: center; /* 가운데 정렬 */
  gap: 16px;
  padding: 20px 0;
  scroll-snap-type: none; /* 필요 시 제거 */
  overflow-x: hidden; /* 가로 스크롤 제거 */
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
  max-width: 100%;
  max-height: 100%;
  object-fit: contain;
}


</style>
