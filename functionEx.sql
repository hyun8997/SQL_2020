desc dept

select * from emp;

-- 함수 (제공되는 함수가 많으므로 대표적이고 자주 쓰는 것 위주로 진행)

--1) 단일 행 함수      일반, 문자, 숫자, 날짜, 변환
--A. 문자
--문자 변환
SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)
FROM EMP;

--문자 조작
SELECT ENAME, SUBSTR(ENAME, 1, 3), SUBSTR(ENAME, 4), LENGTH(ENAME), INSTR(ENAME, 'A')
FROM EMP;

SELECT ENAME, LPAD(SAL, 10, '*'), RPAD(SAL, 10, '*')
FROM EMP;

--기타
SELECT TRIM('o' FROM 'oracleDBMS') NAME
FROM DUAL;

DESC DUAL

SELECT * FROM DUAL; -- 1열 더미 테이블

SELECT TRIM(' ORACLEDATABASE'), TRIM('ORACLEDATAVASE')
FROM DUAL;

SELECT REPLACE('ORACLEDATABASE','ORACLE','DB') NAME FROM DUAL;

-- 실습 : 12월에 입사한 사원들의 이름, 입사일자, 급여를 조회해보세요
SELECT ENAME, HIREDATE, SAL
FROM EMP
WHERE SUBSTR(HIREDATE,4,2) = '12';

-- 실습 : 12월에 입사한 사원들 정보를 조회하고, 그 직원들의 정보를 6자리로 출력
--          (단, 부족한 자리수는 0으로 표기)
SELECT ENAME, HIREDATE, LPAD(SAL,6,'0') SAL
FROM EMP
WHERE SUBSTR(HIREDATE,4,2) = '12';

--B. 숫자 함수
SELECT ROUND(45.139, 2), TRUNC(45.139, 2)
FROM DUAL;

SELECT MOD(101, 2)
FROM DUAL;

-- 실습 : 전체 사원의 매니저를 구분 하려고 함
--  이름, 업무, 매니저(0,1), 매니저 번호 출력
--  (단, 매너지 번호가 짝수이면 0, 홀수이면 1로 구분)

SELECT ENAME, JOB, MOD(MGR, 2) AS "MGR(0, 1)", MGR
FROM EMP;

--C. 날짜 함수
-- SYSDATE
SELECT SYSDATE FROM DUAL;

SELECT HIREDATE, 
            MONTHS_BETWEEN(SYSDATE, HIREDATE),
            ADD_MONTHS(HIREDATE, 6),
            NEXT_DAY(HIREDATE, '금'),
            LAST_DAY(HIREDATE)
FROM EMP; 

-- 실습 : 이번 달의 마지막 일자를 출력
SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- 실습 : 근무 개월 수가 470개월 이상인 사원의 이름, 입사일자, 근무개월 수 조회
--      (단, 근무 개월 수는 월 단위로 표기)

--단일 행 함수는 함수 중첩이 가능
SELECT ENAME, HIREDATE, ROUND(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS "근무 개월 수"
FROM EMP
WHERE MONTHS_BETWEEN(SYSDATE, HIREDATE) >= 470;
 
-- 실습 : 우리 회사는 입사 후 6개월이 지난 사원에 대해서 그 주 금요일에 승진 시험을 볼 겁니다.
-- 그 시험일이 궁금하니 사원명, 입사일, 6개월 후 금요일 정보를 조회하세요
SELECT ENAME, HIREDATE, NEXT_DAY(ADD_MONTHS(HIREDATE, '6'), '금') AS "6개월 후 금요일"
FROM EMP;

-- 날짜 연산 가능
SELECT SYSDATE + 1 FROM DUAL;
SELECT SYSDATE - 1 FROM DUAL;

SELECT SYSDATE-HIREDATE FROM EMP;

SELECT SYSDATE+HIREDATE FROM EMP;   --X

--  실습 : 전체 사원드의 이름, 근무년수 조회해보세요
-- (단 근무년수는 년단위로 표기)
SELECT ENAME, TRUNC((SYSDATE-HIREDATE)/365) AS "근무년수"
FROM EMP;

SELECT SYSDATE - '80/01/01' FROM DUAL;      -- 날짜-문자라서 에러남
SELECT SYSDATE - TO_DATE('80/01/01') FROM DUAL;    

--D. 변환 함수
--ⅰ) 암시적: 오라클 서버가 자동으로 바꿔 줌
--ⅱ) 명시적

SELECT SYSDATE - TO_DATE('99/01/01')
FROM DUAL;

SELECT SYSDATE - TO_DATE('99-01-01')    --가능하지만 본 형태로 해주는게 좋다
FROM DUAL;

SELECT SYSDATE
FROM DUAL;

-- 날짜 형식 모델 요소
-- YYYY : 숫자로된 전체 연도
-- YEAR : 영어 철자로 표기된 연도
-- MM : 월의 2자리 값
-- MONTH : 전체 월의 이름
-- MON : 월의 3자 약어
-- DD : 숫자 형식의 월간 일
-- DAY : 요일 전체 이름
-- DY : 요일 3자 약어

SELECT SYSDATE, TO_CHAR(SYSDATE, 'cc yyyy/mm/dd - hh24 : mi : ss')
FROM DUAL;

-- 숫자 표현 형식 요소
-- 9 : 숫자를 나타냄
-- 0 : 0이 표시되도록 강제
-- $ : 부동 달러 기호 배치
-- L : 부동 로컬 통화 기호 배치
-- . : 소숫점 출력
-- , : 천 단위 표시자

