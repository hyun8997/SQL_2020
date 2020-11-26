-- [ JOIN ���(�Լ�) ]

SELECT ENAME, DNAME
FROM EMP, DEPT;        
-- CARTESIAN PRODUCT: ������ ��� ���� ����

SELECT * FROM EMP;
SELECT * FROM DEPT;

-- ����
-- : ����-������ �������� �� ���̺��� �� ����� ��ģ ��, ���ϴ� �������� ���ڵ带 �������� ���
-- [SQL 92 JOIN]
-- : EQUI-JOIN
-- : NON - EQUI JOIN
-- : SELF-JOIN
-- : OUTER-JOIN

-- [ANSI ǥ�� JOIN ����]
-- : INNER JOIN - EQUI INNER JOIN
--                      - NONE EQUI INNER JOIN
-- : OUTER JOIN
-- : CROSS JOIN
-- : NATURAL JOIN

---	SELECT���� COLUMN�� ���̺�� �Բ� ��Ȯ�ϰ� ����ƾ� ����� ����ʿ� ����
---	�÷��� ��ο� ���̺� ���� ����θ� ACCESS ȿ���� ��������.
---	���̺� �̸��� �ʹ� ��� FROM ���� ���̺� �ΰ� �̴ϼȷ�
---	ANSI EQUI-INNER JOIN�� �޸� ��� INNER JOIN�̶�� ���ڷ� ���
---	INNER�� ������ ����, JOIN CONDITION�� ON���� �´�.

--------------------------------------------------------------------------------------------------
SELECT ENAME, DNAME
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;
-- WHERE CONDITION : JOIN CONDITION = T/F �� �䱸�ϴ� ����

-- ������ �� ��Ȯ�ϰ� �� ���� ����
SELECT ENAME, DNAME
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO
    AND SAL >= 3000;

-- ���� ���� : ���� �� �̻��� ����� ����� �� Primary key �� Foreign key ���� ����Ͽ� ����
--               : �� ���� ���̺��� select ���� �ȿ��� �����Ϸ��� ��� �ϳ��� �÷��� �� �� ���̺� ���̿��� �����Ǿ�� �Ѵ�.

-- [SQL EQUI-JOIN]  �� ���̺��� ���� ������ TRUE�� ��
SELECT E.EMPNO, E.ENAME, D.DNAME -- ������ ��ó�� �����ִ°� ����
FROM EMP E, DEPT D                      -- ��Ī�� �޾Ƽ� �����ϰ� ��
WHERE E.DEPTNO = D.DEPTNO;

-- SELECT���� COLUMN�� ���̺�� �Բ� ��Ȯ�ϰ� ����ƾ� ����� ����ʿ� ����

-- [ANSI EQUI-INNER JOIN] �� ���̺��� ���� ������ TRUE�� ��
SELECT E.EMPNO, E.ENAME, D.DNAME
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

-- [ANSI NONE EQUI-INNER JOIN] 
--���̺��� � �÷��� JOIN�� ���̺��� �÷��� ��ġ���� ���� ��
--���ǿ� ��=���� �ƴ� �ٸ� ������(BETWEEN AND, IS NULL, IS NOT NULL, IN, NOT)�� ���
--���� ���Ǵ� JOIN �ƴ�, ������ �ʵ��� ó������ �����Ǵ� �÷��� �ֵ��� ���� ����

-- ��ü ����� �̸��� �޿� ����� ��ȸ
-- SALGRADE: ȣ���� ���� �޿� �ִ�ġ, �ּ�ġ ���� ����
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
FROM EMP E INNER JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL;

-- ��ü �����, �μ���, �޿� ����� ��ȸ => 3-Way join
SELECT E. EMPNO, E.DEPTNO, S.GRADE
FROM EMP E JOIN SALGRADE S
ON E.SAL < S.HISAL AND E.SAL >= S.LOSAL;

