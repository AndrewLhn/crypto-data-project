{{ config(
    materialized='table',
    unique_key='coin_id',
    tags=['dimension']
) }}

SELECT DISTINCT
    id as coin_id,
    symbol,
    name,
    market_cap_rank,
    CURRENT_TIMESTAMP as valid_from,
    NULL as valid_to
FROM {{ ref('stg_crypto_markets') }}
WHERE id IS NOT NULL
ORDER BY market_cap_rank
