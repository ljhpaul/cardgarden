#=========================================================================================
-- 테이블 제거
-- 1. 외래키 관계 자식 테이블들부터 DROP
DROP TABLE IF EXISTS UserConsumptionPatternDetail;
DROP TABLE IF EXISTS CardBenefitDetail;
DROP TABLE IF EXISTS BenefitDetail;
DROP TABLE IF EXISTS BenefitCategory;

DROP TABLE IF EXISTS LikeCard;
DROP TABLE IF EXISTS LikeAsset;
DROP TABLE IF EXISTS OwnedAsset;
DROP TABLE IF EXISTS CustomCard;
DROP TABLE IF EXISTS CustomAsset;

DROP TABLE IF EXISTS point_history;

DROP TABLE IF EXISTS UserAgreement;
DROP TABLE IF EXISTS Attendance;
DROP TABLE IF EXISTS WeeklyBonus;
DROP TABLE IF EXISTS MonthlyBonus;

-- 2. 부모 테이블 DROP (UserInfo, Card 등)
DROP TABLE IF EXISTS UserConsumptionPattern;
DROP TABLE IF EXISTS Term;
DROP TABLE IF EXISTS Card;
DROP TABLE IF EXISTS UserInfo;

#=========================================================================================
-- 테이블 생성 및 제약조건 설정
-- 1. 부모 테이블 CREATE
CREATE TABLE UserInfo (
  user_id INT PRIMARY KEY AUTO_INCREMENT COMMENT '회원 고유 ID',
  user_name VARCHAR(50) NOT NULL UNIQUE COMMENT '아이디',
  user_password VARCHAR(255) NOT NULL COMMENT '비밀번호 (암호화 저장)',
  email VARCHAR(100) NOT NULL UNIQUE COMMENT '이메일',
  nickname VARCHAR(30) NOT NULL UNIQUE COMMENT '닉네임',
  name VARCHAR(30) DEFAULT NULL COMMENT '이름',
  gender VARCHAR(10) DEFAULT NULL COMMENT '성별',
  birth DATE DEFAULT NULL COMMENT '생년월일',
  phone VARCHAR(20) NOT NULL COMMENT '전화번호',
  address VARCHAR(200) DEFAULT NULL COMMENT '주소',
  created_at DATE NOT NULL DEFAULT (CURDATE()) COMMENT '가입일',
  point INT DEFAULT 0 COMMENT '보유 포인트 수',
  is_admin VARCHAR(2) DEFAULT 'N' COMMENT '관리자 여부(Y/N-기본값)'
);

alter table userInfo modify column phone VARCHAR(20) NOT NULL COMMENT '전화번호';
alter table userInfo modify column created_at DATE NOT NULL DEFAULT (CURDATE()) COMMENT '가입일';

CREATE TABLE Card (
  card_id INT PRIMARY KEY AUTO_INCREMENT COMMENT '카드 번호',
  card_name VARCHAR(100) NOT NULL COMMENT '카드명',
  company VARCHAR(50) NOT NULL COMMENT '카드회사',
  card_type VARCHAR(10) NOT NULL COMMENT '신용카드, 체크카드',
  brand VARCHAR(20) DEFAULT NULL COMMENT 'visa, master, visa/master, null',
  card_image VARCHAR(255) DEFAULT NULL COMMENT '카드 이미지',
  card_url VARCHAR(255) DEFAULT NULL COMMENT '카드사 바로가기 링크',
  fee_domestic INT DEFAULT 0 COMMENT '국내 연회비',
  fee_foreign INT DEFAULT 0 COMMENT '해외사용시 연회비',
  prev_month_cost VARCHAR(50) DEFAULT NULL COMMENT '전월실적',
  card_like INT DEFAULT 0 COMMENT '카드 좋아요 수',
  card_views INT DEFAULT 0 COMMENT '카드 조회수'
);

CREATE TABLE BenefitCategory (
  benefitcategory_id INT PRIMARY KEY AUTO_INCREMENT COMMENT '대분류 번호',
  benefitcategory_name VARCHAR(50) NOT NULL COMMENT '대분류 이름'
);

