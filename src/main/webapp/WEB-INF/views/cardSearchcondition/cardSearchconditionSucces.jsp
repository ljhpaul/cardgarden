<%@ include file="../common/header.jsp"%>
<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>카드조회</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding&family=Nanum+Square+Round&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css" />
<link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
  <script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<style>
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

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
	gap: 30px;
	padding: 20px;
}

.tab {
	width: 100%;
	max-width: 1100px;
	padding: 30px;
	background: white;
	border-radius: 16px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
	display: flex;
	flex-direction: column;
	gap: 20px;
}

#condition {
	display: flex;
	flex-wrap: wrap;
	gap: 16px;
	margin-bottom : 5px;
	margin-top : 30px;
	justify-content: center;
}

#condition > div {
	padding: 10px 16px;
	background-color: #DFEED8;
	border-radius: 12px;
	font-weight: bold;
	text-align: center;
	min-width: 120px;
	flex: 1 1 200px;
}

.card-btn {
	width: 100%;
	background-color: #8FB098;
	border-radius: 12px;
	border: none;
	padding: 14px;
	text-align: center;
	cursor: pointer;
	font-size: 18px;
	font-weight: bold;
	color: white;
	transition: background-color 0.3s;
}

.card-btn:hover {
	background-color: #7ca688;
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

/* .ticks {
	display: flex;
	justify-content: space-between;
	margin-top: 4px;
	font-size: 12px;
	color: #444;
} */

.card_img {
  width: 250px;
  height: 200px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 20px auto;
  background-color: #F5F5F5;
  border-radius: 50%; /* 원형 */
/*   box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15); /* 부드러운 그림자 */ */
}

.card-thumbnail {
  width: 90%;
  height: auto;
  object-fit: contain;
}

.card_content {
	width: 100%;
	display: flex;
	flex-direction: column;
	gap: 10px;
}

.card_content ul {
	list-style: none;
	padding-left: 0;
	margin: 0;
}

.card_content ul li {
	  margin-bottom: 8px;
	  font-size: 16px;
	  line-height: 1.5;
	  white-space: pre-line;
}


.left, .right {
	width: 100%;
}


.right{
	margin-right: 20px;
}

.right p {
	font-size: 18px;
	color: #444;
	margin: 4px 0;
}

.left span,p{
		font-size: 18px;
		font : bold;
}

/* 반응형 규조 */
@media (min-width: 768px) {
	.tab {
		flex-direction: row;
		align-items: center;
	}
	.card_content {
		flex-direction: row;
		justify-content: space-between;
		align-items: flex-start;
		gap: 20px;
	}
	.left {
		width: 70%;
	}

	.right {
		width: 30%;
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: flex-end;
		gap: 10px;
	}

	.card-thumbnail {
		width: 100%;
		height: 180px;
	}
	/* 조건 선택 영역 스타일 개선 */
.condition-section {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 24px;
  padding: 24px;
  margin-bottom: 40px;
  background-color: #ffffff;
  border-radius: 16px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
}

.condition-item {
  flex: 1 1 250px;
  display: flex;
  flex-direction: column;
  gap: 10px;
  padding: 16px;
  background-color: #DFEED8;
  border-radius: 12px;
  font-size: 14px;
}

.condition-item label {
  font-weight: bold;
  color: #333;
}

.condition-item input[type="text"] {
  padding: 8px 10px;
  border: none;
  border-radius: 8px;
  background: #f8f8f8;
  font-weight: bold;
  color: #8FB098;
  text-align: center;
}

.condition-item select {
  padding: 10px;
  border-radius: 8px;
  border: 1px solid #ccc;
  background-color: #fff;
  font-size: 14px;
  color: #333;
}

.slider {
  margin-top: 4px;
  background: #F0F3F1;
  border-radius: 6px;
  height: 8px;
}

#btnarea{
  width: 1100px;
  margin-bottom: 25px;
}

#btnarea .card-btn {
  width: 150px;
  font-size: 15px;
}
</style>

