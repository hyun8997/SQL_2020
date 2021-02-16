--PL/SQL : SQL + ���α׷��� ����
--
--1. Anonymous Block
--2. Procedure
--3. Function
--4. Package
--5. Trigger
--
--Anonymous Blcok �⺻ ����
--DECLARE (����)
--    ���� ����� : ������ ����
--BEGIN (�ʼ�)
--    ����� : ���� ó��
--EXCEPTION (����)
--    ����ó���� : ���ܻ����� ó��
--END (�ʼ�)
--    ����ǥ�ú�
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
--�����ȣ�� �Է¹޾� �ش� ����� �޿� ��� (10% �λ�� ���)
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


--����ڰ� ������ �Լ� ã��
DESC USER_PROCEDURES

SELECT OBJECT_NAME, OBJECT_TYPE
FROM USER_PROCEDURES
WHERE OBJECT_TYPE = 'FUNCTION';


--�Լ� ����
--DROP FUNCTION [�Լ���]

--�ǽ� : 10�� �μ��� �ٹ��ϰ� �ִ� ����� ���, �̸�, �޿��� ��ȸ�Ͻÿ�
--    : �Լ��� - EMP_SAL
--    : �����ȣ�� 7900

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


--�ǽ� : ��ü ����� ���, �̸�, �μ����� ����Ͻÿ�
--    : �־��� �����ʹ� �μ� ��ȣ
--    : �Լ��� = getDname()
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


--��ü ����� �����ȣ, ����̸�, �޿�, ����, ����, ����(10%)�� ��ȸ
CREATE OR REPLACE FUNCTION FULL_SAL 
    (VSAL EMP.SAL%TYPE, VCOMM EMP.COMM%TYPE)
    RETURN NUMBER
    IS
    BEGIN
        RETURN (VSAL*12 + NVL(VCOMM,0));
END;
/
    
SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL(COMM,0) "����", (SAL*12+NVL(COMM,0))*0.1 "����(10%)"
FROM EMP;

SELECT EMPNO, ENAME, SAL, COMM, FULL_SAL(SAL, COMM) "����", FULL_SAL(SAL, COMM)*0.1 "����(10%)"
FROM EMP;


--�ǽ� : ��ü ����� �����ȣ, ����̸�, �޿�, ����, ����, ������ ��ȸ
--    (��, �޿� ���ؿ� ���� ������ �޸� ����)
--    : �޿��� 1000�̸��̸� 5%, 1000�̻�2000�̸� 10%, 2000�̻� 20% ����
--    : ���� ������ ������ ���� ������ �޿���
--      �Լ��� : DIF_TAX
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

SELECT EMPNO, ENAME, SAL, COMM, FULL_SAL(SAL, COMM) "����", DIF_TAX(SAL, COMM) "����"
FROM EMP;







































