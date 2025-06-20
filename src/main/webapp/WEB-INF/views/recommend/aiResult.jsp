<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>추천 카드 리스트</title>
<style>
    .recommend-list {
        max-width: 430px;
        margin: 40px auto;
        padding: 20px 30px;
        background: #f7fbfd;
        border-radius: 14px;
        box-shadow: 0 4px 14px rgba(80,163,247,0.12);
    }
    .card-item {
        padding: 16px 0 12px 0;
        border-bottom: 1px solid #e1eaf0;
        font-size: 17px;
        font-weight: 500;
        color: #3a3c42;
        letter-spacing: 0.5px;
        display: flex;
        flex-direction: column;
    }
    .card-item:last-child {
        border-bottom: none;
    }
    .card-id {
        color: #50a3f7;
        font-weight: bold;
        margin-right: 10px;
    }
    .card-name {
        margin-left: 6px;
        color: #293746;
        font-size: 16px;
    }
    .benefit-list {
        margin: 8px 0 0 12px;
        padding-left: 0;
        font-size: 15px;
        color: #6386a8;
    }
    .benefit-item {
        list-style: disc;
        margin-bottom: 3px;
    }
</style>
</head>
<body>
	
    <div class="recommend-list">
        <h2 style="margin-bottom:18px; color:#3887d2;">추천 카드 상세 리스트</h2>
        <c:forEach var="entry" items="${cardDetailMap}">
            <div class="card-item">
                <%-- <span class="card-id">카드 ID: ${entry.key}</span> --%>
                <!-- 상세 정보가 여러 개일 수 있으니, value(List)를 또 반복 -->
                <ul class="benefit-list">
                    <c:forEach var="detail" items="${entry.value}">
                        <li class="benefit-item">
                            <a class="card-id" href="${cpath}/card/detail?cardid=${entry.key}" style="color:#3498db; text-decoration:underline;">
							  ${detail.card_name}
							</a>
                            <div>
                            	<img src="${detail.card_image}" alt="카드 이미지" width="160" height="90"/>
                            </div>
                            <!-- 카드명 외에 추가적으로 출력할 필드가 있다면 더 추가 -->
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </c:forEach>
        <c:if test="${empty cardDetailMap}">
            <div style="color:#bbb; text-align:center; margin-top:25px;">추천 카드가 없습니다.</div>
        </c:if>
    </div>
</body>
</html>
