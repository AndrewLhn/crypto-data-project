#!/bin/bash
echo "$(date): Starting dbt tests" >> ~/crypto-data-project/logs/dbt_test.log
cd ~/crypto-data-project && ./dbt-run.sh test >> ~/crypto-data-project/logs/dbt_test.log 2>&1
echo "$(date): dbt tests completed" >> ~/crypto-data-project/logs/dbt_test.log
