desc dept

select * from emp;

-- �Լ� (�����Ǵ� �Լ��� �����Ƿ� ��ǥ���̰� ���� ���� �� ���ַ� ����)

--1) ���� �� �Լ�      �Ϲ�, ����, ����, ��¥, ��ȯ
--A. ����
--���� ��ȯ
SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)
FROM EMP;

--���� ����
SELECT ENAME, SUBSTR(ENAME, 1, 3), SUBSTR(ENAME, 4), LENGTH(ENAME), INSTR(ENAME, 'A')
FROM EMP;

SELECT ENAME, LPAD(SAL, 10, '*'), RPAD(SAL, 10, '*')
FROM EMP;

--��Ÿ
SELECT TRIM('o' FROM 'oracleDBMS') NAME
FROM DUAL;

DESC DUAL

SELECT * FROM DUAL; -- 1�� ���� ���̺�

SELECT TRIM(' ORACLEDATABASE'), TRIM('ORACLEDATAVASE')
FROM DUAL;

SELECT REPLACE('ORACLEDATABASE','ORACLE','DB') NAME FROM DUAL;

-- �ǽ� : 12���� �Ի��� ������� �̸�, �Ի�����, �޿��� ��ȸ�غ�����
SELECT ENAME, HIREDATE, SAL
FROM EMP
WHERE SUBSTR(HIREDATE,4,2) = '12';

-- �ǽ� : 12���� �Ի��� ����� ������ ��ȸ�ϰ�, �� �������� ������ 6�ڸ��� ���
--          (��, ������ �ڸ����� 0���� ǥ��)
SELECT ENAME, HIREDATE, LPAD(SAL,6,'0') SAL
FROM EMP
WHERE SUBSTR(HIREDATE,4,2) = '12';

--B. ���� �Լ�
SELECT ROUND(45.139, 2), TRUNC(45.139, 2)
FROM DUAL;

SELECT MOD(101, 2)
FROM DUAL;

-- �ǽ� : ��ü ����� �Ŵ����� ���� �Ϸ��� ��
--  �̸�, ����, �Ŵ���(0,1), �Ŵ��� ��ȣ ���
--  (��, �ų��� ��ȣ�� ¦���̸� 0, Ȧ���̸� 1�� ����)

SELECT ENAME, JOB, MOD(MGR, 2) AS "MGR(0, 1)", MGR
FROM EMP;

--C. ��¥ �Լ�
-- SYSDATE
SELECT SYSDATE FROM DUAL;

SELECT HIREDATE, 
            MONTHS_BETWEEN(SYSDATE, HIREDATE),
            ADD_MONTHS(HIREDATE, 6),
            NEXT_DAY(HIREDATE, '��'),
            LAST_DAY(HIREDATE)
FROM EMP; 

-- �ǽ� : �̹� ���� ������ ���ڸ� ���
SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- �ǽ� : �ٹ� ���� ���� 470���� �̻��� ����� �̸�, �Ի�����, �ٹ����� �� ��ȸ
--      (��, �ٹ� ���� ���� �� ������ ǥ��)

--���� �� �Լ��� �Լ� ��ø�� ����
SELECT ENAME, HIREDATE, ROUND(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS "�ٹ� ���� ��"
FROM EMP
WHERE MONTHS_BETWEEN(SYSDATE, HIREDATE) >= 470;
 
-- �ǽ� : �츮 ȸ��� �Ի� �� 6������ ���� ����� ���ؼ� �� �� �ݿ��Ͽ� ���� ������ �� �̴ϴ�.
-- �� �������� �ñ��ϴ� �����, �Ի���, 6���� �� �ݿ��� ������ ��ȸ�ϼ���
SELECT ENAME, HIREDATE, NEXT_DAY(ADD_MONTHS(HIREDATE, '6'), '��') AS "6���� �� �ݿ���"
FROM EMP;

-- ��¥ ���� ����
SELECT SYSDATE + 1 FROM DUAL;
SELECT SYSDATE - 1 FROM DUAL;

SELECT SYSDATE-HIREDATE FROM EMP;

SELECT SYSDATE+HIREDATE FROM EMP;   --X

--  �ǽ� : ��ü ������� �̸�, �ٹ���� ��ȸ�غ�����
-- (�� �ٹ������ ������� ǥ��)
SELECT ENAME, TRUNC((SYSDATE-HIREDATE)/365) AS "�ٹ����"
FROM EMP;

SELECT SYSDATE - '80/01/01' FROM DUAL;      -- ��¥-���ڶ� ������
SELECT SYSDATE - TO_DATE('80/01/01') FROM DUAL;    

--D. ��ȯ �Լ�
--��) �Ͻ���: ����Ŭ ������ �ڵ����� �ٲ� ��
--��) �����

SELECT SYSDATE - TO_DATE('99/01/01')
FROM DUAL;

SELECT SYSDATE - TO_DATE('99-01-01')    --���������� �� ���·� ���ִ°� ����
FROM DUAL;

SELECT SYSDATE
FROM DUAL;

-- ��¥ ���� �� ���
-- YYYY : ���ڷε� ��ü ����
-- YEAR : ���� ö�ڷ� ǥ��� ����
-- MM : ���� 2�ڸ� ��
-- MONTH : ��ü ���� �̸�
-- MON : ���� 3�� ���
-- DD : ���� ������ ���� ��
-- DAY : ���� ��ü �̸�
-- DY : ���� 3�� ���

SELECT SYSDATE, TO_CHAR(SYSDATE, 'cc yyyy/mm/dd - hh24 : mi : ss')
FROM DUAL;

-- ���� ǥ�� ���� ���
-- 9 : ���ڸ� ��Ÿ��
-- 0 : 0�� ǥ�õǵ��� ����
-- $ : �ε� �޷� ��ȣ ��ġ
-- L : �ε� ���� ��ȭ ��ȣ ��ġ
-- . : �Ҽ��� ���
-- , : õ ���� ǥ����

-- �޷�
SELECT ENAME, SAL, LPAD(SAL, 6,'+'), TO_CHAR(SAL, 'L999,999.99')
FROM EMP;

-- ����ȭ��
SELECT ENAME, SAL, LPAD(SAL, 6,'+'), TO_CHAR(SAL, 'L999,999.99')
FROM EMP;

-- 0 ����
SELECT 123, TO_CHAR(123, '0000') FROM DUAL;

-- 16����
SELECT  TO_CHAR(123, 'XXXX') FROM DUAL;

-- ���ڸ� ���ڷ� ��ȯ
SELECT TO_NUMBER('0123456789') FROM DUAL;

-- E. �Ϲ� �Լ�
-- ��) NULL ó�� �Լ�
SELECT ENAME, SAL, COMM, SAL*12+COMM FULLSAL
FROM EMP;

-- NVL
SELECT ENAME, SAL, COMM, SAL*12+NVL(COMM, 0) FULLSAL
FROM EMP;

-- NVL2 (COL, VAL1, VAL2)
-- COL ���� NULL�� �ƴϸ� VAL1�� ����, NULL�̸� VAL2
SELECT ENAME, MGR, NVL2(MGR, 1, 0) MGR
FROM EMP;

-- COALESCE (COL, VAL1, VAL2)
-- COL�� NULL�̸� VAL1, VAL1�� NULL�̶�� VAL2
SELECT ENAME, COALESCE(COMM, NULL, 0) COMM
FROM EMP;

-- NULLIF : �� ǥ������ ���Ͽ� ������ ��쿡�� NULL�� ��ȯ, �������� ������ ù��° ǥ������ ��ȯ
SELECT NULLIF('A', 'a'), NULLIF('A', 'A')
FROM DUAL;

-------------------------------------------------------------------------------------------------------
-- 11/20 ����
--1
SELECT RPAD(SUBSTR(ENAME, 1,2),LENGTH(ENAME), '*') 
FROM EMP;

--2         
SELECT TO_CHAR(ROUND(HIREDATE, 'MONTH'),'YYYY-MM-DD')
FROM EMP;

--3
SELECT ENAME, COMM, NVL2(COMM,TO_CHAR(COMM), '���߷�')
FROM EMP;

--4
SELECT TO_CHAR(TRUNC(HIREDATE,'YEAR'),'YYYY') AS "�Ի�⵵", 
COUNT(DECODE(JOB,'CLERK',1)) CLERK,
COUNT(DECODE(JOB,'SALESMAN',1)) SALESMAN,
COUNT(CASE WHEN JOB='MANAGER' THEN 1 END) MANAGER,
COUNT(CASE WHEN JOB='PRESIDENT' THEN 1 END) PRESIDENT,
COUNT(CASE WHEN JOB='ANALYST' THEN 1 END) ANALYST,
COUNT(ENAME)
FROM EMP
GROUP BY TRUNC(HIREDATE,'YEAR')
ORDER BY TRUNC(HIREDATE,'YEAR');

