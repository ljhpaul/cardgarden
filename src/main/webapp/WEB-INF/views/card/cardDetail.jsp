<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../common/header.jsp"%>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카드가든 상세페이지</title>

<style>
.wrap {
	width: 100%;
	height: 100%;
	overflow: hidden;
	margin: auto;
	background-color: #F0F3F1;
	position: relative;
	display: flex;
	justify-content: center; /* 수평 가운데 정렬 */
}

body {
	font-family: 'NanumSquareRound', sans-serif;
	background-color: #f7f7f7;
}

.card-rep {
	padding-top: 30px;
}

.card-container {
	position: relative;
	margin: auto;
	max-width: 1000px; /* ✅ 중앙 정렬 + 폭 제한 */
	display: flex;
	flex-wrap: wrap;
	align-items: center;
	padding: 24px;
	margin-bottom: 30px;
	border: 1px solid #ddd;
	border-radius: 16px;
	background-color: #fff;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
}

.card-image {
	padding-left : 100px;
	padding-top: 150px;
}

.card-image img {
	display: flex;
	flex-direction: column;
	align-items: center;
	width: 100%;
	max-width: 220px;
	height: auto;
	border-radius: 12px;
	object-fit: cover;
}

.card-info {
  margin-left: 30px;
  flex: 1;
  min-width: 250px;
  display: block; 
}

.card-info p {
	margin: 6px 0;
}

.benefit-title {
	font-size: 36px;
	font-weight: bold;
	padding-bottom: 50px;
	display: flex;           /* 텍스트와 버튼을 가로로 나란히 */
    align-items: center;     /* 수직 가운데 정렬 */
    gap: 10px;               /* 텍스트와 버튼 사이 여백 */
	
}

.card-tags {
	margin-top: 10px;
	font-size: 14px;
	color: #222;
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
}

.go-button {
	display: flex;
	justify-content: center;
	align-items: center;
	background-color: #FFF5E1;
	color: black;
	padding: 10px;
	border-radius: 8px;
	text-decoration: none;
	font-weight: bold;
	transition: background-color 0.2s;
	width: 100%; /* 카드 이미지와 동일한 폭으로 설정됨 */
	max-width: 50px; /* 이미지 최대 폭에 맞춤 */
	box-sizing: border-box;
	border: none;
	cursor: pointer;
}

.company-button {
	display: flex;
	justify-content: center;
	align-items: center;
	background-color: #FFF5E1;
	color: black;
	padding: 10px;
	border-radius: 8px;
	text-decoration: none;
	font-weight: bold;
	transition: background-color 0.2s;
	width: 100%; /* 카드 이미지와 동일한 폭으로 설정됨 */
	max-width: 220px; /* 이미지 최대 폭에 맞춤 */
	box-sizing: border-box;
	border: none;
	cursor: pointer;
}

.go-button img.like-icon {
	width: 28px;
	vertical-align: middle;
}

.like-section {
	display: flex;
	align-items: center;
	gap: 8px;
	margin-top: 10px;
	width: 100%;
	max-width: 220px;
}

.go-button:hover {
	background-color: #FFE0A3;
}

.brand-logo {
    width: 38px;
    height: auto;
    vertical-align: middle;
    margin-left: 4px;
}


.benefit-icon-list .img {
	width: 60px;
	height: 60px;
	padding: 10px;
}

.card-benefit-section {
	margin-top: 40px;
}

.toggle-header {
	display: flex;
	align-items: center;
	gap: 12px;
}

.toggle-header>div:first-child {
	flex: 0 0 50px;
}

.toggle-header>div:nth-child(2) {
	flex: 1;
	font-weight: bold;
	font-size: 18px;
}

.toggle-header>div:nth-child(3) {
	flex: 2;
	font-size: 14px;
	color: #555;
}

.card-benefit-box:hover {
	background-color: var(- -m2);
}

.card-benefit-box table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}

.card-benefit-box table td {
	padding: 10px;
	font-size: 15px;
	vertical-align: top;
}

