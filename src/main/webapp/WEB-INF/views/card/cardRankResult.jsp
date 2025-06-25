<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<title>카드가든 랭킹</title>
<style>
/* 전체 화면 영역 지정 및 분할 스타일 */
.wrap {
	width: 100%;
	height: 100%;
	overflow: hidden;
	margin: auto;
	background-color: #F0F3F1;
	position: relative;
	display: flex;
	justify-content: center; /* 수평 가운데 정렬 */
}

body {
	font-family: 'NanumSquareRound', sans-serif;
	background-color: #F0F3F1;
	padding: 0;
	margin: 0;
}

.card-container {
	max-width: 1200px;
	margin: auto;
	padding: 20px;
}

/* ===== TOP 1~3 ===== */
.top3 {
	display: flex;
	justify-content: space-around;
	margin-bottom: 40px;
}

.top3 .card-box {
	width: 210px;
	text-align: center;
	background-color: white;
	padding: 16px;
	border: 1px solid #ccc;
	border-radius: 16px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
	transition: background-color 0.3s ease;
}
.card-box:hover {
	background-color: var(--s2);
}

.medal {
	width: 32px;
	height: 32px;
	margin: 0 auto 8px;
}

.medal img {
	width: 100%;
	height: 100%;
	object-fit: contain;
}

.card-image-wrapper {
	width: 150px;
	height: 150px;
	background-color: #f5f5f5;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 0 auto 12px;
	overflow: visible;
}

.card-image-wrapper img {
	max-width: 100%;
	max-height: 100%;
	object-fit: contain;
	transition: transform 1s;
}

.card-image-wrapper img:hover {
	transform: scale(2);
}

/* 카드 이름 텍스트 */
.topcard-name {
	font-size: 18px;
	font-weight: bold;
	color: #333;
}

/* ===== 4~10위 영역 ===== */
.others {
	display: flex;
	flex-direction: column;
	gap: 16px;
}

.card-row {   /*  카드 들어가는곳, 클릭하면 상세로    */
	display: flex;
	align-items: center;
	background-color: white;
	padding: 16px 24px;
	border: 1px solid #ccc;
	border-radius: 16px;
	width: 1000px;
	max-width: 90%;
	margin: 0 auto;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
	transition: background-color 0.3s ease;
}
.card-row:hover {
	background-color: var(--s2);
}

.card-image-wrapper1 {   
	width: 120px;
	height: 120px;
	background-color: #f5f5f5;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	margin-right: 20px;
	overflow: visible;
}

.card-image-wrapper1 img {
	max-width: 100%;
	max-height: 100%;
	object-fit: contain;
	transition: transform 0.5s;
}

.card-image-wrapper1 img:hover {
	transform: scale(1.5);
}

/* 랭킹 번호 */
.rank {
	font-weight: bold;
	font-size: 20px;
	color: #444;
	margin-right: 12px;
}

/* 이름 (4~10위) */
.card-info {
	flex: 1;
}
.card-name {
  font-size: 20px;
  font-weight: bold;
  margin-bottom: 8px;
}

.card-company {
  font-size: 14px;
  color: #666;
}
.card-type {
  background-color: var(--m1);
  color: white;                /* 흰색 글씨 */
  padding: 2px 8px;            /* 안쪽 여백 */
  border-radius: 8px;          /* 둥근 모서리 */
  font-size: 12px;
  margin-left: 8px;            /* 회사명과 간격 */
  display: inline-block;
}
.right-cursor img {
	width: 40px;
	height: 40px;
	overflow: visible;
}
</style>
</head>
<body>
	<c:set var="path" value="${pageContext.request.contextPath}" />
	<div class="card-container">

		<!-- 🎖 상위 1~3위 -->
		<div class="top3">
			<c:forEach var="card" items="${cardList}" begin="0" end="2"
				varStatus="status">
				<div class="card-box" onclick="location.href='${pageContext.request.contextPath}/card/detail?cardid=${card.card_id}'"
     style="cursor: pointer;">
					<div class="medal">
						<c:choose>
							<c:when test="${status.index == 0}">
								<img src="${path}/resources/images/medals/gold.png" />
							</c:when>
							<c:when test="${status.index == 1}">
								<img src="${path}/resources/images/medals/silver.png" />
							</c:when>
							<c:when test="${status.index == 2}">
								<img src="${path}/resources/images/medals/bronze.png" />
							</c:when>
						</c:choose>
					</div>
					<div class="card-image-wrapper">
						<img src="${card.card_image}" />
					</div>
					<div class="topcard-name">${card.card_name}</div>
				</div>
			</c:forEach>
		</div>


		<!-- 👇 나머지 4~10위 -->
		<div class="others">
			<c:forEach var="card" items="${cardList}" begin="3" end="9"
				varStatus="status">
				<div class="card-row" onclick="location.href='${pageContext.request.contextPath}/card/detail?cardid=${card.card_id}'"
     style="cursor: pointer;">
					<span class="rank">TOP${status.index + 1}</span>
					<div class="card-image-wrapper1">
						<img src="${card.card_image}" />
					</div>

					<div class="card-info">
						<div class="card-name">${card.card_name}</div>
						<div class="card-company">${card.company}
							<!-- 신용카드면 [신용]만 뜨게함 -->
							<span class="card-type"> <c:choose>
									<c:when test="${card.card_type == '신용카드'}">신용</c:when>
									<c:when test="${card.card_type == '체크카드'}">체크</c:when>
									<c:otherwise>신용</c:otherwise>
								</c:choose>
							</span>
						</div>
					</div>
					<div class="right-cursor"><img src="${pageContext.request.contextPath}/resources/images/right.png" alt="오른쪽커서" class="right-cursor" /></div>
				</div>
			</c:forEach>
		</div>
	</div>
</body>
</html>