CREATE TABLE Term (
  term_id INT PRIMARY KEY AUTO_INCREMENT COMMENT '약관 고유 ID',
  term_name VARCHAR(100) NOT NULL COMMENT '약관 제목',
  term_content TEXT NOT NULL COMMENT '약관 전문',
  is_required VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT '필수 여부(Y/N)',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '약관 등록일'
);

CREATE TABLE CustomAsset (
  asset_id INT PRIMARY KEY AUTO_INCREMENT COMMENT '커스텀 요소 고유 ID',
  asset_brand VARCHAR(50) NOT NULL COMMENT '산리오, 푸드 등 종류',
  asset_type VARCHAR(20) NOT NULL COMMENT 'sticker/background/mascot',
  asset_no INT NOT NULL COMMENT '브랜드타입 내 번호',
  asset_like INT DEFAULT 0 COMMENT '좋아요 수',
  used INT DEFAULT 0 COMMENT '사용 수',
  point_needed INT DEFAULT 0 COMMENT '가격',
  discount INT DEFAULT 0 COMMENT '콜라보 이벤트의 경우 할인가'
);

-- 2. 자식 테이블 CREATE
CREATE TABLE BenefitDetail (
  benefitdetail_id INT PRIMARY KEY AUTO_INCREMENT COMMENT '소분류 id',
  benefitcategory_id INT NOT NULL COMMENT '혜택 대분류 id',
  benefitdetail_name VARCHAR(50) NOT NULL COMMENT '소분류 이름',
  benefitdetail_image VARCHAR(255) DEFAULT NULL COMMENT '혜택 그림',
  FOREIGN KEY (benefitcategory_id) REFERENCES BenefitCategory(benefitcategory_id)
);

CREATE TABLE UserConsumptionPattern (
  pattern_id INT PRIMARY KEY AUTO_INCREMENT COMMENT '소비패턴 고유번호',
  user_id INT NOT NULL COMMENT '회원 고유 ID',
  pattern_name VARCHAR(100) DEFAULT NULL COMMENT '소비패턴명',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '생성일',
  FOREIGN KEY (user_id) REFERENCES UserInfo(user_id)
);

CREATE TABLE CustomCard (
  customcard_id INT PRIMARY KEY AUTO_INCREMENT COMMENT '생성된 커스텀카드1',
  customcard_name VARCHAR(100) DEFAULT NULL COMMENT '커스텀카드 이름',
  user_id INT NOT NULL COMMENT '생성자',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '생성시간',
  FOREIGN KEY (user_id) REFERENCES UserInfo(user_id)
);

CREATE TABLE point_history (
  id INT PRIMARY KEY AUTO_INCREMENT COMMENT '포인트 내역 고유 번호',
  user_id INT NOT NULL COMMENT '회원 번호',
  type VARCHAR(10) NOT NULL COMMENT '내역 유형 (earn/use)',
  amount INT NOT NULL COMMENT '포인트 변동값 (±)',
  description VARCHAR(100) DEFAULT NULL COMMENT '내역 설명',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '발생 일시',
  FOREIGN KEY (user_id) REFERENCES UserInfo(user_id)
);

CREATE TABLE Attendance (
  user_id INT NOT NULL COMMENT '출석한 사용자',
  date DATE NOT NULL COMMENT '출석 날짜',
  PRIMARY KEY (user_id, date),
  FOREIGN KEY (user_id) REFERENCES UserInfo(user_id)
);

CREATE TABLE WeeklyBonus (
  user_id INT NOT NULL COMMENT '사용자',
  week_start DATE NOT NULL COMMENT '그 주 월요일 날짜',
  bonus_given VARCHAR(2) NOT NULL DEFAULT 'Y' COMMENT '이미 지급됐는지 여부',
  PRIMARY KEY (user_id, week_start),
  FOREIGN KEY (user_id) REFERENCES UserInfo(user_id)
);

CREATE TABLE MonthlyBonus (
  user_id INT NOT NULL COMMENT '사용자',
  month_start DATE NOT NULL COMMENT '그 달 시작 날짜',
  bonus_given VARCHAR(2) NOT NULL DEFAULT 'Y' COMMENT '이미 지급됐는지 여부',
  PRIMARY KEY (user_id, month_start),
  FOREIGN KEY (user_id) REFERENCES UserInfo(user_id)
);