</head>
<body>
<div class="wrap">
  <!-- 조건 선택 영역 -->
  <section id="condition" class="tab condition-section">

    <!-- 연회비 슬라이더 -->
    <div class="condition-item">
      <label for="fee_domestic">연회비</label>
      <input type="text" id="fee_domestic" readonly>
      <div id="slider-range" class="slider"></div>
    </div>

    <!-- 전월 실적 슬라이더 -->
    <div class="condition-item">
      <label for="prev_month_cost">전월실적</label>
      <input type="text" id="prev_month_cost" readonly>
      <div id="slider-range2" class="slider"></div>
    </div>

    <!-- 카드사 선택 -->
    <div class="condition-item">
      <label for="company">카드사</label>
      <select id="company">
        <option value="모든카드사">모든카드사</option>
        <option value="신한카드">신한카드</option>
        <option value="삼성카드">삼성카드</option>
        <option value="현대카드">현대카드</option>
        <option value="NH농협카드">롯데카드</option>
        <option value="KB국민카드">KB국민카드</option>
        <option value="우리카드">우리카드</option>
        <option value="하나카드">하나카드</option>
        <option value="NH농협카드">NH농협카드</option>
        <option value="IBK기업은행">IBK기업은행</option>
        <option value="BC바로카드">BC바로카드</option>
        <option value="애플페이">애플페이</option>
        <option value="네이버페이">네이버페이</option>
        <option value="현대백화점">현대백화점</option>
        <option value="카카오뱅크">카카오뱅크</option>
        <option value="엔이이치엔페이코">엔이이치엔페이코</option>
        <option value="한패스">한패스</option>
      </select>
    </div>

    <!-- 정렬 기준 선택 -->
    <div class="condition-item">
      <label for="sort">정렬기준</label>
      <select id="sort">
        <option value="card_views">조회순</option>
        <option value="card_like">좋아요순</option>
        <option value="fee_domestic">연회비순</option>
      </select>
    </div>
  </section>
  
  <div id="btnarea">
   <button id="reselect" class="card-btn">혜택 재선택</button>
   <button id="reset" class="card-btn">조건 초기화</button>
  </div>

	<div style="text-align: left; width: 1100px; margin-top: -20px;">
	  <span style="font-size: 20px;">총 <strong>${CardList.size()}</strong>개의 카드가 검색되었습니다.</span>
	</div>
	
  <!-- 카드 리스트 출력 -->
  <c:forEach var="card" items="${CardList}">
    <div class="tab"
         data-company="${card.company}"
         data-like="${card.card_like}"
         data-fee_domestic="${card.fee_domestic}"
         data-card_views="${card.card_views}"
         data-prev_month_cost="${card.prev_month_cost}">

      <!-- 카드 이미지 -->
      <div class="card_img">
        <img src="${card.card_image}" alt="${card.card_name}" class="card-thumbnail">
      </div>

      <!-- 카드 정보 -->
      <div class="card_content">

        <!-- 왼쪽: 이름, 회사, 혜택 -->
        <div class="left">
          <h2>${card.card_name}</h2>
          <h3>${card.company}</h3>
          <br>
          <ul>
            <c:forEach var="benefit" items="${card.benefits}" varStatus="bs">
                <c:if test="${bs.index < 3}">
                <li><h4>[혜택 ${bs.index + 1}]</h4> <span> ${benefit}</span></li>
              </c:if>
            </c:forEach>
          </ul>
        </div>

        <!-- 오른쪽: 버튼, 연회비, 전월실적 -->
        <div class="right">
          <a href="${cpath}/card/detail?cardid=${card.card_id}" class="card-btn">카드 보러가기</a>
          <br><br><br><br>
		  <h3>연회비</h3>
		  <c:choose>
		    <c:when test="${card.fee_domestic == 0}">
		      <span>없음</span>
		    </c:when>
		    <c:otherwise>
		      <span>${card.fee_domestic} 원</span>
		    </c:otherwise>
		  </c:choose>
          <h3>전월실적</h3>
          <c:choose>
          	<c:when test="${card.prev_month_cost == 0}">
          	 <span> 없음</span>
          	</c:when>
          	<c:otherwise>
          	 <span> ${card.prev_month_cost} 만원</span>
          	</c:otherwise>
          </c:choose>
          
        </div>

      </div>
    </div>
  </c:forEach>
