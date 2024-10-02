CREATE OR REPLACE FUNCTION portfolio_value 
RETURN NUMBER IS
    total_value NUMBER := 0;
    CURSOR stock_cursor IS 
        SELECT ms.n_shares, sp.price
        FROM my_stocks ms
        JOIN stock_prices sp
        ON ms.symbol = sp.symbol;
BEGIN
    FOR stock IN stock_cursor LOOP
        total_value := total_value + (stock.n_shares * stock.price);
    END LOOP;
    
    RETURN total_value;
END;
/
