<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<%@ include file="../common/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카드조회</title>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding&display=swap"
	rel="stylesheet">

<link rel="stylesheet"
	href="https://unpkg.com/swiper@8/swiper-bundle.min.css" />
<script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>

<style>
    @font-face {
      font-family: 'NanumSquareRound';
      src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/NanumSquareRound.woff') format('woff');
      font-weight: normal;
      font-style: normal;
    }

/* 전체 화면 영역 확인용 스타일 */
* {
	box-sizing: border-box;
}

div, form {
	
}

/* 전체 화면 영역 지정 및 분할 스타일 */
.wrap {
	width: 100%;
	height: 100%;
	overflow: hidden;
	margin: auto;
	background-color: #F0F3F1;
	position: relative;
	display: flex;
	justify-content: center; /* 수평 가운데 정렬 */
}

/* header {
	width: 100%;
	height: 200px;
	margin: 0 auto;
	background-color: blue;
} */

#content {
  margin-top : 30px;
  width:1000px;
  display: grid;
  grid-template-columns: repeat(3, 1fr); /* 가로 3칸 */
  gap: 20px; /* 박스 사이 여백 */
  padding: 40px;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
  border-radius: 12px;
  background-color: #FFFFFF;
}

.folder {
  background-color: #f2f2f2;
  border-radius: 20px;
  height: 160px;
  padding: 20px;
  box-shadow: 0 4px 10px rgba(0,0,0,0.1);
  position: relative;
  margin-bottom: 50px; /*폴더 간격 조정*/
  font-family: 'NanumSquareRound', sans-serif;
}

.tab {
  position: absolute;
  top: -30px;
  left: 0px;
  background-color: #f2f2f2;
  padding: 10px 20px;
  border-radius: 10px 10px 0 0;
  font-weight: bold;
  font-family: 'NanumSquareRound', sans-serif;
  text-align: center; /* 텍스트 가운데 정렬 */
}

.cardtype {
  width: 100%;
  height: 100px;
   display: grid;
   gap: 20px;
   /* 그리드 한 줄 전체 차지 */
  grid-column: 1 / -1;
  grid-template-columns: repeat(2, 1fr); /* 가로 2칸 */
  margin-bottom: 50px;
}

.card-btn {
  display: flex;
/*   display: block; */
  padding: 40px;
  height: 100%;
  text-align: center;
  border-radius: 20px;
  cursor: pointer;
  background-color: #f2f2f2;
  font-size: 30px;
  font-family: 'NanumSquareRound', sans-serif;
  font-weight: bold;
}

