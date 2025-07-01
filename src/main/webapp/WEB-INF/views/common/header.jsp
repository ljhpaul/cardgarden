<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<!-- 파비콘 -->
<link rel="icon" type="image/png"
	href="/cardgarden/resources/favicon.png">

<!---->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/ec9dd02254.js"
	crossorigin="anonymous"></script>
<script src="${cpath}/resources/js/header.js?after"></script>

<link rel="stylesheet" href="${cpath}/resources/css/common.css?after">
<link rel="stylesheet" href="${cpath}/resources/css/header.css?after">

<div class="header-wrapper">
	<header class="main-header">
		<div class="header-container">

			<!-- 로그인/회원가입 -->
			<div class="header-left">
				<c:choose>
					<c:when test="${not empty loginUserId}">
						<a href="${cpath}/user/mypage">마이페이지</a>
						<a href="${cpath}/user/logout">로그아웃</a>
					</c:when>
					<c:otherwise>
						<a href="${cpath}/user/join">회원가입</a>
						<a href="${cpath}/user/login">로그인</a>
					</c:otherwise>
				</c:choose>
			</div>

			<!--로고 -->
			<div class="header-logo">
				<a href="${cpath}/main"> <img class="mascot"
					src="${cpath}/resources/images/mascot/flower/mascot_flower_1.png">
					<img class="logo" src="${cpath}/resources/images/common/logo.png">
				</a>
			</div>

			<!--검색 -->
			<div class="header-right">
				<form action="${cpath}/card/search" method="get">
					<input type="text" name="keyword" class="text1"
						placeholder="검색어를 입력하세요">
				</form>
				<a href="${cpath}/user/card"> <img class="mascot"
					src="${cpath}/resources/images/common/like.png" width="27">
				</a>
				<span class="like-count like-count-header"></span>
			</div>
		</div>

		<!-- 하단 메뉴 -->
		<div class="header-bottom">
			<div class="menu-item">
				<a href="${cpath}/card/rank">카드 <img class="mascot"
					src="${cpath}/resources/images/common/caretDown.png" width="15">
				</a>
				<div class="submenu">
					<a href="${cpath}/cardSearchcondition">카드 조회</a> <a
						href="${cpath}/card/rank">카드 랭킹</a> <a href="${cpath}/card/search">카드
						검색</a>
				</div>
			</div>

			<div class="menu-item">
				<a href="${cpath}/recommend/ai">AI 카드추천</a>
			</div>

			<div class="menu-item">
				<a href="${cpath}/custom/main">카드 커스터마이징 <img class="mascot"
					src="${cpath}/resources/images/common/caretDown.png" width="15">
				</a>
				<div class="submenu">
					<a href="${cpath}/make/frame">나만의 디자인</a> <a
						href="${cpath}/custom/top?type=sticker">인기 아이템 랭킹</a>
				</div>
			</div>

			<div class="menu-item">
				<a href="${cpath}/event/attendance">이벤트 <img class="mascot"
					src="${cpath}/resources/images/common/caretDown.png" width="15">
				</a>
				<div class="submenu">
					<a href="${cpath}/event/attendance">출석체크</a>
					<a href="${cpath}/event/mascot">포인트샵</a>
				</div>
			</div>
		</div>
	</header>
</div>

