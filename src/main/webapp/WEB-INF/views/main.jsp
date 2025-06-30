<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<!-- 공통 헤더/스타일/스크립트 -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${cpath}/resources/css/common.css">
<link rel="stylesheet" href="${cpath}/resources/css/header.css">
<link rel="stylesheet" href="${cpath}/resources/css/font-awesome.min.css">
<link rel="stylesheet" href="${cpath}/resources/css/style.css">

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
</style>
