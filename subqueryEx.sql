-- [��������]
-- : SELECT ���� ������ ��� ���
-- : �ٸ� SQL���� WHERE������ ���������� �ۼ��Ͽ� �� �� ���� ���Ǻ� ��
--   (���α׷��Ӱ� ���̺��� ��� ���� ���� ������ �� ���� ��)�� ������� 
--   ���������� ���ϰ��� �ϴ� ���� ���ϰ��� �� �� ���

--	SELECT ���� �������� �־� �� �� ���� ? �������� ���� SELECT���� SUBQUERY��� �θ�
--	���������� �����Ϸ��� ���� ǥ���ϴ� �κ�: MAIN QUERY

-- �������� ���Ⱚ �ϳ��� SINGLE ROW SUBQUERY
--              ���Ⱚ ���� ���� MULTIPLE ROW SUBQUERY
--              �÷��� ���� ���� MULTIPLE COLUMN SUBQUERY

--> �������� ���� ���� ����
-- 1) ���������� �ݵ�� ��ȣ �ȿ��ٰ� ����
-- ����: JONES ������� �� ���� �޿��� �޴� ����� ���, �̸�, �޿�
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL >= (SELECT SAL
                         FROM EMP
                         WHERE ENAME = 'JONES');
                         
-- 2) SINGLE ROW SUBQUERY �տ��� SINGLE ROW OPERATOR (�� ������) �� �;� �Ѵ�.
-- : =, <, >, <=, >=, <>
SELECT ENAME, SAL
FROM EMP
WHERE SAL > (SELECT SAL --������
                       FROM EMP
                       WHERE ENAME = 'JONES' OR COMM IS NOT NULL);
                       
-- 3) MULTIPLE ROW SUBQUERY �տ��� MULTIPLE ROW OPERATOR(IN, ANY, ALL)�� �;� �Ѵ�.
-- IN ������: ���� �� �� �ϳ��� ����.
-- 10�� �μ� ������� �޿��� ���� �޿��� �޴� ����� �̸��� �޿��� ��ȸ
SELECT ENAME, SAL
FROM EMP
WHERE SAL IN (SELECT SAL 
                        FROM EMP 
                        WHERE DEPTNO=10);
-- ���� : �μ� ��ȣ�� 10, 20, 30�� �������� �μ���ȣ�� ��� �޿� �� �ϳ��� 
-- ���� �޿��� �޴� ����� ���, �̸�, �޿� ���� ��ȸ
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL IN (SELECT TRUNC(AVG(SAL))
                        FROM EMP
                        GROUP BY DEPTNO);

SELECT DEPTNO, TRUNC(AVG(SAL))
FROM EMP
GROUP BY DEPTNO;

--<11-24 ����>------------------------------------------------------------------------------------------
--1
SELECT E.ENAME, E.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO;

SELECT E.ENAME, E.DEPTNO, D.DNAME
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;

--2
SELECT E.ENAME, E.JOB, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO;

SELECT E.ENAME, E.JOB, D.LOC
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;

--3
SELECT E.ENAME, D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO AND E.COMM IS NOT NULL;

SELECT E.ENAME, D.DNAME, D.LOC
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
AND E.COMM IS NOT NULL;

--4
SELECT E.ENAME, E.JOB, D.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO AND D.LOC='DALLAS';

SELECT E.ENAME, E.JOB, D.DEPTNO, D.DNAME
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
AND D.LOC='DALLAS';

--5
SELECT E.ENAME, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO AND E.ENAME LIKE '%A%';

SELECT E.ENAME, D.DNAME
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO 
AND E.ENAME LIKE '%A%';

--6
SELECT E.ENAME AS "EMPLOYEE", D.ENAME AS "MANAGER"
FROM EMP E, EMP D
WHERE E.MGR = D.EMPNO(+);

SELECT E.ENAME AS "EMPLOYEE", D.ENAME AS "MANAGER"
FROM EMP E LEFT OUTER JOIN EMP D
ON E.MGR=D.EMPNO;

--7
SELECT E.ENAME, E.SAL, S.GRADE
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN LOSAL AND HISAL;

SELECT E.ENAME, E.SAL, S.GRADE
FROM EMP E JOIN SALGRADE S
ON E.SAL BETWEEN LOSAL AND HISAL;

--8
SELECT E.ENAME, D.DNAME, E.SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO AND SAL>=3000;

