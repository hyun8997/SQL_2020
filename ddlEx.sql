--[ DDL (Data Definition Language) ] : 데이터 정의어

-- + 데이터베이스 주요 객체
-- 테이블 : 데이터를 저장
-- 뷰       : 하나 이상의 테이블에 있는 데이터의 부분 집합
-- 시퀀스 : 숫자 값을 생성
-- 인덱스 : 일부 질의 성능을 향상
-- 동의어 : 객체에 다른 이름을 부여

-- + 테이블 이름 지정 규칙
-- 1.	A-Z, a-z, 0-9, _ , $, # 사용 가능
-- 2.	첫글자 => 영문자
-- 3.	예약어 ( DB에서 약속해 놓은 문자들 ) 사용 X
-- 4.	이름은 의미 있게 생성할 것 

-- 1) 테이블 생성
-- : 테이블 생성하려면 유저(개발자)는 CREATE TABLE 권한이 있어야 하며 객체를 생성할 저장 영역이 있어야 한다.
-- : DBA(데이터 베이스 관리자)는 DCL(데이터 제어문)문을 사용하여 유저에게 권한을 부여함

CREATE TABLE COPY_EMP2
(EMPNO NUMBER(4),       -- 사번 9999 까지
ENAME VARCHAR(20),      -- 이름 최대 20자 
JOB CHAR(20),              
SAL NUMBER(7, 2),            -- 7자리, 소숫점 아래 2자리 까지
HIREDATE DATE);               -- 날짜는 형식이 딱 정해져 있음

 --> CHAR는 최대 2000자 받을 수 있다.
 --> VARCHAR 최대 4000자 =>VARCHAR2, 개량형이며 알아서 바꿔 줌
 --> LONG 타입: 2G 텍스트
 --> LONG RAW: 2G 이미지
 --> LOB, CLOB, BLOB, BFILE: 4G
 
DESC COPY_EMP2;
SELECT * FROM COPY_EMP2;

CREATE TABLE BIGDATA1
(D1 LONG, D2 LONG RAW);  --> another LONG column may not be added until the unused columns are dropped.

CREATE TABLE BIGDATA2
(D1 LONG, D2 BLOB, D3 BFILE);

-- 테이블 생성 시 서브쿼리 사용 가능
CREATE TABLE EMPS
AS
SELECT * FROM EMP;

SELECT * FROM EMPS;

-- 문제 : COPY_EMP3 테이블 생성
--          다만 이 테이블은 EMP 테이블과 동일한 구조를 갖지만 데이터는 하나도 없는 테이블
CREATE TABLE COPY_EMP3
AS
SELECT * FROM EMP
WHERE EMPNO = 9999; -- WHERE 조건자는 일치하는게 없으면 데이터를 돌려주지 않음. 에러 아님

SELECT * FROM COPY_EMP3;

-- INSERT 구문도 서브쿼리 사용 가능
INSERT INTO COPY_EMP3
SELECT * FROM EMP;

SELECT * FROM COPY_EMP3;

-- 2)	테이블 구조 변경: ALTER TABLE 구문
-- 테이블에 컬럼 추가

ALTER TABLE EMPS
ADD HP VARCHAR(10);

SELECT * FROM EMPS;

-- 테이블에 컬럼명 변경
ALTER TABLE EMPS
RENAME COLUMN HP TO MP;

-- 테이블 컬럼 정의 수정
ALTER TABLE EMPS
MODIFY MP VARCHAR(15);

-- 테이블에 컬럼 삭제
ALTER TABLE EMPS
DROP COLUMN MP;

-- 읽기 전용 테이블
-- : READ ONLY 구문을 지정하여 테이블을 읽기 전용 모드로 둘 수 있음
-- : READ ONLY 모드이면 테이블에 영향을 주는 DML문 실행 불가능
-- : 테이블의 데이터를 수정하지 않는 DDL문 실행할 수 있음

ALTER TABLE EMPS READ ONLY;

INSERT INTO EMPS (EMPNO)
VALUES(9999);

-- 읽기 전용 모드 해제
ALTER TABLE EMPS READ WRITE;

-- 3)	테이블 삭제: DROP TABLE 구문
DROP TABLE EMPS; 

DESC EMPS

-- 테이블 복구(일종의 백업)
-- : DROP 하면 윈도우처럼 DBMS도 RECYCLE BIN(일종의 휴지통)으로 들어가게 됨
SHOW RECYCLEBIN;

FLASHBACK TABLE EMPS
TO BEFORE DROP;

DROP TABLE EMPS;
SHOW RECYCLEBIN;

-- 휴지통 비우기
PURGE RECYCLEBIN;

-- cf) DROP TABLE EMPS PURGE : 휴지통을 거치지 않고 바로 삭제 가능 (사용 시 주의 필요)
-- cf) DELETE 구문은 테이블의 ROW들을 지워주는 명령어
--      DROP 구문은 테이블을 삭제하는 명령어
--      TRUNCATE 구문은 테이블의 ROW들을 지워주는 명령어 -  DELETE와 달리 ROLLBACK이 안되므로 더 빨리 삭제 가능
--       WHERE 절 사용 X => 부분 삭제가 안됨
-- cf) 읽기 전용 모드인 테이블을 삭제할 수 있음. DROP명령은 데이터 딕셔너리에서만 실행되므로 
--      테이블 내용에 엑세스 할 필요가 없기 때문.

-- 4)	테이블 이름 변경
RENAME COPY_EMP2
TO EMPS;

SELECT * FROM EMPS;