-- 달러
SELECT ENAME, SAL, LPAD(SAL, 6,'+'), TO_CHAR(SAL, 'L999,999.99')
FROM EMP;

-- 로컬화폐
SELECT ENAME, SAL, LPAD(SAL, 6,'+'), TO_CHAR(SAL, 'L999,999.99')
FROM EMP;

-- 0 강제
SELECT 123, TO_CHAR(123, '0000') FROM DUAL;

-- 16진수
SELECT  TO_CHAR(123, 'XXXX') FROM DUAL;

-- 문자를 숫자로 변환
SELECT TO_NUMBER('0123456789') FROM DUAL;

-- E. 일반 함수
-- ⅰ) NULL 처리 함수
SELECT ENAME, SAL, COMM, SAL*12+COMM FULLSAL
FROM EMP;

-- NVL
SELECT ENAME, SAL, COMM, SAL*12+NVL(COMM, 0) FULLSAL
FROM EMP;

-- NVL2 (COL, VAL1, VAL2)
-- COL 값이 NULL이 아니면 VAL1을 선택, NULL이면 VAL2
SELECT ENAME, MGR, NVL2(MGR, 1, 0) MGR
FROM EMP;

-- COALESCE (COL, VAL1, VAL2)
-- COL이 NULL이면 VAL1, VAL1이 NULL이라면 VAL2
SELECT ENAME, COALESCE(COMM, NULL, 0) COMM
FROM EMP;

-- NULLIF : 두 표현식을 비교하여 동일한 경우에는 NULL을 반환, 동일하지 않으면 첫번째 표현식을 반환
SELECT NULLIF('A', 'a'), NULLIF('A', 'A')
FROM DUAL;

-------------------------------------------------------------------------------------------------------
-- 11/20 과제
--1
SELECT RPAD(SUBSTR(ENAME, 1,2),LENGTH(ENAME), '*') 
FROM EMP;

--2         
SELECT TO_CHAR(ROUND(HIREDATE, 'MONTH'),'YYYY-MM-DD')
FROM EMP;

--3
SELECT ENAME, COMM, NVL2(COMM,TO_CHAR(COMM), '대기발령')
FROM EMP;

--4
SELECT TO_CHAR(TRUNC(HIREDATE,'YEAR'),'YYYY') AS "입사년도", 
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
SELECT ENAME, SAL*12+NVL(COMM,0) AS "연봉"
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

-- ⅱ) 조건 함수
-- DECODE 함수: 조건에 따라 데이터를 다른 값이나 COLUMN으로 추출할 수 있도록 하는 함수
--	: DECODE(VALUE, IF1, THEN1, IF2, THEN2, …) 형태
--	: => VALUE 값이 IF1 이면 THEN1 값을 반환, IF2 면 THEN2 값 반환, …
--	: => DECODE 함수 안에 DECODE 함수 중첩 사용 가능

-- 부서번호가 10이면 ACCOUNTING, 20이면 RESEARCH, 30이면 SALES, 나머지면 OERATIONS 출력
SELECT DEPTNO,
    DECODE(DEPTNO, 10, '10번 부서', 
                                20, '20번 부서', 
                                30, '30번 부서', 
                                'OPERATIONS') DEPT -- 명확한 조건을 안주면 나머지 의미
FROM DEPT;

-- CASE 함수: DECODE에서 제공하지 못하는 비교연산을 해결할 수 있는 함수
--	: => 비교/조건 연산자를 모두 사용할 수 있다.
 SELECT DEPTNO,
    CASE DEPTNO
        WHEN 10 THEN '10번 부서'
        WHEN 20 THEN '20번 부서'
        WHEN 30 THEN '30번 부서'
        ELSE '나머지부서'
    END "NAME"
FROM DEPT;

-- CASE 와 비교/조건 연산자
-- 급여별로 인상률을 다르게 적용(계산)
-- 1000 이하이면 8%, 2000 이하이면 5%, 3000 이하이면 3%, 그 이상이면 1% 인상
SELECT ENAME, SAL,
    CASE
        WHEN SAL <= 1000 THEN SAL * 1.08
        WHEN SAL <= 2000 THEN SAL * 1.05
        WHEN SAL <= 3000 THEN SAL * 1.03
        ELSE SAL * 1.01
    END "인상급여",
    CASE
        WHEN SAL <= 1000  THEN '8%'
        WHEN SAL <= 2000 AND SAL > 1000 THEN '5%'
        WHEN SAL BETWEEN 2001 AND 3000 THEN '3%'
        ELSE '1%'
    END "인상률"
FROM EMP;

-- 실습: 직책이 매니저인 사원은 급여를 10% 인상, 직책이 일반 사원인 사원은 급여를 5% 인상
--         나머지는 2% 인상해서 사원이름, 직책, 급여, 인상된 급여(UPSAL)를 출력
SELECT ENAME, JOB, SAL,
    CASE JOB
        WHEN 'MANAGER' THEN SAL * 1.1
        WHEN 'CLERK' THEN SAL * 1.05
        ELSE SAL * 1.02
    END "UPSAL"
FROM EMP;

-- CONCAT: 문자를 붙일 때
SELECT ENAME, INITCAP(CONCAT(SUBSTR(ENAME,1,2), '_US')) || ' PLUS' "NAME"
FROM EMP
WHERE DEPTNO=10;



































































