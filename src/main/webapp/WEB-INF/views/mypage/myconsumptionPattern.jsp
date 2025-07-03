<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<c:if test="${not empty msg}">
  <script>alert('${msg}');</script>
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>카드가든 : 소비패턴관리</title>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
  <link rel="stylesheet" href="${cpath}/resources/css/common.css">
  <link rel="stylesheet" href="${cpath}/resources/css/header.css">
  <link rel="stylesheet" href="${cpath}/resources/css/font-awesome.min.css">
  <link rel="stylesheet" href="${cpath}/resources/css/userStyle.css">
  <script src="${cpath}/resources/js/header.js"></script>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style>
.wrap {
  width: 100%;
  min-height: 100vh;
  display: flex;
  justify-content: center;
  flex-direction: row;
  gap: 20px;
  margin-bottom: 50px;
}

.title-lg {
  font-size: 2.6rem;
  font-size: 32px;
  font-weight: bold;
  margin-bottom: 30px;
}

.form-container {
  width: 730px;
  background-color: #ffffff;
  padding: 40px;
  border-radius: 20px;
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
  display: flex;
  flex-direction: column;
  align-items: center;
}

.form-group {
  margin-bottom: 30px;
}

.select-box, .result-box {
  width: 760px;
  padding: 30px;
  box-sizing: border-box;
}

.select-box {
  max-height: 190px;
  margin-bottom: 30px;
}

label {
  display: block;
  margin-bottom: 10px;
  font-weight: bold;
  font-size: 16px;
  color: #3e4e42;
}

select {
  border: 1px solid #ccc;
  border-radius: 12px;
  background-color: #FAFAFA;
  transition: border-color 0.3s ease;
}

.pattern-input, select {
  width: 100%;
  padding: 14px;
  font-size: 15px;
}

select:focus {
  border-color: #8FB098;
  outline: none;
}

span.remove {
  display: inline-block;
  margin-top: 10px;
  background-color: #ff6b6b;
  color: #fff;
  padding: 6px 14px;
  border-radius: 8px;
  font-size: 13px;
  cursor: pointer;
  transition: background-color 0.3s;
}

span.remove:hover {
  background-color: #e84545;
}

.btn {
  width: 110px;
  height: 44px;
  margin-left: 12px;
  cursor: pointer;
}

.button-group {
  display: flex;
  justify-content: center;
  gap: 5px;
  margin-top: 35px;
}


</style>
</head>
<body class="bg-main">
<div class="wrap">
  <!-- 사이드바 네비게이터 -->
  <jsp:include page="/WEB-INF/views/mypage/sidebar.jsp" />
  
  <!-- 패턴 선택 드롭다운 -->
  <div class="form-container">
  	<h2 class="title-lg">내 소비패턴</h2>
  
    <div class="inner-box select-box">
    <label for="patternSelect">소비패턴 선택</label>
    <select id="patternSelect">
      <option value="">-- 소비패턴 선택 --</option>
      <c:forEach var="pattern" items="${myConsumptionPatternList}">
        <option value="${pattern.pattern_id}">${pattern.pattern_name}</option>
      </c:forEach>
    </select>
    <button id="inCon" class="btn" style="width: 20%; float: right; margin-top:15px;">소비패턴 입력</button>
    </div>
    
    <!-- 패턴 상세보기 -->
  <c:forEach var="pattern" items="${myConsumptionPatternList}">
  <div class="pattern-form" id="pattern_${pattern.pattern_id}" style="display:none;">
    <div class="inner-box result-box">
      <form id="patternForm_${pattern.pattern_id}"  action="${cpath}/ConsumptionPattern/updateCon" method="post">
        <input class="input pattern-input" type="hidden" name="pattern_id" value="${pattern.pattern_id}">

        <div class="form-group">
          <label style="font-weight:1000; font-size: 25px;">소비패턴 이름</label>
          <input class="input pattern-input" type="text" name="pattern_name" value="${pattern.pattern_name}" readonly>
		  <div>
		    <span style="display:inline-block; margin-top:10px;">
		  	 생성일자 : <fmt:formatDate value="${pattern.created_at}" pattern="yyyy-MM-dd" />
		    </span>
		  </div>
        </div>

        <c:forEach var="detail" items="${pattern.details}">
          <div class="form-group">
            <label>소비영역</label>
            <select name="benefitcategory_id">
              <c:forEach items="${benefitCategorylist}" var="benefit">
                <option value="${benefit.benefitcategory_id}"
                  <c:if test="${benefit.benefitcategory_id == detail.benefitcategory_id}">selected</c:if>>
                  ${benefit.benefitCategory_name}
                </option>
              </c:forEach>
            </select>
            <br><br>
            <label>소비금액</label>
            <input class="input pattern-input" type="number" name="amount" value="${detail.amount}" min="0">
          </div>
        </c:forEach>

        <div class="button-group">
          <input class="btn" type="submit" value="수정">
          <button type="button" class="btn deleteBtn" data-pattern-id="${pattern.pattern_id}">삭제</button>
        </div>
      </form>
    </div>
  </div>
  </c:forEach>
  </div>
