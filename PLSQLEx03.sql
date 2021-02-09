SET SERVEROUTPUT ON

--[제어문]
--[IF문]
--  - 처리 조건이 한개 일 경우
--    IF 조건 THEN
--        문장...;
--    END IF;
--
--  - 처리 조건이 두개 일 경우
--    IF 조건 THEN
--        문장...;
--    ELSE
--        문장...;
--    END IF;
--
--  - 처리 조건이 여러개 일 경우
--    IF 조건1 THEN
--        문장...;
--    ELSIF 조건2 THEN
--        문장...;
--    ...
--    ELSE
--        문장...;
--    END IF;

ACCEPT VNO NUMBER PROMPT'당신의 성적을 입력하세요:'
SET SERVEROUTPUT ON;
DECLARE
    VSCORE NUMBER:=&VNO;
BEGIN
    IF VSCORE>=90 THEN
        DBMS_OUTPUT.PUT_LINE('A학점');
    ELSIF VSCORE>=80 THEN
        DBMS_OUTPUT.PUT_LINE('B학점');
    ELSIF VSCORE>=70 THEN
        DBMS_OUTPUT.PUT_LINE('C학점');
    ELSIF VSCORE>=60 THEN
        DBMS_OUTPUT.PUT_LINE('D학점');
    ELSE
        DBMS_OUTPUT.PUT_LINE('F학점');
    END IF;
END;
/

--[CASE 문]
ACCEPT VGRADE PROMPT'당신의 학점을 입력하세요'     -- 따옴표 필수
DECLARE
    --GRADE CHAR(1);
    GRADE CHAR(2):=&VGRADE;
BEGIN
    --GRADE:='B';
    CASE GRADE
        WHEN 'A' THEN
            DBMS_OUTPUT.PUT_LINE('참 잘했어요');
        WHEN 'B' THEN
            DBMS_OUTPUT.PUT_LINE('잘했어요');
        WHEN 'C' THEN
            DBMS_OUTPUT.PUT_LINE('준수해요');
        WHEN 'D' THEN
            DBMS_OUTPUT.PUT_LINE('노력하세요');
        ELSE
            DBMS_OUTPUT.PUT_LINE('돌아가세요');
    END CASE;
END;
/
        
------------------------------------------------------
-- 사원번호가 7900인 사원의 급여 정보가 궁금
-- 이 사원의 급여가 3000 이상이면 급여를 출력
-- 급여가 3000 이하이면 급여를 미공개 - ****
DECLARE
    VEMPNO NUMBER:=7900;
    VENAME VARCHAR2(20);
    VSAL NUMBER(4);
BEGIN
    SELECT ENAME, SAL INTO VENAME, VSAL
    FROM EMP
    WHERE EMPNO = VEMPNO;
    
    DBMS_OUTPUT.PUT_LINE('사번      '||'이름      '||'급여');
    IF VSAL>=3000 THEN
        DBMS_OUTPUT.PUT_LINE(VEMPNO||'     '||VENAME||'     '||VSAL);
    ELSE
        DBMS_OUTPUT.PUT_LINE(VEMPNO||'     '||VENAME||'     '||'****');
    END IF;
END;
/

-----------------------------------------------------------------------------
ACCEPT VNO PROMPT'검색할 사번 입력'
DECLARE
--    VEMPNO NUMBER(5):=&VNO;
--    VEMPNO NUMBER(4):=&VNO;
--    VENAME VARCHAR2(20);
--    VSAL NUMBER(7);

--    VEMPNO EMP.EMPNO%TYPE:=&VNO;
--    VENAME EMP.ENAME%TYPE;
--    VSAL  EMP.SAL%TYPE;

    VEMPNO EMP.EMPNO%TYPE:=&VNO;
    VEMP EMP%ROWTYPE;
BEGIN
   -- SELECT EMPNO, ENAME, SAL INTO VEMPNO, VENAME, VSAL
   -- SELECT * INTO VEMPNO, VENAME, VSAL  -- 일단 다 불러오고 그중 3개만 저장, 하지만 뭐가 어디에 매칭되는지 모름
    SELECT * INTO VEMP       -- 그래서 1:1만 되는 TYPE 대신 전부 가져오는 ROWTYPE 씀
    FROM EMP
    WHERE EMPNO = VEMPNO;

    DBMS_OUTPUT.PUT_LINE('=========================');
    --DBMS_OUTPUT.PUT_LINE(VEMP.EMPNO||'     '||VEMP.ENAME||'     '||VEMP.SAL);
    DBMS_OUTPUT.PUT_LINE(VEMP.EMPNO||'     '||VEMP.ENAME||'     '||VEMP.SAL||'     '||VEMP.TEL);
END;
/

-- 변경1
-- 현재 회사가 잘 성장해서 드디어 사원번호가 10000 번이 생김
ALTER TABLE EMP
MODIFY EMPNO NUMBER(5); -- 만 대 자리까지 확보

INSERT INTO EMP (EMPNO, ENAME, SAL, DEPTNO)
VALUES(10000, 'GOOTT', 500, 10);

-- 변경2
-- 회사 정보에 수정이 생김(전화번호 항목 추가 후 사원 한명 더 추가)
ALTER TABLE EMP
ADD TEL VARCHAR2(16);

INSERT INTO EMP (EMPNO, ENAME, SAL, DEPTNO, TEL)
VALUES (10001,'GOOTT2',600,20,'01011112222');





















































































