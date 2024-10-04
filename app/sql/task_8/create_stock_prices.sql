CREATE TABLE stock_prices AS
SELECT 
    symbol, 
    CURRENT_DATE AS quote_date, 
    31.415 AS price
FROM 
    my_stocks;
