<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<style>
.result-container {
  width: 100%;
  height: 100vh;
  background: white;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.result-container h1 {
  font-size: 36px;
  color: var(--m3);
  margin-bottom: 20px;
}
.result-container img {
  width: 300px;
  height: auto;
  margin-bottom: 30px;
  border: 2px solid var(--m1);
  border-radius: 10px;
}
.result-container .btn-group {
  display: flex;
  gap: 20px;
}
.result-container .btn {
  padding: 15px 30px;
  font-size: 20px;
  background-color: var(--m1);
  color: white;
  border: none;
  border-radius: 10px;
  cursor: pointer;
  text-decoration: none;
  font-weight: bold;
}
.result-container .btn:hover {
  background-color: var(--m2);
  color: var(--m3);
}
</style>

<div class="result-container">
  <h1>카드가 성공적으로 저장되었습니다!</h1>
  
  <div class="btn-group">
    <a href="${cpath}/custom/main" class="btn">커스텀 홈으로</a>
    <a href="${cpath}/make/frame" class="btn">새로 만들기</a>
  </div>
</div>
