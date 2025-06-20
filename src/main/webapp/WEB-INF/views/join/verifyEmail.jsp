<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${cpath}/resources/css/common.css">
<link rel="stylesheet" href="${cpath}/resources/css/join.css">
<link rel="stylesheet" href="${cpath}/resources/css/font-awesome.min.css">

<div class="join-bg">
  <div class="join-container">
    <div class="join-box" style="max-width:400px; padding: 40px 32px; margin-top:40px;">
      <h2 style="margin-bottom:24px; color: var(--m3);"><i class="fa fa-envelope"></i> 이메일 인증</h2>
      <form action="${cpath}/user/email/verify" method="POST" style="width:100%;">
        <div style="width:100%; margin-bottom:24px;">
          <label for="email" style="font-weight:600; color:var(--m1); font-size:16px;">이메일 주소</label>
          <input
            type="email"
            id="email"
            name="email"
            class="form-control"
            required
            style="margin-top:10px; width:100%; border:1px solid var(--m1); border-radius:8px; padding:12px; font-size:16px; font-family: var(--font);"
            placeholder="example@email.com"
          />
        </div>
        <button
          type="submit"
          class="join-btn"
          style="width:100%; height:48px; font-size:18px; margin-bottom:16px;"
        >
          인증메일 발송
        </button>
      </form>
      <div style="width:100%; text-align:center;">
        <span style="color:#888; font-size:14px;">
          이미 인증 메일을 받으셨나요?
          <a href="${cpath}/user/email/verifycode" class="join-text-hover">인증번호 입력</a>
        </span>
      </div>
    </div>
  </div>
</div>
