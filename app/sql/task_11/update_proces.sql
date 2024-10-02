BEGIN
    UPDATE stock_prices sp
    SET sp.price = stock_value(sp.symbol);
END;
/