.card-benefit-box p {
	margin: 4px 0;
	line-height: 1.5;
}

.benefit-icon-list {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	grid-template-rows: repeat(3, 60px);
	gap: 16px;
	max-width: 280px;
}

.benefit-icon-list img {
	width: 60px;
	height: 60px;
	object-fit: contain;
	display: block;
	margin: 0 auto;
}

.btn-open-modal {
 background: none;
  border: none;
  padding: 0;
  cursor: pointer;
   position: relative;
  display: flex;
  align-items: center;
}
.tooltip-text {
  margin-left: 8px;
  font-size: 20px;
  color: #444;
  white-space: nowrap;
  opacity: 0;
  transition: opacity 0.2s;
}

.btn-open-modal:hover .tooltip-text {
  opacity: 1;
}


.btn-open-modal img {
	width: 100px;
	height: 100px;
	object-fit: contain;
	display: block;
	background-color: white;
	margin: 0 auto;
}

.modal {
	position: absolute;
	display: flex;
	justify-content: center;
	align-items: center;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	z-index: 9999; /* 추가! */
}

.modal_body {
	background: #fff;
	padding: 30px 40px;
	border-radius: 14px;
	box-shadow: 0 2px 16px rgba(0, 0, 0, 0.15);
	min-width: 300px;
	min-height: 120px;
	/* 아래 2줄 추가!! */
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}

.benefit-icon-list .img {
	width: 60px;
	height: 60px;
	padding: 10px;
}

.card-benefit-section {
	margin-top: 40px;
}

.card-benefit-box {
	max-width: 1000px; /* ✅ 중앙 정렬 + 폭 제한 */
	cursor: pointer;
	margin: auto;
	margin-bottom: 40px;
	padding: 20px;
	border: 1px solid #ddd;
	border-radius: 16px;
	background-color: white;
	display: flex;
	flex-direction: column;
	gap: 10px;
}

.toggle-header {
	display: flex;
	align-items: center;
	gap: 12px;
}

.toggle-header>div:first-child {
	flex: 0 0 50px;
}

.toggle-header>div:nth-child(2) {
	flex: 1;
	font-weight: bold;
	font-size: 18px;
}

.toggle-header>div:nth-child(3) {
	flex: 2;
	font-size: 14px;
	color: #555;
}

.card-benefit-box:hover {
	background-color: var(- -m2);
}

.card-benefit-box table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}

.card-benefit-box table td {
	padding: 10px;
	font-size: 15px;
	vertical-align: top;
}

.card-benefit-box p {
	margin: 4px 0;
	line-height: 1.5;
}
.card-type {
  background-color: #89CFF0;      
  color: white;                /* 흰색 글씨 */
  padding: 12px 8px;            /* 안쪽 여백 */
  border-radius: 100px;          /* 둥근 모서리 */
  font-size: 12px;
  margin-left: 8px;            /* 회사명과 간격 */
  display: inline-block;
}
.card-bottom-center {
  width: 100%;
  text-align: center;
  margin-top: 20px;

  display: flex;
  flex-direction: column;
  align-items: center; /* ✅ 핵심: 카드 전체 기준 가운데 정렬 */
}

.card-bottom-center .card-tags {
	justify-content: center;
	display: flex;
	gap: 10px;
	flex-wrap: wrap;
	  align-items: center; /* ✅ 핵심: 카드 전체 기준 가운데 정렬 */
}

.card-bottom-center .company-button {
	display: inline-block;
	margin-top: 10px;
	  align-items: center; /* ✅ 핵심: 카드 전체 기준 가운데 정렬 */
}

.card-header {
  display: flex;
  justify-content: space-between; /* 왼쪽-오른쪽 끝 정렬 */
  align-items: center; /* 수직 가운데 정렬 */
}

