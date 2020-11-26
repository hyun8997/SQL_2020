-- [ JOIN 기능(함수) ]

SELECT ENAME, DNAME
FROM EMP, DEPT;        
-- CARTESIAN PRODUCT: 가능한 모든 수의 조합

SELECT * FROM EMP;
SELECT * FROM DEPT;

-- 조인
-- : 조인-조건을 기준으로 두 테이블의 각 행들을 합친 후, 원하는 데이터의 레코드를 가져오는 방법
-- [SQL 92 JOIN]
-- : EQUI-JOIN
-- : NON - EQUI JOIN
-- : SELF-JOIN
-- : OUTER-JOIN

-- [ANSI 표준 JOIN 형식]
-- : INNER JOIN - EQUI INNER JOIN
--                      - NONE EQUI INNER JOIN
-- : OUTER JOIN
-- : CROSS JOIN
-- : NATURAL JOIN

---	SELECT에서 COLUMN을 테이블과 함께 명확하게 물어보아야 결과가 도출됨에 유의
---	컬럼명 모두에 테이블 명을 적어두면 ACCESS 효율이 좋아진다.
---	테이블 이름이 너무 길면 FROM 절에 테이블 두고 이니셜로
---	ANSI EQUI-INNER JOIN은 콤마 대신 INNER JOIN이라는 문자로 사용
---	INNER는 생략이 가능, JOIN CONDITION은 ON절에 온다.

--------------------------------------------------------------------------------------------------
SELECT ENAME, DNAME
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;
-- WHERE CONDITION : JOIN CONDITION = T/F 를 요구하는 조건

-- 조건을 더 명확하게 줄 수도 있음
SELECT ENAME, DNAME
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO
    AND SAL >= 3000;

-- 조인 조건 : 보통 둘 이상의 행들의 공통된 값 Primary key 및 Foreign key 값을 사용하여 조인
--               : 두 개의 테이블을 select 문장 안에서 조인하려면 적어도 하나의 컬럼이 그 두 테이블 사이에서 공유되어야 한다.

-- [SQL EQUI-JOIN]  두 테이블의 공유 조건이 TRUE일 때
SELECT E.EMPNO, E.ENAME, D.DNAME -- 정보의 출처를 보여주는걸 권장
FROM EMP E, DEPT D                      -- 별칭을 달아서 간편하게 함
WHERE E.DEPTNO = D.DEPTNO;

-- SELECT에서 COLUMN을 테이블과 함께 명확하게 물어보아야 결과가 도출됨에 유의

-- [ANSI EQUI-INNER JOIN] 두 테이블의 공유 조건이 TRUE일 때
SELECT E.EMPNO, E.ENAME, D.DNAME
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

-- [ANSI NONE EQUI-INNER JOIN] 
--테이블의 어떤 컬럼도 JOIN할 테이블의 컬럼에 일치하지 않을 때
--조건에 ‘=’이 아닌 다른 연산자(BETWEEN AND, IS NULL, IS NOT NULL, IN, NOT)가 사용
--많이 사용되는 JOIN 아님, 사용되지 않도록 처음부터 공유되는 컬럼이 있도록 구성 권장

-- 전체 사원의 이름과 급여 등급을 조회
-- SALGRADE: 호봉에 따른 급여 최대치, 최소치 정보 있음
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
FROM EMP E INNER JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL;

-- 전체 사원명, 부서명, 급여 등급을 조회 => 3-Way join
SELECT E. EMPNO, E.DEPTNO, S.GRADE
FROM EMP E JOIN SALGRADE S
ON E.SAL < S.HISAL AND E.SAL >= S.LOSAL;

-- 11-23 과제 ----------------------------------------------------------
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
SELECT DEPTNO, ENAME, ROUND( SAL/(8*30) ,2) "시급"
FROM EMP
ORDER BY DEPTNO, "시급" DESC;

--4
SELECT DEPTNO,
CASE
    WHEN AVG(SAL)>=2000 THEN '초과'
    ELSE '미만'
END AS "평균급여"
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
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') AS "현재시간",
            TO_CHAR(SYSDATE+1/24,'YYYY-MM-DD HH24:MI:SS') AS "한시간후"
FROM DUAL;

--7
SELECT EMPNO, ENAME, HIREDATE, TRUNC((SYSDATE-HIREDATE)/365) AS "근무년수"
FROM EMP
WHERE TRUNC((SYSDATE-HIREDATE)/365) < 30;

