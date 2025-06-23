<%@ include file="../common/header.jsp" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
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
	margin: auto;
	max-width: 1200px; /* ✅ 중앙 정렬 + 폭 제한 */
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
}

.card-info p {
	margin: 6px 0;
}

.benefit-title {
	font-size: 36px;
	font-weight: bold;
	padding-bottom: 50px;
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
	display: inline-block;
	margin-top: 14px;
	background-color: #FFF5E1;
	color: black;
	padding: 10px 18px;
	border-radius: 8px;
	text-decoration: none;
	font-weight: bold;
	transition: background-color 0.2s;
}

.go-button:hover {
	background-color: #FFE0A3;
}



.benefit-icon-list .img{
	width: 60px;
	height: 60px;
	padding: 10px;

}
.card-benefit-section {
	margin-top: 40px;
}

.card-benefit-box {
	max-width: 1200px; /* ✅ 중앙 정렬 + 폭 제한 */
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
.toggle-header > div:first-child {
    flex: 0 0 50px;
}
.toggle-header > div:nth-child(2) {
    flex: 1;
    font-weight: bold;
    font-size: 18px;
}
.toggle-header > div:nth-child(3) {
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
.modal{
    position: absolute;
    display: flex;
    justify-content: center;
    align-items: center;
    top:0;
    left:0;
    width:100%;
    height:100%;
    z-index: 9999; /* 추가! */
}
.modal_body {
    background: #fff;
    padding: 30px 40px;
    border-radius: 14px;
    box-shadow: 0 2px 16px rgba(0,0,0,0.15);
    min-width: 300px;
    min-height: 120px;
    /* 아래 2줄 추가!! */
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
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
	        target.scrollIntoView({ behavior: 'smooth', block: 'start' });
	        const detail = target.querySelector(".toggle-detail");
	        if (detail && (detail.style.display === "none" || detail.style.display === "")) {
	            detail.style.display = "block";
	        }
	    }
	}

	
	$(function() {
		  $(document).on("click", ".go-button", function() {
		    var cardId = $(this).data("cardid");
		    var $btn = $(this);
		    var $count = $btn.find(".rec_count");
		    var $icon = $btn.find(".like-icon");
		    var liked = $btn.data("liked");

		    if(liked) {
		      $.ajax({
		        url: "${cpath}/card/cardUnlike",
		        type: "POST",
		        data: { card_id: cardId },
		        success: function(res) {
		          if(res === "success") {
		            $btn.data("liked", false);
		            $icon.attr("src", "${cpath}/resources/images/cardlikeImage/unlike.png");
		            $count.text(Number($count.text()) - 1);
		          } else {
		            alert("좋아요 취소 실패!");
		          }
		        },
		        error: function() { alert("서버 에러"); }
		      });
		    } else {
		      $.ajax({
		        url: "${cpath}/card/cardLike",
		        type: "POST",
		        data: { card_id: cardId },
		        success: function(res) {
		          if(res.result === "success") {
		            $btn.data("liked", true);
		            $icon.attr("src", "${cpath}/resources/images/cardlikeImage/like.png");
		            $count.text(Number($count.text()) + 1);
		          } else if(res.result === "login_required" || res.result === "need_login") {
		            alert("로그인 후 이용 가능합니다.");
		          } else {
		            alert("좋아요 실패!");
		          }
		        },
		        error: function() { alert("서버 에러"); }
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
				<div class="card-image">
					<img src="${card.card_image}" alt="카드 이미지" />
    
				    <button class="go-button" data-cardid="${card.card_id}" data-liked="${card.liked ? 'true' : 'false'}">
					  <img class="like-icon" 
					       src="${cpath}/resources/images/cardlikeImage/${card.liked ? 'like.png' : 'unlike.png'}" 
					       alt="like" 
					       style="width:28px;vertical-align:middle;" />
					  <span class="rec_count">${card.card_like}</span>
					</button>



					<%-- <div>

						<div>
							<div class="w3-border w3-center w3-padding">
								<c:choose>
				                    <c:when test="${userid == null}">
				                        <i class="fa fa-heart" style="font-size:16px;color:red"></i>
				                        <span class="rec_count">${card.card_like}</span>
				                        <button class="go-button" disabled>좋아요: ${card.card_like}</button>
				                        <div>로그인 후 이용 가능</div>
				                    </c:when>
				                    <c:otherwise>
				                        <i class="fa fa-heart" style="font-size:16px;color:red"></i>
				                        <span class="rec_count">${card.card_like}</span>
				                        <button class="go-button" id="rec_update_${card.card_id}" data-cardid="${card.card_id}">좋아요</button>
				                    </c:otherwise>
				                </c:choose>

							</div>
						</div> 
					</div> --%>
				</div>
				<div class="card-info">
					<p class="benefit-title">${card.card_name}</p>
					<!-- 카드 혜택 아이콘 (각 그룹의 첫 번째 아이콘) -->
					<div class="benefit-icon-list">
						<c:forEach items="${cardDetail}" var="group" varStatus="status">
							<c:set var="firstDetail" value="${group.value[0]}" />
							<div onclick="scrollToTarget('targetDiv${status.index}')">
								<img src="${cpath}${firstDetail.benefitdetail_image}"
									alt="${group.key}" />
							</div>
						</c:forEach>
					</div>
					<div class="card-tags">
						<span>${card.company}</span> <span>${card.card_type}</span> <span>${card.brand}</span>
					</div>
					<div class="card-tags">
						<span>국내연회비: ${card.fee_domestic}원</span> <span>해외연회비:
							${card.fee_foreign}원</span> <span>전월실적: ${card.prev_month_cost}만원</span>
					</div>
					<a href="${card.card_url}" class="go-button">카드사 바로가기</a>
					
					<button class="btn-open-modal">Modal열기</button>

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

