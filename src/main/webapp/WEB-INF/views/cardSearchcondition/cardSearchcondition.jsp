<%@ include file="../common/header.jsp" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>카드조회</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding&family=Nanum+Square+Round&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css" />
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body {
      font-family: 'Nanum Square Round', sans-serif;
      background-color: #F0F3F1;
    }
    .wrap {
      display: flex;
      justify-content: center;
      gap: 40px;
      padding: 40px 20px;
    }
    #content {
      width: 1000px;
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 20px;
      padding: 40px;
      background: white;
      border-radius: 12px;
      box-shadow: 0 8px 24px rgba(0,0,0,0.1);
    }
   .folder {
      background-color: #f9f9f9;
      border-radius: 16px;
      padding: 30px 20px; /* 글씨 위치 조정  */
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
      position: relative;
      font-size: 16px;
    }
    .tab {
      font-weight: bold;
      margin-bottom: 5px;
      font-size: 16px;
      display: inline-block;
      background-color: #f9f9f9;
      padding: 6px 12px; /* 대카테고리 글씨 영역 */
      border-top-left-radius: 10px;
      border-top-right-radius: 10px;
      position: absolute;
      top: -25px;
      left: 0px;
     box-shadow: 0 -2px 0 rgba(0,0,0,0.1);
    }
    .folder_btn {
      display: block;
      margin: 4px 0;
      cursor: pointer;
    }
    .cardtype {
      grid-column: 1 / -1;
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 16px;
      margin-bottom: 20px;
    }
    .card-btn {
      background-color: #e0e0e0;
      border-radius: 12px;
      padding: 20px;
      text-align: center;
      cursor: pointer;
      font-size: 20px;
      font-weight: bold;
      transition: background-color 0.3s;
    }
    .card-btn:hover {
      background-color: #c8e6c9;
    }
    .right {
      width: 300px;
      min-height: 100vh;
      background-color: #ffffff;
      border-radius: 12px;
      box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
      padding: 20px;
    }
    #cardCountdiv {
      height: 80px;
      background-color: gray;
      color: white;
      font-size: 16px;
      display: flex;
      align-items: center;
      justify-content: center;
      border-radius: 10px;
      margin-bottom: 20px;
      transition: background-color 0.5s;
    }
    input[type="checkbox"]:focus {
      outline: 3px solid #FF9900;
      outline-offset: 4px;
    }
    input[type="submit"] {
      width: 100%;
      padding: 14px;
      font-size: 16px;
      font-weight: bold;
      background-color: #4CAF50;
      color: white;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      transition: background-color 0.3s;
    }
    input[type="submit"]:hover {
      background-color: #388E3C;
    }
    .emoji {
      font-size: 20px;
      margin-right: 6px;
    }
  </style>
</head>
<body>
<form id="searchForm" action="${cpath}/cardSearchcondition" method="post">
  <div class="wrap">
    <div id="content">
      <div class="cardtype">
        <label class="card-btn">
          <input type="checkbox" name="cardType" value="신용카드" id="focus"> 💳 신용카드
        </label>
        <label class="card-btn">
          <input type="checkbox" name="cardType" value="체크카드"> 🏦 체크카드
        </label>
      </div>
      <c:forEach var="category" items="${benefitCategoryList}">
        <div class="folder">
          <div class="tab">
            <span class="emoji">
              <c:choose>
                <c:when test="${category.benefitCategory_name.contains('모빌리티')}">&#x1F697;</c:when>
                <c:when test="${category.benefitCategory_name.contains('대중교통')}">&#x1F68C;</c:when>
                <c:when test="${category.benefitCategory_name.contains('주유')}">&#x26FD;</c:when>
                <c:when test="${category.benefitCategory_name.contains('통신')}">&#x1F4F1;</c:when>
                <c:when test="${category.benefitCategory_name.contains('생활')}">&#x1F3E0;</c:when>
                <c:when test="${category.benefitCategory_name.contains('쇼핑')}">&#x1F6CD;</c:when>
                <c:when test="${category.benefitCategory_name.contains('외식')}">&#x1F37D;</c:when>
                <c:when test="${category.benefitCategory_name.contains('뷰티')}">&#x1F484;</c:when>
                <c:when test="${category.benefitCategory_name.contains('금융')}">&#x1F4B0;</c:when>
                <c:when test="${category.benefitCategory_name.contains('병원')}">&#x1F3E5;</c:when>
                <c:when test="${category.benefitCategory_name.contains('문화')}">&#x1F3AC;</c:when>
                <c:when test="${category.benefitCategory_name.contains('숙박')}">&#x1F3E8;</c:when>
                <c:otherwise>&#x1F4CC;</c:otherwise>
              </c:choose>
            </span>
            ${category.benefitCategory_name}
          </div>
          <c:forEach var="detail" items="${benefitDetailList}">
            <c:if test="${detail.benefitcategory_id == category.benefitcategory_id}">
              <label class="folder_btn">
                <input type="checkbox" name="category" value="${detail.benefitdetail_id}">
                ${detail.benefitdetail_name}
              </label>
            </c:if>
          </c:forEach>
        </div>
      </c:forEach>
    </div>
    <div class="right">
      <div id="cardCountdiv">
        고객님에게 맞는 카드는 <span id="cardCount">0</span>개 입니다
      </div>
      <input type="submit" value="카드보러가기">
    </div>
  </div>
</form>
<script>
  function updateCardCount() {
    const category = [];
    document.querySelectorAll('input[name="category"]:checked').forEach(ct => category.push(ct.value));
    const cardType = [];
    document.querySelectorAll('input[name="cardType"]:checked').forEach(ct => cardType.push(ct.value));

    if (cardType.length === 0) {
      alert("신용카드 또는 체크카드 중 하나는 선택해야 합니다.");
      document.getElementById("cardCount").textContent = 0;
      document.getElementById("cardCountdiv").style.backgroundColor = "gray";
      return;
    }

    $.ajax({
      url: "${cpath}/cardCount",
      method: "POST",
      data: { category: category, cardType: cardType },
      traditional: true,
      success: function(count) {
        $("#cardCount").text(count);
        $("#cardCountdiv").css("background-color", count > 0 ? "#4CAF50" : "gray");
      },
      error: function() {
        $("#cardCount").text("오류");
        $("#cardCountdiv").css("background-color", "darkred");
      }
    });
  }

  document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll('input[name="category"], input[name="cardType"]').forEach(input => {
      input.addEventListener("change", updateCardCount);
    });

    document.getElementById("searchForm").addEventListener("submit", function (e) {
      const checked = document.querySelectorAll('input[name="cardType"]:checked');
      if (checked.length === 0) {
        alert("신용카드 또는 체크카드 중 하나는 선택해야 합니다.");
        e.preventDefault();
        document.getElementById("focus").focus();
      }
    });
  });
</script>
</body>
</html>