</style>
</head>
<body>
<div>됐으면 좋겠다 ㅎㅎ</div>
	<div class="wrap">

		<!-- 콘텐츠 영역 -->
		<div id="content">
		<div class="cardtype">
		  <label class="card-btn">
		    <input type="checkbox" name="credit" value="신용"> 신용카드
		  </label>
		  <label class="card-btn">
		    <input type="checkbox" name="check" value="체크"> 체크카드
		  </label>
		</div>
			<div class="folder">
				<div class="tab">모든가맹점</div>
		            <label for="gas"><input type="checkbox" id="gas" name="category" value="모든가맹점">선택</label>
			</div>
			<div class="folder">
				<div class="tab">모빌리티</div>
                    <br>
		            <label for="gas"><input type="checkbox" id="gas" name="category" value="주유소">주유소</label>
		            <br>
		            <label for="high"><input type="checkbox" id="high" name="category" value="자동차/하이패스">자동차/하이패스</label>
		            <br>
		            <label for="mo_gi"><input type="checkbox" id="mo_gi" name="category" value="기타">기타</label>
			</div>
            <div class="folder">
				<div class="tab">대중교통</div>
                    <br>
		            <label for="train"><input type="checkbox" id="train" name="category" value="기차">기차</label>
		            <br>
		            <label for="taxi"><input type="checkbox" id="taxi" name="category" value="택시">택시</label>
		            <br>
		            <label for="bus"><input type="checkbox" id="bus" name="category" value="고속버스">고속버스</label>
		            <br>
		            <label for="transport"><input type="checkbox" id="transport" name="category" value="대중교통">기타</label>
			</div>
            <div class="folder">
				<div class="tab">통신</div>
                    <br>
		            <label for="LGU"><input type="checkbox" id="LGU" name="category" value="LGU+">LGU+</label>
		            <br>
		            <label for="KT"><input type="checkbox" id="KT" name="category" value="KT">KT</label>
		            <br>
		            <label for="SKT"><input type="checkbox" id="SKT" name="category" value="SKT">SKT</label>
		            <br>
		            <label for="transport"><input type="checkbox" id="transport" name="category" value="통신"> 기타</label>
			</div>
            <div class="folder">
				<div class="tab">생활</div>
                    <br>
		            <label for="gas"><input type="checkbox" id="gas" name="category" value="공과금/렌탈">공과금/렌탈</label>
		            <br>
		            <label for="cafe"><input type="checkbox" id="cafe" name="category" value="교육/육아">교육/육아</label>
		            <br>
		            <label for="cafe"><input type="checkbox" id="cafe" name="category" value="애완동물">애완동물</label>
		            <br>
		            <label for="transport"><input type="checkbox" id="transport" name="category" value="기타">기타</label>
			</div>
            <div class="folder">
				<div class="tab">쇼핑</div>
                    <br>
		            <label for="gas"><input type="checkbox" id="gas" name="category" value="gas">편의점</label>
		            <br>
		            <label for="cafe"><input type="checkbox" id="cafe" name="category" value="cafe">온라인쇼핑</label>
		            <br>
		            <label for="cafe"><input type="checkbox" id="cafe" name="category" value="cafe">마트/백화점</label>
		            <br>
		            <label for="transport"><input type="checkbox" id="transport" name="category" value="기타">기타</label>
			</div>
            <div class="folder">
				<div class="tab">외식/카페</div>
                    <br>
		            <label for="gas"><input type="checkbox" id="gas" name="category" value="음식점">음식점</label>
		            <br>
		            <label for="cafe"><input type="checkbox" id="cafe" name="category" value="배달">배달</label>
		            <br>
		            <label for="cafe"><input type="checkbox" id="cafe" name="category" value="카페">카페</label>
		            <br>
		            <label for="cafe"><input type="checkbox" id="cafe" name="category" value="디저트">디저트</label>
		            <br>
		            <label for="transport"><input type="checkbox" id="transport" name="category" value="기타">기타</label>
			</div>
            <div class="folder">
				<div class="tab">뷰티/피트니스</div>
                    <br>
		            <label for="gas"><input type="checkbox" id="gas" name="category" value="뷰티">뷰티 </label>
		            <br>
		            <label for="cafe"><input type="checkbox" id="cafe" name="category" value="피트니스">피트니스 </label>
		            <br>
		            <label for="transport"><input type="checkbox" id="transport" name="category" value="기타">기타</label>
			</div>
            <div class="folder">
				<div class="tab">금융/포인트</div>
                    <br>
		            <label for="gas"><input type="checkbox" id="gas" name="category" value="혜택">혜택</label>
		            <label for="transport"><input type="checkbox" id="transport" name="category" value="해외">해외</label>
		            <br>
		            <label for="cafe"><input type="checkbox" id="cafe" name="category" value="금융">금융</label>
		            <br>
		            <label for="cafe"><input type="checkbox" id="cafe" name="category" value="보험">보험</label>
		            <br>
		            <label for="cafe"><input type="checkbox" id="cafe" name="category" value="간편결제">간편결제</label>
		          
			</div>
            <div class="folder">
				<div class="tab">병원/약국</div>
                    <br>
		            <label for="gas"><input type="checkbox" id="gas" name="category" value="병원">병원</label>
		            <br>
		            <label for="cafe"><input type="checkbox" id="cafe" name="category" value="약국">약국</label>
			</div>
			       <div class="folder">
				<div class="tab">문화/취미</div>
                    <br>
		            <label for="gas"><input type="checkbox" id="gas" name="category" value="OTT">OTT</label>
		            <br>
		            <label for="cafe"><input type="checkbox" id="cafe" name="category" value="영화">영화</label>
		            <br>
		            <label for="transport"><input type="checkbox" id="transport" name="category" value="취미">취미</label>
		            <br>
		            <label for="transport"><input type="checkbox" id="transport" name="category" value="기타">기타</label>
			</div>
			    <div class="folder">
				<div class="tab">숙박/항공</div>
                    <br>
		            <label for="gas"><input type="checkbox" id="gas" name="category" value="항공">항공</label>
		            		<label for="transport"><input type="checkbox" id="transport" name="category" value="공항라운지/PP">공항라운지/PP</label>
		            <br>
		            <label for="cafe"><input type="checkbox" id="cafe" name="category" value="프리미엄">프리미엄</label>
		            <br>
		            <label for="transport"><input type="checkbox" id="transport" name="category" value="‘여행/숙박">여행/숙박</label>
					<br>
					<label for="transport"><input type="checkbox" id="transport" name="category" value="transport"> 간편결제</label>			
			</div>

		</div>
	</div>



	<script>
		
	</script>



	<%-- 	 <%@ include file="views/common/footer.jsp" %> --%>

</body>
</html>