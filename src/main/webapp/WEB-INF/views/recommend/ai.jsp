<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카드 소비패턴 혜택 리스트</title>
<style>
    .pattern-group { margin-bottom: 30px; padding: 20px; border: 1px solid #ddd; border-radius: 10px; background: #fafcff;}
    .pattern-title { font-weight: bold; font-size: 18px; color: #3c4a5b; margin-bottom: 10px; display: flex; align-items: center;}
    .pattern-checkbox { margin-right: 8px; width: 18px; height: 18px; }
    .benefit-row { padding: 6px 0 6px 12px; border-left: 3px solid #50a3f7; margin-bottom: 5px; background: #f5f7fa;}
    * {
      box-sizing: border-box;
      padding: 0;
      margin: 0 auto;
    }
    .mask {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0);
      z-index: 9999;
      opacity: .5;
      transition: 0.5s ease;
      display: none; /* 기본적으로 안 보임 */
    }
    .loadingImg {
      position: relative;
      display: block;
      top: 50vh;
      transform: translateY(-50%);
    }
</style>
<script>
  // 체크박스 단일 선택
  function checkOnlyOne(element) {
    const checkboxes = document.getElementsByName("patternId");
    checkboxes.forEach((cb) => {
      cb.checked = false;
    })
    element.checked = true;
  }

  // 버튼 클릭 시 마스크 띄우고 폼 제출
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
  <form method="get" action="${cpath}/recommend/aiResult" onsubmit="event.preventDefault(); showMaskAndSubmit(this);">
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
    <button type="submit"
        style="padding:8px 20px; background:#50a3f7; color:white; border:none; border-radius:7px; font-size:15px;">
        선택한 패턴으로 카드 추천받기
    </button>
  </form>
  <!-- 모달/팝업 영역 추가 -->
<div class="popup-mask" style="display:none; position:fixed; left:0; top:0; width:100vw; height:100vh; background:rgba(0,0,0,0.5); z-index:9999;">
  <div style="position:absolute; left:50%; top:50%; transform:translate(-50%,-50%); background:white; border-radius:20px; padding:30px 40px; box-shadow:0 2px 16px rgba(0,0,0,0.2); text-align:center;">
    <img src="https://i.ibb.co/20zw80q/1487.gif" alt="로딩중" style="width:64px; display:block; margin:0 auto 20px;">
    <div style="font-size:1.2em; color:#333;">AI 측정 중입니다...</div>
  </div>
</div>

  
</body>
</html>
