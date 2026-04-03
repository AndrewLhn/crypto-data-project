{{ config(materialized='table') }}

SELECT 
    id,
    symbol,
    name,
    current_price,
    market_cap,
    market_cap_rank,
    price_change_percentage_24h,
    total_volume,
    high_24h,
    low_24h,
    last_updated,
    _loaded_at,
    _etl_id
FROM crypto_dbt.stg_crypto_markets
