SET SERVEROUTPUT ON

--+ PROCEDURE
--    : Ư�� �۾��� �����ϴ�, �̸��� �ִ� PL/SQL BLOCK
--    : �Ű� ������ ���� �� �ְ�, ȣ���Ͽ� �ݺ������� ����� �� �ִ� BLOCK
--    : ���� ���� ���� �Ǵ� ������ ������ TRANSACTION�� �����ϴ� PL/SQL BLOCK
--
--    [����]
--    CREATE OR REPLACE PROCEDURE [PROCEDURE NAME] (parameter IN �ڷ���, parameter IN �ڷ���, ...)
--    IS
--        ���� �����
--    BEGIN
--        ���� ����
--    END;
--    /


--�����ȣ�� 10000�� ����� �޿��� 10% �λ�
CREATE OR REPLACE PROCEDURE UPDATE_SAL(VEMPNO IN NUMBER)
    IS
        BEGIN
            UPDATE CEMP
            SET SAL = SAL * 1.1
            WHERE EMPNO = VEMPNO;
            
            COMMIT; -- TCL TRANSACTION ����
            
        EXCEPTION
            WHEN OTHERS THEN    -- ������ �������� �������� �ѹ��ض�
                ROLLBACK;   
    END UPDATE_SAL;
/

EXECUTE update_sal(10000);














































