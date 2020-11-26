-- [서브쿼리]
-- : SELECT 문의 일종의 고급 기능
-- : 다른 SQL문의 WHERE절에서 서브쿼리를 작성하여 알 수 없는 조건부 값
--   (프로그래머가 테이블에서 얻어 오는 값을 예상할 수 없을 때)을 기반으로 
--   최종적으로 원하고자 하는 값을 구하고자 할 때 사용

--	SELECT 문을 조건절에 넣어 줄 수 있음 ? 조건절에 들어가는 SELECT문을 SUBQUERY라고 부름
--	최종적으로 인출하려는 값을 표기하는 부분: MAIN QUERY

-- 서브쿼리 인출값 하나면 SINGLE ROW SUBQUERY
--              인출값 여러 개면 MULTIPLE ROW SUBQUERY
--              컬럼이 여러 개면 MULTIPLE COLUMN SUBQUERY

--> 서브쿼리 사용시 주의 사항
-- 1) 서브쿼리는 반드시 괄호 안에다가 쓰기
-- 문제: JONES 사원보다 더 많은 급여를 받는 사원의 사번, 이름, 급여
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL >= (SELECT SAL
                         FROM EMP
                         WHERE ENAME = 'JONES');
                         
-- 2) SINGLE ROW SUBQUERY 앞에는 SINGLE ROW OPERATOR (비교 연산자) 가 와야 한다.
-- : =, <, >, <=, >=, <>
SELECT ENAME, SAL
FROM EMP
WHERE SAL > (SELECT SAL --에러남
                       FROM EMP
                       WHERE ENAME = 'JONES' OR COMM IS NOT NULL);
                       
-- 3) MULTIPLE ROW SUBQUERY 앞에는 MULTIPLE ROW OPERATOR(IN, ANY, ALL)가 와야 한다.
-- IN 연산자: 여러 값 중 하나와 같다.
-- 10번 부서 사원들의 급여와 같은 급여를 받는 사원의 이름과 급여를 조회
SELECT ENAME, SAL
FROM EMP
WHERE SAL IN (SELECT SAL 
                        FROM EMP 
                        WHERE DEPTNO=10);
-- 문제 : 부서 번호가 10, 20, 30번 직원들의 부서번호별 평균 급여 중 하나와 
-- 같은 급여를 받는 사원의 사번, 이름, 급여 정보 조회
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL IN (SELECT TRUNC(AVG(SAL))
                        FROM EMP
                        GROUP BY DEPTNO);

SELECT DEPTNO, TRUNC(AVG(SAL))
FROM EMP
GROUP BY DEPTNO;

--<11-24 과제>------------------------------------------------------------------------------------------
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
-- : 문제 : 부서번호별로 가장 많은 급여를 받는 사원의 정보를 출력
SELECT DEPTNO, ENAME, SAL 
FROM EMP
WHERE SAL IN (SELECT MAX(SAL)
                    FROM EMP
                    GROUP BY DEPTNO);

-- 문제 : 다른 직원의 상관으로 근무하고 있는 직원의 사번, 이름, 급여 조회
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE EMPNO IN (SELECT MGR
                                FROM EMP);
                                
SELECT DISTINCT(E.ENAME), E.EMPNO, E.SAL
FROM EMP E JOIN EMP C
ON E.DEPTNO=C.DEPTNO
WHERE E.EMPNO = C.MGR;

-- 문제 : 부하직원이 없는 직원의 사번, 이름, 급여 조회
SELECT EMPNO, ENAME, SAL, MGR
FROM EMP
WHERE EMPNO NOT IN (SELECT MGR
                                        FROM EMP
                                        WHERE MGR IS NOT NULL);


-- ANY 연산자 : 여러 값 중 하나
--                  : 비교 연산자가 앞에 위치
--                  : 값 하나를 리스트의 값 또는 쿼리에서 반환되는 값과 각각 비교
-- SALESMAN 직책의 급여보다 많이 받는 사원의 사원명과 급여 정보를 조회
SELECT SAL, JOB
FROM EMP
WHERE SAL > ANY(SELECT SAL 
                               FROM EMP 
                               WHERE JOB='SALESMAN') 
            AND JOB <> 'SALESMAN';

