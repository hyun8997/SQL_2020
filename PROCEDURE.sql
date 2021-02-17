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
--    EXCEPTION
--        ���� ó���� (DB���� �������)    
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


--��ü ��� �޿� �λ�(DB �ݿ� ���� ����� Ȯ��)
CREATE OR REPLACE PROCEDURE RAISE_SAL
    (VEMPNO EMP.EMPNO%TYPE, VRATIO NUMBER)
    IS
        VSAL NUMBER(10):=0;
    BEGIN
        SELECT SAL INTO VSAL
        FROM EMP
        WHERE EMPNO = VEMPNO;
        
        VSAL:=VSAL*(1+VRATIO/100);
        DBMS_OUTPUT.PUT_LINE('�λ��� ���� �� : '||VSAL);
        
    END RAISE_SAL;
/

EXECUTE RAISE_SAL(7369, 5);


--��� �޿� ����
CREATE OR REPLACE PROCEDURE DOWN_SAL
    (VEMPNO EMP.EMPNO%TYPE, VRATIO NUMBER)
    IS
        VSAL NUMBER(10):=0;
    BEGIN
        SELECT SAL INTO VSAL
        FROM EMP
        WHERE EMPNO = VEMPNO;
        
        VSAL:=VSAL*(0.8+VRATIO/100);
        DBMS_OUTPUT.PUT_LINE('������ ���� �� : '||VSAL);
    
    END DOWN_SAL;
/

EXECUTE DOWN_SAL(7499, 5);


--����ڰ� ���� ���� ���α׷� �ҽ� Ȯ��
DESC USER_SOURCE

SELECT TEXT FROM USER_SOURCE
WHERE NAME = 'DOWN_SAL';

--DB���� ���� ��� ���
SELECT DBMS_RANDOM.VALUE(1, 10) FROM DEPT;

--�Ҽ��� ó��(ROUND, TRUNC)
SELECT ROUND(DBMS_RANDOM.VALUE(1, 10), 0) FROM DEPT;

SELECT TRUNC(DBMS_RANDOM.VALUE(1, 10), 0) FROM DEPT;


--�ǽ� : 7902 ����� �޿��� ����
--    : 30% Ȯ���� �޿� �λ�, 30% Ȯ���� �޿� ����, 40% Ȯ���� �޿� ����
--    : �Լ��� - LOTTO_SAL
CREATE OR REPLACE PROCEDURE LOTTO_SAL(VEMPNO EMP.EMPNO%TYPE)
    IS
        VCHECK NUMBER:= -1;
    BEGIN
        SELECT TRUNC(DBMS_RANDOM.VALUE(1, 10), 0) INTO VCHECK 
        FROM DUAL;
        
        IF VCHECK IN (3,7,9) THEN
            RAISE_SAL(VEMPNO, 10);
            DBMS_OUTPUT.PUT_LINE('�޿� �λ�');
        ELSIF VCHECK IN (1,5,8) THEN
            DOWN_SAL(VEMPNO, 10);
            DBMS_OUTPUT.PUT_LINE('�޿� ����');
        ELSE
            DBMS_OUTPUT.PUT_LINE('�޿� ����');
        END IF;
    END LOTTO_SAL;
/

EXECUTE LOTTO_SAL(7902);








































