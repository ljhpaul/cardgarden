# cardgarden

## 💡 Branch 전략

- main/master: 배포/운영 브랜치
- develop: 통합(기본) 브랜치
- feature/기능명-세부기능명-담당자: 개별 기능 개발 브랜치('-'로 연결)
  담당 기능 안에서의 merge는 자율적으로 하되 전체 통합시 merge는 담당자가 진행
  - 회원관련	[feature/auth]
    - 로그인	[feature/auth-login]
  - 마이페이지	[feature/mypage]
  - 카드관련	[feature/card]
    - 카드조회	[feature/card-search-condition]
    - 카드검색	[feature/card-search-keyword]
      - 각자가 세부 브랜치 파서 진행, merge는 협업자의 승인 하에
    - 카드상세보기	[feature/card-detail]
  - 이벤트		[feature/event]
  - 커스터마이징	[feature/card-customizing]
  - 공통 UI	[feature/ui-header]

- hotfix/버그명: 긴급 수정 브랜치
- docs/문서명: 문서/규칙/README 등 관리용


## 💡 코드리뷰/PR 방법

- 1. [develop]를 pull한 후 각자의 기능에 해당하는 branch 생성 (ex. [develop] → [feature/card])
- 2. 기능브랜치 → 세부기능브랜치 까지 쭉 생성 : [feature/기능명-세부기능명]
- 2. 각자 [feature/기능명-세부기능명]에서 개발
- 3. PR(Pull Request) 작성 시, 리뷰어 지정 및 변경내용/테스트 방법 명시
- 4. 리뷰 후 [feature/기능명]에 merge
- 5. 최종 통합시 [develop]에 각 기능별 브랜치를 총괄 담당자가 merge


## 💡 커밋 메시지 규칙

- [타입]: 내용 (영문 또는 한글)
- 타입 예시:
	feat(기능: 새로운 기능 추가), 
	fix(버그: 버그 수정), 
	docs(문서: 문서, README, 주석 등 변경), 
	style(스타일: 코드 스타일, 포맷팅, 세미콜론 누락, 들여쓰기 등 변경), 
	refactor(리팩토링: 코드 리팩토링 (기능 변화 없음)), 
	test(테스트: 테스트 코드 추가/수정), 
	chore(기타: 빌드 작업, 패키지 관리 등),
	perf(성능: 성능 개선 관련), 
	revert(되돌리기), 
	merge(병합: 브랜치 병합) 
- 예시:  
  - feat: 회원가입 페이지 추가
  - feat: 카드 추천 로직 도입
  - fix: 로그인 시 세션 만료 오류 해결
  - fix: 마이페이지 카드 목록 중복 표시 버그 수정
  - docs: ERD 설계서 업데이트
  - style: 코드 포맷 일관성 적용
  - style: css 파일 정렬
  - style: 변수명 네이밍 규칙 적용
  - refactor: 중복 코드 함수로 분리
  - refactor: 로그인 로직 구조 개선
  - refactor: DAO에서 Service로 로직 이동
  - test: 회원가입 유효성 검사 테스트 구현
  - test: 카드 추천 서비스 통합 테스트
  - chore: .gitignore 파일 수정
  - chore: gradle 의존성 추가
