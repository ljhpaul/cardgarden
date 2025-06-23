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
    top:0; left:0; width:100vw; height:100vh; z-index:9999;
    background:rgba(0,0,0,0.4);
}
.pattern-modal-content {
    background: #fff;
    border-radius: 16px;
    padding: 40px 32px 28px 32px;
    min-width: 340px;
    min-height: 120px;
    box-shadow: 0 4px 18px rgba(0,0,0,0.14);
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
</style>

<form method="get" action="${cpath}/recommend/aiDetailResult">
  <c:forEach var="entry" items="${patternList}">
    <div class="pattern-group">
      <div class="pattern-title">
        <input type="checkbox" class="pattern-checkbox" name="patternId" value="${entry.key}" id="pattern_${entry.key}"
               onclick="checkOnlyOne(this)">
        <label for="pattern_${entry.key}">패턴 ID: ${entry.key}</label>
      </div>
      <c:forEach var="dto" items="${entry.value}">
        <div class="benefit-row">
          ${dto.category.benefitCategory_name} : <b>${dto.detail.amount}</b> 원
        </div>
      </c:forEach>
    </div>
  </c:forEach>
  <input type="submit" value="제출하기">
</form>
