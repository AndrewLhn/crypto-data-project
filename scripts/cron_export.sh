#!/bin/bash
echo "$(date): Starting data export" >> ~/crypto-data-project/logs/export.log
cd ~/crypto-data-project && ./scripts/export_data.sh >> ~/crypto-data-project/logs/export.log 2>&1
echo "$(date): Export completed" >> ~/crypto-data-project/logs/export.log
