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
        align-items: center;
    }
    .card-item:last-child {
        border-bottom: none;
    }
    .card-id {
        color: #50a3f7;
        font-weight: bold;
        margin-right: 10px;
    }
    /* 향후 카드 이름/점수용 스타일 미리 준비 */
    .card-name {
        margin-left: 6px;
        color: #293746;
        font-size: 16px;
    }
    
   
</style>

</head>
<body>
	
    <div class="recommend-list">
        <h2 style="margin-bottom:18px; color:#3887d2;">추천 카드 리스트</h2>
        <c:forEach var="dto" items="${aiList}">
            <div class="card-item">
                <span class="card-id">${dto.card_id}</span>
                <!-- 추후에 카드 이름 들어갈 자리 -->
                <span class="card-name">(카드명 자리)</span>
            </div>
        </c:forEach>
        <c:if test="${empty aiList}">
            <div style="color:#bbb; text-align:center; margin-top:25px;">추천 카드가 없습니다.</div>
        </c:if>
    </div>
    
    
</body>
</html>
