<%@ include file="../common/header.jsp" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>카드가든 : 카드조회</title>
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
	  color: #333;
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
	  background-color: #fff;
	  border-radius: 16px;
	  padding: 30px 30px;
	  box-shadow: 0 2px 8px rgba(0,0,0,0.05);
	  position: relative;
	  border: 2px dashed #8FB098;
	}
	.tab {
	  background-color: #FFF5E1;
	  color: #646F58;
	  font-weight: bold;
	  padding: 8px 14px;
	  border-radius: 12px 12px 0 0;
	  font-size: 15px;
	  box-shadow: 0 -2px 0 rgba(0,0,0,0.1);
	  margin-bottom: 4px;
	  padding-left: 10px;
	  cursor: pointer;
	}
	#benefitDetailListarea{
		padding-left: 18px;
		padding-top: 5px;
		padding-bottom: 5px;
		/* border: 2px dashed #8FB098; */
	    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.08);
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
	  background-color: #DFEED8;
	  color: #2E4637;
	  border-radius: 14px;
	  padding: 20px;
	  text-align: center;
	  cursor: pointer;
	  font-size: 20px;
	  font-weight: bold;
	  transition: all 0.3s;
	  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.08);
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
	  background-color: #DFEED8;
	  color: #2E4637;
	  font-size: 16px;
	  display: flex;
	  flex-direction: column;
	  align-items: center;
	  justify-content: center;
	  border-radius: 14px;
	  margin-top: 50px;
	  margin-bottom: 20px;
	  padding: 20px 10px;
	  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
	  transition: background-color 0.4s ease;
	  text-align: center;
	}
	
	.count-title {
	  font-size: 18px;
	  font-weight: bold;
	  margin-bottom: 6px;
	}
	
	.count-number {
	  font-size: 30px;
	  font-weight: 800;
	  color: #fffff;
	}
    input[type="checkbox"]:focus {
      outline: 3px solid #FF9900;
      outline-offset: 4px;
    }
	input[type="submit"] {
	  background-color: #8FB098;
	  color: white;
	  border: none;
	  padding: 16px;
	  font-size: 17px;
	  font-weight: bold;
	  border-radius: 10px;
	  cursor: pointer;
	  transition: background-color 0.3s ease;
	  width:250px;
	}
    input[type="submit"]:hover {
      background-color: #388E3C;
    }
    /* 비활성화된 상태 */
	input[type="submit"]:disabled {
	  cursor: not-allowed;
	  background-color: #ccc; /* 선택 */
	  opacity: 0.6; /* 선택 */
	}
    .emoji {
      font-size: 20px;
      margin-right: 6px;
    }
  </style>
</head>
<body>
<form id="searchForm" action="${cpath}/cardSearchcondition" method="post">
  <div id="selectedCategories"></div>
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
          <div class="tab category-tab" data-id="${category.benefitcategory_id}">
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
          <div id="benefitDetailListarea">
          <c:forEach var="detail" items="${benefitDetailList}">
            <c:if test="${detail.benefitcategory_id == category.benefitcategory_id}">
              <label class="folder_btn">
                <input type="checkbox" name="category" value="${detail.benefitdetail_id}">
                ${detail.benefitdetail_name}
              </label>
            </c:if>
          </c:forEach>
          </div>
        </div>
      </c:forEach>
    </div>
		<div class="right">
		  <div id="cardCountdiv">
		    <span class="count-title">고객님에게는</span>
		    <span id="cardCount" class="count-number">0</span> 
		    <span style="font-weight: bold;">개의 카드가 적합합니다</span>
		  </div>
		  <input id="cardsubmit" type="submit" value="카드 보러 가기">
		</div>
		  </div>
</form>
<script>
let cardsubmit;


document.querySelectorAll(".category-tab").forEach(tab => {
	  tab.addEventListener("click", function () {
	    const categoryId = this.dataset.id;
	    const container = document.getElementById("selectedCategories");

	    if (this.classList.contains("selected")) {
	      this.classList.remove("selected");
	      this.style.backgroundColor = "#FFF5E1";

	      // 이름까지 포함해 정확히 찾아서 삭제
	      const inputToRemove = Array.from(container.querySelectorAll('input[name="benefitcategory_id"]'))
	                                 .find(input => input.value == categoryId);
	      if (inputToRemove) container.removeChild(inputToRemove);
	    } else {
	      this.classList.add("selected");
	      this.style.backgroundColor = "#DFEED8";

	      const input = document.createElement("input");
	      input.type = "hidden";
	      input.name = "benefitcategory_id";
	      input.value = categoryId;
	      container.appendChild(input);
	    }

	    // 디버깅 정확히 출력
	    const selectedInputs = Array.from(container.querySelectorAll('input[name="benefitcategory_id"]'));
	    console.log("선택된 카테고리들:", selectedInputs.map(i => i.value));
	    console.log("현재 hidden input 개수:", selectedInputs.length);

	    updateCardCount();
	  });
	});

function updateCardCount() {
    const category = [];
    document.querySelectorAll('input[name="category"]:checked').forEach(ct => category.push(ct.value));
    const cardType = [];
    document.querySelectorAll('input[name="cardType"]:checked').forEach(ct => cardType.push(ct.value));
    const benefitCategoryIds = [];
    document.querySelectorAll('#selectedCategories input[name="benefitcategory_id"]').forEach(input => {
      benefitCategoryIds.push(input.value);
    });


    
    if (cardType.length === 0) {
      alert("신용카드 또는 체크카드 중 하나는 선택해야 합니다.");
      document.getElementById("cardCount").textContent = 0;
      document.getElementById("cardCountdiv").style.backgroundColor = "#DFEED8";
      return;
    }
    
    console.log("카테고리:", category);
    console.log("카테고리 탭:", benefitCategoryIds);

    $.ajax({
      url: "${cpath}/cardCount",
      method: "POST",
      data: { category: category, cardType: cardType, benefitcategory_id: benefitCategoryIds },
      traditional: true,
      success: function(count) {
        $("#cardCount").text(count);
        $("#cardCountdiv").css("background-color", count > 0 ? "#4CAF50" : "#DFEED8");
        if(count == 0){
            console.log("카드가 0개임 비활성화");
            cardsubmit.disabled = true;
        }else{
        	console.log("카드가 있음 활성화");
            cardsubmit.disabled = false;
        }

      },
      error: function() {
        $("#cardCount").text("오류");
        $("#cardCountdiv").css("background-color", "darkred");
      }
    });
  }

  document.addEventListener("DOMContentLoaded", function () {
	  cardsubmit = document.getElementById("cardsubmit");
    document.querySelectorAll('input[name="category"], input[name="cardType"]').forEach(input => {
      input.addEventListener("change", updateCardCount);
    });

    document.getElementById("searchForm").addEventListener("submit", function (e) {
      const checked = document.querySelectorAll('input[name="cardType"]:checked');
      if (checked.length === 0) {
        alert("신용카드 또는 체크카드 중 하나는 선택해야 합니다.");
        e.preventDefault();
        document.getElementById("focus").focus();
      }else{
        cardsubmit.disabled = false;
    }
    });
  });
</script>
</body>
</html>
