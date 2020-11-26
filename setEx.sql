-- ���� ����
-- : ���� �����ڰ� ���Ե� ����
-- : ���� ������ - �� �̻��� ���� ��� ���� ����� �ϳ��� ����� ����
-- : ���� - UNION, UNION ALL, INTERSECT, MINUS (SET OPERATOR)
-- : ���� �����ڴ� ��� �켱 ������ ����. ��������� ��ȣ()�� ������ �������� �ʴ� �� ����(��)���� ������(�Ʒ�)�� �����ڸ� ��
--    �ٸ� ���� �����ڿ� �ղ� MINUS�� ���� �������̶�� ������ ��ġ�� ����

-- > ���� ������ ��ħ
-- : SELECT ����Ʈ�� ǥ������ ������ ��ġ�ؾ� �Ѵ�.
-- : �� ��° ������ �ִ� �� ���� ������ ������ ù ��° ������ �ִ� (�����ϴ�) ���� ������ ������ ��ġ�ؾ� �Ѵ�.
-- : ���� ������ �����Ϸ��� ��ȣ�� ����ؾ� �Ѵ�.
-- : ORDER BY ���� ��ɹ��� �� ���� ����ؾ� �Ѵ�.
-- : UNION ALL �����ڸ� ������ ������ SET �����ڴ� ó�� �߿� ����(SORT)�� �߻��ϹǷ� ó���� ������(���ڵ�)
--   �翡 ���� �޸� �Ҹ� ���� �� �ִ�.

-- UNION: ������
--           : �� ���̺��� ����, ���ս�Ű�� �� ���̺��� �ߺ����� ���� ������ ��ȯ
-- �μ���ȣ�� ��ȸ (������)
SELECT DEPTNO FROM EMP
UNION
SELECT DEPTNO FROM DEPT;

SELECT EMPNO FROM EMP
UNION
SELECT DEPTNO FROM DEPT;

-- UNION ALL: �ߺ��� �����ϴ� ������
--                 : UNION�� ������ �� ���̺��� �ߺ��Ǵ� ������ ��ȯ
SELECT DEPTNO FROM EMP
UNION ALL
SELECT DEPTNO FROM DEPT;

SELECT EMPNO FROM EMP
UNION ALL
SELECT DEPTNO FROM DEPT;

-- INTERSECT: ������
--                  : �� ���� ���� �� ����� �� ��ȯ
SELECT DEPTNO FROM EMP
INTERSECT
SELECT DEPTNO FROM DEPT;

SELECT EMPNO FROM EMP
INTERSECT
SELECT DEPTNO FROM DEPT;

-- MINUS: ������
--          : ù ��° SELECT���� ���� ��ȯ�Ǵ� ��� �� �� ��° SELECT���� ���� ��ȯ�Ǵ� �࿡ �������� �ʴ� ��� ��ȯ
-- ���� : ����� ���� �μ��� ��ȸ�غ�����.
SELECT DEPTNO FROM DEPT
MINUS
SELECT DEPTNO FROM EMP;

-- ������ ��
-- : �� SELECT���� �÷� ����, ������ ������ ��ġ���� ���� ��� ���� �߻�
SELECT DEPTNO, HIREDATE FROM EMP
UNION
SELECT DEPTNO, LOC FROM DEPT;  --������ Ÿ�� �޶� ����

-- 1) ��ȯ �Լ� ����Ͽ� ���� �ذ�
SELECT DEPTNO, TO_CHAR(HIREDATE) FROM EMP
UNION
SELECT DEPTNO, LOC FROM DEPT;   --������ Ÿ���� ���ߴ� ���

-- 2) NULL Ű���� ���
--����->��¥ �� ��ȯ�Լ� ��� ����� ��(����Ȯ���� NULL)
SELECT DEPTNO, NULL, HIREDATE FROM EMP
UNION
SELECT DEPTNO, LOC, NULL FROM DEPT; 

-- 3) ������ ����� �̿��Ͽ� ���� �ذ�
SELECT EMPNO, SAL, COMM, ENAME FROM EMP
UNION
SELECT DEPTNO, 0,0, '-' FROM DEPT; 

--<11-25 ����>------------------------------------------------------------------------------------------------------------
--1
SELECT ENAME, SAL
FROM EMP
WHERE SAL > (SELECT SAL
                        FROM EMP
                        WHERE ENAME='SMITH');

--2
SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL = ANY (SELECT SAL
                                FROM EMP
                                WHERE DEPTNO = 10);

--3
SELECT ENAME, HIREDATE
FROM EMP
WHERE DEPTNO =  (SELECT DEPTNO
                               FROM EMP
                               WHERE ENAME='BLAKE')
            AND ENAME != 'BLAKE';
                               
--4
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > (SELECT AVG(SAL)
                        FROM EMP);

--5
SELECT EMPNO, ENAME, DEPTNO
FROM EMP
WHERE DEPTNO = ANY (SELECT DEPTNO
                                     FROM EMP
                                     WHERE ENAME LIKE('%T%'));

--6
SELECT ENAME, SAL,DEPTNO
FROM EMP
WHERE SAL > (SELECT MAX(SAL)
                        FROM EMP
                        GROUP BY DEPTNO
                        HAVING DEPTNO=30);

--7
SELECT ENAME, DEPTNO, JOB
FROM EMP
WHERE DEPTNO = (SELECT DEPTNO
                                FROM DEPT
                                WHERE LOC = 'DALLAS');

--8
SELECT DEPTNO, ENAME, JOB
FROM EMP
WHERE DEPTNO = (SELECT DEPTNO
                                FROM DEPT
                                WHERE DNAME = 'SALES');

--9
SELECT ENAME, SAL
FROM EMP
WHERE MGR =  (SELECT EMPNO
                        FROM EMP
                        WHERE ENAME = 'KING');

--10
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = ANY (SELECT DEPTNO
                                     FROM EMP
                                     WHERE ENAME LIKE('%S%'))
    AND SAL > (SELECT AVG(SAL)
                        FROM EMP);
--<11-25 ����>------------------------------------------------------------------------------------------------------------




































































