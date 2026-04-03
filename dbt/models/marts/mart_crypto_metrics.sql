{{ config(materialized='table') }}

SELECT 
    id,
    symbol,
    name,
    current_price,
    market_cap,
    market_cap_rank,
    price_change_percentage_24h,
    CASE 
        WHEN price_change_percentage_24h > 5 THEN 'HIGH_GROWTH'
        WHEN price_change_percentage_24h > 0 THEN 'POSITIVE'
        WHEN price_change_percentage_24h < -5 THEN 'HIGH_DECLINE'
        WHEN price_change_percentage_24h < 0 THEN 'NEGATIVE'
        ELSE 'STABLE'
    END as performance_category,
    last_updated
FROM {{ ref('stg_crypto_markets') }}
ORDER BY market_cap_rank
