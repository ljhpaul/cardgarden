<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />
<!-- 공통 헤더/스타일/스크립트 -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${cpath}/resources/css/common.css">
<link rel="stylesheet" href="${cpath}/resources/css/header.css">
<link rel="stylesheet" href="${cpath}/resources/css/admin.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${cpath}/resources/js/header.js"></script>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>카드가든 관리자 대시보드</title>
  <style>
    body {
  background: #F0F3F1;
  font-family: 'NanumSquareRound', sans-serif;
  margin: 0;
  padding: 0;
}
.admin-container {
  max-width: 1200px;
  margin: 36px auto 50px auto;
  padding: 36px 20px;
  background: #fff;
  border-radius: 24px;
  box-shadow: 0 6px 36px 0 rgba(0,60,20,0.10);
  min-height: 700px;
}
.admin-title {
  font-size: 2.5rem;
  font-weight: 800;
  color: #388E3C;
  text-align: center;
  margin-bottom: 32px;
  letter-spacing: -1.5px;
}
/* --- 그리드 --- */
.chart-list {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 36px 28px;
}
@media (max-width: 900px) {
  .chart-list {
    grid-template-columns: 1fr;
    gap: 20px 0;
  }
}

.chart-section {
  min-width: 0;  /* grid 컨테이너에서 오버플로우 방지 */
  padding: 24px 18px 32px 18px;
  background: #F7FAF8;
  border-radius: 18px;
  box-shadow: 0 2px 16px 0 rgba(56,142,60,0.06);
  text-align: center;
  transition: box-shadow 0.2s;
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
}
.chart-section:hover {
  box-shadow: 0 6px 24px 0 rgba(56,142,60,0.14);
}
.chart-title {
  font-size: 1.55rem;
  font-weight: 700;
  color: #23722F;
  margin-bottom: 16px;
  letter-spacing: -1px;
  text-align: left;
}
.chart-desc {
  font-size: 1.03rem;
  color: #777;
  margin-bottom: 12px;
  text-align: left;
}
.chart-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 360px;
  width: 100%;
}
/* --- 여기서부터 iframe 핵심 --- */
.chart-container iframe {
  width: 100%;
  max-width: 100%;
  min-width: 0;
  border-radius: 14px;
  box-shadow: 0 2px 12px 0 rgba(120,180,110,0.07);
  border: none;
  background: #fff;
  transition: box-shadow 0.2s;
  height: 480px;
  display: block;
}
/* --- 반응형 --- */
@media (max-width: 1000px) {
  .admin-container {
    padding: 18px 4vw;
  }
  .chart-container iframe {
    height: 400px;
  }
}

  </style>
</head>
<body>
  <div class="admin-container">
    <div class="admin-title">관리자 대시보드</div>
    <div class="chart-list">
      <div class="chart-section">
        <div class="chart-title">카드 혜택 카테고리 분포</div>
        <div class="chart-desc">카드별 제공되는 주요 혜택 카테고리의 분포 현황을 시각화합니다.</div>
        <div class="chart-container">
          <iframe src="${metabasebenefitUrl}" allowtransparency></iframe>
        </div>
      </div>
      <div class="chart-section">
        <div class="chart-title">날짜별 유저 유입 수</div>
        <div class="chart-desc">날짜별로 유저의 유입 수를 보여줍니다.</div>
        <div class="chart-container">
          <iframe src="${metabaseuserUrl}" allowtransparency></iframe>
        </div>
      </div>
      <div class="chart-section">
        <div class="chart-title">여성 포인트 TOP 10</div>
        <div class="chart-desc">여성 회원 기준, 가장 포인트가 높은 상위 10명의 순위를 보여줍니다.</div>
        <div class="chart-container">
          <iframe src="${metabasefUrl}" allowtransparency></iframe>
        </div>
      </div>
      <div class="chart-section">
        <div class="chart-title">남성 포인트 TOP 10</div>
        <div class="chart-desc">남성 회원 기준, 가장 포인트가 높은 상위 10명의 순위를 보여줍니다.</div>
        <div class="chart-container">
          <iframe src="${metabasemUrl}" allowtransparency></iframe>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
