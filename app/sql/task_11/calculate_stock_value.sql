CREATE OR REPLACE FUNCTION stock_value(symbol IN VARCHAR2) 
RETURN NUMBER IS
    stock_val NUMBER := 0;
BEGIN
    FOR i IN 1..LENGTH(symbol) LOOP
        stock_val := stock_val + ASCII(SUBSTR(symbol, i, 1));
    END LOOP;
    RETURN stock_val;
END;
/
