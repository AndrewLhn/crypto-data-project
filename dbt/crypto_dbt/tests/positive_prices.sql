SELECT 
    id,
    name,
    current_price
FROM {{ ref('stg_crypto_markets') }}
WHERE current_price <= 0
