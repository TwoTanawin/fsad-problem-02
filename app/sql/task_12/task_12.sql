-- Step 1: Calculate the average price of your holdings
-- (This will be used in Step 2 for the WHERE condition)
DO $$ 
DECLARE
    avg_price NUMERIC;
BEGIN
    -- Step 1: Calculate the average price
    SELECT AVG(price) INTO avg_price FROM stock_prices;

    -- Step 2: Insert rows to double holdings for stocks with price above average
    INSERT INTO my_stocks (symbol, n_shares, date_acquired)
    SELECT ms.symbol, ms.n_shares, CURRENT_DATE
    FROM my_stocks ms
    JOIN stock_prices sp ON ms.symbol = sp.symbol
    WHERE sp.price > avg_price;

    -- Output to show the average price (optional for debug)
    RAISE NOTICE 'Average price is %', avg_price;
END $$;

-- Step 3: Produce a report of symbols and total shares held
SELECT symbol, SUM(n_shares) AS total_shares
FROM my_stocks
GROUP BY symbol;

-- Step 4: Produce a report of symbols and total value held per symbol
SELECT ms.symbol, SUM(ms.n_shares * sp.price) AS total_value
FROM my_stocks ms
JOIN stock_prices sp ON ms.symbol = sp.symbol
GROUP BY ms.symbol;

-- Step 5: Produce a report of symbols, total shares held, and total value held for "winners"
-- (symbols with at least two blocks of shares)
SELECT ms.symbol, SUM(ms.n_shares) AS total_shares, SUM(ms.n_shares * sp.price) AS total_value
FROM my_stocks ms
JOIN stock_prices sp ON ms.symbol = sp.symbol
GROUP BY ms.symbol
HAVING COUNT(*) >= 2;
