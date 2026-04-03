{{ config(
    materialized='incremental',
    unique_key=['id', 'last_updated'],
    tags=['fact']
) }}

SELECT 
    id,
    symbol,
    name,
    current_price,
    market_cap,
    price_change_percentage_24h,
    total_volume,
    high_24h,
    low_24h,
    last_updated,
    _loaded_at
FROM {{ ref('stg_crypto_markets') }}

{% if is_incremental() %}
    WHERE last_updated > (SELECT MAX(last_updated) FROM {{ this }})
{% endif %}
