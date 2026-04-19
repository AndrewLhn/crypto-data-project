#!/bin/bash
ANOMALIES=$(docker exec crypto_postgres psql -U crypto_user -d crypto_db -t -c "SELECT COUNT(*) FROM crypto_dbt.mart_crypto_metrics WHERE ABS(price_change_percentage_24h) > 10")
if [ $ANOMALIES -gt 0 ]; then
    echo "⚠️ Warning: $ANOMALIES cryptocurrencies with abnormal price changes!"
   
fi
