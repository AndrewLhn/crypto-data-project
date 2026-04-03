#!/bin/bash
echo "$(date): Starting ETL pipeline" >> ~/crypto-data-project/logs/etl.log
docker exec crypto_python_scheduler python /app/src/main.py >> ~/crypto-data-project/logs/etl.log 2>&1
echo "$(date): ETL completed" >> ~/crypto-data-project/logs/etl.log