</div>
<script>
  // jQuery - 연회비 슬라이더
  $(function () {
    $("#slider-range").slider({
      range: true,
      min: 0,
      max: 300000,
      values: [0, 300000],
      step: 10000,
      slide: function (event, ui) {
        $("#fee_domestic").val(ui.values[0] + "원 ~ " + ui.values[1] + "원");
        selectCardsByFee(ui.values[0], ui.values[1]);
      }
    });

    $("#fee_domestic").val(
      $("#slider-range").slider("values", 0) + "원 ~ " +
      $("#slider-range").slider("values", 1) + "원"
    );
  });

  // jQuery - 전월 실적 슬라이더
  $(function () {
    $("#slider-range2").slider({
      range: true,
      min: 0,
      max: 75,
      values: [0, 75],
      step: 5,
      slide: function (event, ui) {
        $("#prev_month_cost").val(ui.values[0] + "만원 ~ " + ui.values[1] + "만원");
        selectCardsByMonthcost(ui.values[0], ui.values[1]);
      }
    });

    $("#prev_month_cost").val(
      $("#slider-range2").slider("values", 0) + "만원 ~ " +
      $("#slider-range2").slider("values", 1) + "만원"
    );
  });

  // 연회비로 카드 필터링
  function selectCardsByFee(min, max) {
    const allCards = document.querySelectorAll(".tab[data-fee_domestic]");
    allCards.forEach(card => {
      const fee = parseInt(card.getAttribute("data-fee_domestic")) || 0;
      card.style.display = (fee >= min && fee <= max) ? "flex" : "none";
    });
  }
  // 전월실적으로 카드 필터링
  function selectCardsByMonthcost(min, max) {
    const allCards = document.querySelectorAll(".tab[data-prev_month_cost]");
    allCards.forEach(card => {
      const fee = parseInt(card.getAttribute("data-prev_month_cost")) || 0;
      card.style.display = (fee >= min && fee <= max) ? "flex" : "none";
    });
  }

  // 카드 정렬
  function sortCardsBy(type) {
    const wrap = document.querySelector(".wrap");
    const cards = Array.from(document.querySelectorAll(".tab[data-company]"));
    cards.sort((a, b) => {
      const aVal = parseInt(a.dataset[type]) || 0;
      const bVal = parseInt(b.dataset[type]) || 0;
      return bVal - aVal; // 내림차순
    });
    cards.forEach(card => wrap.appendChild(card));
  }

  // DOMContentLoaded 시 회사 필터링 및 정렬 이벤트 등록
  document.addEventListener("DOMContentLoaded", function () {
    const companySelect = document.getElementById("company");
    const sortSelect = document.getElementById("sort");

    companySelect.addEventListener("change", function () {
      const selectedCompany = this.value;
      const allCards = document.querySelectorAll(".tab[data-company]");
      allCards.forEach(card => {
        const company = card.getAttribute("data-company");
        card.style.display = (selectedCompany === "모든카드사" || company === selectedCompany) ? "flex" : "none";
      });
    });

    sortSelect.addEventListener("change", function () {
      const selectedSort = this.value;
      sortCardsBy(selectedSort);
    });
  });
  
  document.addEventListener("DOMContentLoaded", function () {
	    const reselect = document.getElementById("reselect");

	    reselect.addEventListener("click", function () {
	      console.log("재선택 버튼 잘 눌리나??");
	      
	      window.location.href = `${cpath}/cardSearchcondition`;
	    });

	  });
  
  document.addEventListener("DOMContentLoaded", function () {
	  const reset = document.getElementById("reset");

	  reset.addEventListener("click", function () {
	    console.log("초기화버튼 잘 눌리나??");

	    // 연회비 슬라이더 초기화
	    $("#slider-range").slider("values", [0, 300000]);
	    $("#fee_domestic").val("0원 ~ 300000원");
	    selectCardsByFee(0, 300000);  // 필터링 다시

	    // 전월실적 슬라이더 초기화
	    $("#slider-range2").slider("values", [0, 75]);
	    $("#prev_month_cost").val("0만원 ~ 75만원");
	    selectCardsByMonthcost(0, 75);  // 필터링 다시

	    // 카드사 선택 초기화
	    document.getElementById("company").value = "모든카드사";

	    // 정렬 기준 초기화 (필요한 경우)
	    document.getElementById("sort").value = "card_views";
	    
	    // 모든 카드 다시 보이게
	    document.querySelectorAll(".tab[data-company]").forEach(card => {
	      card.style.display = "flex";
	    });
	  });
	});
  
</script>

</body>
</html>
