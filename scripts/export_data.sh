#!/bin/bash
docker exec crypto_postgres psql -U crypto_user -d crypto_db -c "\copy (SELECT * FROM crypto_dbt.mart_crypto_metrics) TO '/tmp/crypto_report.csv' CSV HEADER"
docker cp crypto_postgres:/tmp/crypto_report.csv ./reports/crypto_report_$(date +%Y%m%d).csv
