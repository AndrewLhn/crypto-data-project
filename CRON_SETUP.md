# Cron Jobs Configuration

## Schedule

| Job | Schedule | Description |
|-----|----------|-------------|
| ETL | 0 */12 * * * | Runs every 12 hours (0:00, 12:00) |
| dbt run | 5 */12 * * * | Runs 5 min after ETL |
| dbt tests | 10 */12 * * * | Runs 10 min after ETL |
| Export | 15 */12 * * * | Runs 15 min after ETL |
| Alerts | 0 * * * * | Runs every hour |
| Health check | 0 9 * * * | Runs daily at 9 AM |

## Logs Location

- ETL: `~/crypto-data-project/logs/etl.log`
- dbt run: `~/crypto-data-project/logs/dbt.log`
- dbt tests: `~/crypto-data-project/logs/dbt_test.log`
- Export: `~/crypto-data-project/logs/export.log`
- Alerts: `~/crypto-data-project/logs/alerts.log`

## Manual Run

```bash
# Run all pipeline manually
./scripts/run_all.sh

# Run individual jobs
./scripts/cron_etl.sh
./scripts/cron_dbt.sh
./scripts/cron_dbt_test.sh
./scripts/cron_export.sh
./scripts/cron_alerts.sh

# Health check
./scripts/health_check.sh
E0F
