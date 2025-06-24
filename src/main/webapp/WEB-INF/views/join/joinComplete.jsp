<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<!-- 공통 헤더/스타일/스크립트 -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${cpath}/resources/css/common.css">
<link rel="stylesheet" href="${cpath}/resources/css/header.css">
<link rel="stylesheet" href="${cpath}/resources/css/font-awesome.min.css">
<link rel="stylesheet" href="${cpath}/resources/css/style.css">

<head>
    <title>카드가든 : 회원가입</title>
</head>

<body class="bg-main">
  <div class="container" style="padding-top: 100px;">
    <div class="box" style="max-width: 480px; width: 100%; padding: 48px 36px; box-sizing: border-box;">
      <i class="fa fa-check-circle" style="font-size: 60px; color: var(--m1); margin-bottom: 18px;"></i>
      <div class="title-lg" style="margin-bottom: 18px;">회원가입 완료</div>
      <div style="font-size: 17px; color: #444; text-align: center; margin-bottom: 36px; line-height: 1.7;">
        카드가든의 다양한 서비스를<br>
        지금 바로 이용하실 수 있습니다.<br>
        <span style="color:var(--m3); font-size:15px;">
          <i class="fa fa-smile-o"></i> 환영합니다!
        </span>
      </div>
      <a href="${cpath}/user/login" class="btn" style="width: 100%; font-size: 18px; padding: 15px 0; font-weight: 600; margin-bottom: 10px;">
        <i class="fa fa-sign-in" style="margin-right: 8px;"></i> 로그인하기
      </a>
      <a href="${cpath}/main" class="btn" style="width: 100%; background: var(--m2); color: var(--m3); font-size: 16px; padding: 12px 0; font-weight: 600;">
        <i class="fa fa-home" style="margin-right: 7px;"></i> 메인으로 이동
      </a>
    </div>
  </div>
</body>
