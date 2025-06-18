<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
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


</head>
<body>

	<div>
		<c:forEach items="${cardList}" var="card" varStatus="status">
				<div class="card-container">
					<div class="card-image">
						<img src="${card.card_image}" alt="카드 이미지" onerror="this.src='${cpath}/resources/images/no-image.png';" />
					</div>
					<div class="card-info">
						<p class="benefit-title">${card.card_name}</p>
						<p>${card.company}</p>
						<p>${card.card_type}</p>
						<p>${card.brand}</p>
						<%-- <a href="${cpath}/card/cardlike.do" target="_blank" class="go-button">좋아요: ${card.card_like}</a> --%>
						<div class="card-tags">
							<span>국내연회비: ${card.fee_domestic}원</span>
							<span>해외연회비: ${card.fee_foreign}원</span>
							<span>전월실적: ${card.prev_month_cost}만원</span>
						</div>
							<a href="${card.card_url}" target="_blank" class="go-button">
								카드사 바로가기
							</a>
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
