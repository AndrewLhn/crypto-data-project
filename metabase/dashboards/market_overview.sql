-- Market Overview Dashboard
SELECT 
    'Total Market Cap' as metric,
    CONCAT('$', ROUND(SUM(market_cap)::numeric / 1000000000, 2), 'B') as value
FROM crypto_dbt.mart_crypto_metrics
UNION ALL
SELECT 
    '24h Volume',
    CONCAT('$', ROUND(SUM(total_volume)::numeric / 1000000000, 2), 'B')
FROM crypto_dbt.mart_crypto_metrics
UNION ALL
SELECT 
    'Active Coins',
    COUNT(*)::text
FROM crypto_dbt.mart_crypto_metrics
UNION ALL
SELECT 
    'BTC Dominance',
    CONCAT(ROUND(100.0 * (SELECT market_cap FROM crypto_dbt.mart_crypto_metrics WHERE name = 'Bitcoin')::numeric / SUM(market_cap), 2), '%')
FROM crypto_dbt.mart_crypto_metrics;