</div>

<script>
// 소비영역 중복금지, 3개 미만 금지
// 소비금액 100만원까지만
document.addEventListener("DOMContentLoaded", function () {
  document.querySelectorAll('input[type="submit"]').forEach(btn => {
    btn.addEventListener("click", function (event) {
      event.preventDefault();

      const form = this.closest("form");
      const categorySelects = form.querySelectorAll('select[name="benefitcategory_id"]');
      const amountInputs = form.querySelectorAll('input[name="amount"]');

      // 소비영역 최소 3개
      if (categorySelects.length < 3) {
        alert("소비영역을 최소 3개 이상 입력해 주세요.");
        return;
      }

      // 소비영역 중복 확인
      const selectedValues = Array.from(categorySelects).map(select => select.value);
      const hasDuplicate = new Set(selectedValues).size !== selectedValues.length;
      if (hasDuplicate) {
        alert("중복된 소비영역이 존재합니다. 다시 확인해 주세요");
        return;
      }

      // 소비금액 유효성 검사
      const hasInvalidAmount = Array.from(amountInputs).some(input => {
        const value = parseInt(input.value);
        return !input.value || isNaN(value) || value > 1000000 || value <= 0;
      });
      if (hasInvalidAmount) {
        alert("소비금액은 1원 이상 100만원 이하로 입력해 주세요.");
        return;
      }

      form.submit();
    });
  });
});

const cpath = "${cpath}";

// 패턴 선택해서 보기
document.getElementById("patternSelect").addEventListener("change", function () {
  const selectedId = this.value;
  document.querySelectorAll(".pattern-form").forEach(form => {
    form.style.display = "none";
  });
  if (selectedId) {
    const target = document.getElementById("pattern_" + selectedId);
    if (target) target.style.display = "flex";
  }
});

document.getElementById("inCon").addEventListener("click", function () {
  location.href = cpath + "/ConsumptionPattern/inCon";
});
 
// 삭제 버튼 전체에 이벤트 바인딩
document.querySelectorAll(".deleteBtn").forEach(btn => {
  btn.addEventListener("click", function () {
    const patternId = this.dataset.patternId;
    if (confirm("정말 삭제하시겠습니까?")) {
      fetch(`${cpath}/ConsumptionPattern/deleteCon`, {
        method: "POST",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "pattern_id=" + encodeURIComponent(patternId)
      }).then(response => response.text())
        .then(result => {
          if (result.trim() === "ok") {
            alert("삭제가 완료되었습니다.");
            location.href = cpath + "/user/consumptionPattern";
          } else {
            alert("삭제에 실패했습니다.");
          }
        });
    }
  });
});


</script>

</body>
</html>
