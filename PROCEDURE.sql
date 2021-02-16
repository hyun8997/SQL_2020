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














