<!-- sticky -->
<nav class="sticky-menu">
	<div class="menu-inner">

		<!-- 왼쪽 로고 -->
		<div class="menu-left">
			<a href="${cpath}/main">
				<c:choose>
					<c:when test="${not empty loginUserId}">
						<img class="mascot"
							src="${cpath}/resources/images/mascot/${mascotBrand}/mascot_${mascotBrand}_1.png"
							style="height: 36px;">
					</c:when>
					<c:otherwise>
						<img class="mascot"
							src="${cpath}/resources/images/mascot/flower/mascot_flower_1.png"
							style="height: 36px;">
					</c:otherwise>
				</c:choose>
				<img class="logo"
					src="${cpath}/resources/images/common/logo.png"
					style="height: 26px;">
			</a>
		</div>


		<!-- 가운데 메뉴 -->
		<div class="menu-center">
			<div class="header-bottom-sticky">
			<div class="menu-item">
				<a href="${cpath}/card/rank">카드 <img class="mascot"
					src="${cpath}/resources/images/common/caretDown.png" width="15">
				</a>
				<div class="submenu">
					<a href="${cpath}/cardSearchcondition">카드 조회</a> <a
						href="${cpath}/card/rank">카드 랭킹</a> <a href="${cpath}/card/search">카드
						검색</a>
				</div>
			</div>

			<div class="menu-item">
				<a href="${cpath}/recommend/ai">AI 카드추천</a>
			</div>

			<div class="menu-item">
				<a href="${cpath}/custom/main">카드 커스터마이징 <img class="mascot"
					src="${cpath}/resources/images/common/caretDown.png" width="15">
				</a>
				<div class="submenu">
					<a href="${cpath}/make/frame">나만의 디자인</a> <a
						href="${cpath}/custom/top?type=sticker">인기 아이템 랭킹</a>
				</div>
			</div>

			<div class="menu-item">
				<a href="${cpath}/event/attendance">이벤트 <img class="mascot"
					src="${cpath}/resources/images/common/caretDown.png" width="15">
				</a>
				<div class="submenu">
					<a href="${cpath}/event/attendance">출석체크</a>
					<a href="${cpath}/event/mascot">포인트샵</a>
				</div>
			</div>
		</div>
		</div>

		<!-- 오른쪽 검색 + 하트 -->
		<div class="menu-right">
			<form action="${cpath}/card/search" method="get">
				<input type="text" name="keyword" placeholder="검색어">
			</form>

			<div class="like-wrapper">
				<a href="${cpath}/user/card" style="position: relative; display: inline-block;"> 
					<img class="mascot" src="${cpath}/resources/images/common/like.png" width="27"> 
				</a>
				<span class="like-count like-count-sticky"></span>
			</div>
		</div>
	</div>
	
</nav>

<!-- 나뭇잎,꽃잎 떨어지는 효과 -->
<canvas id="rareCanvas"></canvas>
<style>
canvas#rareCanvas {
  position: fixed;
  top: 0;
  left: 0;
  pointer-events: auto;
  z-index: -1;
}
</style>
<script>
//희귀 꽃 캔버스
const rareCanvas = document.getElementById("rareCanvas");
const rareCtx = rareCanvas.getContext("2d");
rareCanvas.width = window.innerWidth;
rareCanvas.height = window.innerHeight;

const rareImg = new Image();
rareImg.src = `${cpath}/resources/images/common/rare.png`;

let rareParticles = [];

function createRareParticle() {
  return {
    id: Date.now() + Math.random(),
    x: Math.random() * rareCanvas.width,
    y: -20,
    speedY: 1 + Math.random(),
    speedX: Math.random() * 2 - 1,
    size: 40,
    angle: Math.random() * Math.PI * 2,
    rotateSpeed: Math.random() * 0.02,
  };
}

// 그리기
function drawRareParticles() {
  rareCtx.clearRect(0, 0, rareCanvas.width, rareCanvas.height);
  rareParticles.forEach(p => {
    rareCtx.save();
    rareCtx.translate(p.x, p.y);
    rareCtx.rotate(p.angle);
    rareCtx.drawImage(rareImg, -p.size / 2, -p.size / 2, p.size, p.size);
    rareCtx.restore();

    p.y += p.speedY;
    p.x += p.speedX;
    p.angle += p.rotateSpeed;
  });

  rareParticles = rareParticles.filter(p => p.y < rareCanvas.height + 50);
  requestAnimationFrame(drawRareParticles);
}

// 일정 간격 생성
setInterval(() => {
  if (Math.random() < 0.01) {
    rareParticles.push(createRareParticle());
  }
}, 300);

// 클릭 이벤트
rareCanvas.addEventListener("click", function (e) {
  const rect = rareCanvas.getBoundingClientRect();
  const x = e.clientX - rect.left;
  const y = e.clientY - rect.top;

  for (let i = 0; i < rareParticles.length; i++) {
    const p = rareParticles[i];
    const dx = p.x - x;
    const dy = p.y - y;
    if (Math.sqrt(dx * dx + dy * dy) < p.size / 2) {
      alert("🎉 희귀 꽃 클릭!");
      rareParticles.splice(i, 1);
      break;
    }
  }
});

// 시작
drawRareParticles();
</script>



<style>
canvas#effectCanvas {
	position: fixed;
	top: 0;
	left: 0;
	pointer-events: none;
	z-index: -1; /* 필요시 조절 */
}
</style>


<canvas id="effectCanvas"></canvas>

<script>
const canvas = document.getElementById("effectCanvas");
const ctx = canvas.getContext("2d");
canvas.width = window.innerWidth;
canvas.height = window.innerHeight;