SELECT E.ENAME, D.DNAME, E.SAL
FROM EMP E JOIN DEPT D
ON E.DEPTNO=D.DEPTNO 
AND SAL>=3000;

--9
SELECT E.ENAME, E.DEPTNO, D.ENAME
FROM EMP E, EMP D
WHERE E.DEPTNO=D.DEPTNO AND E.ENAME <> D.ENAME;

SELECT E.ENAME, E.DEPTNO, D.ENAME
FROM EMP E JOIN EMP D
ON E.DEPTNO=D.DEPTNO
AND E.ENAME <> D.ENAME;

--10
SELECT ENAME, HIREDATE
FROM EMP
WHERE HIREDATE > (SELECT HIREDATE
                                FROM EMP
                                WHERE ENAME='BLAKE');
                                
SELECT E.ENAME, E.HIREDATE
FROM EMP E, EMP C
WHERE C.ENAME='BLAKE' AND E.HIREDATE > C.HIREDATE;

SELECT E.ENAME, E.HIREDATE
FROM EMP E JOIN EMP C
ON C.ENAME='BLAKE' AND E.HIREDATE > C.HIREDATE;
--------------------------------------------------------------------------------------------------------------------

--<11-25>
-- : ���� : �μ���ȣ���� ���� ���� �޿��� �޴� ����� ������ ���
SELECT DEPTNO, ENAME, SAL 
FROM EMP
WHERE SAL IN (SELECT MAX(SAL)
                    FROM EMP
                    GROUP BY DEPTNO);

-- ���� : �ٸ� ������ ������� �ٹ��ϰ� �ִ� ������ ���, �̸�, �޿� ��ȸ
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE EMPNO IN (SELECT MGR
                                FROM EMP);
                                
SELECT DISTINCT(E.ENAME), E.EMPNO, E.SAL
FROM EMP E JOIN EMP C
ON E.DEPTNO=C.DEPTNO
WHERE E.EMPNO = C.MGR;

-- ���� : ���������� ���� ������ ���, �̸�, �޿� ��ȸ
SELECT EMPNO, ENAME, SAL, MGR
FROM EMP
WHERE EMPNO NOT IN (SELECT MGR
                                        FROM EMP
                                        WHERE MGR IS NOT NULL);


-- ANY ������ : ���� �� �� �ϳ�
--                  : �� �����ڰ� �տ� ��ġ
--                  : �� �ϳ��� ����Ʈ�� �� �Ǵ� �������� ��ȯ�Ǵ� ���� ���� ��
-- SALESMAN ��å�� �޿����� ���� �޴� ����� ������ �޿� ������ ��ȸ
SELECT SAL, JOB
FROM EMP
WHERE SAL > ANY(SELECT SAL 
                               FROM EMP 
                               WHERE JOB='SALESMAN') 
            AND JOB <> 'SALESMAN';

-- ���� : �μ���ȣ�� 10, 20, 30���� �������� �μ���ȣ�� ��� �޿� �� �ϳ����� �۰ų� ���� �޿��� �޴�
--         ������ �޿�, �̸�, ����� ��ȸ�ϼ���.
SELECT SAL, ENAME, EMPNO
FROM EMP
WHERE SAL <= ANY(SELECT AVG(SAL)
                                FROM EMP
                                WHERE DEPTNO IN (10, 20, 30)
                                GROUP BY DEPTNO);

-- ALL ������ : ��� ��
--                  : �񱳿����ڰ� �տ� ��ġ
-- ��� SALESMAN�� �޿����� ���� �޴� ����� ������ �޿� ������ ��ȸ
SELECT ENAME, SAL
FROM EMP
WHERE SAL > ALL(SELECT SAL
                                FROM EMP
                                WHERE JOB = 'SALESMAN');

-- ���� : �μ���ȣ�� 10, 20, 30���� �������� �μ���ȣ�� ��� �޿� ��� ���� ���� �޿��� �޴�
--         ������ ���, �޿�, �̸��� ��ȸ�ϼ���.
SELECT SAL, ENAME, EMPNO
FROM EMP
WHERE SAL < ALL(SELECT AVG(SAL)
                                FROM EMP
                                WHERE DEPTNO IN (10, 20, 30)
                                GROUP BY DEPTNO);

