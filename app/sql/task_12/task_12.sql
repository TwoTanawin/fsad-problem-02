DO $$ 
DECLARE
    avg_price NUMERIC;
BEGIN
    SELECT AVG(price) INTO avg_price FROM stock_prices;

    INSERT INTO my_stocks (symbol, n_shares, date_acquired)
    SELECT ms.symbol, ms.n_shares, CURRENT_DATE
    FROM my_stocks ms
    JOIN stock_prices sp ON ms.symbol = sp.symbol
    WHERE sp.price > avg_price;

    RAISE NOTICE 'Average price is %', avg_price;
END $$;

SELECT symbol, SUM(n_shares) AS total_shares
FROM my_stocks
GROUP BY symbol;

SELECT ms.symbol, SUM(ms.n_shares * sp.price) AS total_value
FROM my_stocks ms
JOIN stock_prices sp ON ms.symbol = sp.symbol
GROUP BY ms.symbol;

SELECT ms.symbol, SUM(ms.n_shares) AS total_shares, SUM(ms.n_shares * sp.price) AS total_value
FROM my_stocks ms
JOIN stock_prices sp ON ms.symbol = sp.symbol
GROUP BY ms.symbol
HAVING COUNT(*) >= 2;
