<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<title>카드가든-카드 검색</title>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding&display=swap"
	rel="stylesheet">

<link rel="stylesheet"
	href="https://unpkg.com/swiper@8/swiper-bundle.min.css" />
<script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>

<style>
@font-face {
	font-family: 'NanumSquareRound';
	src:
		url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/NanumSquareRound.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

/* 전체 화면 영역 확인용 스타일 */
* {
	box-sizing: border-box;
}

div, form {
	
}

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

header {
	width: 100%;
	height: 200px;
	margin: 0 auto;
	background-color: blue;
}

#content {
	margin-top: 30px;
	width: 1000px;
	display: grid;
	grid-template-columns: repeat(3, 1fr); /* 가로 3칸 */
	gap: 20px; /* 박스 사이 여백 */
	padding: 40px;
	box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
	border-radius: 12px;
	background-color: #FFFFFF;
}

.folder {
	background-color: #f2f2f2;
	border-radius: 20px;
	height: 160px;
	padding: 20px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	position: relative;
	margin-bottom: 50px; /*폴더 간격 조정*/
	font-family: 'NanumSquareRound', sans-serif;
}

.tab {
	position: absolute;
	top: -30px;
	left: 0px;
	background-color: #f2f2f2;
	padding: 10px 20px;
	border-radius: 10px 10px 0 0;
	font-weight: bold;
	font-family: 'NanumSquareRound', sans-serif;
	text-align: center; /* 텍스트 가운데 정렬 */
}

.cardtype {
	width: 100%;
	height: 100px;
	display: grid;
	gap: 20px;
	/* 그리드 한 줄 전체 차지 */
	grid-column: 1/-1;
	grid-template-columns: repeat(2, 1fr); /* 가로 2칸 */
	margin-bottom: 50px;
}

.card-btn {
	display: flex;
	/*   display: block; */
	padding: 40px;
	height: 100%;
	text-align: center;
	border-radius: 20px;
	cursor: pointer;
	background-color: #f2f2f2;
	font-size: 30px;
	font-family: 'NanumSquareRound', sans-serif;
	font-weight: bold;
}
</style>
<style>
.card-box {
 position: relative;       /* 추가 */
  overflow: visible;        /* ✅ 이미지가 안 잘리도록 */
  display: flex;
  align-items: center;
  border: 1px solid #ccc;
  padding: 12px;
  margin: 20px auto;              /* 가운데 정렬 + 위아래 여백 */
  width: 900px;                   /* ✅ 고정 너비 설정 */
  max-width: 90%;                 /* ✅ 작은 화면 대응 (반응형) */
  border-radius: 12px;            /* 옵션: 둥근 테두리 */
  background-color: white;        /* 옵션: 배경색 */
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05); /* 옵션: 그림자 */
  transition: background-color 0.3s ease;
}

.card-box:hover {
	background-color: var(--s2);
}


.card-image-wrapper {
  width: 120px;
  height: 120px;
  background-color: #f5f5f5;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: visible; /* 기본 overflow: visible */
  margin-right: 20px;
  position: relative; /* z-index 기준용 */
}

.card-image {
  max-width: 90%;
  max-height: 90%;
  border-radius: 0;
  object-fit: contain;
  transition: transform 0.3s ease;
  position: relative; /* z-index 기준 */
  z-index: 1;
}

.card-image:hover {
  transform: scale(1.5);
  z-index: 100; /* 부모 위로 나오도록 */
}

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



.like-icon {
	width: 32px;
	height: 32px;
	cursor: pointer;
}

.liked {
	fill: #f88;
}

.pagination {
	margin-top: 30px;
	text-align: center;
}

.pagination a {
	margin: 0 5px;
	text-decoration: none;
	color: #333;
}

.search-bar {
	text-align: center;
	margin: 20px 0;
}

.search-bar input {
	background-image: url("/cardgarden/resources/images/common/search.png");
	background-size: 16px;
	background-position: 15px center;
	background-repeat: no-repeat;
	text-indent: 35px;
	height: 40px;
	width: 200px;
	border: 1px solid var(--m1);
	border-radius: 20px;
	font-size: 15px;
	font-weight: 400;
	color: var(--m3);
}

.search-wrapper {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 10px; /* 요소 간 간격 */
}

.search-bar select {
  height: 40px;
  width: 120px;
  padding-left: 15px;
  padding-right: 30px;
  font-size: 15px;
  font-weight: 400;
  color: var(--m3);
  border: 1px solid var(--m1);
  background-color: white;
  background-image: url("/cardgarden/resources/images/common/dropdown.png");
  background-repeat: no-repeat;
  background-position: right 10px center;
  background-size: 12px;
  appearance: none;
  -webkit-appearance: none;
  -moz-appearance: none;
  cursor: pointer;
}

.search-bar button {
	height: 40px;
	width: 40px;
	border: none;
	border-radius: 50%;
	background-color: var(--m1); /* 메인 색상 */
	color: white;
	font-size: 18px;
	cursor: pointer;
	margin-left: 10px;
	transition: background-color 0.3s;
}

.search-bar button:hover {
	background-color: var(--m2); /* hover 시 색상 변경 */
}

.right-cursor img {
	width: 40px;
	height: 40px;
	overflow: visible;
}
</style>
</head>
<body>

	<div class="search-bar">
		<form method="get" action="search">
			<div class="search-wrapper">
				<select name="sort">
					<option value="name" ${param.sort == 'name' ? 'selected' : ''}>이름순</option>
					<option value="views" ${param.sort == 'views' ? 'selected' : ''}>조회수순</option>
					<option value="likes" ${param.sort == 'likes' ? 'selected' : ''}>좋아요순</option>
				</select> <input type="text" name="keyword" value="${param.keyword}"
					placeholder="카드 이름, 회사 등 검색" />
				<button type="submit">🔍</button>
			</div>
		</form>
	</div>

	<c:if test="${empty cardList}">
		<div style="text-align: center; margin: 20px;">카드가 0건 검색되었습니다.</div>
	</c:if>
	<c:forEach var="card" items="${cardList}">
		<div class="card-box" onclick="location.href='${pageContext.request.contextPath}/card/detail?cardid=${card.card_id}'"
     style="cursor: pointer;">
			<div class="card-image-wrapper">
			  <img src="${card.card_image}" alt="카드 이미지" class="card-image" />
			</div>
			
			<div class="card-info">
				<div class="card-name">${card.card_name}</div>
				<div class="card-company">${card.company}
			  <span class="card-type">
			    <c:choose>
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

	<!-- 페이징 -->
	<div class="pagination">
		<c:set var="prevPage" value="${currentPage - 5}" />
		<c:set var="nextPage" value="${currentPage + 5}" />

		<c:if test="${currentPage > 1}">
			<a
				href="?page=${prevPage < 1 ? 1 : prevPage}&keyword=${param.keyword}&sort=${param.sort}">이전</a>
		</c:if>

		<c:forEach begin="${startPage}" end="${endPage}" var="i">
			<a href="?page=${i}&keyword=${param.keyword}&sort=${param.sort}"
				style="${i == currentPage ? 'font-weight:bold;' : ''}">${i}</a>
		</c:forEach>

		<c:if test="${currentPage < totalPages}">
			<a
				href="?page=${nextPage > totalPages ? totalPages : nextPage}&keyword=${param.keyword}&sort=${param.sort}">다음</a>
		</c:if>
	</div>



</body>
</html>
