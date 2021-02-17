SET SERVEROUTPUT ON

--+ PROCEDURE
--    : 특정 작업을 수행하는, 이름이 있는 PL/SQL BLOCK
--    : 매개 변수를 받을 수 있고, 호출하여 반복적으로 사용할 수 있는 BLOCK
--    : 보통 연속 실행 또는 구현이 복잡한 TRANSACTION을 수행하는 PL/SQL BLOCK
--
--    [형식]
--    CREATE OR REPLACE PROCEDURE [PROCEDURE NAME] (parameter IN 자료형, parameter IN 자료형, ...)
--    IS
--        변수 선언부
--    BEGIN
--        수행 로직
--    EXCEPTION
--        예외 처리부 (DB들어가면 권장사항)    
--    END;
--    /


--사원번호가 10000인 사원의 급여를 10% 인상
CREATE OR REPLACE PROCEDURE UPDATE_SAL(VEMPNO IN NUMBER)
    IS
        BEGIN
            UPDATE CEMP
            SET SAL = SAL * 1.1
            WHERE EMPNO = VEMPNO;
            
            COMMIT; -- TCL TRANSACTION 제어
            
        EXCEPTION
            WHEN OTHERS THEN    -- 에러가 터졌으면 쓰지말고 롤백해라
                ROLLBACK;   
    END UPDATE_SAL;
/

EXECUTE update_sal(10000);


--전체 사원 급여 인상(DB 반영 없이 결과만 확인)
CREATE OR REPLACE PROCEDURE RAISE_SAL
    (VEMPNO EMP.EMPNO%TYPE, VRATIO NUMBER)
    IS
        VSAL NUMBER(10):=0;
    BEGIN
        SELECT SAL INTO VSAL
        FROM EMP
        WHERE EMPNO = VEMPNO;
        
        VSAL:=VSAL*(1+VRATIO/100);
        DBMS_OUTPUT.PUT_LINE('인상율 적용 후 : '||VSAL);
        
    END RAISE_SAL;
/

EXECUTE RAISE_SAL(7369, 5);


--사원 급여 인하
CREATE OR REPLACE PROCEDURE DOWN_SAL
    (VEMPNO EMP.EMPNO%TYPE, VRATIO NUMBER)
    IS
        VSAL NUMBER(10):=0;
    BEGIN
        SELECT SAL INTO VSAL
        FROM EMP
        WHERE EMPNO = VEMPNO;
        
        VSAL:=VSAL*(0.8+VRATIO/100);
        DBMS_OUTPUT.PUT_LINE('인하율 적용 후 : '||VSAL);
    
    END DOWN_SAL;
/

EXECUTE DOWN_SAL(7499, 5);


--사용자가 만든 서브 프로그램 소스 확인
DESC USER_SOURCE

SELECT TEXT FROM USER_SOURCE
WHERE NAME = 'DOWN_SAL';

--DB에서 랜덤 기능 사용
SELECT DBMS_RANDOM.VALUE(1, 10) FROM DEPT;

--소수점 처리(ROUND, TRUNC)
SELECT ROUND(DBMS_RANDOM.VALUE(1, 10), 0) FROM DEPT;

SELECT TRUNC(DBMS_RANDOM.VALUE(1, 10), 0) FROM DEPT;


--실습 : 7902 사원의 급여를 조정
--    : 30% 확률로 급여 인상, 30% 확률로 급여 인하, 40% 확률로 급여 동결
--    : 함수명 - LOTTO_SAL
CREATE OR REPLACE PROCEDURE LOTTO_SAL(VEMPNO EMP.EMPNO%TYPE)
    IS
        VCHECK NUMBER:= -1;
    BEGIN
        SELECT TRUNC(DBMS_RANDOM.VALUE(1, 10), 0) INTO VCHECK 
        FROM DUAL;
        
        IF VCHECK IN (3,7,9) THEN
            RAISE_SAL(VEMPNO, 10);
            DBMS_OUTPUT.PUT_LINE('급여 인상');
        ELSIF VCHECK IN (1,5,8) THEN
            DOWN_SAL(VEMPNO, 10);
            DBMS_OUTPUT.PUT_LINE('급여 인하');
        ELSE
            DBMS_OUTPUT.PUT_LINE('급여 동결');
        END IF;
    END LOTTO_SAL;
/

EXECUTE LOTTO_SAL(7902);








































