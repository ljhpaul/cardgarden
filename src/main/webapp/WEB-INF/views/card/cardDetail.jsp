<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp"%>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />


<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<link rel="stylesheet" href="${cpath}/resources/css/cardDetail.css" />
<meta charset="UTF-8">
<title>카드가든 : 카드상세</title>

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

//좋아요 애니메이션
function createRandomBurstEffect(button, imageUrl) {
	const rect = button.getBoundingClientRect();
	  const centerX = rect.left + rect.width / 2 + window.scrollX;
	  const centerY = rect.top + rect.height / 2 + window.scrollY;

	  const heartCount = 10; // 하트 개수
	  const maxDistance = 80; // 최대 이동 거리(px)

	  for (let i = 0; i < heartCount; i++) {
	    // 랜덤 방향과 거리
	    const angle = Math.random() * 2 * Math.PI;
	    const distance = Math.random() * maxDistance;
	    const x = Math.cos(angle) * distance + "px";
	    const y = Math.sin(angle) * distance + "px";

	    const heart = document.createElement("img");
	    heart.src = imageUrl;
	    heart.className = "burst-heart";
	    heart.style.left = centerX + "px";
	    heart.style.top = centerY + "px";
	    heart.style.setProperty("--x", x);
	    heart.style.setProperty("--y", y);

	    document.body.appendChild(heart);

	    setTimeout(() => {
	      heart.remove();
	    }, 600);
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
					if (res.result === "success") {
						$btn.data("liked", false);
						$icon.attr("src", "${cpath}/resources/images/cardlikeImage/unlike.png");
						$count.text(Number($count.text()) - 1);
						if (res.userLike !== undefined) {
					        $("#userLike").text(res.userLike);
					        $(".like-count.like-count-sticky").text(res.userLike);
					        if (res.userLike === 0) {
					            $(".like-count").hide();
					        } else {
					        	$(".like-count-header").css({
					        	    top: "41px",
					        	    right: "12px",
					        	    fontSize: "11px",
					        	    width: "16px",
					        	    height: "15px"
					        	}).show();

					        	$(".like-count-sticky").css({
					        	    top: "-6px",
					        	    right: "-6px",
					        	    fontSize: "11px",
					        	    width: "15px",
					        	    height: "14px"
					        	}).show();
					        }
					    }
						
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
						// 좋아요 애니메이션 추가
						createRandomBurstEffect($btn[0], "${cpath}/resources/images/cardlikeImage/like.png");
						if (res.userLike !== undefined) {
					        $("#userLike").text(res.userLike);
					        $(".like-count.like-count-sticky").text(res.userLike);
					        if (res.userLike === 0) {
					            $(".like-count").hide();
					        } else {
					        	$(".like-count-header").css({
					        	    top: "41px",
					        	    right: "12px",
					        	    fontSize: "11px",
					        	    width: "16px",
					        	    height: "15px"
					        	}).show();

					        	$(".like-count-sticky").css({
					        	    top: "-6px",
					        	    right: "-6px",
					        	    fontSize: "11px",
					        	    width: "15px",
					        	    height: "14px"
					        	}).show();
					        }
					    }
						
					} else if (res.result === "login_required" || res.result === "need_login") {
					    alert("로그인 후 이용 가능합니다.");
					    const cpath = "${cpath}";
					    
					    let path = "/card/detail" + window.location.search;
					    console.log(path);
					    $.ajax({
							url: "${cpath}/card/cardLike/pageSave",
							type: "POST",
							data: { path: path },
							success: function (res) {
									
							}
						});
					    
					    // 로그인 페이지로 이동
					    location.href = cpath + "/user/login";
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
			  <!-- 추천하지 않으면 class가 card-recommend-block.dimmed로 변경 -->
			    <li class="card-recommend-block ${!result.recommend ? 'dimmed' : ''}"> 
			      <div class="gauge-label">
		              카드 적합도
		            </div>
		            <div class="gauge-bar"  style="--rate: ${(result.q_value-0.2) * 100}%;">
		              <div class="gauge-fill" ></div>
		            </div>
			      <div class="category-match">
			        혜택 일치 카테고리:
			        <span class="stars">
			          <c:forEach begin="1" end="${result.matched_category_count}" var="i">★</c:forEach>
			        </span>
			        (${result.matched_category_count}개)
			      </div>
			      <div class="recommend-status">
			        <c:choose>
			          <c:when test="${result.recommend}">
			            <span class="recommend-yes">${userInfo.nickname}님께 추천합니다.</span>
			          </c:when>
			          <c:otherwise>
			            <span class="recommend-no">추천 제외</span>
			          </c:otherwise>
			        </c:choose>
			      </div>
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
						<fmt:formatNumber value="${card.fee_domestic}" type="number" groupingUsed="true" var="fee_domestic"/>
						<span>국내연회비: ${fee_domestic}원 &ensp;|</span>
						<fmt:formatNumber type="number" maxFractionDigits="3" value="${card.fee_foreign}" var="fee_foreign" />
						<span>해외연회비: ${fee_foreign}원 &ensp;|</span>
						<%-- <fmt:formatNumber value="${card.prev_month_cost}" type="number" groupingUsed="true" var="prev_month_cost"/> --%>
						<span>전월실적: ${card.prev_month_cost}만원</span>
					</div>
					<a href="${card.card_url}" class="company-button" target="_blank" rel="noopener noreferrer">카드사 바로가기</a>
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
		<!-- 추천 카드 섹션 (Swiper 버전) -->
<div class="recommend-card-section">
  <h2 class="rec-text">많이 비교된 카드</h2>

  <!-- Swiper 컨테이너 -->
  <div class="swiper recommend-swiper">
    <div class="swiper-wrapper">
      <c:forEach items="${cosineData}" var="entry">
        <c:forEach items="${entry.value}" var="card">
          <div class="swiper-slide recommend-card-box"
               onclick="location.href='${pageContext.request.contextPath}/card/detail?cardid=${card.card_id}'">
            <div class="recommend-card-img">
              <img src="${card.card_image}" alt="${card.card_name}" />
            </div>
            <div class="recommend-card-info">
              <p class="card-name">${card.card_name}</p>
              <p class="card-company">${card.company}</p>
            </div>
          </div>
        </c:forEach>
      </c:forEach>
    </div>
  </div>
<!-- 좌우 버튼 -->
    <div class="swiper-button-prev"></div>
    <div class="swiper-button-next"></div>
</div>


	
	<div class="modal" id="patternModal" style="display: none;">
		<div class="modal_body">
			<jsp:include page="../recommend/aiPattern.jsp" />
		</div>
	</div>
	
	<script>
	  new Swiper(".recommend-swiper", {
		    slidesPerView: 3,
		    spaceBetween: 30,
		    loop: true,
		    loopFillGroupWithBlank: true,
		    grabCursor: true, // 마우스 커서 손모양
		    allowTouchMove: true, // 터치 슬라이딩 허용
		    navigation: {
		      nextEl: ".swiper-button-next",
		      prevEl: ".swiper-button-prev"
		    },
		    autoplay: {
		      delay: 5000,
		      disableOnInteraction: false
		    }
		  });
	</script>	
	
	<script>

		
		$(function() {
			$(document).on("click", ".btn-open-modal", function () {
				$.ajax({
					url: "${cpath}/recommend/noaipattern",
					type: "POST",
					success: function (res) {
						console.log(res);
						if (res.result == "go_need_login") {
							alert("로그인 후 이용 가능합니다.");
							const cpath = "${cpath}";
							let path = "/card/detail" + window.location.search;
							$.ajax({
								url: cpath + "/recommend/goodaipattern",
								type: "POST",
								data: { path: path },
								success: function (res) {
								}
							});
							location.href = cpath + "/user/login";
						}else if (res.result == "login_good"){
							$("#patternModal").css("display", "flex");
						}
					}
				});
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