-- 11-23 ���� ----------------------------------------------------------
--1
--SELECT D.DEPTNO, COUNT(E.ENAME), SUM(E.SAL)
--FROM DEPT D INNER JOIN EMP E
--ON E.DEPTNO = D.DEPTNO 
--GROUP BY E.DEPTNO
--HAVING COUNT(E.EMPNO) > 4;
SELECT DEPTNO, COUNT(ENAME), SUM(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(ENAME) > 4;

--2
SELECT COUNT(ENAME)
FROM EMP
GROUP BY DEPTNO
HAVING DEPTNO=10 OR DEPTNO=30;

--3
SELECT DEPTNO, ENAME, ROUND( SAL/(8*30) ,2) "�ñ�"
FROM EMP
ORDER BY DEPTNO, "�ñ�" DESC;

--4
SELECT DEPTNO,
CASE
    WHEN AVG(SAL)>=2000 THEN '�ʰ�'
    ELSE '�̸�'
END AS "��ձ޿�"
FROM EMP
GROUP BY DEPTNO;

--5
SELECT ENAME,
CASE
    WHEN COMM IS NULL THEN 500
    WHEN COMM = 0 THEN 500
    ELSE COMM
END "COMM"
FROM EMP;

--6
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') AS "����ð�",
            TO_CHAR(SYSDATE+1/24,'YYYY-MM-DD HH24:MI:SS') AS "�ѽð���"
FROM DUAL;

--7
SELECT EMPNO, ENAME, HIREDATE, TRUNC((SYSDATE-HIREDATE)/365) AS "�ٹ����"
FROM EMP
WHERE TRUNC((SYSDATE-HIREDATE)/365) < 30;

-- 11-23 ���� ----------------------------------------------------------

-- <11-24>
-- EMP�� DEPT EQUI JOIN, EMP�� SALGRADE NONE EQUI JOIN
-- =>	DEPT�� SALGRADE�� JOIN�� �� ����(EMP�� ���ؼ�)
-- : 3���� ���̺��� �����ϴ� ���� 3-way ����.
-- : 3�� �̻��� ���̺��� �����ϴ� ���� N-way ����, N-way ���� ���� �ۼ��ÿ� JOIN Ű���� ������ ����� ���̺���
--   �׻� �տ� ����� ���̺� �ϰ� ���ε� �� ������ ����
--   ��, �ڿ� �ִ� ���̺� �ϰ�� ������ �� ����.

-- ����-������ ���� : ���̺� ? 1��
-- EX) A = B, B = C, A = C ===> A=B, A=C
SELECT E.ENAME, D.DNAME, S.GRADE
FROM EMP E, DEPT D, SALGRADE S
WHERE E.DEPTNO = D.DEPTNO AND E.SAL BETWEEN S.LOSAL AND S.HISAL;

-- [SQL 92 SELF JOIN]
-- EQUI JOIN�� ������ �ϳ��� ���̺��� ������ �Ͼ�� ����
-- ���� ���̺� ���Ͽ� �� ���� ALIAS�� ����Ͽ� FROM ���� �� ���� ���̺��� ����ϴ� �� ó�� ����
-- ���� �ٸ� ROW���� ��
-- ����� �̸� ��ȸ
SELECT E.EMPNO, E.ENAME, E.MGR, C.EMPNO, C.ENAME
FROM EMP E, EMP C
WHERE E.MGR = C.EMPNO;

-- [SQL 92 OUTER JOIN]
-- : EQUI-JOIN�� ������ �����Ϸ��� �� ���̺��� �� �� �÷��� ���� ���ٸ� �����͸� ��ȯ���� ���Ѵ�.
-- : -	���� ���ǿ��� ���� ������ �����ϴ� ���� ����(FALSE, NULL) ����� ��ȸ
-- : OUTER JOIN�� �����ڴ� (+)
-- : ���ν� ���ΰ��� ���� �������� (+)�� ��ġ��Ŵ
-- : OUTER JOIN �����ڴ� ǥ������ ���ʿ��� �� �� �ִ�.
-- : JOIN ��� �� �� ���� ��� ���� ���� ���� �ʿ� ��

-- ��� �μ� ��ȣ�� �μ��� ��ȸ
SELECT DISTINCT(E.DEPTNO) "E_DEPTNO", D.DEPTNO "D_DEPTNO", D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;

-- �ǽ� : ��� ���̺��� ����̸� ��ο� �Ŵ��� ���� ��ȸ�ϼ���
SELECT E.ENAME, C.ENAME
FROM EMP E, EMP C
WHERE E.MGR = C.EMPNO(+);

--[ANSI OUTER JOIN]
--: LEFT OUTER JOIN, RIGHT OUTER JOIN, FULL OUTER JOIN

--LEFT OUTER JOIN : INNER JOIN ����� ǥ���ϰ� JOIN Ű���� ���� �ִ� ���̺��� 
--���� ������ ������Ű�� ���ؼ� ǥ�õ��� �ʴ� ���ڵ带 �� ǥ��
SELECT DISTINCT(E.DEPTNO), D.DEPTNO
FROM EMP E LEFT OUTER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

--RIGHT OUTER JOIN : INNER JOIN ����� ǥ���ϰ� JOIN Ű���� ������ �ִ� ���̺��� 
--���� ������ ������Ű�� ���ؼ� ǥ�õ��� �ʴ� ���ڵ带 �� ǥ��
SELECT DISTINCT(E.DEPTNO), D.DEPTNO
FROM EMP E RIGHT OUTER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

--FULL OUTER JOIN: ���� ���̺� ��ο� OUTER JOIN�� �ʿ��� ��쿡 ���
SELECT DISTINCT(E.DEPTNO), D.DEPTNO
FROM EMP E FULL OUTER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

