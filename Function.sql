--PL/SQL : SQL + 프로그래밍 성격
--
--1. Anonymous Block
--2. Procedure
--3. Function
--4. Package
--5. Trigger
--
--Anonymous Blcok 기본 구조
--DECLARE (선택)
--    변수 선언부 : 변수를 선언
--BEGIN (필수)
--    실행부 : 로직 처리
--EXCEPTION (선택)
--    예외처리부 : 예외사항을 처리
--END (필수)
--    종료표시부
--/

SET SERVEROUTPUT ON

DECLARE
    COUNTER INTEGER;
BEGIN
    COUNTER := COUNTER + 1;
    IF COUNTER IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('COUNTER IS NULL');
    ELSE
        DBMS_OUTPUT.PUT_LINE('COUNTER ' || COUNTER);
    END IF;
END;
/


DECLARE
    COUNTER INTEGER;
    I INTEGER;
BEGIN
    FOR I IN 1..9 LOOP
        COUNTER := (2*I);
        DBMS_OUTPUT.PUT_LINE('2 * ' || I || ' = ' || COUNTER);
    END LOOP;
END;
/


CREATE OR REPLACE FUNCTION HELLO
    RETURN VARCHAR2 IS
        MSG VARCHAR2(30);
    BEGIN
        MSG := 'HELLO PL/SQL';
    RETURN MSG;
END;
/

VARIABLE HI VARCHAR2(30);
EXECUTE :HI := HELLO;
PRINT HI;

--------------------------------------------------------------------------------
--CREATE TABLE CEMP
--AS
--SELECT * FROM EMP;

--------------------------------------------------------------------------------
--사원번호를 입력받아 해당 사원의 급여 출력 (10% 인상된 결과)
CREATE OR REPLACE FUNCTION CEMP_UP(VEMPNO IN NUMBER)
    RETURN NUMBER
    IS
        VSAL CEMP.SAL%TYPE;
    BEGIN
        UPDATE CEMP
        SET SAL = SAL*1.1
        WHERE EMPNO = VEMPNO;
        
        COMMIT;
        
        SELECT SAL INTO VSAL
        FROM CEMP
        WHERE EMPNO = VEMPNO;
    RETURN VSAL;
END;
/

VARIABLE SALARY NUMBER;
EXECUTE :SALARY := CEMP_UP(10000);
PRINT SALARY;


VARIABLE SALARY2 NUMBER;
EXECUTE :SALARY2 := CEMP_UP(10001);
PRINT SALARY2;


--사용자가 생성한 함수 찾기
DESC USER_PROCEDURES

SELECT OBJECT_NAME, OBJECT_TYPE
FROM USER_PROCEDURES
WHERE OBJECT_TYPE = 'FUNCTION';


--함수 삭제
--DROP FUNCTION [함수명]

--실습 : 10번 부서에 근무하고 있는 사원의 사번, 이름, 급여를 조회하시오
--    : 함수명 - EMP_SAL
--    : 사원번호는 7900

CREATE OR REPLACE FUNCTION EMP_SAL (VEMPNO IN NUMBER)
    RETURN NUMBER
    IS
        VSAL EMP.SAL%TYPE;
    BEGIN
        SELECT SAL INTO VSAL
        FROM EMP
        WHERE EMPNO = VEMPNO;
    RETURN VSAL;
END;
/

--VARIABLE SALARY3 NUMBER;
--EXECUTE :SALARY3 := EMP_SAL(7900);
--PRINT SALARY3;

SELECT EMPNO, ENAME, EMP_SAL(EMPNO)
FROM EMP
WHERE DEPTNO = 10;


--실습 : 전체 사원의 사번, 이름, 부서명을 출력하시오
--    : 주어진 데이터는 부서 번호
--    : 함수명 = getDname()
create or replace function getDname(vdeptno EMP.DEPTNO%TYPE)
    return varchar2
    is
        vdname VARCHAR2(30);
    begin
        select dname into vdname
        from dept
        where deptno = vdeptno;
    return vdname;
end;
/

SELECT EMPNO, ENAME, getDname(DEPTNO)
FROM EMP;


--전체 사원의 사원번호, 사원이름, 급여, 수당, 연봉, 세금(10%)를 조회
CREATE OR REPLACE FUNCTION FULL_SAL 
    (VSAL EMP.SAL%TYPE, VCOMM EMP.COMM%TYPE)
    RETURN NUMBER
    IS
    BEGIN
        RETURN (VSAL*12 + NVL(VCOMM,0));
END;
/
    
SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL(COMM,0) "연봉", (SAL*12+NVL(COMM,0))*0.1 "세금(10%)"
FROM EMP;

SELECT EMPNO, ENAME, SAL, COMM, FULL_SAL(SAL, COMM) "연봉", FULL_SAL(SAL, COMM)*0.1 "세금(10%)"
FROM EMP;


--실습 : 전체 사원의 사원번호, 사원이름, 급여, 수당, 연봉, 세금을 조회
--    (단, 급여 수준에 따라 세율을 달리 적용)
--    : 급여가 1000미만이면 5%, 1000이상2000미만 10%, 2000이상 20% 적용
--    : 세금 적용은 연봉에 적용 구분은 급여로
--      함수명 : DIF_TAX
CREATE OR REPLACE FUNCTION DIF_TAX(VSAL EMP.SAL%TYPE, VCOMM EMP.COMM%TYPE)
    RETURN NUMBER
    IS
        RSUM NUMBER;
        RTAX NUMBER;
    BEGIN
        RSUM := VSAL*12 + NVL(VCOMM, 0);
        IF VSAL<1000 THEN
            RTAX := RSUM * 0.05;
        ELSIF VSAL<2000 THEN
            RTAX := RSUM * 0.1;
        ELSE
            RTAX := RSUM * 0.2;
        END IF;
    RETURN RTAX;
END;
/

SELECT EMPNO, ENAME, SAL, COMM, FULL_SAL(SAL, COMM) "연봉", DIF_TAX(SAL, COMM) "세금"
FROM EMP;







