-- 11-23 과제 ----------------------------------------------------------

-- <11-24>
-- EMP와 DEPT EQUI JOIN, EMP와 SALGRADE NONE EQUI JOIN
-- =>	DEPT와 SALGRADE를 JOIN할 수 있음(EMP를 통해서)
-- : 3개의 테이블을 조인하는 것을 3-way 조인.
-- : 3개 이상의 테이블을 조인하는 것을 N-way 조인, N-way 조인 구문 작성시에 JOIN 키워드 다음에 선언된 테이블은
--   항상 앞에 선언된 테이블 하고만 조인될 수 있음에 유의
--   즉, 뒤에 있는 테이블 하고는 조인할 수 없다.

-- 조인-조건의 개수 : 테이블 ? 1개
-- EX) A = B, B = C, A = C ===> A=B, A=C
SELECT E.ENAME, D.DNAME, S.GRADE
FROM EMP E, DEPT D, SALGRADE S
WHERE E.DEPTNO = D.DEPTNO AND E.SAL BETWEEN S.LOSAL AND S.HISAL;

-- [SQL 92 SELF JOIN]
-- EQUI JOIN과 같으나 하나의 테이블에서 조인이 일어나는 형태
-- 같은 테이블에 대하여 두 개의 ALIAS를 사용하여 FROM 절에 두 개의 테이블을 사용하는 것 처럼 조인
-- 서로 다른 ROW끼리 비교
-- 상사의 이름 조회
SELECT E.EMPNO, E.ENAME, E.MGR, C.EMPNO, C.ENAME
FROM EMP E, EMP C
WHERE E.MGR = C.EMPNO;

-- [SQL 92 OUTER JOIN]
-- : EQUI-JOIN은 조인을 생성하려는 두 테이블의 한 쪽 컬럼에 값이 없다면 데이터를 반환하지 못한다.
-- : -	동일 조건에서 조인 조건을 만족하는 값이 없는(FALSE, NULL) 행들을 조회
-- : OUTER JOIN의 연산자는 (+)
-- : 조인시 조인값이 없는 조인측에 (+)를 위치시킴
-- : OUTER JOIN 연산자는 표현식의 한쪽에만 올 수 있다.
-- : JOIN 대상 둘 다 없을 경우 보고 싶은 정보 쪽에 씀

-- 모든 부서 번호와 부서명 조회
SELECT DISTINCT(E.DEPTNO) "E_DEPTNO", D.DEPTNO "D_DEPTNO", D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;

-- 실습 : 사원 테이블에서 사원이름 모두와 매니저 명을 조회하세요
SELECT E.ENAME, C.ENAME
FROM EMP E, EMP C
WHERE E.MGR = C.EMPNO(+);

--[ANSI OUTER JOIN]
--: LEFT OUTER JOIN, RIGHT OUTER JOIN, FULL OUTER JOIN

--LEFT OUTER JOIN : INNER JOIN 결과도 표시하고 JOIN 키워도 왼편에 있는 테이블에서 
--조인 조건을 만족시키지 못해서 표시되지 않는 레코드를 더 표시
SELECT DISTINCT(E.DEPTNO), D.DEPTNO
FROM EMP E LEFT OUTER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

--RIGHT OUTER JOIN : INNER JOIN 결과도 표시하고 JOIN 키워도 오른편에 있는 테이블에서 
--조인 조건을 만족시키지 못해서 표시되지 않는 레코드를 더 표시
SELECT DISTINCT(E.DEPTNO), D.DEPTNO
FROM EMP E RIGHT OUTER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

--FULL OUTER JOIN: 양쪽 테이블 모두에 OUTER JOIN이 필요한 경우에 사용
SELECT DISTINCT(E.DEPTNO), D.DEPTNO
FROM EMP E FULL OUTER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

-- [ANSI NATURAL JOIN]
-- : EQUI JOIN과 거의 동일하다고 보면 됨
-- : 두 테이블의 동일한 이름을 가진 컬럼은 모두 조인이 됨
-- : 동일한 컬럼이 2개 이상일 경우, JOIN ~ USING 문장으로 조인되는 컬럼을 제어할 수 있음
-- : 동일한 컬럼을 내부적으로 모두 조인하므로 ON절 생략 가능
SELECT E.ENAME, D.DNAME
FROM EMP E NATURAL JOIN DEPT D;

