SET SERVEROUT ON

-- [LOOP]
DECLARE
    i integer:=0;
BEGIN
    -- basic loop
    LOOP        -- LOOP�� ������ ���� �� ����ؼ� �ݺ�
        i:=i+1;
    EXIT WHEN i>9;
    
    DBMS_OUTPUT.PUT_LINE('3 * ' || i || ' = ' || 3*i);
    END LOOP;
END;
/

-- [FOR LOOP]
--    FOR ī���� ���� IN �ּҰ�.. LOOP
--        ���� 1;
--        ���� 2;
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

-- basic loop, for loop�� ���� 1���� 100������ ���� ���غ�����
DECLARE
    VSUM NUMBER;
BEGIN
    VSUM:=0;
    
    FOR I IN 1..100 LOOP
        VSUM:=VSUM+I;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('1���� 100 ��:'||VSUM);
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
    DBMS_OUTPUT.PUT_LINE('1���� 100 ��:'||VSUM);
END;
/

BEGIN
    FOR I IN REVERSE 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;
/

-- [WHILE LOOP]
--    WHILE ���� LOOP
--        �ʿ��� ����;
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

-- WHILE LOOP�� ���� 1~100�� ���ϱ�
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














































































