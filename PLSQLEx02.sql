SET SERVEROUT ON

-- [LOOP]
DECLARE
    i integer:=0;
BEGIN
    -- basic loop
    LOOP        -- LOOP는 조건이 없을 시 계속해서 반복
        i:=i+1;
    EXIT WHEN i>9;
    
    DBMS_OUTPUT.PUT_LINE('3 * ' || i || ' = ' || 3*i);
    END LOOP;
END;
/

-- [FOR LOOP]
--    FOR 카운터 변수 IN 최소값.. LOOP
--        문장 1;
--        문장 2;
--        .
--        .
--    END LOOP;

BEGIN
    for i in 2 .. 9 loop
        for j in 1 .. 9 loop
            DBMS_OUTPUT.PUT_LINE(i || ' * ' || j || ' = ' || j*i);
        end loop;
    end loop;
END;
/

-- basic loop, for loop로 각각 1부터 100까지의 합을 구해보세요
DECLARE
    VSUM NUMBER;
BEGIN
    VSUM:=0;
    
    FOR I IN 1..100 LOOP
        VSUM:=VSUM+I;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('1부터 100 합:'||VSUM);
END;
/

DECLARE
    VSUM NUMBER;
    i integer:=0;
BEGIN
    VSUM:=0;
    LOOP
        i:=i+1;
        VSUM:=VSUM+i;
    EXIT WHEN i>=100;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('1부터 100 합:'||VSUM);
END;
/

BEGIN
    FOR I IN REVERSE 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;
/

-- [WHILE LOOP]
--    WHILE 조건 LOOP
--        필요한 로직;
--    END LOOP;
DECLARE
    I NUMBER:=0;
BEGIN
    WHILE I<=9 LOOP
        I:=I+1;
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;
/

-- WHILE LOOP를 통해 1~100합 구하기
DECLARE
    I INTEGER;
    VSUM INTEGER;
BEGIN
    I:=0;
    VSUM:=0;
    WHILE I<100 LOOP
        I:=I+1;
        VSUM:=VSUM+I;
    END LOOP;
    dbms_output.put_line(VSUM);
END;
/














































































