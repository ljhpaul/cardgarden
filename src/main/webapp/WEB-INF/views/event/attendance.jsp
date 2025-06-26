<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<link rel="stylesheet" href="${cpath}/resources/css/attendance.css?ver=7">

<div class="attendance-container">

    <!-- 상단 배너 -->
    <div class="attendance-banner">
        <div class="banner-text">
            <h2>당신만의 카드, 당신만의 혜택</h2>
            <h1>카드가든 출석 이벤트</h1>
        </div>
        <div class="banner-image">
            <img src="${cpath}/resources/images/event/stamp.png">
        </div>
    </div>

    <!-- 달력 영역 -->
    <div class="calendar-box">
        <div class="calendar-header">
            <span id="yearMonth"></span>
        </div>

        <div class="calendar-grid-wrapper">
            <div class="wednesday-banner">카드가든데이</div>
            <div class="calendar-grid">
                <div class="day-label">일</div>
                <div class="day-label">월</div>
                <div class="day-label">화</div>
                <div class="day-label">수</div>
                <div class="day-label">목</div>
                <div class="day-label">금</div>
                <div class="day-label">토</div>
            </div>
        </div>

        <form action="${cpath}/event/attendance/check" method="post">
            <c:choose>
                <c:when test="${alreadyAttended}">
                    <button type="button" class="attendance-btn" disabled>출석 완료</button>
                </c:when>
                <c:otherwise>
                    <button type="submit" class="attendance-btn">출석하기</button>
                </c:otherwise>
            </c:choose>
        </form>
    </div>

    <!-- 보상 안내 -->
    <div class="attendance-reward">
        <h3>출석 혜택</h3>
        <ul>
            <li>✔ 하루 출석 시 <strong class="point">50P</strong></li>
            <li>✔ 생일날 출석 시 <strong class="point">200P 추가</strong></li>
            <li>✔ 주 3일 이상 출석 시 <strong class="point">100P 추가</strong></li>
            <li>✔ 주 5일 이상 출석 시 <strong class="point">200P 추가</strong></li>
            <li>✔ <span class="highlight">매주 수요일</span> 카드가든데이 <strong class="point">50P 추가</strong></li>
        </ul>
    </div>
</div>

<!-- 팝업 레이어 -->
<div id="popup-layer" class="popup-layer">
    <div class="popup-content">
        <p class="popup-text">출석이 완료되었습니다.</p>
        <p class="popup-point"><strong>${receivedPoint}P</strong> 적립 완료!</p>
        <button id="popup-close">확인</button>
    </div>
</div>

<script>
    <%-- 출석 완료 팝업 --%>
    <% if ("success".equals(request.getAttribute("attendanceCheck"))) { %>
        document.getElementById("popup-layer").style.display = "flex";
    <% } %>

    document.getElementById("popup-close").addEventListener("click", function() {
        document.getElementById("popup-layer").style.display = "none";
    });

    const date = new Date();
    const year = date.getFullYear();
    const month = date.getMonth();
    const lastDay = new Date(year, month + 1, 0).getDate();
    const firstDay = new Date(year, month, 1).getDay();
    const grid = document.querySelector(".calendar-grid");

    // 출석한 날짜 리스트
    const attendedDays = ${attendedDays};

    // 기존 날짜 영역 비우기
    grid.querySelectorAll(".day-circle").forEach(e => e.remove());

    for (let i = 0; i < firstDay; i++) {
        const empty = document.createElement("div");
        empty.className = "day-circle";
        grid.appendChild(empty);
    }

    for (let i = 1; i <= lastDay; i++) {
        const day = document.createElement("div");
        day.className = "day-circle";
        day.innerText = i;

        if (attendedDays.includes(i)) {
            day.classList.add("attended");
        }

        grid.appendChild(day);
    }

    document.getElementById("yearMonth").innerText = year+"년 "+(month + 1)+"월";
</script>
