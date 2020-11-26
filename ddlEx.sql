--[ DDL (Data Definition Language) ] : ������ ���Ǿ�

-- + �����ͺ��̽� �ֿ� ��ü
-- ���̺� : �����͸� ����
-- ��       : �ϳ� �̻��� ���̺� �ִ� �������� �κ� ����
-- ������ : ���� ���� ����
-- �ε��� : �Ϻ� ���� ������ ���
-- ���Ǿ� : ��ü�� �ٸ� �̸��� �ο�

-- + ���̺� �̸� ���� ��Ģ
-- 1.	A-Z, a-z, 0-9, _ , $, # ��� ����
-- 2.	ù���� => ������
-- 3.	����� ( DB���� ����� ���� ���ڵ� ) ��� X
-- 4.	�̸��� �ǹ� �ְ� ������ �� 

-- 1) ���̺� ����
-- : ���̺� �����Ϸ��� ����(������)�� CREATE TABLE ������ �־�� �ϸ� ��ü�� ������ ���� ������ �־�� �Ѵ�.
-- : DBA(������ ���̽� ������)�� DCL(������ ���)���� ����Ͽ� �������� ������ �ο���

CREATE TABLE COPY_EMP2
(EMPNO NUMBER(4),       -- ��� 9999 ����
ENAME VARCHAR(20),      -- �̸� �ִ� 20�� 
JOB CHAR(20),              
SAL NUMBER(7, 2),            -- 7�ڸ�, �Ҽ��� �Ʒ� 2�ڸ� ����
HIREDATE DATE);               -- ��¥�� ������ �� ������ ����

 --> CHAR�� �ִ� 2000�� ���� �� �ִ�.
 --> VARCHAR �ִ� 4000�� =>VARCHAR2, �������̸� �˾Ƽ� �ٲ� ��
 --> LONG Ÿ��: 2G �ؽ�Ʈ
 --> LONG RAW: 2G �̹���
 --> LOB, CLOB, BLOB, BFILE: 4G
 
DESC COPY_EMP2;
SELECT * FROM COPY_EMP2;

CREATE TABLE BIGDATA1
(D1 LONG, D2 LONG RAW);  --> another LONG column may not be added until the unused columns are dropped.

CREATE TABLE BIGDATA2
(D1 LONG, D2 BLOB, D3 BFILE);

-- ���̺� ���� �� �������� ��� ����
CREATE TABLE EMPS
AS
SELECT * FROM EMP;

SELECT * FROM EMPS;

-- ���� : COPY_EMP3 ���̺� ����
--          �ٸ� �� ���̺��� EMP ���̺�� ������ ������ ������ �����ʹ� �ϳ��� ���� ���̺�
CREATE TABLE COPY_EMP3
AS
SELECT * FROM EMP
WHERE EMPNO = 9999; -- WHERE �����ڴ� ��ġ�ϴ°� ������ �����͸� �������� ����. ���� �ƴ�

SELECT * FROM COPY_EMP3;

-- INSERT ������ �������� ��� ����
INSERT INTO COPY_EMP3
SELECT * FROM EMP;

SELECT * FROM COPY_EMP3;

-- 2)	���̺� ���� ����: ALTER TABLE ����
-- ���̺� �÷� �߰�

ALTER TABLE EMPS
ADD HP VARCHAR(10);

SELECT * FROM EMPS;

-- ���̺� �÷��� ����
ALTER TABLE EMPS
RENAME COLUMN HP TO MP;

-- ���̺� �÷� ���� ����
ALTER TABLE EMPS
MODIFY MP VARCHAR(15);

-- ���̺� �÷� ����
ALTER TABLE EMPS
DROP COLUMN MP;

-- �б� ���� ���̺�
-- : READ ONLY ������ �����Ͽ� ���̺��� �б� ���� ���� �� �� ����
-- : READ ONLY ����̸� ���̺� ������ �ִ� DML�� ���� �Ұ���
-- : ���̺��� �����͸� �������� �ʴ� DDL�� ������ �� ����

ALTER TABLE EMPS READ ONLY;

INSERT INTO EMPS (EMPNO)
VALUES(9999);

-- �б� ���� ��� ����
ALTER TABLE EMPS READ WRITE;

-- 3)	���̺� ����: DROP TABLE ����
DROP TABLE EMPS; 

DESC EMPS

-- ���̺� ����(������ ���)
-- : DROP �ϸ� ������ó�� DBMS�� RECYCLE BIN(������ ������)���� ���� ��
SHOW RECYCLEBIN;

FLASHBACK TABLE EMPS
TO BEFORE DROP;

DROP TABLE EMPS;
SHOW RECYCLEBIN;

-- ������ ����
PURGE RECYCLEBIN;

-- cf) DROP TABLE EMPS PURGE : �������� ��ġ�� �ʰ� �ٷ� ���� ���� (��� �� ���� �ʿ�)
-- cf) DELETE ������ ���̺��� ROW���� �����ִ� ��ɾ�
--      DROP ������ ���̺��� �����ϴ� ��ɾ�
--      TRUNCATE ������ ���̺��� ROW���� �����ִ� ��ɾ� -  DELETE�� �޸� ROLLBACK�� �ȵǹǷ� �� ���� ���� ����
--       WHERE �� ��� X => �κ� ������ �ȵ�
-- cf) �б� ���� ����� ���̺��� ������ �� ����. DROP����� ������ ��ųʸ������� ����ǹǷ� 
--      ���̺� ���뿡 ������ �� �ʿ䰡 ���� ����.

-- 4)	���̺� �̸� ����
RENAME COPY_EMP2
TO EMPS;

SELECT * FROM EMPS;

-- 5)	���̺� �ּ� �ޱ�
COMMENT ON TABLE EMPS
IS 'EMPOYEE TABLE';

-- �ּ��� Data Dictionary���� Ȯ���� �� ����
DESC USER_TAB_COMMENTS

SELECT * FROM USER_TAB_COMMENTS;





























