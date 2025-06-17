<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<title>카드 검색</title>
<style>
.card-box {
	display: flex;
	align-items: center;
	border: 1px solid #ccc;
	padding: 12px;
	margin: 12px 0;
}

.card-image {
	width: 100px;
	margin-right: 20px;
}

.card-info {
	flex: 1;
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
</style>
</head>
<body>

	<div class="search-bar">
		<form method="get" action="cardsearch">
			<input type="text" name="keyword" value="${param.keyword}"
				placeholder="카드 이름, 회사 등 검색" />
			<button type="submit">🔍</button>
			<select name="sort">
				<option value="name" ${param.sort == 'name' ? 'selected' : ''}>이름순</option>
				<option value="views" ${param.sort == 'views' ? 'selected' : ''}>조회수순</option>
				<option value="likes" ${param.sort == 'likes' ? 'selected' : ''}>좋아요순</option>
			</select>

		</form>
	</div>
	<c:if test="${empty cardList}">
		<div style="text-align: center; margin: 20px;">카드가 0건 검색되었습니다.</div>
	</c:if>
	<c:forEach var="card" items="${cardList}">
		<div class="card-box">
			<img src="${card.card_image}" alt="카드 이미지" class="card-image" />
			<div class="card-info">
				<div>${card.card_name}</div>
				<div>${card.company}[${card.card_type}]</div>
			</div>
			<%--         <div>
            <c:choose>
                <c:when test="${card.likedByUser == 1}">
                    <img src="heart_filled.png" class="like-icon" alt="좋아요" />
                </c:when>
                <c:otherwise>
                    <img src="heart_empty.png" class="like-icon" alt="좋아요 안눔" />
                </c:otherwise>
            </c:choose>
        </div> --%>
		</div>
	</c:forEach>

<!-- 페이징 -->
<div class="pagination">
    <c:set var="prevPage" value="${currentPage - 5}" />
    <c:set var="nextPage" value="${currentPage + 5}" />

    <c:if test="${currentPage > 1}">
        <a href="?page=${prevPage < 1 ? 1 : prevPage}&keyword=${param.keyword}&sort=${param.sort}">이전</a>
    </c:if>

    <c:forEach begin="${startPage}" end="${endPage}" var="i">
        <a href="?page=${i}&keyword=${param.keyword}&sort=${param.sort}"
           style="${i == currentPage ? 'font-weight:bold;' : ''}">${i}</a>
    </c:forEach>

    <c:if test="${currentPage < totalPages}">
        <a href="?page=${nextPage > totalPages ? totalPages : nextPage}&keyword=${param.keyword}&sort=${param.sort}">다음</a>
    </c:if>
</div>



</body>
</html>
