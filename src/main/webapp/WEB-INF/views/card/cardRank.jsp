<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
  <title>카드가든-카드 랭킹</title>
  <style>
    body {
      font-family: 'NanumSquareRound', sans-serif;
      background-color: #f7f7f7;
      padding: 40px;
    }

.section {
  margin: 40px auto;
  padding: 20px;
  max-width: 1200px;   /* ✅ 중앙 정렬 + 폭 제한 */
  background: white;
  border-radius: 16px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.05);
}

    .section-title {
      font-size: 36px;
      font-weight: bolder;
      margin-bottom: 20px;
      text-align: left;
    }

.image-button-grid {
  display: grid;
  gap: 8px;                         /* 버튼 사이 여백 */
  grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); /* 유동적으로 꽉 채움 */
}

/* 각 영역별 컬럼 수 유지 */
.section1 .image-button-grid {
  grid-template-columns: repeat(3, 1fr);
}
.section2 .image-button-grid {
  grid-template-columns: repeat(5, 1fr);
}
.section3 .image-button-grid {
  grid-template-columns: repeat(6, 1fr);
}
.section1 {
  max-width: 1200px;  /* 기존 100% -> 1200px로 맞춤 */
  margin: 40px auto;  /* 좌우 중앙 정렬 + 상하 마진 */
  overflow-x: auto;
}
.section1-grid {
  display: grid;
  grid-template-columns: 8fr 5fr 5fr;  /* 8:5:5 비율 */
  gap: 10px;
}

.section1 .image-button {
  width: 100%;
  height: 250px;
  border: none;
  padding: 0;
  margin: 0;
  background: none;
  overflow: hidden;
}
.section2 .image-button {
  width: 100%;
  height: 250px;
  border: none;
  padding: 0;
  margin: 0;
  background: none;
  overflow: hidden;
}
.section3 .image-button {
  width: 100%;
  height: 350px;
  border: none;
  padding: 0;
  margin: 0;
  background: none;
  overflow: hidden;
}

.section1 .image-button img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  border-radius: 16px;
}

.image-button {
  border: none;
  background: none;
  padding: 0;
  margin: 0;
  width: 100%;
  height: auto;
  aspect-ratio: 3 / 4; /* 카드 비율 유지 */
  overflow: hidden;
}

.image-button img {
  width: 100%;
  height: 100%;
  object-fit: cover; /* 잘림 허용하면서 꽉 채움 */
  border-radius: 16px;
  transition: transform 0.3s;
}

  </style>
</head>
<body>
  <c:set var="path" value="${pageContext.request.contextPath}" />
<div class="section section1">
  <div class="section1-grid">
    <button class="image-button">
      <img src="${path}/resources/images/button/all.png" alt="all">
    </button>
    <button class="image-button">
      <img src="${path}/resources/images/button/credit.png" alt="credit">
    </button>
    <button class="image-button">
      <img src="${path}/resources/images/button/check.png" alt="check">
    </button>
  </div>
</div>


  <div class="section section2">
    <div class="section-title">⭐ 카드사별 Top 10</div>
    <div class="image-button-grid">
      <c:forEach var="i" begin="1" end="10">
        <button class="image-button"><img src="${path}/resources/images/button/company/company${i}.png" alt="company${i}"></button>
      </c:forEach>
    </div>
  </div>

  <div class="section section3">
    <div class="section-title">🎯 혜택별 카드 Top 10</div>
    <div class="image-button-grid">
      <c:forEach var="i" begin="1" end="12">
        <button class="image-button"><img src="${path}/resources/images/button/benefit/benefit${i}.png" alt="benefit${i}"></button>
      </c:forEach>
    </div>
  </div>

</body>
</html>
