--2)	���� �� �Լ� [�׷� �Լ�]
--: ���� �� �Լ��� �޸� �� ���տ� ���ؼ� ����Ǿ� �׷�� �ϳ��� ��� ����. �̷��� �� ������ ��ü ���̺��̳� �׷����� ���ҵ� ���̺�� ������ �� �ִ�.

SELECT SAL FROM EMP;

SELECT AVG(SAL), MAX(SAL), MIN(SAL), SUM(SAL)
FROM EMP;

SELECT AVG(SAL), MAX(SAL), MIN(SAL), SUM(SAL)
FROM EMP
WHERE JOB LIKE 'CLERK';

-- ���� �ֱٿ� �Ի��� ���, ���� ���� �ٹ��� ����� �Ի���
SELECT MAX(HIREDATE), MIN(HIREDATE)
FROM EMP;

-- ���� ������ ���ĵ� ��� ��� ����Ʈ���� �� ���������� ������ ����� �̸�, �� ó�� ������ ����� �̸�
SELECT MAX(ENAME), MIN(ENAME)
FROM EMP;

-- AVG, SUM, VARIANCE(�л�), STDDEV(ǥ������) �Լ��� ���� ������ ������ ��� ����
-- MAX, MIN�� �Լ��� LOB��, LONG�� ������ ���� ��� �Ұ�

-- COUNT: ���̺��� �� ���� ��ȯ
-- ��ü ����� ���� ���Ͻÿ�
SELECT COUNT(*)
FROM EMP;

-- �ǽ� : 10�� �μ� ����� ���� ���غ�����.
SELECT COUNT(ENAME)
FROM EMP
WHERE DEPTNO=10;

-- ���� �� �Լ��� NULL�� �ƴ� ���� ���� ���� ���� ��ȯ�ϵ��� ����Ǿ� �ִ�. 
-- =>	NULL ����
-- =>	����� �޶����� ��찡 ����
-- => �׷��Ƿ� NULL ó�� �Լ��� ���� ����� �����ִ� ���� �Ű� ��� ��
SELECT COUNT(COMM), COUNT(NVL(COMM,0))
FROM EMP;

-- �ǽ� : ��ü ����� ������ ����� ���غ�����.
SELECT AVG(NVL(COMM,0)), AVG(COMM)
FROM EMP;

SELECT STDDEV(SAL) FROM EMP; --ǥ������

-- �ǽ� : ��ü ������ ��� �޿�, �޿� �� �հ�, �ְ� �޿�, ���� �޿��� ��ȸ
-- (��, ��� �޿��� �Ҽ��� ��° �ڸ�����, �޿� �� �հ�� õ������ ǥ��)
SELECT ROUND(AVG(SAL),2) "AVG_SAL", TO_CHAR(SUM(SAL),'$999,999') "SUM_SAL", MAX(SAL), MIN(SAL)
FROM EMP;

-- ��� �׷��Լ��� ���̺��� �ϳ��� Ŀ�ٶ� ���� �׷����� ���
-- �׷��� �� ���� ���̺��� �� ���� �׷����� ������ �ϴ� ��찡 �ִ�.
-- : GROUP BY ��

-- �� �μ���ȣ ���� ��� �޿� ��ȸ
SELECT DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO ASC;

-- �ǽ� : �� ���� ���� ��� �޿��� ��ȸ�غ�����.
SELECT JOB, ROUND(AVG(SAL), 0) "AVG_SAL"
FROM EMP
GROUP BY JOB;

-- GROUP BY ���� �� ���� COLUMN ��� ����
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB;  -- ��� ��ġ�ϴ� ROW ���� �׷� ����

-- �ǽ�: �������� �׷�ȭ �Ͽ� ����, �ο� ��, ��� �޿���, �ְ� �޿���, �ּ� �޿���, �հ� ��ȸ
SELECT JOB, COUNT(ENAME), AVG(SAL), MAX(SAL), MIN(SAL), SUM(SAL)
FROM EMP
GROUP BY JOB;

-- HAVING ��: ���� �׷���� ��� ����
-- : WHERE ���� ����Ͽ� ������ ���� �����ϴ� �Ͱ� ������ ������� HAVING ���� ����Ͽ� �׷��� ����
SELECT DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL) > 2500;

--WHERE CONDITION : ������ TRUE�� �����ϴ� ROW ����
--HAVING CONDITION : ������ TRUE�� �����ϴ� �׷� ����

--JOB�� ��� �޿�(��, ��ձ޿��� 1500 �̻�)
SELECT JOB, AVG(SAL)
FROM EMP
GROUP BY JOB
HAVING AVG(SAL) >= 1500;

-- �ǽ� :
-- 1. �� �μ����� �� ���� �ο��� �ִ��� ���
-- 2. �ο��� 4�� �̻��� �μ���ȣ�� �ο��� ����غ�����
SELECT DEPTNO, COUNT(*)
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(*) >= 4;

-- �׷��Լ� ��ø ����
SELECT MAX(AVG(SAL))
FROM EMP
GROUP BY DEPTNO;




































































































