-- 5)	테이블에 주석 달기
COMMENT ON TABLE EMPS
IS 'EMPOYEE TABLE';

-- 주석은 Data Dictionary에서 확인할 수 있음
DESC USER_TAB_COMMENTS

SELECT * FROM USER_TAB_COMMENTS;

----------------------------------------------------------------------------------------------------------------------------------
-- + DDL 성질
-- 1. 동시성
-- : 동시 공유
-- : 동시성 제어 - 트랜잭션 (commit, rollback, savepoint) ex) 은행 계좌이체

-- 2. 무결성
-- : 무결성을 만족시키려면 DDL, DML 문을 사용할 때 테이블 조건을 만족할 때만 실행될 수 있도록 하면 됨
-- 제약조건: 
--	1) Primary key: 필수 권장사항, 전체 컬럼중에 하나만 가능, 2개를 조합해서 PRIMARYKEY 처럼 쓸수는 있다
--	2) NOT NULL
--	3) CHECK
--	4) UNIQUE
--	5) FOREIGN KEY

--ex) EMP, DEPT 테이블  -> 만들때 설정, 아래의 조건들에 만족해야 DDL, DML 실행되도록 (무결성 보장)
-- EMPNO : NULL(X), 중복 X           - PRIMARY KEY
-- ENAME : NULL(X), 중복 O(동명이인)  - NOT NULL
-- SAL    : 0 보다는 커야 한다.       - CHECK(0이라는 기준점)
-- DEPTNO : 부서테이블 중 하나        - FOREIGN KEY

-- DEPTNO : NULL(X), 중복 X		- PRIMARY KEY
-- DNAME : 중복 X, 고유			- UNIQUE
--> 이 모든 조건들은 테이블을 설계할 때 정해놔야 한다. 중요!
----------------------------------------------------------------------------------------------------------------------------------
-- + 제약 조건 정의
-- (권장) 제약명을 생략하면 SYS_C숫자 형으로 랜덤으로 정해지므로 직접 정하는걸 권장함.

-- 1) 집합레벨 정의 방식
-- : 컬럼명 DATATYPE [ CONSTRAINT 제약명 ] 제약 종류

CREATE TABLE DEPT1
(DEPTNO NUMBER(2) PRIMARY KEY,
 DNAME VARCHAR2(20) UNIQUE,
 LOC VARCHAR2(20));  -- LOC는 제약조건 딱히 필요 없어서 안씀

DESC DEPT1;  -- NOT NULL DEPTNO에 걸려있는것 확인

-- 2) 테이블 레벨 정의 방식
-- : 컬럼명 DATATYPE,
--   컬럼명 DATATYPE,
--   컬럼명 DATATYPE,
--   CONSTRAINT 제약명 제약종류 (컬럼명),
--   CONSTRAINT 제약명 제약종류 (컬럼명),
--   CONSTRAINT 제약명 제약종류 (컬럼명)

CREATE TABLE EMP1
(EMPNO NUMBER(4) CONSTRAINT EMP1_EMPNO_PK PRIMARY KEY,  -- 이름까지 적어주는게 권장 사항
 ENAME VARCHAR2(20) NOT NULL,
 SAL NUMBER(7, 2),
 DEPTNO NUMBER(2),
 CONSTRAINT EMP1_SAL_CK CHECK (SAL BETWEEN 500 AND 5000),
 CONSTRAINT EMP1_DEPTNO_FK FOREIGN KEY (DEPTNO) REFERENCES DEPT1(DEPTNO)); -- 레퍼런스를 바로 거는건 권장하진 않는다.

DESC EMP1;  -- PRIMARY KEY랑 NOT NULL 제약건거에 NOT NULL걸린거 볼수 있음

INSERT INTO DEPT1
VALUES (1, '영업', '서울');
                                                                 
INSERT INTO DEPT1
VALUES (1, '회계', '부산');  -- violated(위배), 유니크하지 못하다. => 조건을 만족하지 않아서 데이터 자체를 업데이트 하지 않음

INSERT INTO DEPT1
VALUES (2, '회계', '부산');  -- 정상 삽입

INSERT INTO EMP1
VALUES (1111, 'HONG', 3000, 3);  -- violated, (SCOTT.EMP1_DEPTNO_PK)제약X: parent key not found => 현재 DEPT1에 3번 부서가 없음

INSERT INTO EMP1
VALUES (1111, 'HONG', 3000, 1);  -- 정상 삽입

INSERT INTO EMP1
VALUES (2222, 'YU', 6000, 2);  -- violated, (SCOTT.EMP1_SAL_CK)의 500~5000 외의 SAL이라서

INSERT INTO DEPT1
VALUES (3, '회계', '대전');  -- violated, UNIQUE 조건에 '회계' 중복

-- DEPT1 테이블 LOC 컬럼에 UNIQUE 제약을 부여, 추가
ALTER TABLE DEPT1 
ADD CONSTRAINT DEPT1_LOC_UQ UNIQUE(LOC);

INSERT INTO DEPT1
VALUES (3, '리서치', '부산');  -- violated, DEPT1_LOC_UQ 조건(UNIQUE)에 '부산' 중복 

-- DESC: 컬럼명, 널?, 데이터유형 만 보여줌, 데이터 제약 볼 수 없음
-- 제약 조건 조회 : DATA DICTIONARY를 통해 조회
DESC USER_CONSTRAINTS;  

SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN (EMP1, DEPT1);   -- 방금 만든 테이블들의 제약 조건 조회

-- 제약조건 삭제
ALTER TABLE DEPT1
DROP CONSTRAINT DEPT1_LOC_UQ;










































































































































































































































