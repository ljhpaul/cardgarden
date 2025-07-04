<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.List" %>
<%@ page import="com.cardgarden.project.model.benefitCategory.benefitCategoryDTO" %>
<c:set var="cpath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>카드가든 : 소비패턴 등록</title>
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
      background-color: #f0f3f1;
      color: #333;
    }

    .wrap {
      display: flex;
      justify-content: center;
      padding: 40px;
    }

    .form-container {
      width: 100%;
      max-width: 700px;
      background: #fff;
      padding: 40px;
      border-radius: 16px;
      box-shadow: 0 4px 16px rgba(0, 0, 0, 0.05);
    }

    h1 {
      text-align: center;
      font-size: 26px;
      color: #646f58;
      margin-bottom: 24px;
    }

    .form-group {
      margin-bottom: 20px;
    }

    label {
      display: block;
      margin-bottom: 8px;
      font-weight: bold;
      font-size: 15px;
      color: #3e4e42;
    }

    input[type="text"],
    input[type="number"],
    select {
      width: 100%;
      padding: 12px 14px;
      font-size: 15px;
      border: 1px solid #ccc;
      border-radius: 10px;
      background-color: #fafafa;
      transition: border-color 0.2s ease;
    }

    input:focus,
    select:focus {
      border-color: #8fb098;
      outline: none;
    }

    .button-group {
      display: flex;
      justify-content: center;
      gap: 10px;
      margin-top: 30px;
    }

    input[type="submit"],
    input[type="reset"],
    #btnpuls,
    #calcBtn {
      background-color: #8fb098;
      color: white;
      font-size: 15px;
      border: none;
      padding: 12px 20px;
      border-radius: 10px;
      cursor: pointer;
      transition: background-color 0.2s;
    }

    input[type="submit"]:hover,
    input[type="reset"]:hover,
    #btnpuls:hover {
      background-color: #6b8b71;
    }

    span.remove {
      display: inline-block;
      margin-top: 10px;
      background-color: #ff6b6b;
      color: white;
      padding: 5px 12px;
      font-size: 13px;
      border-radius: 8px;
      cursor: pointer;
      transition: background-color 0.2s;
    }

    span.remove:hover {
      background-color: #e84545;
    }
  </style>
</head>

<body>
  <div class="wrap">
    <div class="form-container">
      <form id="myfrm" onsubmit="return false;">
        <input type="hidden" id="cardId" value="${param.cardid}" />

        <div class="form-group" id="container">
          <label>소비영역</label>
          <select name="benefitcategory_id" required>
            <option disabled selected>카테고리 선택</option>
            <c:forEach items="${benefitCategorylist}" var="benefit">
              <option value="${benefit.benefitcategory_id}">${benefit.benefitCategory_name}</option>
            </c:forEach>
          </select><br><br>

          <label>소비금액</label>
          <input type="number" name="amount" placeholder="금액을 입력하세요" min="0"><br><br>
        </div>

        <div class="button-group">
          <input type="button" id="calcBtn" value="계산하기">
          <input type="reset" value="초기화">
          <button type="button" id="btnpuls">입력칸 추가</button>
        </div>
      </form>

      <!-- ✅ 계산 결과 출력 영역 -->
      <div id="resultBox" style="margin-top: 30px;"></div>
    </div>
  </div>

  <script>
    document.addEventListener("DOMContentLoaded", function () {
      let benefitCategoryList = [];

      // ✅ 서버에서 카테고리 로딩
      fetch("${cpath}/ConsumptionPattern/loadBenefitCategories")
        .then(res => res.json())
        .then(data => {
          benefitCategoryList = data;
          console.log("✅ 카테고리 목록 로딩 완료:", benefitCategoryList);
        });

      // ✅ 계산하기 버튼 클릭
      document.getElementById("calcBtn").addEventListener("click", function () {
        const selects = document.querySelectorAll('select[name="benefitcategory_id"]');
        const amounts = document.querySelectorAll('input[name="amount"]');

        const pattern = {};
        for (let i = 0; i < selects.length; i++) {
          const category = selects[i].options[selects[i].selectedIndex].textContent.trim();
          const amount = parseInt(amounts[i].value.trim());

          if (category !== "카테고리 선택" && !isNaN(amount) && amount > 0) {
            pattern[category] = amount;
          }
        }

        const cardId = new URLSearchParams(window.location.search).get("cardid");
        if (!cardId || Object.keys(pattern).length < 3) {
          alert("카드 ID가 없거나 소비영역을 3개 이상 입력해야 합니다.");
          return;
        }

        fetch("http://localhost:5000/api/benefit-calc", {
          method: "POST",
          headers: {
            "Content-Type": "application/json"
          },
          body: JSON.stringify({
            cardId: parseInt(cardId),
            pattern: pattern
          })
        })
          .then(res => res.json())
          .then(data => {
            console.log("✅ 계산 결과:", data);
            showBenefitResult(data);
          })
          .catch(err => {
            console.error("❌ 계산 실패:", err);
            alert("서버와의 통신 중 오류가 발생했습니다.");
          });
      });

   // ✅ 계산 결과 출력 함수 (백틱 없이)
      function showBenefitResult(result) {
        let html = '<div style="padding:16px; border:1px solid #ccc; border-radius:10px; background:#f9f9f9;">';
        html += '<h3>총 혜택: ' + result["총 혜택"].toLocaleString() + '원</h3>';
        html += '<ul style="padding-left:20px;">';

        for (const [cat, amt] of Object.entries(result.details)) {
          html += '<li>' + cat + ' ▶ ' + amt.toLocaleString() + '원</li>';
        }

        html += '</ul></div>';

        document.getElementById("resultBox").innerHTML = html;
      }


      // ✅ 입력칸 추가
      document.getElementById("btnpuls").addEventListener("click", function () {
        const div = document.createElement("div");
        div.classList.add("form-group");

        const label1 = document.createElement("label");
        label1.textContent = "소비영역";

        const select = document.createElement("select");
        select.name = "benefitcategory_id";
        select.required = true;

        const defaultOption = document.createElement("option");
        defaultOption.disabled = true;
        defaultOption.selected = true;
        defaultOption.textContent = "카테고리 선택";
        select.appendChild(defaultOption);

        benefitCategoryList.forEach(item => {
          const option = document.createElement("option");
          option.value = item.benefitcategory_id;
          option.textContent = item.benefitCategory_name || item.benefitcategory_name;
          select.appendChild(option);
        });

        const label2 = document.createElement("label");
        label2.textContent = "소비금액";

        const input = document.createElement("input");
        input.type = "number";
        input.name = "amount";
        input.placeholder = "금액을 입력하세요";
        input.min = "0";

        const span = document.createElement("span");
        span.classList.add("remove");
        span.textContent = "삭제";
        span.addEventListener("click", function () {
          this.parentElement.remove();
        });

        div.appendChild(label1);
        div.appendChild(select);
        div.appendChild(document.createElement("br"));
        div.appendChild(document.createElement("br"));
        div.appendChild(label2);
        div.appendChild(input);
        div.appendChild(span);

        document.getElementById("container").appendChild(div);
      });
    });
  </script>
</body>
</html>
