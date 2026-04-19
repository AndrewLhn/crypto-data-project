#!/bin/bash
echo "========================================="
echo "HEALTH CHECK: $(date)"
echo "========================================="


echo "Containers status:"
docker ps --format "table {{.Names}}\t{{.Status}}" | grep crypto


echo ""
echo "Data quality:"
docker exec crypto_postgres psql -U crypto_user -d crypto_db -c "SELECT COUNT(*) as total_coins, ROUND(AVG(current_price)::numeric,2) as avg_price FROM crypto_dbt.mart_crypto_metrics;"


echo ""
echo "Last ETL run:"
tail -3 ~/crypto-data-project/logs/etl.log | grep "completed"


echo ""
echo "Disk space:"
df -h ~ | tail -1

echo "========================================="
