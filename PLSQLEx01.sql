--SQL + (프로그래밍) 언어적 성격 => PL/SQL      CF) 오라클 DB에서만 적용
--
--+ 종류
--
--1. Anonymous Block 익명 블록
--2. Proocedure
--3. Function
--4. Package
--5. Trigger

--1. Anonymous Block 기본 형태 (4가지 요소)
--    1) DECLARE      (선택 요소임)
--        변수 선언부 : 변수를 선언
--    2) BEGIN        (필수)
--        실행부 : 로직을 처리
--    3) EXCEPTION    (선택)
--        예외처리부 : 예외사항을 처리
--    4) END          (필수)
--        종료표시부

SET SERVEROUTPUT ON

BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO PL/SQL WORLD');
END;
/
-----------------------------------------------------------
--+ 변수와 상수
--    변수 선언
--    cf) 자료형 변수명     (자바 언어)
--    변수명 자료형         (PL/SQL)
--    
--    ex)
--        emp_empno1  NUMBER(10);
--        grade       CHAR(2);
--
--    변수 선언과 동시에 초기화
--        emp_empno2 NUMBER(2):=10;

--    > %TYPE : 참조할 테이블에 있는 컬럼의 데이터 타입을 자동으로 인식
--    [형식]
--    변수명 테이블명.컬럼명%TYPE;
--    ex)
--    VSAL EMP.SAL%TYPE;
--
--    > %ROWTYPE
--    : %TYPE은 하나의 값에만 적용
--      %ROWTYPE은 하나 이상의 값에 대해 적용
--    
--    [형식]
--    변수명 테이블명%ROWTYPE
    
    > 상수
    emp_emp3 CONSTANT INTEGER:=20;
    : 상수는 반드시 데이터를 할당하여 초기화 해야 함. 그렇지 않으면 오류가 발생
    
DECLARE
    -- 변수 선언부
    -- 변수명 자료형
    VDATA NUMBER;

BEGIN
    -- 실행부
    -- PL/SQL은 := 이 대입연산자, = 은 비교연산자
    VDATA:=10;
    DBMS_OUTPUT.PUT_LINE(VDATA);
END;
/

--문자형 변수에 Hello PL/SQL WOW 문자열을 담고 콘솔에 출력
DECLARE
    WOW CHAR(20);
BEGIN
    WOW:='Hello PL/SQL WOW';
    DBMS_OUTPUT.PUT_LINE(WOW);
END;
/

-- 7900 사원의 사번, 이름, 급여를 구해서 출력해보세요
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE EMPNO=7900;

DECLARE
    VEMPNO NUMBER(4);
    VENAME VARCHAR2(10);
    VSAL NUMBER(7);
BEGIN
    --PL/SQL은 SQL문장이 가진 절차적 성격에 프로그래밍 언어적 성격을 가미한 언어
    --SQL문을 그대로 사용할 수 있음
    SELECT EMPNO, ENAME, SAL INTO VEMPNO, VENAME, VSAL
    FROM EMP
    WHERE EMPNO = 7900;

    DBMS_OUTPUT.PUT_LINE(VEMPNO||'  '||VENAME||'    '||VSAL);
END;
/

-- 입력을 받아서 사원번호, 사원이름, 급여 출력
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE EMPNO = &EMPNO;

ACCEPT VNO PROMPT'검색할 사번 입력:'
DECLARE
    -- 치환변수 : &변수명
    VEMPNO NUMBER(4):=&VNO;
    VENAME VARCHAR2(20);
    VSAL NUMBER(7);
BEGIN
    SELECT ENAME, SAL INTO VENAME, VSAL
    FROM EMP
    WHERE EMPNO = VEMPNO;
    
    DBMS_OUTPUT.PUT_LINE(VEMPNO||'  '||VENAME||'    '||VSAL);
END;
/



















































































