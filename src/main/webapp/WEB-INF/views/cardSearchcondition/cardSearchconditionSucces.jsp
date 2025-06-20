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
	  flex-direction: column;
	  align-items: center;
	  justify-content: center;
	  width: 100%;
    }
    .tab {
      width: 1000px;
      padding: 40px;
      background: white;
      border-radius: 12px;
      box-shadow: 0 8px 24px rgba(0,0,0,0.1);
      display: flex;
      flex-direction: row; /* 가로 정렬 */
      gap: 20px;
    }
	#condition {
	  margin-bottom: 50px;
	  display: flex;
	  flex-direction: row; /* 가로 정렬 */
	  gap: 20px;
	}
	#condition > div {
	  padding: 10px 20px;
	  background-color: #f5f5f5;
	  border-radius: 8px;
	  font-weight: bold;
	  text-align: center;
	  min-width: 100px;
	}
    /* 카드 자세히 보기 버튼 */
    .card-btn {
      background-color: #e0e0e0;
      border-radius: 12px;
      border-style: none;
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
    .ticks {
	  display: flex;
	  justify-content: space-between;
	  margin-top: 4px;
	  font-size: 12px;
	  color: #444;
	}
  </style>
</head>
<body>
  <div class="wrap">
    <div class="tab" id="condition">
		<div id="fee_domestic">
		연회비</div>
    	<div id="prev_month_cost">전월실적</div>
    	<div id="company">
          <select name="company">
			<option value=""></option>
          </select>
    	</div>
    	<div id="sort">
          <select name="company">
			<option value="">조회순</option>
			<option value="">좋아요순</option>
			<option value="">연회비순</option>
          </select>
		</div>
    </div>
    <c:forEach var="card" items="${CardList}">
        <div class="tab">
	        <div class="card_img">
	         <img src="${card.card_image}" alt="${card.card_name}" width="200">
	        </div>
	        <div class="card_content">
	        	<h3>${card.card_name}</h3>
			    <p>연회비: ${card.fee_domestic} 원</p>
			     <ul>
			      <c:forEach var="benefit" items="${card.benefits}">
			        <li>${benefit}</li>
			      </c:forEach>
			    </ul>
			    <p>전월실적: ${card.prev_month_cost} 만원</p>
	        </div>
	        <div>
	        	<a href="?card_id=${card.card_id}" class=card-btn>카드 보러가기</a>
	        </div>
   		</div>
   	</c:forEach>
  </div>
  
  
  
  
<script>
	const value = document.querySelector("#volume-output");
	const input = document.querySelector("#volume");
	value.textContent = input.value;
	input.addEventListener("input", (event) => {
	  value.textContent = event.target.value;
	});
</script>
</body>
</html>