-- 동일한 컬럼이 두개 이상이라면 : JOIN ~ USING
SELECT E.ENAME, D.DNAME
FROM EMP E JOIN DEPT D
USING (DEPTNO);

-- [ANSI CROSS JOIN]
-- : CARTESIAN PROJECT 값을 얻을 때 사용, 거의 사용 X
-- : INNER JOIN 또는 OUTER JOIN으로 합쳐질 수 없는 행을 합쳐야 할 때 사용할 수 있다.
SELECT ENAME
FROM EMP CROSS JOIN DEPT;

-- 테이블의 행의 수를 극소수로 제한하는 조건절과 함께 사용하는 것을 권장
SELECT ENAME, DNAME
FROM EMP CROSS JOIN DEPT
WHERE DEPT.DEPTNO=10;

-------------------------------------------------------------
-- + 테이블 조인 시 추가적인 조건을 적용 가능
-- INNER JOIN에서는 추가적인 조건을 기술할 때 ON절 뒤에 AND절 또는 WHERE절을 이용 가능(둘 다 가능)
-- 10번 부서에 근무하는 사원의 이름과 부서 이름을 조회
SELECT E.DEPTNO, E.ENAME, D.DNAME
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
AND E.DEPTNO=10;

-- 실습 : 부서 위치가 'BOSTON'인 사원의 사번, 이름, 부서번호, 부서명, 입사일을 조회하세요.
SELECT E.EMPNO, E.ENAME, E.DEPTNO, D.DNAME, E.HIREDATE
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
AND D.LOC='BOSTON';


-- OUTER JOIN + WHERE 절
SELECT E.ENAME, D.DNAME
FROM EMP E LEFT OUTER JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
WHERE E.DEPTNO=30;

SELECT E.ENAME, D.DNAME
FROM EMP E LEFT OUTER JOIN DEPT D
ON E.DEPTNO=D.DEPTNO
AND E.DEPTNO=30;

-- OUTER JOIN에서는 추가적인 조건을 기술 시에 AND절 또는 WHERE 절 사용시 표시되는 결과가 다를 수 있음에 주의.

--------------------------------------------------------------------------------------------------------------

--FUNCTIONS_DML_SELECT
--
--SINGLE ROW FUNCTION		단일 행 함수
--: 문자, 숫자, 날짜, 변환, 일반
--
--MULTIPLE ROW FUNCTION	다중 행 함수
--: 여러 값을 만나 값 하나를 돌려주는 함수
--: COUNT, AVG, SUM, MIN, MAX
--
--GROUP FUCTION			
--: GROUP BY 절을 통해서 테이블을 나누고 그 안에서 각각 값 하나 반환
--: 작은 그룹 단위로 묶은 후 MULTIPLE 함수를 사용
--: 작은 그룹에서 데이터를 제한(원하는 정보를 추출) : HAVING 절 사용
--SELECT DEPTNO, AVG(SAL)
--FROM EMP
--GROUP BY DEPTNO
--HAVING AVG(SAL)>=2500;

--------------------------------------------------------------------------------------------------------

--SELECT 문
--4 SELECT 컬럼명, 컬럼명, *, f(x), ||, ‘~~’, ALIAS, DISTINCT(), SAL*12
--1 FROM 테이블명, 테이블명, … n개
--2 WHERE CONDITION ? 연산자(비교/논리/BETWEEN AND/IN/LIKE/IS NULL) =>NOT 부정 가능
--3 GROUP BY 컬럼, 컬럼, …
--5 HAVING CONDITION ? WHERE CONDITION에서 사용하는 연산자와 같은 연산자
--6 ORDER BY 컬럼명(컬럼명/ALIAS/POSITION) <ASC/DESC>, 컬럼명
--                   (첫번째 컬럼으로 1차 정렬 후 두번째 컬럼으로 2차 정렬)

-- 문제 : 급여가 1000이상인 사원을 대상으로 조사
-- 부서번호별 직책별 평균 급여를 구하려고 한다.
-- 단, 평균 급여는 2000 이상
-- 평균 급여가 많은 순으로 출력
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
WHERE SAL >= 1000
GROUP BY DEPTNO, JOB
HAVING AVG(SAL) >= 2000
ORDER BY AVG(SAL) DESC;
































































