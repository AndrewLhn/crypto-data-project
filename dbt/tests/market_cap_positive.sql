SELECT id, name, market_cap 
FROM {{ ref('mart_crypto_metrics') }}
WHERE market_cap <= 0
