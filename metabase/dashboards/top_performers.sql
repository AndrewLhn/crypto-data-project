-- Top Gainers & Losers
SELECT 
    'Top Gainer' as type,
    name,
    CONCAT(ROUND(price_change_percentage_24h, 2), '%') as change_24h,
    CONCAT('$', current_price) as price
FROM crypto_dbt.mart_crypto_metrics
WHERE price_change_percentage_24h IS NOT NULL
ORDER BY price_change_percentage_24h DESC
LIMIT 5
UNION ALL
SELECT 
    'Top Loser' as type,
    name,
    CONCAT(ROUND(price_change_percentage_24h, 2), '%'),
    CONCAT('$', current_price)
FROM crypto_dbt.mart_crypto_metrics
WHERE price_change_percentage_24h IS NOT NULL
ORDER BY price_change_percentage_24h ASC
LIMIT 5;