</style>
<!-- 반드시 jQuery 포함! -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- <script>
$(function(){
    // 동적으로 렌더링되는 경우에도 동작
    $(document).on('click', '.go-button', function(){
        var cardId = $(this).data("cardid");
        var $count = $(this).find(".rec_count");
        $count.text(Number($count.text()) + 1);
        alert("테스트용: 버튼 클릭됨, 카드번호=" + cardId);
    });
});
</script> -->

<script>
	function toggleDetail(wrapper) {
		const detail = wrapper.querySelector(".toggle-detail");
		if (detail.style.display === "none" || detail.style.display === "") {
			detail.style.display = "block";
		} else {
			detail.style.display = "none";
		}
	}

	function scrollToTarget(targetId) {
		const target = document.getElementById(targetId);
		if (target) {
			target.scrollIntoView({
				behavior : 'smooth',
				block : 'start'
			});
			const detail = target.querySelector(".toggle-detail");
			if (detail
					&& (detail.style.display === "none" || detail.style.display === "")) {
				detail.style.display = "block";
			}
		}
	}

	$(function() {
		$(document)
				.on(
						"click",
						".go-button",
						function() {
							var cardId = $(this).data("cardid");
							var $btn = $(this);
							var $count = $btn.find(".rec_count");
							var $icon = $btn.find(".like-icon");
							var liked = $btn.data("liked");

							if (liked) {
								$
										.ajax({
											url : "${cpath}/card/cardUnlike",
											type : "POST",
											data : {
												card_id : cardId
											},
											success : function(res) {
												if (res === "success") {
													$btn.data("liked", false);
													$icon
															.attr("src",
																	"${cpath}/resources/images/cardlikeImage/unlike.png");
													$count.text(Number($count
															.text()) - 1);
												} else {
													alert("좋아요 취소 실패!");
												}
											},
											error : function() {
												alert("서버 에러");
											}
										});
							} else {
								$
										.ajax({
											url : "${cpath}/card/cardLike",
											type : "POST",
											data : {
												card_id : cardId
											},
											success : function(res) {
												if (res.result === "success") {
													$btn.data("liked", true);
													$icon
															.attr("src",
																	"${cpath}/resources/images/cardlikeImage/like.png");
													$count.text(Number($count
															.text()) + 1);
												} else if (res.result === "login_required"
														|| res.result === "need_login") {
													alert("로그인 후 이용 가능합니다.");
												} else {
													alert("좋아요 실패!");
												}
											},
											error : function() {
												alert("서버 에러");
											}
										});
							}
						});
	});
	// modal 버튼 옆 한글자씩 뜨는 기능
	$(document).ready(function () {
	    $('.btn-open-modal').hover(function () {
	      const tooltip = $(this).find('.tooltip-text');
	      const message = "카드 추천을 받아보세요!";
	      tooltip.text(""); // 초기화

	      let i = 0;
	      const interval = setInterval(() => {
	        if (i < message.length) {
	          tooltip.append(message[i]);
	          i++;
	        } else {
	          clearInterval(interval);
	        }
	      }, 60); // 글자 하나당 60ms
	    }, function () {
	      $(this).find('.tooltip-text').text(""); // 마우스 떠나면 초기화
	    });
	  });
</script>

