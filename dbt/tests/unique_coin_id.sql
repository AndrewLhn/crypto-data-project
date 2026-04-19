
SELECT 
    id, 
    COUNT(*) as duplicate_count
FROM {{ ref('stg_crypto_markets') }}
GROUP BY id
HAVING COUNT(*) > 1
