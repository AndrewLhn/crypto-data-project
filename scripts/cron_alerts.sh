#!/bin/bash
LOG_FILE="$HOME/crypto-data-project/logs/alerts.log"
echo "$(date): Checking for anomalies" >> $LOG_FILE

# Проверяем аномалии в данных
cd ~/crypto-data-project
ANOMALIES=$(docker exec crypto_postgres psql -U crypto_user -d crypto_db -t -c "SELECT COUNT(*) FROM crypto_dbt.mart_crypto_metrics WHERE ABS(price_change_percentage_24h) > 20;" 2>/dev/null | xargs)

if [ -n "$ANOMALIES" ] && [ "$ANOMALIES" -gt 0 ]; then
    echo "$(date): WARNING - Found $ANOMALIES coins with abnormal price changes (>20%)" >> $LOG_FILE
    
    # Получаем список аномалий
    docker exec crypto_postgres psql -U crypto_user -d crypto_db -c "SELECT name, price_change_percentage_24h FROM crypto_dbt.mart_crypto_metrics WHERE ABS(price_change_percentage_24h) > 20 ORDER BY ABS(price_change_percentage_24h) DESC LIMIT 5;" >> $LOG_FILE 2>/dev/null
else
    echo "$(date): No anomalies detected" >> $LOG_FILE
fi

echo "$(date): Alert check completed" >> $LOG_FILE
