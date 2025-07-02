<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<style>
body {
  background-color: var(--main);
  font-family: var(--font);
  padding: 0;
  margin: 0;
  background-color: #F0F3F1;
}

.result-container {
  background-color: white;
  padding: 100px;
  border-radius: 20px;
  margin: 20px auto;
  max-width: 1100px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
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
  cursor: pointer;
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

  <a href="${cpath}/user/customcard">
  <img id="fakeImg" src="${cpath}/resources/images/custom/gotocustomcard.png" alt="대기 이미지">
  </a>

  <div class="btn-group">
    <a href="${cpath}/custom/main" class="btn">커스텀 홈으로</a>
    <a href="${cpath}/make/frame" class="btn">새로 만들기</a>
  </div>
</div>
