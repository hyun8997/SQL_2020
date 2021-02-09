--SQL + (���α׷���) ����� ���� => PL/SQL      CF) ����Ŭ DB������ ����
--
--+ ����
--
--1. Anonymous Block �͸� ���
--2. Proocedure
--3. Function
--4. Package
--5. Trigger

--1. Anonymous Block �⺻ ���� (4���� ���)
--    1) DECLARE      (���� �����)
--        ���� ����� : ������ ����
--    2) BEGIN        (�ʼ�)
--        ����� : ������ ó��
--    3) EXCEPTION    (����)
--        ����ó���� : ���ܻ����� ó��
--    4) END          (�ʼ�)
--        ����ǥ�ú�

SET SERVEROUTPUT ON

BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO PL/SQL WORLD');
END;
/
-----------------------------------------------------------
--+ ������ ���
--    ���� ����
--    cf) �ڷ��� ������     (�ڹ� ���)
--    ������ �ڷ���         (PL/SQL)
--    
--    ex)
--        emp_empno1  NUMBER(10);
--        grade       CHAR(2);
--
--    ���� ����� ���ÿ� �ʱ�ȭ
--        emp_empno2 NUMBER(2):=10;

--    > %TYPE : ������ ���̺� �ִ� �÷��� ������ Ÿ���� �ڵ����� �ν�
--    [����]
--    ������ ���̺��.�÷���%TYPE;
--    ex)
--    VSAL EMP.SAL%TYPE;
--
--    > %ROWTYPE
--    : %TYPE�� �ϳ��� ������ ����
--      %ROWTYPE�� �ϳ� �̻��� ���� ���� ����
--    
--    [����]
--    ������ ���̺��%ROWTYPE
    
    > ���
    emp_emp3 CONSTANT INTEGER:=20;
    : ����� �ݵ�� �����͸� �Ҵ��Ͽ� �ʱ�ȭ �ؾ� ��. �׷��� ������ ������ �߻�
    
DECLARE
    -- ���� �����
    -- ������ �ڷ���
    VDATA NUMBER;

BEGIN
    -- �����
    -- PL/SQL�� := �� ���Կ�����, = �� �񱳿�����
    VDATA:=10;
    DBMS_OUTPUT.PUT_LINE(VDATA);
END;
/

--������ ������ Hello PL/SQL WOW ���ڿ��� ��� �ֿܼ� ���
DECLARE
    WOW CHAR(20);
BEGIN
    WOW:='Hello PL/SQL WOW';
    DBMS_OUTPUT.PUT_LINE(WOW);
END;
/

-- 7900 ����� ���, �̸�, �޿��� ���ؼ� ����غ�����
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE EMPNO=7900;

DECLARE
    VEMPNO NUMBER(4);
    VENAME VARCHAR2(10);
    VSAL NUMBER(7);
BEGIN
    --PL/SQL�� SQL������ ���� ������ ���ݿ� ���α׷��� ����� ������ ������ ���
    --SQL���� �״�� ����� �� ����
    SELECT EMPNO, ENAME, SAL INTO VEMPNO, VENAME, VSAL
    FROM EMP
    WHERE EMPNO = 7900;

    DBMS_OUTPUT.PUT_LINE(VEMPNO||'  '||VENAME||'    '||VSAL);
END;
/

-- �Է��� �޾Ƽ� �����ȣ, ����̸�, �޿� ���
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE EMPNO = &EMPNO;

ACCEPT VNO PROMPT'�˻��� ��� �Է�:'
DECLARE
    -- ġȯ���� : &������
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



















































































