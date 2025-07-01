<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
	.pattern-page {
		display: flex;
	    align-items: flex-start;
	    justify-content: center;
	    gap: 36px;
	    width: 100%;
	    max-width: 1400px;
	    margin: 0 auto;
	    padding-top: 0px;
	    margin-top: -10;
	}
	.side-menu {
		display: flex;
		flex-direction: column;
		gap: 24px;
		min-width: 210px;
		align-items: flex-start;
		margin-top: 0;
	}
	.side-menu .side-btn {
		width: 210px;
		padding: 0;
		background: none;
		border: none;
		display: block;
	}
	.side-btn img{
		box-shadow: 0 2px 16px rgba(100,130,120,0.08);
	}
	.side-btn img:hover {
		box-shadow: 0 3px 24px rgba(180, 140, 90, 0.22);
		transition: box-shadow 0.18s;
	}
	.side-menu img {
		margin-left: 50px;
		width: 100%;
		border-radius: 20px;
		margin-bottom: 0;
		display: block;
	}
	.pattern-content {
		flex: 1 1 0;
		min-width: 360px;
	}
	.pattern-container {
		display: grid;
		grid-template-columns: repeat(3, 1fr);
		gap: 24px;
		max-width: 900px;
		width: 100%;
		background: rgba(255,255,255,0.93);
		border: none;
		box-shadow: none;
		padding: 25px;
		text-align: center;
		margin-left: 50px;
		min-height: 370px;
		border-radius: 20px;
	}
	.pattern-group {
		position: relative;
		cursor: pointer;
		transition: border-color 0.22s cubic-bezier(0.4,0,0.2,1), box-shadow 0.22s cubic-bezier(0.4,0,0.2,1), background 0.22s cubic-bezier(0.4,0,0.2,1);
		border: 1.5px solid var(--m2, #D3E8D6);
		border-radius: 16px;
		box-shadow: 0 2px 10px rgba(143,176,152,0.07);
		background: #fafcfb;
		padding: 22px;
		display: flex;
		flex-direction: column;
		gap: 10px;
		min-width: 220px;
		max-width: 100%;
	}
	.pattern-group:hover {
		border-color: var(--m1, #8FB098);
		background: #F8FBF8;
		box-shadow: 0 6px 24px 0 rgba(143,176,152,0.14);
	}
	.pattern-group.selected {
		border-color: var(--m1, #8FB098) !important;
		background: #F1F5EB;
		box-shadow: 0 0 0 0.4px var(--m1, #8FB098), 0 6px 28px 0 rgba(255,184,74,0.12), 0 3px 18px rgba(143,176,152,0.16);
	}
	.pattern-title {
		font-weight: bold;
		font-size: 20px;
		color: var(--m1, #8FB098);
		margin-bottom: 12px;
		display: flex;
		align-items: center;
		gap: 8px;
	}
	.benefit-row {
		padding: 8px 0 8px 18px;
		border-left: 4px solid var(--m1, #8FB098);
		margin-bottom: 7px;
		background: white;
		border-radius: 5px;
		font-size: 15px;
		color: var(--m3, #49615A);
	}
	.button-primary {
		margin-top: 32px;
		padding: 16px 48px;
		background-color: #FFF5E1;
		color: var(--m3, #49615A);
		border: none;
		border-radius: 10px;
		font-size: 24px;
		font-weight: 800;
		cursor: pointer;
		box-shadow: 0 2px 8px rgba(143,176,152,0.07);
		transition: background 0.15s, color 0.15s;
		display: inline-block;
		text-align: center;
		margin-left: 50px; 
		text-decoration: none;
		margin-bottom: 300px;
	}
	.button-primary:hover {
		background-color: #FFE0A3;
		color: #fff;
	}
	.non-pattern {
		font-size: 20px;
		font-weight: bold;
		text-align: center;
	}
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
	@media (max-width: 1100px) {
		.pattern-container {
			grid-template-columns: repeat(2, 1fr);
		}
	}
	@media (max-width: 800px) {
		.pattern-page {
			flex-direction: column;
			align-items: stretch;
			gap: 24px;
		}
		.side-menu {
			flex-direction: row;
			justify-content: center;
			gap: 16px;
			min-width: 0;
			margin-bottom: 20px;
		}
		.pattern-content {
			min-width: 0;
		}
	}
	.pattern-radio {
	  position: absolute;
	  opacity: 0;
	  width: 0;
	  height: 0;
	  pointer-events: none;
	  margin: 0;
	  padding: 0;
	  /* 아래 줄을 추가해도 확실! */
	  appearance: none;
	  -webkit-appearance: none;
	  -moz-appearance: none;
	}
	.loading-popup-mask {
	  position: fixed; left: 0; top: 0; width: 100vw; height: 100vh;
	  background: rgba(0,0,0,0.4); z-index: 9999;
	  display: flex; align-items: center; justify-content: center;
	}
	.loading-popup-inner {
	  background: white; border-radius: 24px; padding: 40px 60px 32px;
	  box-shadow: 0 2px 18px rgba(0,0,0,0.17); text-align: center;
	  min-width: 260px;
	}
	.loading-run {
	  width: 120px; height: 120px; margin: 0 auto 16px;
	  position: relative;
	}
	.loading-run img {
	  position: absolute; left: 0; top: 0; width: 120px; height: 120px;
	  object-fit: contain;
	  user-select: none;
	  pointer-events: none;
	}
	.loading-text {
	  font-size: 1.25em; color: #2B362D; font-weight: bold; letter-spacing: 1.5px;
	}

</style>
<script>
document.addEventListener('DOMContentLoaded', function() {
	  var cpath = "${cpath}";

	  // pattern-radio 클릭 시 aside-ai 링크 업데이트 + 선택 표시
	  document.querySelectorAll('.pattern-radio').forEach(function(radio) {
	    radio.addEventListener('change', function() {
	      const asideAi = document.getElementById('aside-ai');
	      const submitBtn = document.getElementById('submit-pattern');
	      document.querySelectorAll('.pattern-group').forEach(function(label){
	        label.classList.remove('selected');
	      });
	      if (radio.checked) {
	        const newHref = cpath + "/recommend/selectPattern?patternId=" + radio.value;
	        asideAi.href = newHref;
	        submitBtn.href = newHref; // ← 제출 버튼에도 적용
	        radio.closest('.pattern-group').classList.add('selected');
	      }
	    });
	  });

	  // 공통 클릭 핸들러
	  function handlePatternClick(e) {
	    const checkedRadio = document.querySelector('.pattern-radio:checked');
	    if (!checkedRadio) {
	      e.preventDefault();
	      alert('소비패턴을 먼저 선택해 주세요!');
	    } else {
	      e.preventDefault();
	      alert('AI 카드 추천을 시작합니다!\n잠시만 기다려 주세요.');
	      document.querySelector('.mask').style.display = 'block';
	      document.querySelector('html').style.overflow = 'hidden';
	      location.href = e.currentTarget.href;
	    }
	  }

	  document.getElementById('aside-ai').addEventListener('click', handlePatternClick);
	  document.getElementById('submit-pattern').addEventListener('click', handlePatternClick);
	});
	
</script>

<script>
let frameIdx = 0;
let runInterval = null;

function showLoadingPopup() {
  document.querySelector('.loading-popup-mask').style.display = 'flex';
  frameIdx = 0;
  const frames = document.querySelectorAll('.run-frame');
  if (runInterval) clearInterval(runInterval);
  runInterval = setInterval(() => {
    frames.forEach((img, i) => img.style.display = i === frameIdx ? 'block' : 'none');
    frameIdx = (frameIdx + 1) % frames.length;
    /* 달리는 속도 조절 */
  }, 1000);
}

function hideLoadingPopup() {
  document.querySelector('.loading-popup-mask').style.display = 'none';
  if (runInterval) clearInterval(runInterval);
}

document.addEventListener('DOMContentLoaded', function() {
  var cpath = "${cpath}";
  // 패턴 라디오 변경시 aside-ai href, selected 표시
  document.querySelectorAll('.pattern-radio').forEach(function(radio) {
    radio.addEventListener('change', function() {
      const asideAi = document.getElementById('aside-ai');
      document.querySelectorAll('.pattern-group').forEach(function(label){
        label.classList.remove('selected');
      });
      if (radio.checked) {
        asideAi.href = cpath + "/recommend/selectPattern?patternId=" + radio.value;
        radio.closest('.pattern-group').classList.add('selected');
      }
    });
  });

  // aside-ai 클릭 시: 선택 없으면 alert, 있으면 로딩
  document.getElementById('aside-ai').addEventListener('click', function(e){
    const checkedRadio = document.querySelector('.pattern-radio:checked');
    if (!checkedRadio) {
      e.preventDefault();
      alert('소비패턴을 먼저 선택해 주세요!');
    } else {
      e.preventDefault();
      showLoadingPopup();
      setTimeout(() => { location.href = this.href; }, 1000); // 1초 후 이동
    }
  });
});



</script>
</head>
<body>

<div class="mask">
   <img class="loadingImg" src='https://i.ibb.co/20zw80q/1487.gif'>
</div>

<div class="pattern-page">
  <div class="side-menu">
    <a href="${cpath}/ConsumptionPattern/inCon" class="side-btn">
      <img src="${cpath}/resources/images/consumpattern/goconsumpattern.png" alt="소비패턴 입력하러 가기">
    </a>
    <a href="#" id="aside-ai" class="side-btn">
      <img src="${cpath}/resources/images/consumpattern/goAI.png" alt="AI 맞춤 카드 추천 받기">
    </a>
  </div>
  <div class="pattern-content">
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
        <div class="ai-form">
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
          <a href="${cpath}/ConsumptionPattern/submitPattern"  class="button-primary"  id="submit-pattern" >
		   제출하기
		  </a>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
</div>

<!-- 모달/팝업 영역 동일 -->
<div class="loading-popup-mask" style="display:none;">
  <div class="loading-popup-inner">
    <div class="loading-run">
      <img class="run-frame" src="${cpath}/resources/images/consumpattern/ai1.png" alt="1" style="display:block;">
      <img class="run-frame" src="${cpath}/resources/images/consumpattern/ai2.png" alt="2" style="display:none;">
      <img class="run-frame" src="${cpath}/resources/images/consumpattern/ai3.png" alt="3" style="display:none; ">
      <%-- <img class="run-frame" src="${cpath}/resources/images/consumpattern/ai4.png" alt="4" style="display:none;"> --%>
      <img class="run-frame" src="${cpath}/resources/images/consumpattern/ai5.png" alt="5" style="display:none;">
    </div>
    <div class="loading-text">로딩중입니다...</div>
  </div>
</div>
</body>
</html>
