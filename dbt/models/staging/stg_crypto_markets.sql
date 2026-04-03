{{ config(materialized='table') }}

SELECT 
    'bitcoin'::varchar as id,
    'btc'::varchar as symbol,
    'Bitcoin'::varchar as name,
    65000.00::numeric as current_price,
    1200000000000::bigint as market_cap,
    1::int as market_cap_rank,
    2.5::numeric as price_change_percentage_24h,
    NOW()::timestamp as last_updated
UNION ALL
SELECT 
    'ethereum',
    'eth',
    'Ethereum',
    3500.00,
    420000000000,
    2,
    1.8,
    NOW()
UNION ALL
SELECT 
    'cardano',
    'ada',
    'Cardano',
    0.50,
    18000000000,
    8,
    -1.2,
    NOW()
UNION ALL
SELECT 
    'solana',
    'sol',
    'Solana',
    180.00,
    80000000000,
    5,
    5.5,
    NOW()
