<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>페이지를 찾을 수 없습니다</title>
<link rel="stylesheet" href="${cpath}/resources/css/common.css?after">
<link rel="stylesheet" href="${cpath}/resources/css/error.css?after">
</head>
<body>

<div class="error-container">
    <img src="${cpath}/resources/images/common/mascot_error.png" alt="마스코트" class="error-mascot">
    <h1>[400 오류] 잘못된 요청입니다</h1>
    <p>요청이 잘못되었거나, 서버가 요청을 이해할 수 없습니다.</p>
    
    <c:if test="${not empty errorMessage}">
        <h2>${errorMessage}</h2>
    </c:if>
    
    <div class="btn-group">
        <a href="${cpath}/" class="btn-home">메인으로</a>
    </div>
</div>

<canvas id="effectCanvas"></canvas>

<style>
canvas#effectCanvas {
    position: fixed;
    top: 0;
    left: 0;
    pointer-events: none;
    z-index: -1;
}
</style>

<script>
const cpath = '${cpath}';
const canvas = document.getElementById("effectCanvas");
const ctx = canvas.getContext("2d");
canvas.width = window.innerWidth;
canvas.height = window.innerHeight;

let particles = [];

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

const flowerImg = new Image();
flowerImg.src = cpath + "/resources/images/common/sakuraleaf.png";
const leafImg = new Image();
leafImg.src = cpath + "/resources/images/common/leaf2.png";

function drawParticles() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    particles.forEach(p => {
        ctx.save();
        ctx.translate(p.x, p.y);
        ctx.rotate(p.angle);
        const img = p.type === "flower" ? flowerImg : leafImg;
        ctx.drawImage(img, -p.size / 2, -p.size / 2, p.size, p.size);
        ctx.restore();

        p.y += p.speedY;
        p.x += p.speedX;
        p.angle += p.rotateSpeed;
    });

    particles = particles.filter(p => p.y < canvas.height + 50);

    requestAnimationFrame(drawParticles);
}

setInterval(() => {
    if (Math.random() < 0.2) {
        particles.push(createParticle());
    }
}, 200);

drawParticles();
</script>

</body>
</html>
