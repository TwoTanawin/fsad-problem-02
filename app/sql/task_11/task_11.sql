CREATE OR REPLACE FUNCTION stock_value(symbol TEXT) 
RETURNS NUMERIC AS $$
DECLARE
    stock_val NUMERIC := 0;
    i INT;
BEGIN
    FOR i IN 1..LENGTH(symbol) LOOP
        stock_val := stock_val + ASCII(SUBSTRING(symbol FROM i FOR 1));
    END LOOP;
    RETURN stock_val;
END;
$$ LANGUAGE plpgsql;

UPDATE stock_prices
SET price = stock_value(symbol);

CREATE OR REPLACE FUNCTION portfolio_value() 
RETURNS NUMERIC AS $$
DECLARE
    total_value NUMERIC := 0;
    rec RECORD;
BEGIN
    FOR rec IN
        SELECT ms.n_shares, sp.price
        FROM my_stocks ms
        JOIN stock_prices sp ON ms.symbol = sp.symbol
    LOOP
        total_value := total_value + (rec.n_shares * rec.price);
    END LOOP;

    RETURN total_value;
END;
$$ LANGUAGE plpgsql;

-- Step 4: Select and display the portfolio value
SELECT portfolio_value();
