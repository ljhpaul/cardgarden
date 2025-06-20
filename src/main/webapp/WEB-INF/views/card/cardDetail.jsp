<%@ include file="../common/header.jsp" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Card List</title>

<style>
	.card-container {
		display: flex;
		flex-wrap: wrap;
		align-items: center;
		padding: 24px;
		margin-bottom: 30px;
		border: 1px solid #ddd;
		border-radius: 10px;
		background-color: #fff;
		box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
	}
	
	.card-image img {
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
		font-size: 16px;
		margin: 6px 0;
	}
	
	.benefit-title {
		font-size: 20px;
		font-weight: bold;
		margin-bottom: 10px;
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
	
	.card-benefit-section {
		margin-top: 40px;
	}
	
	.card-benefit-box {
		margin-bottom: 40px;
		padding: 20px;
		border: 1px solid #ddd;
		border-radius: 10px;
		background-color: #f9f9f9;
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(function(){
    // 좋아요 클릭
    $(document).on("click", ".go-button", function(){
        var cardId = $(this).data("cardid");
        var $btn = $(this);
        var $count = $btn.find(".rec_count");
        
        alert("테스트용: 버튼 클릭됨, 카드번호=" + cardId);

        // AJAX
        $.ajax({
        	url: "${cpath}/card/cardLike",
            type: "POST",
            data: { card_id: cardId },
            /* dataType: "json", */
            success: function(res){
                if(res.result === "success"){
                    // 서버에서 정상 처리됐을 때만 개수 증가!
                    $count.text(Number($count.text()) + 1);
                } else if(res.result === "login_required"){
                    alert("로그인 후 이용 가능합니다.");
                } else {
                    alert("실패");
                }
            },
            error: function(xhr, status, error){
                alert("서버 에러: " + error);
            }
        });
    });
});
</script>

</head>
<body>						
	<div>
		<!-- 카드 대표 정보 출력 -->
		<c:forEach items="${cardList}" var="card">
		    <div class="card-container">
		        <div class="card-image">
		            <img src="${card.card_image}" alt="카드 이미지" />
		            <button class="go-button" data-cardid="${card.card_id}">
		                <i class="fa fa-heart" style="font-size:16px;color:red"></i>
		                <span class="rec_count">${card.card_like}</span>
		            </button>
		            <div>
		            
		            	<div>
				            <div class="w3-border w3-center w3-padding">
				                <%-- <c:choose>
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
				                </c:choose> --%>
				                
				            </div>
				        </div>
		            </div>
		        </div>
		        <div class="card-info">
		            <p class="benefit-title">${card.card_name}</p>
		            <!-- 카드 혜택 아이콘 (각 그룹의 첫 번째 아이콘) -->
		            <div class="benefit-icon-list">
		                <c:forEach items="${cardDetail}" var="group">
		                    <c:set var="firstDetail" value="${group.value[0]}" />
		                    <img src="${cpath}${firstDetail.benefitdetail_image}" alt="${group.key}" style="width:36px;" />
		                </c:forEach>
		            </div>
						<div class="card-tags">
							<span>${card.company}</span>
							<span>${card.card_type}</span>
							<span>${card.brand}</span>
						</div>
						<div class="card-tags">
							<span>국내연회비: ${card.fee_domestic}원</span>
							<span>해외연회비: ${card.fee_foreign}원</span>
							<span>전월실적: ${card.prev_month_cost}만원</span>
						</div>
		            <a href="${card.card_url}" class="go-button">카드사 바로가기</a>
		        </div>
		    </div>
		</c:forEach>

	</div>
	<div class="card-benefit-section">
		<c:forEach items="${cardDetail}" var="cardDetail" varStatus="status">
			
			<div class="card-benefit-box">
				<table>
					<c:set var="firstItem" value="${cardDetail.value[0]}" />
					<tr>
						<th><img src="${cpath}${firstItem.benefitdetail_image}" alt="혜택 이미지" style="width: 50px;"/></th>
						<th>${cardDetail.key}</th>
						<th>${firstItem.cardbenefitdetail_text}</th>
					</tr>
				</table>
				 
				<br>
					<c:forEach items="${cardDetail.value}" var="detail">
						
						<p><strong>${detail.title}</strong></p>	
						<p>${detail.description}</p>	
						<br>
					</c:forEach>
			</div>
		</c:forEach>
	</div>
</body>
</html>
