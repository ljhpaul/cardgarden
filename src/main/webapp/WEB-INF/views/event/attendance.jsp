<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ include file="../common/header.jsp" %>  
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />  

<link rel="stylesheet" href="${cpath}/resources/css/attendance.css?after">  

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
            <div class="wednesday-banner">카드가든데이<br>50P 추가지급!</div>  
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

        <div class="reward-box-container">  

            <!-- 오늘 출석 -->  
            <div class="reward-box">  
                <div class="reward-inner">  
                    <c:if test="${alreadyAttended}">  
                        <img src="${cpath}/resources/images/event/welldone1.png" class="reward-stamp">  
                    </c:if>  
                </div>  
                <div class="reward-text">오늘 출석 시<br><strong class="point">50P 지급!</strong></div>  
            </div>  

            <!-- 주 3일 이상 -->  
            <div class="reward-box">  
                <div class="reward-inner">  
                    <c:if test="${rewardStatus.weekly3}">  
                        <img src="${cpath}/resources/images/event/welldone1.png" class="reward-stamp">  
                    </c:if>  
                </div>  
                <div class="reward-text">주 3일 이상<br>출석 시 <strong class="point">100P</strong></div>  
            </div>  

            <!-- 주 5일 이상 -->  
            <div class="reward-box">  
                <div class="reward-inner">  
                    <c:if test="${rewardStatus.weekly5}">  
                        <img src="${cpath}/resources/images/event/welldone1.png" class="reward-stamp">  
                    </c:if>  
                </div>  
                <div class="reward-text">주 5일 이상<br>출석 시 <strong class="point">150P</strong></div>  
            </div>  

        </div>  

        <ul class="reward-extra">  
            <li>✔ 생일날 출석 시 <strong class="point">200P 추가</strong>  
            </li>  
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
    <% if ("success".equals(request.getAttribute("attendanceCheck"))) { %>  
        document.getElementById("popup-layer").style.display = "flex";  
    <% } %>  

    document.getElementById("popup-close").addEventListener("click", function () {  
        document.getElementById("popup-layer").style.display = "none";  
    });  

    const date = new Date();  
    const year = date.getFullYear();  
    const month = date.getMonth();  
    const lastDay = new Date(year, month + 1, 0).getDate();  
    const firstDay = new Date(year, month, 1).getDay();  
    const grid = document.querySelector(".calendar-grid");  

    const attendedDays = ${attendedDays};  

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

    document.getElementById("yearMonth").innerText = year + "년 " + (month + 1) + "월";  
</script>  
