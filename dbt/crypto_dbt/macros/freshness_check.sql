{% macro check_data_freshness(table_name, max_age_hours=12) %}
    {% set query %}
        SELECT 
            MAX(last_updated) as last_update,
            EXTRACT(EPOCH FROM (NOW() - MAX(last_updated))) / 3600 as hours_ago
        FROM {{ ref(table_name) }}
    {% endset %}
    
    {% set results = run_query(query) %}
    {% set hours_ago = results.columns[1].values()[0] %}
    
    {% if hours_ago > max_age_hours %}
        {{ log("WARNING: Data is " ~ hours_ago ~ " hours old!", info=True) }}
    {% else %}
        {{ log("Data freshness OK: " ~ hours_ago ~ " hours ago", info=True) }}
    {% endif %}
{% endmacro %}
