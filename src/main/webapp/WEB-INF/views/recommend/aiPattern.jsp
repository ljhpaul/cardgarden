<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="cpath" value="${pageContext.servletContext.contextPath}" />

<script>
function openPatternModal() {
  document.getElementById('patternModal').style.display = 'flex';
}
function closePatternModal() {
  document.getElementById('patternModal').style.display = 'none';
}
document.addEventListener('DOMContentLoaded', function() {
  document.querySelectorAll('.pattern-radio').forEach(function(radio) {
    radio.addEventListener('change', function() {
      document.querySelectorAll('.pattern-group').forEach(function(label){
        label.classList.remove('selected');
      });
      if (radio.checked) {
        radio.closest('.pattern-group').classList.add('selected');
      }
    });
    if (radio.checked) {
      radio.closest('.pattern-group').classList.add('selected');
    }
  });
});
</script>

<style>
:root {
  --modal-width: 720px;
  --modal-radius: 24px;
  --modal-header-h: 56px;
  --modal-footer-h: 80px;
}

.pattern-modal-mask {
  display: flex; align-items: center; justify-content: center;
  position: fixed; top: 0; left: 0; width: 100vw; height: 100vh;
  background: rgba(0, 0, 0, 0.40);
  z-index: 9999;
}
.pattern-modal-content {
  width: 98vw; max-width: var(--modal-width);
  height: 85vh; /* ! 중요: 고정 높이 */
  background: #fff;
  border-radius: var(--modal-radius);
  box-shadow: 0 4px 18px rgba(0,0,0,0.14);
  display: flex;
  flex-direction: column;
  position: relative;
  overflow: hidden;
}
.pattern-modal-header {
  height: var(--modal-header-h);
  min-height: var(--modal-header-h);
  display: grid;
  grid-template-columns: 1fr auto;
  align-items: center;
  justify-content: center;
  padding: 0 20px;
  background: transparent;
  z-index: 2;
  flex-shrink: 0;
  position: relative;
}
/* .pattern-modal-header {
  height: var(--modal-header-h);
  min-height: var(--modal-header-h);
  display: flex;
  align-items: center;
  justify-content: flex-end;
  padding: 0 20px;
  background: transparent;
  z-index: 2;
  flex-shrink: 0;
} */
.pattern-close-button {
  font-size: 28px;
  border: none; background: none; cursor: pointer;
  line-height: 1;
  padding: 0 2px;
  justify-self: end;      /* 우측 정렬 (grid라면 필요) */
}
.pattern-close-button:hover { color: #d33; }

.model-center-scroll-wrap {
  flex: 1 1 0%;
  min-height: 0;
  position: relative;
  display: flex;
  flex-direction: column;
}
.model-center {
  flex: 1 1 0%;
  min-height: 0;
  overflow-y: auto;
  padding: 0 30px;
  position: relative;
  background: transparent;
  margin-top: 36px;
}
.pattern-container {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 20px;
  width: 100%;
  padding: 12px 0 12px 0;
  margin: 0 auto;
  background: none;
  box-shadow: none;
  border: none;
  max-width: 620px;
}
.pattern-group {
  position: relative;
  cursor: pointer;
  border: 2px solid #A5D6C6;
  border-radius: 20px;
  box-shadow: 0 2px 10px rgba(143,176,152,0.08);
  background: #f9fffa;
  padding: 16px 18px 12px 18px;
  display: flex;
  flex-direction: column;
  gap: 7px;
  min-width: 180px;
  max-width: 100%;
  margin-bottom: 18px;
  transition: border-color 0.22s, box-shadow 0.22s, background 0.22s;
}
.pattern-group:hover {
  border-color: #59A985;
  background: #F8FBF8;
  box-shadow: 0 6px 24px 0 rgba(143,176,152,0.14);
}
.pattern-group.selected {
  border-color: #59A985 !important;
  background: #F1F5EB;
  box-shadow:
    0 0 0 0.4px #59A985,
    0 6px 28px 0 rgba(255,184,74,0.12),
    0 3px 18px rgba(143,176,152,0.16);
}
.pattern-radio {
  position: absolute;
  opacity: 0;
  pointer-events: none;
  width: 0; height: 0;
  margin: 0; padding: 0;
}
.pattern-title {
  font-weight: bold;
  font-size: 16px;
  color: #59A985;
  margin-bottom: 8px;
  display: flex;
  align-items: center;
  gap: 8px;
}
.pattern-title .pattern-id {
  font-size: 13px; color:#bbb; margin-left:8px;
}
.benefit-row {
  padding: 7px 0 7px 12px;
  border-left: 4px solid #59A985;
  margin-bottom: 6px;
  background: #fff;
  border-radius: 5px;
  font-size: 14px;
  color: #495957;
}
.pattern-submit-container {
  height: var(--modal-footer-h);
  min-height: 0;
  background: #fff;
  border-bottom-left-radius: var(--modal-radius);
  border-bottom-right-radius: var(--modal-radius);
  box-shadow: 0 -2px 12px rgba(143,176,152,0.06);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 2;
  flex-shrink: 0;
}
.btn {
  border-radius: 10px;
  box-shadow: 0 2px 16px rgba(100,130,120,0.08);
  background: var(--m1,#9ABFA7);
  color: #fff;
  border: none;
  font-size: 17px;
  font-weight: bold;
  padding: 13px 36px;
  transition: background 0.2s;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
}
.btn:hover {
  background: var(--m3,#49615A);
  box-shadow: 0 3px 24px rgba(84, 118, 106, 0.142);
}
.btn:disabled, .btn:disabled:hover {
  background: #eee;
  color: #aaa;
  cursor: not-allowed;
}

.modal-fade-blur {
  position: absolute;
  left: 0; right: 0;
  height: 56px;
  pointer-events: none;
  z-index: 2;
}
.modal-fade-blur.top {
  top: 0;
  border-top-left-radius: var(--modal-radius);
  border-top-right-radius: var(--modal-radius);
  background: linear-gradient(
    to bottom,
    #fff 70%,
    rgba(255,255,255,0.01) 100%
  );
}
.modal-fade-blur.bottom {
  bottom: 0;
  border-bottom-left-radius: var(--modal-radius);
  border-bottom-right-radius: var(--modal-radius);
  background: linear-gradient(
    to bottom,
    rgba(255,255,255,0.01) 0%,
    #fff 100%
  );
}
@media (max-width: 650px) {
  .pattern-modal-content { max-width: 99vw; }
  .pattern-container { grid-template-columns: 1fr; }
  .model-center { padding: 0 10px; }
}
.modal-fade-blur.top, .modal-fade-blur.bottom {
  left: 0; right: 0;
  margin-left: 2px; margin-right: 16px; /* 스크롤바 만큼 여백, 값 조절 가능 */
}
.header-title {
  justify-self: center;
  letter-spacing: 0.02em;
  font-size: 2.3rem;
  font-weight: 700;
  color: var(--m1);
  margin-top: 20px;
  margin-left: 26px;
}
</style>

<!-- 모달 -->
<div class="pattern-modal-mask" id="patternModal" style="display:flex;">
  <div class="pattern-modal-content">
    <div class="pattern-modal-header">
      <span class="header-title">소비패턴 선택</span>
      <button type="button" class="pattern-close-button" onclick="closePatternModal()">×</button>
      
    </div>
    <form method="get" action="${cpath}/card/detail" style="display:flex; flex-direction:column; flex:1 1 0%; min-height:0;">
      <input type="hidden" name="cardid" value="${cardid}" />
      <div class="model-center-scroll-wrap">
        <div class="modal-fade-blur top"></div>
        <div class="model-center">
          <c:choose>
            <c:when test="${not empty patternList}">
              <div class="pattern-container">
                <c:forEach var="entry" items="${patternList}">
                  <label class="pattern-group">
                    <input type="radio" class="pattern-radio" name="patternId"
                           value="${entry.key}" autocomplete="off">
                    <div class="pattern-title">
                      <c:if test="${not empty entry.value}">
                        ${entry.value[0].pattern.pattern_name}
                      </c:if>
                      <span class="pattern-id">(ID: ${entry.key})</span>
                    </div>
                    <c:forEach var="dto" items="${entry.value}">
                      <div class="benefit-row">
                        ${dto.category.benefitCategory_name} :
                        <b><fmt:formatNumber value="${dto.detail.amount}" type="number" /></b> 원
                      </div>
                    </c:forEach>
                  </label>
                </c:forEach>
              </div>
            </c:when>
            <c:otherwise>
              <div class="no-pattern-message" style="text-align:center;">
                <p>아직 등록된 소비 패턴이 없습니다.</p>
                <a href="${cpath}/ConsumptionPattern/inCon?cardid=${cardid}" class="btn">패턴 입력하러 가기</a>
              </div>
            </c:otherwise>
          </c:choose>
        </div>
        <div class="modal-fade-blur bottom"></div>
      </div>
      <div class="pattern-submit-container">
        <input type="submit" value="제출하기" class="btn" />
      </div>
    </form>
  </div>
</div>
