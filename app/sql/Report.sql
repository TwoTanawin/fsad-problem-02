SELECT 
    my_stocks.symbol,
    my_stocks.n_shares,
    stock_prices.price AS price_per_share,
    my_stocks.n_shares * stock_prices.price AS current_value
FROM 
    my_stocks
JOIN 
    stock_prices 
ON 
    my_stocks.symbol = stock_prices.symbol;
