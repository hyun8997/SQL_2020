SET SERVEROUTPUT ON;

--+ PL/SQL 서브 프로그램
-- : PL/SQL 서브 프로그램은 파라미터와 고유의 이름을 가진 PL/SQL 블럭
-- : 데이터베이스 객체로 존재
-- : 호출하여 사용할 목적
-- 
-- : 종류에는 함수(FUNCTION), 내장 프로시저(Stored Procedure)가 있음

--+ 함수(FUNCTION)
--    [형식]
--    CREATE OR REPLACE FUNCTION 함수이름 (parameter)
--        RETURN 자료형 IS
--            변수 선언;
--        BEGIN
--            수행 로직;
--        RETURN 변수;
--    END;
--    /


CREATE OR REPLACE FUNCTION HELLO
    RETURN VARCHAR2 IS
        MSG VARCHAR2(30);
    BEGIN
        MSG:='HELLO PL/SQL FUNCTION';
    RETURN MSG;
END;
/

VARIABLE HI VARCHAR2(30);   -- 순서대로 실행해야됨
EXECUTE :HI :=HELLO;        -- 컬럼에 함수 실행
PRINT HI;                   -- 컬럼/내용 으로 출력됨(SELECT와 비슷한 출력방식)

SELECT HELLO FROM DUAL;

-- parameter
CREATE OR REPLACE FUNCTION TAX(P_VALUE IN NUMBER)
    RETURN NUMBER IS
        RESULT NUMBER;
    BEGIN
        RESULT := (P_VALUE*0.1);
    RETURN RESULT;
END;
/

SELECT TAX(800) FROM DUAL;


-- SAL_DESCRIBE : 사원번호를 입력하면 그 사원의 급여정보를 출력
CREATE OR REPLACE FUNCTION SAL_DESCRIBE(VEMPNO IN NUMBER)
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

VAR SALARY NUMBER;
EXECUTE :SALARY := SAL_DESCRIBE(7900);
PRINT SALARY;

SELECT SAL_DESCRIBE(7900) FROM DUAL;

SELECT SAL_DESCRIBE(EMPNO) FROM EMP;


-- [실습] 전체 사원의 급여를 10% 인상한 결과를 출력해보세요 (FUNCTION - SAL_UP)
CREATE OR REPLACE FUNCTION SAL_UP(VEMPNO IN NUMBER)
    RETURN NUMBER 
    IS
        VSAL EMP.SAL%TYPE;
    BEGIN
        SELECT SAL INTO VSAL
        FROM EMP
        WHERE EMPNO = VEMPNO;
    RETURN VSAL*1.1;
END;
/

SELECT SAL_DESCRIBE(EMPNO) AS "SALARY", SAL_UP(EMPNO) AS "SALARY*1.1" FROM EMP;




























