let particles = [];

// 파티클 생성 함수
function createParticle() {
  const isFlower = Math.random() < 0.5;
  return {
    x: Math.random() * canvas.width,
    y: -20,
    speedY: 1 + Math.random() * 1,
    speedX: Math.random() * 1 - 0.5,
    size: 20 + Math.random() * 30,
    angle: Math.random() * Math.PI * 2,
    rotateSpeed: Math.random() * 0.02,
    type: isFlower ? "flower" : "leaf"
  };
}

// flower와 leaf 이미지
const flowerImg = new Image();
flowerImg.src = `${cpath}/resources/images/common/sakuraleaf.png`;
const leafImg = new Image();
leafImg.src = `${cpath}/resources/images/common/leaf2.png`;

// 매 프레임마다 그리기
function drawParticles() {
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  particles.forEach(p => {
    ctx.save();
    ctx.translate(p.x, p.y);
    ctx.rotate(p.angle);
    const img = p.type === "flower" ? flowerImg : leafImg;
    ctx.drawImage(img, -p.size / 2, -p.size / 2, p.size, p.size);
    ctx.restore();

    // 업데이트
    p.y += p.speedY;
    p.x += p.speedX;
    p.angle += p.rotateSpeed;
  });

  // 화면 밖으로 나간 파티클 제거
  particles = particles.filter(p => p.y < canvas.height + 50);

  requestAnimationFrame(drawParticles);
}

// 일정 간격으로 새 파티클 추가 (랜덤하게)
setInterval(() => {
  if (Math.random() < 0.2) { // 생성 확률 조절 가능
    particles.push(createParticle());
  }
}, 200); // 200ms마다 생성 시도 (느리게 흩날리도록)

// 시작
drawParticles();

// 좋아요 수 하트에 표시 및 스타일 변동
const userLike = Number("${userLike}");
$(".like-count").show().text(userLike<100?userLike:"99+");
if(userLike >= 100) {
	$(".like-count").css("font-weight", "700");
	$(".like-count-header").css("top", "40px").css("right", "11px").css("font-size", "9px").css("width", "18px").css("height", "18px");
	$(".like-count-sticky").css("top", "-6px").css("right", "-6px").css("font-size", "9px").css("width", "18px").css("height", "18px");
} else if(userLike >= 10) {
	$(".like-count-header").css("top", "41px").css("right", "12px").css("font-size", "10px").css("width", "16px").css("height", "16px");
	$(".like-count-sticky").css("top", "-6px").css("right", "-6px").css("font-size", "10px").css("width", "16px").css("height", "16px");
} else if(userLike >= 1) {
	$(".like-count-header").css("top", "41px").css("right", "12px").css("font-size", "11px").css("width", "16px").css("height", "15px");
	$(".like-count-sticky").css("top", "-6px").css("right", "-6px").css("font-size", "11px").css("width", "15px").css("height", "14px");
} else {
	$(".like-count").hide();
}

</script>

<script>
img.src = "${cpath}/resources/images/mascot/" + mascotBrand + "/mascot_" + mascotBrand + "_1.png";
</script>
<c:if test="${not empty loginUserId}">
<script>
$(document).ready(function () {
    const mascotImgs = document.querySelectorAll(".mascot");

    const mascotId = ${mascotId}; 
    let mascotBrand = "flower";
    if (mascotId === 121) mascotBrand = "card";
    if (mascotId === 122) mascotBrand = "fairy";
    
    mascotImgs.forEach(img => {
        if (img.src.includes("mascot/flower")) {
        	img.src = "${cpath}/resources/images/mascot/" + mascotBrand + "/mascot_" + mascotBrand + "_1.png";
        }
    });

    const sessionDuration = 40;
    let lastActionTime = Date.now();
    $(document).on("click", () => { lastActionTime = Date.now(); });
	
    setInterval(() => {
        const elapsedSec = (Date.now() - lastActionTime) / 1000;
        const remaining = sessionDuration - elapsedSec;

        let imgNum = 3;
        if (remaining > 20) imgNum = 1;
        else if (remaining > 0) imgNum = 2;
		
        mascotImgs.forEach(img => {
            if (img.src.includes(`mascot/${mascotBrand}`)) {
            	 img.src = "${cpath}/resources/images/mascot/" + mascotBrand + "/mascot_" + mascotBrand + "_" + imgNum + ".png";
            }
        });
    }, 1000);
});
</script>
</c:if>