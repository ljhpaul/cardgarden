<%@ include file="../common/mypageheader.jsp" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    HttpSession mySession = request.getSession();
    Object userId = mySession.getAttribute("loginUserId");
    System.out.println("로그인한 사용자 ID: " + userId);
    if (userId == null) {
%>
    <script>
        alert("로그인이 필요한 기능입니다.");
        location.href = "<%= request.getContextPath() %>/user/login";
    </script>
<%
        return;
    }
%>

<c:set var="cpath" value="${pageContext.request.contextPath}" />
<c:if test="${not empty msg}">
    <script>alert('${msg}');</script>
</c:if>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 소비패턴</title>
<style>
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

@font-face {
  font-family: 'NanumSquareRound';
  src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/NanumSquareRound.woff') format('woff');
  font-weight: normal;
  font-style: normal;
}

body {
  font-family: 'NanumSquareRound', sans-serif;
  background-color: #F0F3F1;
  color: #333;
  
}

h1 {
  text-align: center;
  font-size: 30px;
  margin-bottom: 40px;
  color: #646F58;
}

#myfrm {
  max-width: 700px;
  margin: auto;
  background: #ffffff;
  padding: 40px;
  border-radius: 20px;
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
}

.wrap {
  width: 100%;
  height: 1024px;
  min-height: 100vh;
  display: flex;
  justify-content: center;
  padding: 40px;
  background-color: #F0F3F1;
}

.wrap2 {
  width: 100%;
  height:180px; 
  display: flex;
  justify-content: center;
  background-color: #F0F3F1;
  margin-top: 80px;
}

.form-container {
  width:730px;
  background-color: #ffffff;
  padding: 40px;
  border-radius: 20px;
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
}

.form-group {
  margin-bottom: 30px;
}

label {
  display: block;
  margin-bottom: 10px;
  font-weight: bold;
  font-size: 16px;
  color: #3e4e42;
}

input[type="text"],
input[type="number"],
select {
  width: 100%;
  padding: 14px 16px;
  font-size: 15px;
  border: 1px solid #ccc;
  border-radius: 12px;
  background-color: #FAFAFA;
  transition: border-color 0.3s ease;
}

input:focus,
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

.button-group {
  text-align: center;
  margin-top: 40px;
}

input[type="submit"],
input[type="reset"],
.deleteBtn,
#inCon {
  background-color: #8FB098;
  color: white;
  font-size: 16px;
  border: none;
  padding: 14px 28px;
  margin: 5px;
  border-radius: 12px;
  cursor: pointer;
  transition: background-color 0.3s;
}

input[type="submit"]:hover,
input[type="reset"]:hover,
#btnpuls:hover {
  background-color: #6B8B71;
}
.patternSelectarea{
	  width: 800px;

}

</style>
</head>
<body>
<div class="wrap2">
<!-- 패턴 선택 드롭다운 -->
    <div class="form-container">
      <label for="patternSelect">소비패턴 선택</label>
      <select id="patternSelect">
        <option value="">-- 소비패턴 선택 --</option>
        <c:forEach var="pattern" items="${myConsumptionPatternList}">
          <option value="${pattern.pattern_id}">${pattern.pattern_name}</option>
        </c:forEach>
      </select>
          <button id="inCon" style="float: right;">소비패턴 입력</button>
    </div>

     
</div>
<div class="wrap">
<!-- 패턴 상세보기 -->
<c:forEach var="pattern" items="${myConsumptionPatternList}">
  <div class="wrap pattern-form" id="pattern_${pattern.pattern_id}" style="display:none;">
    <div class="form-container">
      <form id="patternForm_${pattern.pattern_id}"  action="${cpath}/ConsumptionPattern/updateCon" method="post">
        <input type="hidden" name="pattern_id" value="${pattern.pattern_id}">

        <div class="form-group">
          <label style="font-weight:1000; font-size: 25px;">소비패턴 이름</label>
          <input type="text" name="pattern_name" value="${pattern.pattern_name}">
		  <span style="display:inline-block; margin-top:10px;">
		  	 생성일자 : <fmt:formatDate value="${pattern.created_at}" pattern="yyyy-MM-dd" />
		  </span>
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
            <input type="number" name="amount" value="${detail.amount}" min="0">
          </div>
        </c:forEach>

        <div class="button-group">
          <input type="submit" value="수정">
          <button type="button" class="deleteBtn" data-pattern-id="${pattern.pattern_id}">삭제</button>
        </div>
      </form>
    </div>
  </div>
</c:forEach>
</div>

<script>
const cpath = "${cpath}";

document.getElementById("patternSelect").addEventListener("change", function() {
  const selectedId = this.value;
  document.querySelectorAll(".pattern-form").forEach(form => {
    form.style.display = "none";
  });
  if (selectedId) {
    const target = document.getElementById("pattern_" + selectedId);
    if (target) target.style.display = "flex";
  }
});




document.getElementById("inCon").addEventListener("click", function() {
	
	  location.href = cpath + "/ConsumptionPattern/inCon"; 

});


//삭제 버튼 전체에 이벤트 바인딩
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
    	      }).then(response => response.text()) // 결과값에 담긴 text 꺼내기
    	      .then(result => {
    	    	  if (result.trim() === "ok") {
    	    		    alert("삭제가 완료되었습니다.");
    	    		    location.href = cpath + "/user/consumptionPattern"; 
    	    		  } else {
    	    		    alert("삭제에 실패했습니다.");
    	    		  }
    	    })
    }
  });
});

</script>

</body>
</html>