-- 3. 관계 및 세부 테이블 CREATE
CREATE TABLE CardBenefitDetail (
  cardbenefitdetail_id INT PRIMARY KEY AUTO_INCREMENT COMMENT 'PK',
  card_id INT NOT NULL COMMENT '카드 id',
  benefitdetail_id INT NOT NULL COMMENT '혜택 소분류 id',
  cardbenefitdetail_text VARCHAR(200) DEFAULT NULL COMMENT '간단 설명',
  cardbenefitdetail_info JSON DEFAULT NULL COMMENT '세부 설명',
  FOREIGN KEY (card_id) REFERENCES Card(card_id) ON DELETE CASCADE,
  FOREIGN KEY (benefitdetail_id) REFERENCES BenefitDetail(benefitdetail_id)
);

CREATE TABLE UserAgreement (
  user_id INT NOT NULL COMMENT '회원 ID',
  term_id INT NOT NULL COMMENT '약관 ID',
  is_agreed VARCHAR(2) NOT NULL DEFAULT 'N' COMMENT '동의 여부(Y/N)'
  PRIMARY KEY (user_id, term_id),
  FOREIGN KEY (user_id) REFERENCES UserInfo(user_id) ON DELETE CASCADE,
  FOREIGN KEY (term_id) REFERENCES Term(term_id)
);

select * from UserAgreement ua ;
alter TABLE UserAgreement drop agreed_at;
alter table UserAgreement DROP agreed_at;
ALTER TABLE UserAgreement
  ADD CONSTRAINT useragreement_ibfk_1
  FOREIGN KEY (user_id) REFERENCES UserInfo(user_id) ON DELETE CASCADE;

ALTER TABLE UserAgreement DROP FOREIGN KEY useragreement_ibfk_1;


CREATE TABLE LikeCard (
  card_id INT NOT NULL COMMENT '좋아요 한 카드 번호',
  user_id INT NOT NULL COMMENT '회원 고유 ID',
  PRIMARY KEY (card_id, user_id),
  FOREIGN KEY (card_id) REFERENCES Card(card_id),
  FOREIGN KEY (user_id) REFERENCES UserInfo(user_id)
);

CREATE TABLE LikeAsset (
  user_id INT NOT NULL COMMENT '누가 좋아요 눌렀는지',
  asset_id INT NOT NULL COMMENT '좋아요 한 스티커',
  PRIMARY KEY (user_id, asset_id),
  FOREIGN KEY (user_id) REFERENCES UserInfo(user_id),
  FOREIGN KEY (asset_id) REFERENCES CustomAsset(asset_id)
);

CREATE TABLE OwnedAsset (
  user_id INT NOT NULL COMMENT '자산을 보유한 사용자',
  asset_id INT NOT NULL COMMENT '가지고 있는 스티커',
  PRIMARY KEY (user_id, asset_id),
  FOREIGN KEY (user_id) REFERENCES UserInfo(user_id),
  FOREIGN KEY (asset_id) REFERENCES CustomAsset(asset_id)
);

CREATE TABLE UserConsumptionPatternDetail (
  pattern_id INT NOT NULL COMMENT '소비패턴 고유번호',
  benefitcategory_id INT NOT NULL COMMENT '혜택 대분류',
  amount INT NOT NULL DEFAULT 0 COMMENT '해당 대분류 소비금액',
  PRIMARY KEY (pattern_id, benefitcategory_id),
  FOREIGN KEY (pattern_id) REFERENCES UserConsumptionPattern(pattern_id),
  FOREIGN KEY (benefitcategory_id) REFERENCES BenefitCategory(benefitcategory_id)
);
#=========================================================================================

-- cardlike 테이블 트리거

CREATE TRIGGER LikeCardTrigger_Insert
AFTER INSERT ON likecard
FOR EACH ROW
BEGIN
    UPDATE Card
    SET card_like = (
        SELECT COUNT(*)
        FROM LikeCard
        WHERE card_id = NEW.card_id
    )
    WHERE card_id = NEW.card_id;
END;

CREATE TRIGGER LikeCardTrigger_Delete
AFTER DELETE ON likecard
FOR EACH ROW
BEGIN
    UPDATE Card
    SET card_like = (
        SELECT COUNT(*)
        FROM LikeCard
        WHERE card_id = OLD.card_id
    )
    WHERE card_id = OLD.card_id;
END;


