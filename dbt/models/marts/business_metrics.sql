{{ config(materialized='view') }}

SELECT 
    COUNT(DISTINCT id) as total_coins,
    SUM(market_cap) as total_market_cap,
    AVG(current_price) as avg_price,
    COUNT(CASE WHEN price_change_percentage_24h > 0 THEN 1 END) as coins_growing,
    COUNT(CASE WHEN price_change_percentage_24h < 0 THEN 1 END) as coins_declining,
    MAX(price_change_percentage_24h) as best_performer,
    MIN(price_change_percentage_24h) as worst_performer,
    MAX(last_updated) as last_data_update
FROM {{ ref('mart_crypto_metrics') }}
