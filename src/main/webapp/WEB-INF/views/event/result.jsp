<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<%@ include file="../common/header.jsp" %>
<link rel="stylesheet" href="${cpath}/resources/css/mascotResult.css?after">

<div class="custom-top-container">
  
  <h2>구매가 완료되었습니다!</h2>
  
  <div class="btn-row">
    <a href="${cpath}/event/mascot/my" class="buy-btn">변경하러 가기</a>
    <a href="${cpath}/event/mascot" class="buy-btn">상점으로 돌아가기</a>
  </div>

</div>
