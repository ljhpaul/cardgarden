<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<!--  -->
<script>
 
	function openPatternModal() {
		document.getElementById('patternModal').style.display = 'flex';
	}

	function closePatternModal() {
		document.getElementById('patternModal').style.display = 'none';
	}

	function checkOnlyOne(checkbox) {
		var checkboxes = document.getElementsByName('patternId');
		checkboxes.forEach(function(cb) {
			if (cb !== checkbox)
				cb.checked = false;
		});
	}

	function showMaskAndSubmit(form) {

		form.submit();
	}
</script>
<style>
.pattern-modal-mask {
	display: flex;
	align-items: center;
	justify-content: center;
	position: fixed;
	top: 0;
	left: 0;
	width: 100vw;
	height: 100vh;
	z-index: 9999;
	background: rgba(0, 0, 0, 0.4);
}

.pattern-modal-content {
	background: #fff;
	border-radius: 16px;
	padding: 40px 32px 28px 32px;
	min-width: 340px;
	min-height: 120px;
	box-shadow: 0 4px 18px rgba(0, 0, 0, 0.14);
}

.pattern-group {
	margin-bottom: 20px;
	background: #f7f7fa;
	padding: 14px 20px 10px 20px;
	border-radius: 8px;
}

.pattern-title {
	font-weight: bold;
	margin-bottom: 8px;
}

.benefit-row {
	margin-left: 14px;
	margin-bottom: 4px;
}

.pattern-table {
	width: 100%;
	border-collapse: collapse;
	font-family: 'NanumSquareRound', sans-serif;
	margin-top: 24px;
	font-size: 15px;
}

.pattern-table th, .pattern-table td {
	border: 1px solid #ddd;
	padding: 10px;
	text-align: center;
}

.pattern-table thead {
	background-color: #f3f3f3;
}

.pattern-group {
	background-color: #fafafa;
	border-top: 4px solid #ddd; /* 패턴별 시각적 구분 */
}

.pattern-group tr:first-child {
	border-top: 2px solid #ccc;
}

.checkbox-cell {
	vertical-align: middle;
}

.pattern-id-cell {
	font-weight: bold;
	background-color: #f9f9ff;
}

.category-cell {
	text-align: left;
	padding-left: 14px;
}

.amount-cell {
	text-align: right;
	padding-right: 14px;
}

.pattern-submit-container {
	text-align: center;
	margin-top: 20px;
}

.pattern-submit-button {
	padding: 12px 24px;
	font-size: 16px;
	font-weight: bold;
	border: none;
	background-color: #007BFF;
	color: white;
	border-radius: 6px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.pattern-submit-button:hover {
	background-color: #0056b3;
}

/* ✅ 반응형 대응 */
@media screen and (max-width: 768px) {
	.pattern-table, .pattern-table thead, .pattern-table tbody,
		.pattern-table th, .pattern-table td, .pattern-table tr {
		display: block;
	}
	.pattern-table thead {
		display: none;
	}
	.pattern-table tr {
		margin-bottom: 16px;
		border-bottom: 1px solid #ccc;
		background: #fff;
		padding: 10px;
		border-radius: 8px;
	}
	.pattern-table td {
		text-align: left;
		padding: 8px 12px;
		position: relative;
	}
	.pattern-table td::before {
		content: attr(data-label);
		font-weight: bold;
		position: absolute;
		left: 12px;
		top: 8px;
		color: #555;
		display: block;
	}
	.pattern-submit-button {
		width: 100%;
		font-size: 18px;
	}
}

.pattern-close-button {
	position: relative;
	top: 12px;
	right: 16px;
	background: none;
	border: none;
	font-size: 26px;
	color: #333;
	cursor: pointer;
	transition: color 0.3s;
	margin-bottom: 10px;
}

.pattern-close-button:hover {
	color: #d33;
}

.no-pattern-message p {
	padding-bottom: 25px;
}

.no-pattern-message a {
	display: inline-block; /* 또는 block */
	margin: 0 auto;
	padding-left: 50px;
	padding-right: 50px;
	text-align: center;
}

.modal-block {
	display: block;
}

.model-center {
	height: 75vh;
	overflow-y: auto;
}

.no-pattern-submit-button {
	padding: 6px 10px;
	font-size: 16px;
	font-weight: bold;
	border: none;
	background-color: #E63946;
	color: white;
	border-radius: 6px;
	cursor: pointer;
	transition: background-color 0.3s;
	border-radius: 50%;
	float: right;
	margin-bottom: 8px;
	margin-right: 4px;
}

.no-pattern-submit-button:hover {
	background-color: #D7263D;
}
/* .model-class{
	display:none;
} */
</style>

<div class="modal-block">
	<button type="button" class="pattern-close-button" onclick="closePatternModal()">×</button>	
	<div class="model-center">
	
	<c:choose>
	  <c:when test="${not empty patternList}">
	  	
	    <form method="get" action="${cpath}/card/detail">
	      <input type="hidden" name="cardid" value="${cardid}" />
		  <!-- <div class="model-class">
			<input type="submit" value="X" class="no-pattern-submit-button">
		</div>	 -->
	      <table class="pattern-table">
	        <thead>
	          <tr>
	            <th>선택</th>
	            <th>패턴 ID</th>
	            <th>카테고리</th>
	            <th>금액</th>
	          </tr>
	        </thead>
			
	        <c:forEach var="entry" items="${patternList}">
	          <tbody class="pattern-group">
	            <c:set var="patternId" value="${entry.key}" />
	            <c:forEach var="dto" items="${entry.value}" varStatus="status">
	              <tr>
	                <c:if test="${status.index == 0}">
	                  <td rowspan="${fn:length(entry.value)}" class="checkbox-cell">
	                    <input type="checkbox" name="patternId" value="${patternId}" onclick="checkOnlyOne(this)">
	                  </td>
	                  <td rowspan="${fn:length(entry.value)}" class="pattern-id-cell">${patternId}</td>
	                </c:if>
	                <td class="category-cell">${dto.category.benefitCategory_name}</td>
	                <td class="amount-cell">
	                  <fmt:formatNumber value="${dto.detail.amount}" type="number" /> 원
	                </td>
	              </tr>
	            </c:forEach>
	          </tbody>
	        </c:forEach>
	      </table>
	
	      <div class="pattern-submit-container">
	        <input type="submit" value="제출하기" class="pattern-submit-button">
	      </div>
	      
	    </form>
	  </c:when>
	
	  <c:otherwise>
	    <div class="no-pattern-message">
	      <p>아직 등록된 소비 패턴이 없습니다.</p>
	      <a href="${cpath}/ConsumptionPattern/inCon" class="pattern-submit-button">패턴 입력하러 가기</a>
	    </div>
	  </c:otherwise>
	</c:choose>
	</div>
</div>
