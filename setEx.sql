-- 복합 쿼리
-- : 집합 연산자가 포함된 쿼리
-- : 집합 연산자 - 둘 이상의 구성 요소 쿼리 결과를 하나의 결과로 조합
-- : 종류 - UNION, UNION ALL, INTERSECT, MINUS (SET OPERATOR)
-- : 집합 연산자는 모두 우선 순위가 같다. 명시적으로 괄호()로 순서를 지정하지 않는 한 왼쪽(위)에서 오른쪽(아래)로 연산자를 평가
--    다른 집합 연산자와 합꼐 MINUS가 사용된 쿼리문이라면 집합의 배치에 주의

-- > 집합 연산자 지침
-- : SELECT 리스트의 표현식은 갯수가 일치해야 한다.
-- : 두 번째 쿼리에 있는 각 열의 데이터 유형은 첫 번째 쿼리에 있는 (상응하는) 열의 데이터 유형과 일치해야 한다.
-- : 실행 순서를 변경하려면 괄호를 사용해야 한다.
-- : ORDER BY 절은 명령문의 맨 끝에 사용해야 한다.
-- : UNION ALL 연산자를 제외한 나머지 SET 연산자는 처리 중에 정렬(SORT)이 발생하므로 처리할 데이터(레코드)
--   양에 따라 메모리 소모가 많을 수 있다.

-- UNION: 합집합
--           : 두 테이블의 결합, 결합시키는 두 테이블의 중복되지 않은 값들을 반환
-- 부서번호를 조회 (합집합)
SELECT DEPTNO FROM EMP
UNION
SELECT DEPTNO FROM DEPT;

SELECT EMPNO FROM EMP
UNION
SELECT DEPTNO FROM DEPT;

-- UNION ALL: 중복을 포함하는 합집합
--                 : UNION과 같으나 두 테이블의 중복되는 값까지 반환
SELECT DEPTNO FROM EMP
UNION ALL
SELECT DEPTNO FROM DEPT;

SELECT EMPNO FROM EMP
UNION ALL
SELECT DEPTNO FROM DEPT;

-- INTERSECT: 교집합
--                  : 두 행의 집합 중 공통된 행 반환
SELECT DEPTNO FROM EMP
INTERSECT
SELECT DEPTNO FROM DEPT;

SELECT EMPNO FROM EMP
INTERSECT
SELECT DEPTNO FROM DEPT;

-- MINUS: 차집합
--          : 첫 번째 SELECT문에 의해 반환되는 행들 중 두 번째 SELECT문에 의해 반환되는 행에 존재하지 않는 행들 반환
-- 문제 : 사원이 없는 부서를 조회해보세요.
SELECT DEPTNO FROM DEPT
MINUS
SELECT DEPTNO FROM EMP;

-- 유의할 점
-- : 두 SELECT문의 컬럼 갯수, 데이터 유형이 일치하지 않을 경우 에러 발생
SELECT DEPTNO, HIREDATE FROM EMP
UNION
SELECT DEPTNO, LOC FROM DEPT;  --데이터 타입 달라서 에러

-- 1) 변환 함수 사용하여 에러 해결
SELECT DEPTNO, TO_CHAR(HIREDATE) FROM EMP
UNION
SELECT DEPTNO, LOC FROM DEPT;   --데이터 타입을 맞추는 방법

-- 2) NULL 키워드 사용
--문자->날짜 등 변환함수 사용 어려울 때(공간확보용 NULL)
SELECT DEPTNO, NULL, HIREDATE FROM EMP
UNION
SELECT DEPTNO, LOC, NULL FROM DEPT; 

-- 3) 적절한 상수를 이용하여 에러 해결
SELECT EMPNO, SAL, COMM, ENAME FROM EMP
UNION
SELECT DEPTNO, 0,0, '-' FROM DEPT; 

--<11-25 과제>------------------------------------------------------------------------------------------------------------
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
--<11-25 과제>------------------------------------------------------------------------------------------------------------




































