--5
SELECT ENAME
FROM EMP
WHERE HIREDATE < '81/01/01';

--6
SELECT ENAME, SAL*12+NVL(COMM,0) AS "����"
FROM EMP
WHERE SAL*12+NVL(COMM,0) BETWEEN 12000 AND 45000;

--7
SELECT ENAME
FROM EMP
WHERE SUBSTR(ENAME,1,1) BETWEEN 'H' AND 'U'
ORDER BY SUBSTR(ENAME,1,1) ASC;

--8
SELECT ENAME
FROM EMP
WHERE SUBSTR(ENAME,2,1) ='A';

--9
SELECT RPAD(SUBSTR(ENAME, 1,1),LENGTH(ENAME)-2, '*') || SUBSTR(ENAME, LENGTH(ENAME)-1,2)
FROM EMP;

--10
SELECT ENAME,
CASE
    WHEN SAL<NVL(COMM,0) THEN 'GOOD'
    ELSE 'BAD'
END
FROM EMP;

-------------------------------------------------------------------------------------------------------

-- ��) ���� �Լ�
-- DECODE �Լ�: ���ǿ� ���� �����͸� �ٸ� ���̳� COLUMN���� ������ �� �ֵ��� �ϴ� �Լ�
--	: DECODE(VALUE, IF1, THEN1, IF2, THEN2, ��) ����
--	: => VALUE ���� IF1 �̸� THEN1 ���� ��ȯ, IF2 �� THEN2 �� ��ȯ, ��
--	: => DECODE �Լ� �ȿ� DECODE �Լ� ��ø ��� ����

-- �μ���ȣ�� 10�̸� ACCOUNTING, 20�̸� RESEARCH, 30�̸� SALES, �������� OERATIONS ���
SELECT DEPTNO,
    DECODE(DEPTNO, 10, '10�� �μ�', 
                                20, '20�� �μ�', 
                                30, '30�� �μ�', 
                                'OPERATIONS') DEPT -- ��Ȯ�� ������ ���ָ� ������ �ǹ�
FROM DEPT;

-- CASE �Լ�: DECODE���� �������� ���ϴ� �񱳿����� �ذ��� �� �ִ� �Լ�
--	: => ��/���� �����ڸ� ��� ����� �� �ִ�.
 SELECT DEPTNO,
    CASE DEPTNO
        WHEN 10 THEN '10�� �μ�'
        WHEN 20 THEN '20�� �μ�'
        WHEN 30 THEN '30�� �μ�'
        ELSE '�������μ�'
    END "NAME"
FROM DEPT;

-- CASE �� ��/���� ������
-- �޿����� �λ���� �ٸ��� ����(���)
-- 1000 �����̸� 8%, 2000 �����̸� 5%, 3000 �����̸� 3%, �� �̻��̸� 1% �λ�
SELECT ENAME, SAL,
    CASE
        WHEN SAL <= 1000 THEN SAL * 1.08
        WHEN SAL <= 2000 THEN SAL * 1.05
        WHEN SAL <= 3000 THEN SAL * 1.03
        ELSE SAL * 1.01
    END "�λ�޿�",
    CASE
        WHEN SAL <= 1000  THEN '8%'
        WHEN SAL <= 2000 AND SAL > 1000 THEN '5%'
        WHEN SAL BETWEEN 2001 AND 3000 THEN '3%'
        ELSE '1%'
    END "�λ��"
FROM EMP;

-- �ǽ�: ��å�� �Ŵ����� ����� �޿��� 10% �λ�, ��å�� �Ϲ� ����� ����� �޿��� 5% �λ�
--         �������� 2% �λ��ؼ� ����̸�, ��å, �޿�, �λ�� �޿�(UPSAL)�� ���
SELECT ENAME, JOB, SAL,
    CASE JOB
        WHEN 'MANAGER' THEN SAL * 1.1
        WHEN 'CLERK' THEN SAL * 1.05
        ELSE SAL * 1.02
    END "UPSAL"
FROM EMP;

-- CONCAT: ���ڸ� ���� ��
SELECT ENAME, INITCAP(CONCAT(SUBSTR(ENAME,1,2), '_US')) || ' PLUS' "NAME"
FROM EMP
WHERE DEPTNO=10;



































































