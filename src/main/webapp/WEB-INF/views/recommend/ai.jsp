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
		font-family: 'NanumSquareRound', sans-serif;
		background-color: #F0F3F1;
		padding: 0;
		margin: 0;
	}
	
	.pattern-wrap {
		display:flex;
		flex-direction: column;
	    width: 100%;
	    min-height: 100vh;
	    background-color: var(--main);
	    display: flex;
	    ustify-content: flex-start;
	    /* align-items: flex-start; */
	    align-items: center;
	    padding-top: 0px;
	}

	.pattern-container {
	  display: grid;
	  grid-template-columns: repeat(4, 1fr);
	  gap: 24px;
	  max-width: 1200px;
	  width: 100%;
	  margin: auto;
	  background: white;
	  border: none;
	  box-shadow: none;
	  padding: 25px;
	  text-align: center;
	  min-height: 370px;
	}
	.pattern-title-main {
	    font-size: 28px;
	    font-weight: bold;
	    margin-bottom: 36px;
	    color: var(--m3);
	    letter-spacing: -1px;
	}
	
	.pattern-group {
	  position: relative;
	  cursor: pointer;
	  transition:
	    border-color 0.22s cubic-bezier(0.4,0,0.2,1),
	    box-shadow 0.22s cubic-bezier(0.4,0,0.2,1),
	    background 0.22s cubic-bezier(0.4,0,0.2,1);
	  border: 1.5px solid var(--m2);
	  border-radius: 16px;
	  box-shadow: 0 2px 10px rgba(143,176,152,0.07);
	  background: #fafcfb;  /* 기본 연한 회녹색 계열 배경 */
	  padding: 22px;
	  display: flex;
	  flex-direction: column;
	  gap: 10px;
	  min-width: 220px;
	  max-width: 100%;
	}
	/* 호버(마우스 올릴 때) 스타일 */
	.pattern-group:hover {
	  border-color: var(--m1);
	  background: #F8FBF8;    /* 연초록~연주황 섞인 듯한 느낌 */
	  box-shadow: 0 6px 24px 0 rgba(143,176,152,0.14);
	}
	/* 선택된 카드 (radio:checked) 스타일 */
	.pattern-group.selected {
	  border-color: var(--m1) !important;
	  background: #F1F5EB;
	  box-shadow:
	    0 0 0 0.4px var(--m1),
	    0 6px 28px 0 rgba(255,184,74,0.12),
	    0 3px 18px rgba(143,176,152,0.16);
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
	    background: white;
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
	    display :inline-block;
	    text-align: center;
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
	.non-pattern{
		font-size:20px; 
		font-weight:bold; 
		/* margin-bottom: 22px */
		text-align: center;	
	}
	.btn-all {
	  display: flex;
	  flex-direction: row;
	  justify-content: flex-start;
	  align-items: center;
	  gap: 14px;
	  margin-bottom: 32px; /* 버튼 아래에 여백 */
	  margin-left: 24px;
	}

	.pattern-list{
		background: white;
	}
	/* .ai-form{
		display: flex;
		
		justify-content: center;
		height: 100vh;
	} */
	.pattern-radio {
	  position: absolute;
	  opacity: 0;
	  pointer-events: none;
	  width: 0; height: 0;
	  margin: 0; padding: 0;
	}
	/* 선택된 패턴 스타일 */
	.pattern-radio:checked + .pattern-title,
	.pattern-radio:checked ~ .benefit-row {
	  /* 이건 title, benefit-row에 주는 방법이지만... */
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
        <p class="non-pattern">등록된 소비패턴이 없습니다.</p>
        <form action="${cpath}/ConsumptionPattern/inCon" method="get">
          <button type="submit" class="button-primary">소비패턴 입력하러 가기</button>
        </form>
      </div>
    </c:when>
    <c:otherwise>
      <form method="post" action="${cpath}/recommend/selectPattern" onsubmit="event.preventDefault(); showMaskAndSubmit(this);" class="ai-form">
        <!-- 버튼: 상단에 한 줄 -->
        <div class="btn-all">
          <button type="submit" class="button-primary" style="margin-right: 12px;">
            선택한 패턴으로 카드 추천받기
          </button>
          <a class="button-primary" href="${cpath}/ConsumptionPattern/inCon">
            소비패턴 입력하러 가기
          </a>
        </div>
        <!-- 소비패턴 카드들: 버튼 아래 -->
        <div class="pattern-container">
		  <c:forEach var="entry" items="${patternList}">
		    <label class="pattern-group" for="pattern_${entry.key}">
		      <input type="radio" class="pattern-radio" name="patternId"
		             value="${entry.key}" id="pattern_${entry.key}" autocomplete="off">
		      <div class="pattern-title">
		        <c:if test="${not empty entry.value}">
		          ${entry.value[0].pattern.pattern_name}
		        </c:if>
		      </div>
		      <c:forEach var="dto" items="${entry.value}">
		        <div class="benefit-row">
		          ${dto.category.benefitCategory_name} : <b>${dto.detail.amount}</b> 원
		        </div>
		      </c:forEach>
		    </label>
		  </c:forEach>
		</div>

      </form>
      <script type="text/javascript">
		document.querySelectorAll('.pattern-radio').forEach(function(radio) {
		  radio.addEventListener('change', function() {
		    document.querySelectorAll('.pattern-group').forEach(function(label){
		      label.classList.remove('selected');
		    });
		    if (radio.checked) {
		      radio.closest('.pattern-group').classList.add('selected');
		    }
		  });
		});
	</script>
    </c:otherwise>
  </c:choose>
</div>

	



<!-- 모달/팝업 영역은 동일하게 아래에 두세요. -->
<div class="popup-mask" style="display:none; position:fixed; left:50%; top:50%; width:100vw; height:100vh; background:rgba(0,0,0,0.5); z-index:9999;">
  <div style="position:absolute; left:50%; top:50%; transform:translate(-50%,-50%); background:white; border-radius:20px; padding:30px 40px; box-shadow:0 2px 16px rgba(0,0,0,0.2); text-align:center;">
    <img src="https://i.ibb.co/20zw80q/1487.gif" alt="로딩중" style="width:64px; display:block; margin:0 auto 20px;">
    <div style="font-size:1.2em; color:#333;">AI 측정 중입니다...</div>
  </div>
</div>

</body>
</html>
