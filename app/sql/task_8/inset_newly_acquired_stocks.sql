INSERT INTO newly_acquired_stocks (symbol, n_shares, date_acquired)
SELECT symbol, n_shares, date_acquired
FROM my_stocks
WHERE n_shares <= 25;