-- [ANSI NATURAL JOIN]
-- : EQUI JOIN�� ���� �����ϴٰ� ���� ��
-- : �� ���̺��� ������ �̸��� ���� �÷��� ��� ������ ��
-- : ������ �÷��� 2�� �̻��� ���, JOIN ~ USING �������� ���εǴ� �÷��� ������ �� ����
-- : ������ �÷��� ���������� ��� �����ϹǷ� ON�� ���� ����
SELECT E.ENAME, D.DNAME
FROM EMP E NATURAL JOIN DEPT D;

-- ������ �÷��� �ΰ� �̻��̶�� : JOIN ~ USING
SELECT E.ENAME, D.DNAME
FROM EMP E JOIN DEPT D
USING (DEPTNO);

-- [ANSI CROSS JOIN]
-- : CARTESIAN PROJECT ���� ���� �� ���, ���� ��� X
-- : INNER JOIN �Ǵ� OUTER JOIN���� ������ �� ���� ���� ���ľ� �� �� ����� �� �ִ�.
SELECT ENAME
FROM EMP CROSS JOIN DEPT;

-- ���̺��� ���� ���� �ؼҼ��� �����ϴ� �������� �Բ� ����ϴ� ���� ����
SELECT ENAME, DNAME
FROM EMP CROSS JOIN DEPT
WHERE DEPT.DEPTNO=10;

-------------------------------------------------------------
-- + ���̺� ���� �� �߰����� ������ ���� ����
-- INNER JOIN������ �߰����� ������ ����� �� ON�� �ڿ� AND�� �Ǵ� WHERE���� �̿� ����(�� �� ����)
-- 10�� �μ��� �ٹ��ϴ� ����� �̸��� �μ� �̸��� ��ȸ
SELECT E.DEPTNO, E.ENAME, D.DNAME
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
AND E.DEPTNO=10;

-- �ǽ� : �μ� ��ġ�� 'BOSTON'�� ����� ���, �̸�, �μ���ȣ, �μ���, �Ի����� ��ȸ�ϼ���.
SELECT E.EMPNO, E.ENAME, E.DEPTNO, D.DNAME, E.HIREDATE
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
AND D.LOC='BOSTON';


-- OUTER JOIN + WHERE ��
SELECT E.ENAME, D.DNAME
FROM EMP E LEFT OUTER JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE E.DEPTNO=30;

SELECT E.ENAME, D.DNAME
FROM EMP E LEFT OUTER JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
AND E.DEPTNO=30;

-- OUTER JOIN������ �߰����� ������ ��� �ÿ� AND�� �Ǵ� WHERE �� ���� ǥ�õǴ� ����� �ٸ� �� ������ ����.

--------------------------------------------------------------------------------------------------------------

--FUNCTIONS_DML_SELECT
--
--SINGLE ROW FUNCTION		���� �� �Լ�
--: ����, ����, ��¥, ��ȯ, �Ϲ�
--
--MULTIPLE ROW FUNCTION	���� �� �Լ�
--: ���� ���� ���� �� �ϳ��� �����ִ� �Լ�
--: COUNT, AVG, SUM, MIN, MAX
--
--GROUP FUCTION			
--: GROUP BY ���� ���ؼ� ���̺��� ������ �� �ȿ��� ���� �� �ϳ� ��ȯ
--: ���� �׷� ������ ���� �� MULTIPLE �Լ��� ���
--: ���� �׷쿡�� �����͸� ����(���ϴ� ������ ����) : HAVING �� ���
--SELECT DEPTNO, AVG(SAL)
--FROM EMP
--GROUP BY DEPTNO
--HAVING AVG(SAL)>=2500;

--------------------------------------------------------------------------------------------------------

--SELECT ��
--4 SELECT �÷���, �÷���, *, f(x), ||, ��~~��, ALIAS, DISTINCT(), SAL*12
--1 FROM ���̺��, ���̺��, �� n��
--2 WHERE CONDITION ? ������(��/��/BETWEEN AND/IN/LIKE/IS NULL) =>NOT ���� ����
--3 GROUP BY �÷�, �÷�, ��
--5 HAVING CONDITION ? WHERE CONDITION���� ����ϴ� �����ڿ� ���� ������
--6 ORDER BY �÷���(�÷���/ALIAS/POSITION) <ASC/DESC>, �÷���
--                   (ù��° �÷����� 1�� ���� �� �ι�° �÷����� 2�� ����)

-- ���� : �޿��� 1000�̻��� ����� ������� ����
-- �μ���ȣ�� ��å�� ��� �޿��� ���Ϸ��� �Ѵ�.
-- ��, ��� �޿��� 2000 �̻�
-- ��� �޿��� ���� ������ ���
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
WHERE SAL >= 1000
GROUP BY DEPTNO, JOB
HAVING AVG(SAL) >= 2000
ORDER BY AVG(SAL) DESC;
































