-- 문제 : 부서번호가 10, 20, 30번인 직원들의 부서번호별 평균 급여 중 하나보다 작거나 같은 급여를 받는
--         직원의 급여, 이름, 사번을 조회하세요.
SELECT SAL, ENAME, EMPNO
FROM EMP
WHERE SAL <= ANY(SELECT AVG(SAL)
                                FROM EMP
                                WHERE DEPTNO IN (10, 20, 30)
                                GROUP BY DEPTNO);

-- ALL 연산자 : 모든 값
--                  : 비교연산자가 앞에 위치
-- 모든 SALESMAN의 급여보다 많이 받는 사원의 사원명과 급여 정보를 조회
SELECT ENAME, SAL
FROM EMP
WHERE SAL > ALL(SELECT SAL
                                FROM EMP
                                WHERE JOB = 'SALESMAN');

-- 문제 : 부서번호가 10, 20, 30번인 직원들의 부서번호별 평균 급여 모두 보다 작은 급여를 받는
--         직원의 사번, 급여, 이름을 조회하세요.
SELECT SAL, ENAME, EMPNO
FROM EMP
WHERE SAL < ALL(SELECT AVG(SAL)
                                FROM EMP
                                WHERE DEPTNO IN (10, 20, 30)
                                GROUP BY DEPTNO);

-- 4. 단일 행 서브쿼리 집합함수 사용 가능
-- EMP 테이블에서 부서별 평균 급여가 가장 큰 부서의 부서번호와 그 평균 급여를 구하시오
SELECT DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL) = (SELECT MAX(AVG(SAL))
                                 FROM EMP
                                 GROUP BY DEPTNO);

-- 문제 : EMP 테이블에서 직책별 평균 급여가 가장 작은 직책과 그 평균 급여를 구하시오
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
--5) 서브쿼리가 메인쿼리로 반환되는 행이 없으면
--(서브쿼리 조건을 만족하는 행이 없거나 또는 행이 있지만 해당 컬럼이 NULL 상태)
--메인쿼리의 결과는 항상 ‘선택된 행이 없음’ 이라는 메시지 표시된다.
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

-- 만족하는 행이 있지만 NULL상태인 경우는 추후 문제가 발생할 수 있다.
-- NULL을 없애도록 컬럼에 숫자는 NULL 대신 0, 문자는 ‘-‘ 같은 대체값을 입력해 둘 것
--	NULL 처리 함수를 사용할 수 있지만 데이터의 양이나 인덱스의 키 값 구성 방법에 따라 DB에 부하가 될 수 있다.


-- 6) EXISTS 연산자: 테이블의 특정 행이 있는지 여부에 따라 쿼리 결과가 달라지는 쿼리에 사용하는 연산자
-- : 서브쿼리 데이터가 존재하는가를 체크해 존재 여부(True/False)를 반환
-- : 서브쿼리에서 결과 행을 찾으면, INNER QUERY 수행을 중단하고 True 반환

-- 부서원이 없는 부서 정보를 조회
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

-- 사원 테이블을 통해 사원들이 속한 부서번호의 정보를 조회
-- 결과 : 추출하고자 하는 정보의 대상 테이블은 DEPT지만 EMP테이블과 조인하여 부서번호를 체크해야 함
--         두 테이블의 관계는 1:N 관계임. 그러므로 불필요하게 EMP 테이블을 모두 읽고 있는 상태
--         최종적으로는 중복 제거로 올바른 결과를 얻어냄
SELECT DISTINCT(D.DEPTNO), D.DNAME
FROM DEPT D, EMP E
WHERE D.DEPTNO=E.DEPTNO;
                            
-- EXISTS 연산자를 사용한 서브쿼리 질의문
-- 결과 : 추출하고자 하는 대상만을 FROM 절에 넣고 EMP 테이블은 체크만 하기 위해 EXISTS 절에 위치 시킨 상태
--          그러므로 전체 수행 속도 대폭 감소
SELECT D.DEPTNO, D.DNAME
FROM DEPT D
WHERE EXISTS (SELECT 1                                             
                            FROM EMP E
                            WHERE E.DEPTNO = D.DEPTNO);

--7) 서브쿼리문에는 ORDER BY절을 지원하지 않는다. (에러 발생)
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > (SELECT SAL
                        FROM EMP
                        WHERE ENAME = 'JONES'
                        ORDER BY 1);
















































