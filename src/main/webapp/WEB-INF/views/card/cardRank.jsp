<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>카드가든-카드 랭킹</title>
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
	margin : 0;
	padding : 0;
}

.section {
	margin: 40px auto;
	padding: 20px;
	max-width: 1200px; /* ✅ 중앙 정렬 + 폭 제한 */
	background: white;
	border-radius: 16px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.section-title {
	font-size: 36px;
	font-weight: bolder;
	margin-bottom: 20px;
	text-align: left;
}

.image-button-grid {
	display: grid;
	gap: 8px; /* 버튼 사이 여백 */
	grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
	/* 유동적으로 꽉 채움 */
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
	max-width: 1200px; /* 기존 100% -> 1200px로 맞춤 */
	margin: 40px auto; /* 좌우 중앙 정렬 + 상하 마진 */
	overflow-x: auto;
}

.section1-grid {
	display: grid;
	grid-template-columns: 8fr 5fr 5fr; /* 8:5:5 비율 */
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
	height: auto; /* 높이 고정 제거 */
  aspect-ratio: 3 / 4; /* 비율 유지 */
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
	border-radius: 26px;
	padding: 0;
	margin: 0;
	width: 100%;
	height: auto;
	aspect-ratio: 3/4; /* 카드 비율 유지 */
	overflow: hidden;
	cursor: pointer;
}

.image-button img {
	width: 100%;
	height: 100%;
	object-fit: cover; /* 잘림 허용하면서 꽉 채움 */
	border-radius: 16px;
	transition: transform 0.3s;
}

.image-button img:hover {
	transform: scale(1.05);
}


</style>
</head>
<body>


	<c:set var="path" value="${pageContext.request.contextPath}" />
	<div class="section section1">
		<div class="section1-grid">
			<form action="${path}/card/rankResult" method="get">
				<input type="hidden" name="type" value="all" />
				<button class="image-button" type="submit">
					<img src="${path}/resources/images/button/all.png" alt="all">
				</button>
			</form>

			<form action="${path}/card/rankResult" method="get">
				<input type="hidden" name="type" value="credit" />
				<button class="image-button" type="submit">
					<img src="${path}/resources/images/button/credit.png" alt="credit">
				</button>
			</form>

			<form action="${path}/card/rankResult" method="get">
				<input type="hidden" name="type" value="check" />
				<button class="image-button" type="submit">
					<img src="${path}/resources/images/button/check.png" alt="check">
				</button>
			</form>
		</div>
	</div>


	<div class="section section2">
		<div class="section-title">⭐ 카드사별 Top 10</div>
		<div class="image-button-grid">
			<c:set var="companies" value="신한,삼성,현대,롯데,우리,국민,하나,농협,IBK,BC" />
			<c:forEach var="company" items="${fn:split(companies, ',')}"
				varStatus="status">
				<form action="${path}/card/rankResult" method="get">
					<input type="hidden" name="type" value="${company}" /> <input
						type="hidden" name="keyword" value="${company}" />
					<button class="image-button" type="submit">
						<img
							src="${path}/resources/images/button/company/company${status.index + 1}.png"
							alt="${company}" />
					</button>
				</form>
			</c:forEach>
		</div>
	</div>

	<div class="section section3">
		<div class="section-title">🎯 혜택별 카드 Top 10</div>
		<div class="image-button-grid">
			<c:set var="benefits"
				value="모빌리티,대중교통,통신,생활,쇼핑,외식/카페,뷰티/피트니스,금융/포인트,병원/약국,문화/취미,숙박/항공,모든가맹점" />
			<c:forEach var="benefit" items="${fn:split(benefits, ',')}"
				varStatus="status">
				<form action="${path}/card/rankResult" method="get">
					<input type="hidden" name="type" value="${benefit}" /> <input
						type="hidden" name="keyword" value="${benefit}" />
					<button class="image-button" type="submit">
						<img
							src="${path}/resources/images/button/benefit/benefit${status.index + 1}.png"
							alt="${benefit}" />
					</button>
				</form>
			</c:forEach>
		</div>
	</div>

</body>
</html>
