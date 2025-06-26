<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />


<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${cpath}/resources/css/cardDetail.css" />
<meta charset="UTF-8">
<title>카드가든 상세페이지</title>

<!-- 반드시 jQuery 포함! -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<script>
function toggleDetail(wrapper) {
	  const detail = wrapper.querySelector(".toggle-detail");
	  const caret = wrapper.querySelector(".toggle-caret");

	  const isOpen = wrapper.classList.contains("open");

	  if (isOpen) {
	    wrapper.classList.remove("open");
	    caret.src = "${cpath}/resources/images/common/caretDown.png";
	  } else {
	    wrapper.classList.add("open");
	    caret.src = "${cpath}/resources/images/common/caretUp.png";
	  }
	}

function scrollToTarget(targetId) {
	const target = document.getElementById(targetId);
	if (target) {
		target.scrollIntoView({
			behavior: 'smooth',
			block: 'start'
		});

		// .open 클래스가 없으면 추가
		if (!target.classList.contains("open")) {
			target.classList.add("open");

			// caret 이미지도 변경
			const caret = target.querySelector(".toggle-caret");
			if (caret) {
				caret.src = "${cpath}/resources/images/common/caretUp.png";
			}
		}
	}
}

$(function() {
	$(document).on("click", ".go-button", function () {
		var cardId = $(this).data("cardid");
		var $btn = $(this);
		var $count = $btn.siblings(".rec_count");
		var $icon = $btn.find(".like-icon");
		var liked = $btn.data("liked");

		console.log("Clicked cardId:", cardId);
		console.log("Liked status before click:", liked);

		if (liked) {
			// 좋아요 취소
			$.ajax({
				url: "${cpath}/card/cardUnlike",
				type: "POST",
				data: { card_id: cardId },
				success: function (res) {
					console.log("서버 응답 (unlike):", res);
					if (res === "success") {
						$btn.data("liked", false);
						$icon.attr("src", "${cpath}/resources/images/cardlikeImage/unlike.png");
						$count.text(Number($count.text()) - 1);
					} else {
						alert("좋아요 취소 실패!");
					}
				},
				error: function (xhr, status, error) {
					console.error("서버 에러:", error);
					console.error("응답 내용:", xhr.responseText);
					alert("서버 에러");
				}
			});
		} else {
			// 좋아요
			$.ajax({
				url: "${cpath}/card/cardLike",
				type: "POST",
				data: { card_id: cardId },
				success: function (res) {
					console.log("서버 응답 (like):", res);
					if (res.result === "success") {
						$btn.data("liked", true);
						$icon.attr("src", "${cpath}/resources/images/cardlikeImage/like.png");
						$count.text(Number($count.text()) + 1);
					} else if (res.result === "login_required" || res.result === "need_login") {
						alert("로그인 후 이용 가능합니다.");
					} else {
						alert("좋아요 실패!");
					}
				},
				error: function (xhr, status, error) {
					console.error("서버 에러:", error);
					console.error("응답 내용:", xhr.responseText);
					alert("서버 에러");
				}
			});
		}
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
			<div class="card-image-wrapper">
				<img src="${card.card_image}" alt="카드 이미지" />
			</div>
			<!-- 좋아요 버튼 -->
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
			<!-- 오른쪽 카드 정보 -->
		<div class="card-info">
			<!-- 카드명 + 버튼 -->
			<div class="card-header">
				<div class="card-title"> <p> ${card.card_name}</p></div>
				<button class="btn-open-modal">
					<img src="${cpath}/resources/images/button/aibutton.png" alt="aibutton" />
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
		
		<!-- ✅ AI 추천 결과: card-info 아래, card-bottom-center 위로 이동 -->
		<div class="ai-recommendation">
			<c:choose>
				<c:when test="${not empty aiDetailResult}">
					<ul>
						<c:forEach items="${aiDetailResult}" var="result">
							<li>
								예상 매칭률: <b><fmt:formatNumber value="${result.resultValue * 100}" pattern="#.0" />%</b><br>
								${result.message}
							</li>
						</c:forEach>
					</ul>
				</c:when>
				<c:otherwise>
					추천 결과가 없습니다. AI 버튼을 눌러보세요!
				</c:otherwise>
			</c:choose>
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
			<div class="card-benefit-box" onclick="toggleDetail(this)" id="targetDiv${status.index}">
			  <div class="toggle-header" style="display: flex; align-items: center; gap: 12px;">
			    <div style="flex: 0 0 50px;">
			      <img src="${cpath}${firstItem.benefitdetail_image}" alt="혜택 이미지" style="width: 50px;" />
			    </div>
			    <div style="flex: 1; font-weight: bold; font-size: 18px;">
			      ${cardDetail.key}
			    </div>
			    <div style="flex: 2; font-size: 14px; color: #555;">
			      ${firstItem.cardbenefitdetail_text}
			    </div>
			    <div class="caret-icon" style="margin-left: auto;">
			      <img src="${cpath}/resources/images/common/caretDown.png" alt="펼치기" class="toggle-caret" style="width: 24px;" />
			    </div>
			  </div>

				<!-- 펼쳐질 상세 영역 -->
				<div class="toggle-detail">
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
	
	<c:forEach items="${cosineData}" var="card">
	    <p>${card.key}</p>
	    <p>${card.value}</p>
	</c:forEach>


	
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

