-- Проверка, что цены в разумном диапазоне
SELECT 
    id,
    name,
    current_price
FROM {{ ref('stg_crypto_markets') }}
WHERE current_price < 0 OR current_price > 1000000
