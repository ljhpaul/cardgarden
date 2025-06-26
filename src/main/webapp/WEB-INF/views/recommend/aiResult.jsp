<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>추천 카드 리스트</title>
<style>
    body {
		font-family: 'NanumSquareRound', sans-serif;
		background-color: #F0F3F1;
		padding: 0;
		margin: 0;
	}
	.recommend-list {
	    max-width: 480px;
	    margin: 40px auto;
	    padding: 32px 32px 28px 32px;
	    background: #fff;
	    border-radius: 16px;
	    box-shadow: 0 2px 12px rgba(143,176,152,0.08);
	    border: 2px solid var(--m2);
	}
	.recommend-list h2 {
	    margin-bottom: 22px;
	    color: var(--m3);
	    font-size: 23px;
	    font-weight: bold;
	    letter-spacing: -1px;
	    text-align: center;
	}
	.card-item {
	    padding: 20px 0 14px 0;
	    border-bottom: 1.5px solid var(--m2);
	    font-size: 17px;
	    font-weight: 500;
	    color: var(--m3);
	    display: flex;
	    flex-direction: column;
	    background: var(--s2);
	    border-radius: 10px;
	    margin-bottom: 16px;
	    box-shadow: 0 2px 6px rgba(143,176,152,0.06);
	    transition: box-shadow 0.15s, background 0.2s;
	}
	.card-item:last-child {
	    border-bottom: none;
	    margin-bottom: 0;
	}
	.benefit-list {
	    margin: 0 0 0 10px;
	    padding-left: 0;
	    font-size: 15px;
	    color: var(--m3);
	}
	.benefit-item {
	    list-style: none;
	    margin-bottom: 8px;
	    display: flex;
	    align-items: center;
	    gap: 18px;
	}
	.card-id {
	    color: var(--m1);
	    font-weight: bold;
	    margin-right: 12px;
	    font-size: 16px;
	    text-decoration: underline;
	    transition: color 0.2s;
	}
	.card-id:hover {
	    background-color: #FFE0A3;
	}
	.card-name {
	    margin-left: 4px;
	    color: var(--m3);
	    font-size: 16px;
	    font-weight: bold;
	}
	.card-img {
	    margin: 10px 0 0 0;
	    border-radius: 8px;
	    border: 1px solid var(--m2);
	    background: var(--main);
	    width: 130px;
	    height: 80px;
	    object-fit: cover;
	    box-shadow: 0 1px 4px rgba(143,176,152,0.07);
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
	a { text-decoration: none; color: var(--m3);}
	.detail-type{
		display: flex;
		flex-direction : column;
	}
</style>
</head>
<body>
    <div class="recommend-list">
	    <h2>추천 카드 상세 리스트</h2>
	    <c:forEach var="entry" items="${cardDetailMap}">
	        <div class="card-item">
	            <ul class="benefit-list">
	                <c:forEach var="detail" items="${entry.value}">
	                    <li class="benefit-item">
	                    <div>
	                    	<img class="card-img" src="${detail.card_image}" alt="카드 이미지"/>
	                    </div>
	                    <div class="detail-type">
	                        <a class="card-id" href="${cpath}/card/detail?cardid=${entry.key}">
	                          ${detail.card_name}
	                        </a>
	                        <p>
	                          ${detail.company}
	                        </p>
	                        <p>
	                          ${detail.card_type}
	                        </p>
	                    </div>    
	                        
	                        <!-- 추가 정보도 여기서 자유롭게! -->
	                    </li>
	                </c:forEach>
	            </ul>
	        </div>
	    </c:forEach>
	    <c:if test="${empty cardDetailMap}">
	        <div class="no-recommend">추천 카드가 없습니다.</div>
	    </c:if>
	</div>

</body>
</html>
