--2)	다중 행 함수 [그룹 함수]
--: 단일 행 함수와 달리 행 집합에 대해서 실행되어 그룹당 하나의 결과 산출. 이러한 행 집합은 전체 테이블이나 그룹으로 분할된 테이블로 구성될 수 있다.

SELECT SAL FROM EMP;

SELECT AVG(SAL), MAX(SAL), MIN(SAL), SUM(SAL)
FROM EMP;

SELECT AVG(SAL), MAX(SAL), MIN(SAL), SUM(SAL)
FROM EMP
WHERE JOB LIKE 'CLERK';

-- 가장 최근에 입사한 사원, 가장 오래 근무한 사원의 입사일
SELECT MAX(HIREDATE), MIN(HIREDATE)
FROM EMP;

-- 사전 순으로 정렬된 모든 사원 리스트에서 맨 마지막으로 나오는 사원의 이름, 맨 처음 나오는 사원의 이름
SELECT MAX(ENAME), MIN(ENAME)
FROM EMP;

-- AVG, SUM, VARIANCE(분산), STDDEV(표준편차) 함수는 숫자 데이터 유형만 사용 가능
-- MAX, MIN은 함수는 LOB형, LONG형 데이터 유형 사용 불가

-- COUNT: 테이블의 행 수를 반환
-- 전체 사원의 수를 구하시오
SELECT COUNT(*)
FROM EMP;

-- 실습 : 10번 부서 사원의 수를 구해보세요.
SELECT COUNT(ENAME)
FROM EMP
WHERE DEPTNO=10;

-- 다중 행 함수는 NULL이 아닌 값을 가진 행의 수를 반환하도록 설계되어 있다. 
-- =>	NULL 무시
-- =>	모수가 달라지는 경우가 생김
-- => 그러므로 NULL 처리 함수를 통해 모수를 맞춰주는 것을 신경 써야 함
SELECT COUNT(COMM), COUNT(NVL(COMM,0))
FROM EMP;

-- 실습 : 전체 사원의 수당의 평균을 구해보세요.
SELECT AVG(NVL(COMM,0)), AVG(COMM)
FROM EMP;

SELECT STDDEV(SAL) FROM EMP; --표준편차

-- 실습 : 전체 직원의 평균 급여, 급여 총 합계, 최고 급여, 최저 급여를 조회
-- (단, 평균 급여는 소수점 둘째 자리까지, 급여 총 합계는 천단위로 표기)
SELECT ROUND(AVG(SAL),2) "AVG_SAL", TO_CHAR(SUM(SAL),'$999,999') "SUM_SAL", MAX(SAL), MIN(SAL)
FROM EMP;

-- 모든 그룹함수가 테이블을 하나의 커다란 정보 그룹으로 취급
-- 그러나 이 정보 테이블을 더 작은 그룹으로 나눠야 하는 경우가 있다.
-- : GROUP BY 절

-- 각 부서번호 별로 평균 급여 조회
SELECT DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO ASC;

-- 실습 : 각 업무 별로 평균 급여를 조회해보세요.
SELECT JOB, ROUND(AVG(SAL), 0) "AVG_SAL"
FROM EMP
GROUP BY JOB;

-- GROUP BY 절에 두 개의 COLUMN 사용 가능
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB;  -- 모두 일치하는 ROW 끼리 그룹 생성

-- 실습: 업무별로 그룹화 하여 업무, 인원 수, 평균 급여액, 최고 급여액, 최소 급여액, 합계 조회
SELECT JOB, COUNT(ENAME), AVG(SAL), MAX(SAL), MIN(SAL), SUM(SAL)
FROM EMP
GROUP BY JOB;

-- HAVING 절: 작은 그룹들의 결과 제한
-- : WHERE 절을 사용하여 선택할 행을 제한하는 것과 동일한 방식으로 HAVING 절을 사용하여 그룹을 제한
SELECT DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL) > 2500;

--WHERE CONDITION : 조건을 TRUE로 만족하는 ROW 제한
--HAVING CONDITION : 조건을 TRUE로 만족하는 그룹 제한

--JOB별 평균 급여(단, 평균급여가 1500 이상)
SELECT JOB, AVG(SAL)
FROM EMP
GROUP BY JOB
HAVING AVG(SAL) >= 1500;

-- 실습 :
-- 1. 각 부서별로 몇 명의 인원이 있는지 출력
-- 2. 인원이 4명 이상인 부서번호와 인원을 출력해보세요
SELECT DEPTNO, COUNT(*)
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(*) >= 4;

-- 그룹함수 중첩 가능
SELECT MAX(AVG(SAL))
FROM EMP
GROUP BY DEPTNO;




































































































































