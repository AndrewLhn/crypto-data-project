-- Проверка валидности категорий
SELECT 
    id,
    name,
    performance_category
FROM {{ ref('mart_crypto_metrics') }}
WHERE performance_category NOT IN ('HIGH_GROWTH', 'POSITIVE', 'NEGATIVE', 'HIGH_DECLINE', 'STABLE')
