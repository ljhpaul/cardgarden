<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카드 소비패턴 혜택 리스트</title>
<style>
	body {
	    font-family: var(--font);
	    background-color: var(--main);
	}
	.pattern-wrap {
	    width: 100%;
	    min-height: 100vh;
	    background-color: var(--main);
	    display: flex;
	    justify-content: center;
	    align-items: flex-start;
	    padding-top: 60px;
	}

	.pattern-container {
	    display: flex;
	    flex-wrap: wrap;
	    gap: 24px;
	    max-width: 1200px;
	    width: 100%;
	    margin: auto;
	    background: none;
	    border: none;
	    box-shadow: none;
	    padding: 0;
	}
	.pattern-title-main {
	    font-size: 28px;
	    font-weight: bold;
	    margin-bottom: 36px;
	    color: var(--m3);
	    letter-spacing: -1px;
	}
	
	.pattern-group {
	    flex: 1 1 270px;
	    max-width: 300px;
	    min-width: 220px;
	    margin-bottom: 24px;
	    padding: 22px;
	    border: 1.5px solid var(--m2);
	    border-radius: 12px;
	    box-shadow: 0 1px 6px rgba(143,176,152,0.09);
	    background: #fff;
	    display: flex;
	    flex-direction: column;
	    gap: 7px;
	}
	.pattern-group:hover {
	    box-shadow: 0 3px 14px rgba(143,176,152,0.18);
	    background: #fff;
	    border-color: var(--m1);
	}
	.pattern-title {
	    font-weight: bold;
	    font-size: 20px;
	    color: var(--m1);
	    margin-bottom: 12px;
	    display: flex;
	    align-items: center;
	    gap: 8px;
	}
	.pattern-checkbox {
	    margin-right: 10px;
	    width: 20px;
	    height: 20px;
	    accent-color: var(--m1);
	}
	.benefit-row {
	    padding: 8px 0 8px 18px;
	    border-left: 4px solid var(--m1);
	    margin-bottom: 7px;
	    background: var(--main);
	    border-radius: 5px;
	    font-size: 15px;
	    color: var(--m3);
	}
	.button-primary {
	    margin-top: 32px;
	    padding: 13px 36px;
	    /* background: linear-gradient(90deg, var(--m1), var(--m2)); */
	    background-color: #FFF5E1;
	    color: var(--m3);
	    border: none;
	    border-radius: 10px;
	    font-size: 17px;
	    font-weight: bold;
	    cursor: pointer;
	    box-shadow: 0 2px 8px rgba(143,176,152,0.07);
	    transition: background 0.15s, color 0.15s;
	}
	.button-primary:hover {
	    background-color: #FFE0A3;
	    color: #fff;
	}
	.nopattern-wrap {
	    text-align: center;
	    margin-top: 80px;
	    background: #fff;
	    border-radius: 16px;
	    max-width: 400px;
	    margin-left: auto;
	    margin-right: auto;
	    padding: 36px 0 40px 0;
	    box-shadow: 0 2px 12px rgba(143,176,152,0.09);
	    border: 2px solid var(--m2);
	}
	a { text-decoration: none; color: var(--m3);}
	.mask {
	  position: fixed;
	  top: 0;
	  left: 0;
	  width: 100vw;
	  height: 100vh;
	  background-color: rgba(0, 0, 0, 0.5);
	  z-index: 9999;
	  display: none;
	}	
</style>

<script>
  function checkOnlyOne(element) {
    const checkboxes = document.getElementsByName("patternId");
    checkboxes.forEach((cb) => {
      cb.checked = false;
    })
    element.checked = true;
  }

  function showMaskAndSubmit(form) {
    document.querySelector('.mask').style.display = 'block';
    document.querySelector('html').style.overflow = 'hidden';
    form.submit();
  }
</script>
</head>
<body>
 <!-- 로딩 화면 -->
 <div class="mask">
   <img class="loadingImg" src='https://i.ibb.co/20zw80q/1487.gif'>
 </div>
<!-- 로딩화면 끝 -->
	<div class="pattern-wrap">
	  <c:choose>
	    <c:when test="${empty patternList}">
	      <div class="pattern-container" style="display:block;">
	        <p style="font-size:20px; font-weight:bold; margin-bottom: 22px;">등록된 소비패턴이 없습니다.</p>
	        <form action="${cpath}/ConsumptionPattern/inCon" method="get">
	          <button type="submit" class="button-primary">소비패턴 입력하러 가기</button>
	        </form>
	      </div>
	    </c:when>
	    <c:otherwise>
	      <form method="post" action="${cpath}/recommend/selectPattern" onsubmit="event.preventDefault(); showMaskAndSubmit(this);">
	        <div class="pattern-container">
	          <c:forEach var="entry" items="${patternList}">
	            <div class="pattern-group" onclick="document.getElementById('pattern_${entry.key}').click();">
	              <div class="pattern-title">
	               <input type="radio" class="pattern-radio" name="patternId"
					       value="${entry.key}" id="pattern_${entry.key}">
					<label for="pattern_${entry.key}">${entry.value[0].pattern.pattern_name}</label>

	              </div>
	              <c:forEach var="dto" items="${entry.value}">
	                <div class="benefit-row">
	                  ${dto.category.benefitCategory_name} : <b>${dto.detail.amount}</b> 원
	                </div>
	              </c:forEach>
	            </div>
	          </c:forEach>
	        </div>
	        <button type="submit" class="button-primary" style="margin: 40px auto 0 auto; display: block;">
	          선택한 패턴으로 카드 추천받기
	        </button>
	      </form>
	    </c:otherwise>
	  </c:choose>
	</div>




<!-- 모달/팝업 영역은 동일하게 아래에 두세요. -->
<div class="popup-mask" style="display:none; position:fixed; left:0; top:0; width:100vw; height:100vh; background:rgba(0,0,0,0.5); z-index:9999;">
  <div style="position:absolute; left:50%; top:50%; transform:translate(-50%,-50%); background:white; border-radius:20px; padding:30px 40px; box-shadow:0 2px 16px rgba(0,0,0,0.2); text-align:center;">
    <img src="https://i.ibb.co/20zw80q/1487.gif" alt="로딩중" style="width:64px; display:block; margin:0 auto 20px;">
    <div style="font-size:1.2em; color:#333;">AI 측정 중입니다...</div>
  </div>
</div>

</body>
</html>
