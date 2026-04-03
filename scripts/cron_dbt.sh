#!/bin/bash
echo "$(date): Starting dbt run" >> ~/crypto-data-project/logs/dbt.log
cd ~/crypto-data-project && ./dbt-run.sh run >> ~/crypto-data-project/logs/dbt.log 2>&1
echo "$(date): dbt run completed" >> ~/crypto-data-project/logs/dbt.log
