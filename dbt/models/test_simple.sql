{{ config(materialized='table') }}

SELECT 
    'Test' as test_column,
    NOW() as timestamp
