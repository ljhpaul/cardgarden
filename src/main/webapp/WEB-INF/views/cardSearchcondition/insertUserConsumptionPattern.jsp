<%@ include file="../common/header.jsp"%>
<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false" session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
HttpSession mySession = request.getSession();
Object userId = mySession.getAttribute("loginUserId");
System.out.println("로그인한 사용자 ID: " + userId);
if (userId == null) {
%>
<script>
        alert("로그인이 필요한 기능입니다.");
        location.href = "<%=request.getContextPath()%>/user/login";
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
<title>소비패턴 등록</title>
<style>
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

@font-face {
	font-family: 'NanumSquareRound';
	src:
		url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/NanumSquareRound.woff')
		format('woff');
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
	min-height: 100vh;
	display: flex;
	justify-content: center;
	padding: 40px;
	background-color: #F0F3F1;
}

.form-container {
	width: 800px;
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

input[type="text"], input[type="number"], select {
	width: 100%;
	padding: 14px 16px;
	font-size: 15px;
	border: 1px solid #ccc;
	border-radius: 12px;
	background-color: #FAFAFA;
	transition: border-color 0.3s ease;
}

input:focus, select:focus {
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

input[type="submit"], input[type="reset"], #btnpuls {
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

input[type="submit"]:hover, input[type="reset"]:hover, #btnpuls:hover {
	background-color: #6B8B71;
}
</style>
</head>
<body>
	<div class="wrap">
		<div class="form-container">
			<form id="myfrm" action="${cpath}/ConsumptionPattern/inCon"
				method="post">
				<input type="hidden" name="job" value="insert">

				<div class="form-group">
					<label style="font-weight: 1000; font-size: 25px;">소비패턴 이름</label>
					<input type="text" name="pattern_name" required autofocus
						placeholder="소비패턴 이름을 입력하세요">
				</div>

				<div class="form-group" id="container">
					<label>소비영역</label> <select name="benefitcategory_id" required>
						<c:forEach items="${benefitCategorylist}" var="benefit">
							<option value="${benefit.benefitcategory_id}">${benefit.benefitCategory_name}</option>
						</c:forEach>
					</select> <br>
					<br> <label>소비금액</label> <input type="number" name="amount"
						id="inputAmount" placeholder="금액을 입력하세요" min="0" max=""> <br>
					<br>
				</div>

				<div class="button-group">
					<input type="submit" value="등록"> <input type="reset"
						id="reset_id_btn" value="초기화">
					<button type="button" id="btnpuls">입력칸 추가</button>
				</div>
			</form>
		</div>
	</div>

	<script>
	// 소비영역 중복금지, 3개 미만 금지
	// 소비금액 100만원까지만
	  document.addEventListener("DOMContentLoaded", function() {
		    document.querySelector('input[type="submit"]').addEventListener("click", function(event) {
		      event.preventDefault(); 
		      
		      // 선택된 소비영역 모두 가져오기
		      const categorySelects = document.querySelectorAll('select[name="benefitcategory_id"]');
		      
		      // 소비영역이 3개 이상인 경우
		      if(categorySelects.length >= 3){
		          // 소비영역 중복방지
		          const selectedValues = Array.from(categorySelects).map(select => select.value);
		          const hasDuplicate = new Set(selectedValues).size !== selectedValues.length;
		    	  
		          if (hasDuplicate) {
		              alert("중복된 소비영역이 존재합니다. 다시 확인해 주세요");
		              return;
		            
		          // 소비금액 100만원 이상까지만 가능 
		          // 입려된 금액 모두 가져오기
		           const amountInputs = document.querySelectorAll('input[name="amount"]');
		           let hasInvalidAmount = false;
		           
		           amountInputs.forEach(input => {
		        	      const value = parseInt(input.value);
		        	      // 100만원 초과 불가, 빈칸 불가, 0원 불가
		        	      if (!input.value || isNaN(value) || value > 1000000 || value < 0) {
		        	    	  hasInvalidAmount = true;
		        	    	}
		        	    });
		           
		           if (hasInvalidAmount) {
		        	      alert("소비금액은 100만원 이하로 입력해 주세요.");
		        	      return;
		        	    }
 
		    	  document.getElementById("myfrm").submit();
		      } else { // 소비영역이 3개 미안인 경우
		          alert("소비영역을 최소 3개 이상 입력해 주세요.");
		      }
		      
		    });
		  });
	
	
	
	  const benefitCategoryList = [
		    <c:forEach var="benefit" items="${benefitCategorylist}" varStatus="bene">
		      {
		        id: "${benefit.benefitcategory_id}",
		        name: "${benefit.benefitCategory_name}"
		      }<c:if test="${!bene.last}">,</c:if>
		    </c:forEach>
		  ];
	
	document.addEventListener("DOMContentLoaded", function() {
		document.getElementById("btnpuls").addEventListener("click",function() {
			console.log("btnpuls 잘 눌리나..?");

					const div = document.createElement("div"); // <div> </div>
					div.classList.add("form-group")// <div class="form-group"> </div>
					
					const label1 = document.createElement("label"); // <label></label>
					label1.textContent = "소비영역";
					
					// <br> 두 개 추가
					const br1 = document.createElement("br");
					const br2 = document.createElement("br");
					
					
					const select = document.createElement("select"); // <select></select>
					select.name = "benefitcategory_id"; // <select name="benefitcategory_id"> </select>
					
					
				    // ✅ JSP에서 전달한 배열로 option 동적 추가
				    benefitCategoryList.forEach(item => {
				      const option = document.createElement("option");
				      option.value = item.id;
				      option.textContent = item.name;
				      select.appendChild(option);
				    });
					
					
/* 			        const opt1 = document.createElement("option");
			        opt1.value = "1";
			        opt1.textContent = "식비";
			        const opt2 = document.createElement("option");
			        opt2.value = "2";
			        opt2.textContent = "교통"; */
			        
/* 			        select.appendChild(opt1); 
			        select.appendChild(opt2); // select에 opt1,2 추가 하기 */
			        
					const label2 = document.createElement("label"); // <label></label>
					label2.textContent = "소비금액";
					
					const input = document.createElement("input"); // <input >
					input.setAttribute("type", "number"); // <input type="numeber">
					input.setAttribute("name", "amount"); // name 속성 설정
					input.setAttribute("placeholder", "금액을 입력하세요");
					input.setAttribute("min", "0");

					// 요소에 속성 추가하거나 변경할때 사용하는 함수
					// 요소. setAttribute("속성명","속성값");
					//  <-->  요소.removeAttribute("속성명")  : 속성제거
					
					const span = document.createElement("span"); // <sapn></span>
					span.classList.add("remove"); //  // <span class="remove"></span>
					span.innerHTML="삭제";
					
				    //span에 click이벤트 동작 추가 (동적요소에 동적으로 이벤트 추가)
				    span.addEventListener("click",function(){
				        //alert("동적요소이벤트 추가!");

				        //클릭된 X버튼의 부모요소를 삭제
				        // 요소.remove()   : 해당 요소를 제거
				        this.parentElement.remove();

				    })
				    
					div.appendChild(label1);
					div.appendChild(select);
					div.appendChild(br1);
					div.appendChild(br2);
					div.appendChild(label2);
					div.appendChild(input); // input을 div에 넣고
				    div.appendChild(span);
					document.querySelector("#container").appendChild(div); // div를 container에 추가
					
					
				});
	});
	
	</script>
</body>
</html>
