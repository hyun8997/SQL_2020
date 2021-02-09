SET SERVEROUTPUT ON

--[���]
--[IF��]
--  - ó�� ������ �Ѱ� �� ���
--    IF ���� THEN
--        ����...;
--    END IF;
--
--  - ó�� ������ �ΰ� �� ���
--    IF ���� THEN
--        ����...;
--    ELSE
--        ����...;
--    END IF;
--
--  - ó�� ������ ������ �� ���
--    IF ����1 THEN
--        ����...;
--    ELSIF ����2 THEN
--        ����...;
--    ...
--    ELSE
--        ����...;
--    END IF;

ACCEPT VNO NUMBER PROMPT'����� ������ �Է��ϼ���:'
SET SERVEROUTPUT ON;
DECLARE
    VSCORE NUMBER:=&VNO;
BEGIN
    IF VSCORE>=90 THEN
        DBMS_OUTPUT.PUT_LINE('A����');
    ELSIF VSCORE>=80 THEN
        DBMS_OUTPUT.PUT_LINE('B����');
    ELSIF VSCORE>=70 THEN
        DBMS_OUTPUT.PUT_LINE('C����');
    ELSIF VSCORE>=60 THEN
        DBMS_OUTPUT.PUT_LINE('D����');
    ELSE
        DBMS_OUTPUT.PUT_LINE('F����');
    END IF;
END;
/

--[CASE ��]
ACCEPT VGRADE PROMPT'����� ������ �Է��ϼ���'     -- ����ǥ �ʼ�
DECLARE
    --GRADE CHAR(1);
    GRADE CHAR(2):=&VGRADE;
BEGIN
    --GRADE:='B';
    CASE GRADE
        WHEN 'A' THEN
            DBMS_OUTPUT.PUT_LINE('�� ���߾��');
        WHEN 'B' THEN
            DBMS_OUTPUT.PUT_LINE('���߾��');
        WHEN 'C' THEN
            DBMS_OUTPUT.PUT_LINE('�ؼ��ؿ�');
        WHEN 'D' THEN
            DBMS_OUTPUT.PUT_LINE('����ϼ���');
        ELSE
            DBMS_OUTPUT.PUT_LINE('���ư�����');
    END CASE;
END;
/
        
------------------------------------------------------
-- �����ȣ�� 7900�� ����� �޿� ������ �ñ�
-- �� ����� �޿��� 3000 �̻��̸� �޿��� ���
-- �޿��� 3000 �����̸� �޿��� �̰��� - ****
DECLARE
    VEMPNO NUMBER:=7900;
    VENAME VARCHAR2(20);
    VSAL NUMBER(4);
BEGIN
    SELECT ENAME, SAL INTO VENAME, VSAL
    FROM EMP
    WHERE EMPNO = VEMPNO;
    
    DBMS_OUTPUT.PUT_LINE('���      '||'�̸�      '||'�޿�');
    IF VSAL>=3000 THEN
        DBMS_OUTPUT.PUT_LINE(VEMPNO||'     '||VENAME||'     '||VSAL);
    ELSE
        DBMS_OUTPUT.PUT_LINE(VEMPNO||'     '||VENAME||'     '||'****');
    END IF;
END;
/

-----------------------------------------------------------------------------
ACCEPT VNO PROMPT'�˻��� ��� �Է�'
DECLARE
--    VEMPNO NUMBER(5):=&VNO;
--    VEMPNO NUMBER(4):=&VNO;
--    VENAME VARCHAR2(20);
--    VSAL NUMBER(7);

--    VEMPNO EMP.EMPNO%TYPE:=&VNO;
--    VENAME EMP.ENAME%TYPE;
--    VSAL  EMP.SAL%TYPE;

    VEMPNO EMP.EMPNO%TYPE:=&VNO;
    VEMP EMP%ROWTYPE;
BEGIN
   -- SELECT EMPNO, ENAME, SAL INTO VEMPNO, VENAME, VSAL
   -- SELECT * INTO VEMPNO, VENAME, VSAL  -- �ϴ� �� �ҷ����� ���� 3���� ����, ������ ���� ��� ��Ī�Ǵ��� ��
    SELECT * INTO VEMP       -- �׷��� 1:1�� �Ǵ� TYPE ��� ���� �������� ROWTYPE ��
    FROM EMP
    WHERE EMPNO = VEMPNO;

    DBMS_OUTPUT.PUT_LINE('=========================');
    --DBMS_OUTPUT.PUT_LINE(VEMP.EMPNO||'     '||VEMP.ENAME||'     '||VEMP.SAL);
    DBMS_OUTPUT.PUT_LINE(VEMP.EMPNO||'     '||VEMP.ENAME||'     '||VEMP.SAL||'     '||VEMP.TEL);
END;
/

-- ����1
-- ���� ȸ�簡 �� �����ؼ� ���� �����ȣ�� 10000 ���� ����
ALTER TABLE EMP
MODIFY EMPNO NUMBER(5); -- �� �� �ڸ����� Ȯ��

INSERT INTO EMP (EMPNO, ENAME, SAL, DEPTNO)
VALUES(10000, 'GOOTT', 500, 10);

-- ����2
-- ȸ�� ������ ������ ����(��ȭ��ȣ �׸� �߰� �� ��� �Ѹ� �� �߰�)
ALTER TABLE EMP
ADD TEL VARCHAR2(16);

INSERT INTO EMP (EMPNO, ENAME, SAL, DEPTNO, TEL)
VALUES (10001,'GOOTT2',600,20,'01011112222');





















































