</head>
<body>
	<div class="card-rep">
		<c:forEach items="${cardList}" var="card">
			<div class="card-container">
			<!-- 왼쪽 카드 이미지 -->
			<div class="card-image">
				<img src="${card.card_image}" alt="카드 이미지" />
				<div class="like-section">
					<button class="go-button" data-cardid="${card.card_id}" data-liked="${card.liked ? 'true' : 'false'}">
						<img class="like-icon"
							src="${cpath}/resources/images/cardlikeImage/${card.liked ? 'like.png' : 'unlike.png'}"
							alt="like" />
					</button>
					<span class="rec_count">${card.card_like}</span>
				</div>
			</div>
		
			<!-- 오른쪽 카드 정보 -->
			<div class="card-info">
				<!-- 카드명 + 버튼 -->
				<div class="card-header">
					<h2 class="card-title">${card.card_name}</h2>
					<button class="btn-open-modal">
						<img src="${cpath}/resources/images/button/aibutton.png" alt="aibutton" />
						<span class="tooltip-text"></span>
					</button>
				</div>
		
				<!-- 혜택 아이콘 -->
				<div class="benefit-icon-list">
					<c:forEach items="${cardDetail}" var="group" varStatus="status">
						<c:set var="firstDetail" value="${group.value[0]}" />
						<div onclick="scrollToTarget('targetDiv${status.index}')">
							<img src="${cpath}${firstDetail.benefitdetail_image}" alt="${group.key}" />
						</div>
					</c:forEach>
				</div>
		</div>
						<!-- 카드 타입/브랜드/연회비 등 -->
				<div class="card-bottom-center">
					<div class="card-tags">
						<span class="card-type">
							<c:choose>
								<c:when test="${card.card_type == '신용카드'}">신용</c:when>
								<c:when test="${card.card_type == '체크카드'}">체크</c:when>
								<c:otherwise>신용</c:otherwise>
							</c:choose>
						</span>
						<c:choose>
							<c:when test="${card.brand eq 'visa'}">
								<img src="${cpath}/resources/images/type/visa.png" alt="Visa" class="brand-logo" />
							</c:when>
							<c:when test="${card.brand eq 'master'}">
								<img src="${cpath}/resources/images/type/master.png" alt="Master" class="brand-logo" />
							</c:when>
							<c:when test="${card.brand eq 'visa/master'}">
								<img src="${cpath}/resources/images/type/visa.png" alt="Visa" class="brand-logo" />
								<img src="${cpath}/resources/images/type/master.png" alt="Master" class="brand-logo" />
							</c:when>
							<c:when test="${card.brand eq 'none'}">
								<span>국내 전용</span>
							</c:when>
							<c:otherwise>
								<span>${card.brand}</span>
							</c:otherwise>
						</c:choose>
					</div>
		
					<div class="card-tags">
						<span>국내연회비: ${card.fee_domestic}원 &ensp;|</span>
						<span>해외연회비: ${card.fee_foreign}원 &ensp;|</span>
						<span>전월실적: ${card.prev_month_cost}만원</span>
					</div>
					<a href="${card.card_url}" class="company-button">카드사 바로가기</a>
				</div>
</div>
		</c:forEach>

	</div>
	<div class="card-benefit-section">
		<c:forEach items="${cardDetail}" var="cardDetail" varStatus="status">
			<c:set var="firstItem" value="${cardDetail.value[0]}" />
			<div class="card-benefit-box" onclick="toggleDetail(this)"
				id="targetDiv${status.index}">
				<div class="toggle-header"
					style="display: flex; align-items: center; gap: 12px;">
					<div style="flex: 0 0 50px;">
						<img src="${cpath}${firstItem.benefitdetail_image}" alt="혜택 이미지"
							style="width: 50px;" />
					</div>
					<div style="flex: 1; font-weight: bold; font-size: 18px;">
						${cardDetail.key}</div>
					<div style="flex: 2; font-size: 14px; color: #555;">
						${firstItem.cardbenefitdetail_text}</div>
				</div>

				<!-- 펼쳐질 상세 영역 -->
				<div class="toggle-detail" style="display: none; padding: 10px;">
					<c:forEach items="${cardDetail.value}" var="detail">
						<p>
							<strong>${detail.title}</strong>
						</p>
						<p>${detail.description}</p>
						<br>
					</c:forEach>
				</div>
			</div>

		</c:forEach>
	</div>

	<div class="modal" id="patternModal" style="display: none;">
		<div class="modal_body">
			<jsp:include page="../recommend/aiPattern.jsp" />
		</div>
	</div>

	<script>
		$(function() {
			$(document).on("click", ".btn-open-modal", function() {
				$("#patternModal").css("display", "flex");
			});
			$(document).on("click", ".modal", function(e) {
				if (e.target === this) {
					$(this).hide();
				}
			});
		});
	</script>

</body>
</html>

