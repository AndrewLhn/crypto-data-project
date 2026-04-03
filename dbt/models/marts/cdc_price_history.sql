{{ config(
    materialized='incremental',
    unique_key=['id', 'last_updated'],
    schema='marts'
) }}

SELECT 
    id,
    name,
    current_price,
    price_change_percentage_24h,
    last_updated,
    CURRENT_TIMESTAMP as captured_at,
    'daily_snapshot' as change_type
FROM {{ ref('stg_crypto_markets') }}

{% if is_incremental() %}
    WHERE last_updated > (SELECT MAX(last_updated) FROM {{ this }})
{% endif %}
