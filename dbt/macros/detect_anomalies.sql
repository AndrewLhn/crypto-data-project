{% macro detect_price_anomalies(threshold=10) %}
    SELECT 
        id,
        name,
        current_price,
        price_change_percentage_24h,
        last_updated,
        CASE 
            WHEN ABS(price_change_percentage_24h) > {{ threshold }} 
            THEN 'ANOMALY_DETECTED'
            ELSE 'NORMAL'
        END as anomaly_status
    FROM {{ ref('stg_crypto_markets') }}
    WHERE ABS(price_change_percentage_24h) > {{ threshold }}
{% endmacro %}
