<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>카드가든 : AI 카드추천</title>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Square+Round&display=swap" rel="stylesheet">
<style>
:root {
  --m1: #8FB098;
  --m2: #D3E8D6;
  --m3: #49615A;
  --main: #F0F3F1;
  --s2: #FAFAF8;
}

body {
  font-family: 'Nanum Square Round', 'NanumSquareRound', sans-serif;
  background: var(--main);
  margin: 0;
  padding: 0;
}

.recommend-list {
  max-width: 1050px;
  margin: 40px auto;
  padding: 34px 36px 34px 36px;
  background: #fff;
  border-radius: 24px;
  box-shadow: 0 6px 32px rgba(143,176,152,0.13);
  display: flex;
  flex-direction: column;
  gap: 30px;
}

.recommend-list h2 {
  margin-bottom: 18px;
  color: var(--m3);
  font-size: 27px;
  font-weight: bold;
  letter-spacing: -1.5px;
  text-align: left;
  padding-left: 10px;
}

.card-list {
  display: flex;
  flex-direction: column;
  gap: 28px;
}

.card-item {
  position: relative; /* 배지 포지셔닝 위해 추가 */
  display: flex;
  flex-direction: row;
  gap: 36px;
  align-items: stretch;
  background: var(--s2);
  border-radius: 18px;
  box-shadow: 0 2px 10px rgba(143,176,152,0.07);
  border: 2px solid var(--m2);
  padding: 22px 30px;
  transition: box-shadow 0.14s;
  margin-top: 20px;
}
.card-item:hover {
  box-shadow: 0 8px 32px rgba(143,176,152,0.16);
  border-color: var(--m1);
}

.card-img-area {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  width: 160px;
  min-width: 120px;
  margin-right: 24px;
}
.card-img {
  width: 130px;
  height: 90px;
  border-radius: 12px;
  background: #f5f5f5;
  object-fit: contain;
  border: 1px solid var(--m2);
  margin-bottom: 14px;
  box-shadow: 0 1px 4px rgba(143,176,152,0.08);
}
.card-id-link {
  display: inline-block;
  color: var(--m1);
  font-weight: bold;
  font-size: 16px;
  margin-bottom: 4px;
  text-decoration: underline;
  transition: color 0.2s;
}
.card-id-link:hover {
  color: #ffcb66;
  background: #FFE0A3;
}
.card-id {
  color: #59A985;
  font-size: 20px;
  font-weight: 800;
  text-decoration: none;
  margin-bottom: 3px;
  trans
}
.card-id:hover { color: #ffcb66; }

.card-company-type {
  color: #444;
  font-size: 16px;
  margin-bottom: 2px;
}

.card-main-info {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 6px;
  justify-content: center;
}

.card-name {
  font-size: 20px;
  font-weight: bold;
  color: var(--m3);
  margin-bottom: 2px;
}
.card-company {
  font-size: 16px;
  font-weight: 600;
  color: #67a886;
  margin-bottom: 3px;
  letter-spacing: -0.5px;
}
.card-type {
  font-size: 15px;
  color: #888;
  font-weight: 500;
  margin-bottom: 7px;
}

.card-type-label {
  color: #8FB098;
}
.card-fee-info {
  color: #999;
  font-size: 15px;
}

.benefit-list {
  margin: 6px 0 0 0;
  padding: 0;
  display: flex;
  flex-direction: column;
  gap: 2px;
}
.benefit-item {
  list-style: none;
  font-size: 15px;
  color: #555;
  display: flex;
  align-items: center;
  gap: 9px;
  margin-bottom: 3px;
}
.benefit-item .benefit-badge {
  background: var(--m2);
  color: var(--m3);
  border-radius: 7px;
  font-size: 12px;
  padding: 1px 8px 0 8px;
  margin-right: 5px;
  font-weight: bold;
}

.card-detail-right {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  justify-content: center;
  min-width: 130px;
  gap: 10px;
}
.detail-btn {
  background: var(--m1);
  color: #fff;
  border: none;
  border-radius: 10px;
  font-weight: bold;
  padding: 12px 28px;
  font-size: 15px;
  margin-bottom: 8px;
  transition: background 0.18s;
  cursor: pointer;
  box-shadow: 0 2px 12px rgba(100,130,120,0.07);
}
.detail-btn:hover {
  background: var(--m3);
}
.card-fee, .card-perf {
  font-size: 14px;
  color: #59715A;
  margin-bottom: 2px;
  font-weight: 600;
  text-align: right;
}
@media (max-width: 900px) {
  .recommend-list { max-width: 98vw; padding: 16px; }
  .card-item { flex-direction: column; gap: 14px; align-items: flex-start; padding: 16px 10px;}
  .card-img-area { width: 100%; flex-direction: row; margin: 0 0 14px 0; }
  .card-detail-right { align-items: flex-start; }
}
.no-recommend {
  color: #bbb;
  text-align: center;
  margin-top: 30px;
  background: var(--s2);
  border-radius: 12px;
  padding: 32px 0;
  border: 1.5px solid var(--m2);
  font-size: 18px;
}
.recommend-rank-badge {
  position: absolute;
  top: -14px;
  left: 16px;
  background: linear-gradient(90deg, #FFCB66 70%, #8FB098 100%);
  color: #3d4140;
  font-size: 14.5px;
  font-weight: bold;
  letter-spacing: -0.5px;
  padding: 6px 18px 6px 15px;
  border-radius: 16px 14px 14px 0;
  box-shadow: 0 2px 12px rgba(143,176,152,0.08);
  z-index: 10;
  display: inline-block;
  border: 1px solid #F7D9A3;
  /* 살짝 튀어나오게! */
}
.detail-type {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: center;
  gap: 0px;
}

</style>
</head>
<body>
<div class="recommend-list">
    <h2>추천 카드 상세 리스트</h2>
    <c:forEach var="entry" items="${cardDetailMap}" varStatus="loop">
	    <div class="card-item">
	        <div class="recommend-rank-badge">추천 ${loop.index+1}순위</div>
	        <div style="flex-shrink:0; margin-right:18px;">
	            <img class="card-img" src="${entry.value[0].card_image}" alt="카드 이미지">
	        </div>
	        <div class="detail-type">
	            <a class="card-id" href="${cpath}/card/detail?cardid=${entry.key}">${entry.value[0].card_name}</a>
	            <span class="card-company-type">
	              ${entry.value[0].company} &nbsp;|&nbsp; <b class="card-type-label">${entry.value[0].card_type}</b>
	            </span>
	            <span class="card-fee-info">
	              국내연회비: ${entry.value[0].fee_domestic}원, 전월실적: ${entry.value[0].prev_month_cost}만원
	            </span>
	        </div>
	    </div>
	</c:forEach>
    <c:if test="${empty cardDetailMap}">
        <div class="no-recommend">추천 카드가 없습니다.</div>
    </c:if>
</div>
</body>

