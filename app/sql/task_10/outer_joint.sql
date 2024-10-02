SELECT 
    my_stocks.symbol,
    my_stocks.n_shares,
    stock_prices.price AS price_per_share,
    COALESCE(my_stocks.n_shares * stock_prices.price, 0) AS current_value
FROM 
    my_stocks
LEFT OUTER JOIN 
    stock_prices 
ON 
    my_stocks.symbol = stock_prices.symbol;
