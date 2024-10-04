CREATE VIEW stocks_i_like AS
SELECT ms.symbol, SUM(ms.n_shares) AS total_shares, SUM(ms.n_shares * sp.price) AS total_value
FROM my_stocks ms
JOIN stock_prices sp ON ms.symbol = sp.symbol
GROUP BY ms.symbol
HAVING COUNT(*) >= 2;