-- 4. ���� �� �������� �����Լ� ��� ����
-- EMP ���̺��� �μ��� ��� �޿��� ���� ū �μ��� �μ���ȣ�� �� ��� �޿��� ���Ͻÿ�
SELECT DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL) = (SELECT MAX(AVG(SAL))
                                 FROM EMP
                                 GROUP BY DEPTNO);

-- ���� : EMP ���̺��� ��å�� ��� �޿��� ���� ���� ��å�� �� ��� �޿��� ���Ͻÿ�
SELECT JOB, TRUNC(AVG(SAL), 2) "AVG_SAL"
FROM EMP
GROUP BY JOB
HAVING AVG(SAL) = (SELECT MIN(AVG(SAL))
                                 FROM EMP
                                 GROUP BY JOB);
SELECT JOB , TRUNC(AVG(SAL), 2) "AVG_SAL"
FROM EMP
GROUP BY JOB
HAVING AVG(SAL) <= ALL (SELECT AVG(SAL)
                                          FROM EMP
                                          GROUP BY JOB);
--5) ���������� ���������� ��ȯ�Ǵ� ���� ������
--(�������� ������ �����ϴ� ���� ���ų� �Ǵ� ���� ������ �ش� �÷��� NULL ����)
--���������� ����� �׻� �����õ� ���� ������ �̶�� �޽��� ǥ�õȴ�.
SELECT ENAME, JOB
FROM EMP
WHERE JOB =(SELECT JOB
                        FROM EMP
                        WHERE EMPNO = 9999);

SELECT ENAME, JOB
FROM EMP
WHERE MGR = (SELECT MGR
                        FROM EMP
                        WHERE MGR IS NULL);

-- �����ϴ� ���� ������ NULL������ ���� ���� ������ �߻��� �� �ִ�.
-- NULL�� ���ֵ��� �÷��� ���ڴ� NULL ��� 0, ���ڴ� ��-�� ���� ��ü���� �Է��� �� ��
--	NULL ó�� �Լ��� ����� �� ������ �������� ���̳� �ε����� Ű �� ���� ����� ���� DB�� ���ϰ� �� �� �ִ�.


-- 6) EXISTS ������: ���̺��� Ư�� ���� �ִ��� ���ο� ���� ���� ����� �޶����� ������ ����ϴ� ������
-- : �������� �����Ͱ� �����ϴ°��� üũ�� ���� ����(True/False)�� ��ȯ
-- : ������������ ��� ���� ã����, INNER QUERY ������ �ߴ��ϰ� True ��ȯ

-- �μ����� ���� �μ� ������ ��ȸ
SELECT *
FROM DEPT
WHERE EXISTS (SELECT *
                            FROM EMP
                            WHERE EMP.DEPTNO = DEPT.DEPTNO);

SELECT *
FROM DEPT
WHERE NOT EXISTS (SELECT *
                            FROM EMP
                            WHERE EMP.DEPTNO = DEPT.DEPTNO);

-- ��� ���̺��� ���� ������� ���� �μ���ȣ�� ������ ��ȸ
-- ��� : �����ϰ��� �ϴ� ������ ��� ���̺��� DEPT���� EMP���̺�� �����Ͽ� �μ���ȣ�� üũ�ؾ� ��
--         �� ���̺��� ����� 1:N ������. �׷��Ƿ� ���ʿ��ϰ� EMP ���̺��� ��� �а� �ִ� ����
--         ���������δ� �ߺ� ���ŷ� �ùٸ� ����� ��
SELECT DISTINCT(D.DEPTNO), D.DNAME
FROM DEPT D, EMP E
WHERE D.DEPTNO=E.DEPTNO;
                            
-- EXISTS �����ڸ� ����� �������� ���ǹ�
-- ��� : �����ϰ��� �ϴ� ����� FROM ���� �ְ� EMP ���̺��� üũ�� �ϱ� ���� EXISTS ���� ��ġ ��Ų ����
--          �׷��Ƿ� ��ü ���� �ӵ� ���� ����
SELECT D.DEPTNO, D.DNAME
FROM DEPT D
WHERE EXISTS (SELECT 1                                             
                            FROM EMP E
                            WHERE E.DEPTNO = D.DEPTNO);

--7) �������������� ORDER BY���� �������� �ʴ´�. (���� �߻�)
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > (SELECT SAL
                        FROM EMP
                        WHERE ENAME = 'JONES'
                        ORDER BY 1);
















































