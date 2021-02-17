SET SERVEROUTPUT ON

--+ TRIGGER
--    : INSERT, UPDATE, DELETE ���� TABLE�� ���� ������ �� ���������� ����Ǵ� PROCEDURE
--    : ���̺���� ������ ��ü (������ DATABASE�� ����)
--    : VIEW�� ���ؼ��� �ƴ϶� TABLE�� ���ؼ��� ������ �� �ִ�.
--    : �̺�Ʈ�� ����Ǹ� �ڵ����� ����Ǵ� �� (�Ͻ��� ����)
--    
--    - �� Ʈ���� : �÷��� �� ���� ������ �� ��ȭ�� ���� ������ ����Ǹ�, �� ������ ���� �������� ������ �� ����
--    
--    - ���� Ʈ���� : Ʈ���� �̺�Ʈ�� ���� �� �ѹ� ����, �÷��� �� ���������� ������ �� ����
--    
--    [����]
--    CREATE OR REPLACE TRIGGER [TRIGGER NAME]
--        BEFORE|AFTER    (BEFORE : DML�� ����Ǳ� ��, AFTER : DML�� ���� �� ��)
--        [TRIGGER EVENT] ON [TABLE NAME]
--
--        [FOR EACH ROW]  {�� Ʈ����}
--        [WHEN CONDITION]

CREATE TABLE COPY_DEPT
AS
SELECT * FROM DEPT;

CREATE OR REPLACE TRIGGER TRIGGER_EX
    BEFORE
        UPDATE ON COPY_DEPT
        FOR EACH ROW
            BEGIN
                DBMS_OUTPUT.PUT_LINE('���� �� �μ��̸� ��: '|| :OLD.DNAME);
                DBMS_OUTPUT.PUT_LINE('���� �� �μ��̸� ��: '|| :NEW.DNAME);
    END;
/

UPDATE COPY_DEPT
SET DNAME = '����1'
WHERE DEPTNO = 10;


CREATE OR REPLACE TRIGGER AVG_TRIGGER
    BEFORE                          -- �̺�Ʈ�� �Ͼ �� INSERT ���� ������ ���� ������ �����ض�
        INSERT OR UPDATE ON CEMP
        FOR EACH ROW
            DECLARE
                AVG_SAL NUMBER;
            BEGIN
                SELECT ROUND(AVG(SAL), 2) INTO AVG_SAL
                FROM CEMP;
                
                DBMS_OUTPUT.PUT_LINE('��� �޿� ���: '||AVG_SAL);
    END;
/

INSERT INTO CEMP (EMPNO, ENAME, SAL)
VALUES (8888, 'HONG', 10000);           --��� 1879.79 (��)
            
SELECT ROUND(AVG(SAL),2)
FROM CEMP;                              --��� 2421.14 (��)


--DEPT ���̺� ���� ������ CDEPT ���̺��� ���� ���� �ϰ� ����
CREATE TABLE CDEPT
AS
SELECT * FROM DEPT;

CREATE OR REPLACE TRIGGER INS_DEPT
    AFTER
        INSERT ON DEPT
        FOR EACH ROW
--            ���� ����
--            1. �����̺��� ��ȭ�� �ִ� �κ��� ��������
--            2. ���� �Ҵ�: ��ȭ�� �ִ� �÷� �� ��ŭ �Ҵ�(�������� ����)
--            3. �ٸ� ���̺� ���� �ֱ�
--            : TRIGGER�� �˾Ƽ� �ڵ����� ������ ��
        BEGIN
--            DB���� �����̺� �ֱٿ� �Է��� ���� �������� (TRIGGER�� �ڵ����� �ν�)
--            �����ڴ� ���� ������ ���� ������ ó���ϸ� ��
            INSERT INTO CDEPT
            VALUES (:NEW.DEPTNO, :NEW.DNAME, :NEW.LOC);
        END;
/

INSERT INTO DEPT
VALUES (99,'A','B');    --INSERT �� COMMIT�ϱ�

SELECT * FROM DEPT
UNION ALL
SELECT * FROM CDEPT;


CREATE OR REPLACE TRIGGER UPDATE_DEPT
    AFTER UPDATE ON DEPT
    FOR EACH ROW
        BEGIN
            UPDATE CDEPT
            SET DNAME = :NEW.DNAME, LOC = :NEW.LOC
            WHERE DEPTNO = :OLD.DEPTNO;
    END;
/

UPDATE DEPT
SET DNAME = 'C', LOC='D'
WHERE DEPTNO = 99;

SELECT * FROM DEPT
UNION ALL
SELECT * FROM CDEPT;


--�ǽ� : DEPT���̺� �μ���ȣ 99���� �����ϴ� ��� ���� �� CDEPT ���̺��� 99�� �μ��� �����ǵ��� �غ�����
--DEL_DEPT
CREATE OR REPLACE TRIGGER DEL_DEPT
    AFTER DELETE ON DEPT
    FOR EACH ROW
        BEGIN
            DELETE CDEPT
            WHERE DEPTNO = :OLD.DEPTNO;
    END;
/

DELETE DEPT WHERE DEPTNO=99;

SELECT * FROM DEPT
UNION ALL
SELECT * FROM CDEPT;


--���� ���� Ʈ����
CREATE OR REPLACE TRIGGER DML_TRI
    AFTER INSERT OR UPDATE OR DELETE ON DEPT
    FOR EACH ROW
    BEGIN
        IF INSERTING THEN
            INSERT INTO CDEPT
            VALUES (:NEW.DEPTNO, :NEW.DNAME, :NEW.LOC);
        ELSIF UPDATING THEN
            UPDATE CDEPT
            SET DNAME = :NEW.DNAME, LOC = :NEW.LOC
            WHERE DEPTNO = :OLD.DEPTNO;
        ELSIF DELETING THEN
            DELETE CDEPT
            WHERE DEPTNO = :OLD.DEPTNO;
        END IF;
    END;
/

INSERT INTO DEPT
VALUES (90, 'A', 'B');

SELECT * FROM DEPT
UNION ALL
SELECT * FROM CDEPT;

UPDATE DEPT
SET DNAME='C'
WHERE DEPTNO = 90;

SELECT * FROM DEPT
UNION ALL
SELECT * FROM CDEPT;

DELETE DEPT WHERE DEPTNO = 80;

SELECT * FROM DEPT
UNION ALL
SELECT * FROM CDEPT;


































































