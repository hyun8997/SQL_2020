SET SERVEROUTPUT ON;

--+ PL/SQL ���� ���α׷�
-- : PL/SQL ���� ���α׷��� �Ķ���Ϳ� ������ �̸��� ���� PL/SQL ��
-- : �����ͺ��̽� ��ü�� ����
-- : ȣ���Ͽ� ����� ����
-- 
-- : �������� �Լ�(FUNCTION), ���� ���ν���(Stored Procedure)�� ����

--+ �Լ�(FUNCTION)
--    [����]
--    CREATE OR REPLACE FUNCTION �Լ��̸� (parameter)
--        RETURN �ڷ��� IS
--            ���� ����;
--        BEGIN
--            ���� ����;
--        RETURN ����;
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

VARIABLE HI VARCHAR2(30);   -- ������� �����ؾߵ�
EXECUTE :HI :=HELLO;        -- �÷��� �Լ� ����
PRINT HI;                   -- �÷�/���� ���� ��µ�(SELECT�� ����� ��¹��)

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


-- SAL_DESCRIBE : �����ȣ�� �Է��ϸ� �� ����� �޿������� ���
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


-- [�ǽ�] ��ü ����� �޿��� 10% �λ��� ����� ����غ����� (FUNCTION - SAL_UP)
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




























































