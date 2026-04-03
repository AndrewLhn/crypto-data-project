{{ config(
    materialized='table',
    unique_key='id',
    tags=['staging']
) }}

WITH source AS (
    -- Здесь мы будем читать данные из MinIO через external table
    -- Пока создаем заглушку, позже подключим через MinIO
    SELECT 
        '{{ run_started_at.strftime("%Y%m%d_%H%M%S") }}' as _loaded_at,
        'staging' as _source
)

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
FROM source
WHERE id IS NOT NULL
{% if is_incremental() %}
    AND last_updated > (SELECT MAX(last_updated) FROM {{ this }})
{% endif %}
