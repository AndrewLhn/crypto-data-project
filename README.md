
Production-ready data pipeline for cryptocurrency market data with automated ETL, transformation, BI visualization, and monitoring.

✅ Architecture: Docker + PostgreSQL + MinIO + Metabase"
✅ ETL: 250+ cryptocurrencies from CoinGecko API"
✅ dbt: Staging + Marts + Tests + Documentation"
✅ BI: Metabase dashboards ready"
✅ Monitoring: Logs + Anomaly detection + Health checks"
✅ Orchestration: Cron jobs every 12 hours"

### Technology Stack

| Component | Technology | Purpose |
|-----------|------------|---------|
| **Ingestion** | Python + CoinGecko API | Data extraction |
| **Storage** | MinIO (S3) + PostgreSQL | Raw & processed data |
| **Transformation** | dbt | Data modeling & testing |
| **BI** | Metabase | Visualization & dashboards |
| **Orchestration** | Cron + Docker | Automation & containerization |
| **Monitoring** | Custom scripts + logs | Health checks & alerts |

## 📊 Data Pipeline

### 1. **ETL Pipeline (Python)**
- Fetches 250+ cryptocurrencies from CoinGecko API
- Runs every 12 hours automatically
- Saves raw data as Parquet in MinIO
- Stores transformed data in PostgreSQL

### 2. **Data Transformation (dbt)**
- **Staging models**: Raw data cleaning and preparation
- **Marts models**: Business-ready data marts
- **Business metrics**: Automated KPI views
- **CDC tracking**: Change data capture history
- **Tests**: Uniqueness, freshness, relationships, positive values

### 3. **BI & Analytics (Metabase)**
- Interactive dashboards
- Top 10 coins by market cap
- Performance category analysis
- Market statistics and trends

### 4. **Monitoring & Alerts**
- Anomaly detection (>20% price changes)
- Health check script
- Automated logging
- Email/Slack alerts ready

## 🚀 Quick Start

### Prerequisites

```bash
# Required software
- Docker & Docker Compose
- Python 3.11+
- Make (optional)

###Installation

# Clone repository
git clone https://github.com/yourusername/crypto-data-project.git
cd crypto-data-project

# Copy environment variables
cp .env.example .env
# Edit .env with your passwords

# Start all services
cd docker
docker-compose up -d
cd ..

###Verify Installation

# Check all services are running
docker ps | grep crypto

# Check data is loaded
docker exec crypto_postgres psql -U crypto_user -d crypto_db -c "SELECT COUNT(*) FROM crypto_dbt.mart_crypto_metrics;"

# Run health check
./scripts/health_check.sh

Manual Pipeline Execution

# Run entire pipeline manually
./scripts/run_all.sh

# Run individual components
./scripts/cron_etl.sh          # Run ETL only
./dbt-run.sh run                # Run dbt models
./dbt-run.sh test               # Run dbt tests
./scripts/export_data.sh        # Export data to CSV

###View/Edit Cron Jobs

# View all cron jobs
crontab -l | grep crypto

# Edit cron jobs
crontab -e

###dbt Documentation

# Generate documentation
./dbt-run.sh docs generate

# Serve documentation locally
./dbt-run.sh docs serve --port 8082

###Logging
All processes are logged for monitoring:
# View logs
tail -f logs/etl.log          # ETL pipeline logs
tail -f logs/dbt.log          # dbt run logs
tail -f logs/dbt_test.log     # dbt test logs
tail -f logs/alerts.log       # Anomaly alerts
tail -f logs/export.log       # Data export logs

# Check for errors
grep -i error logs/*.log

###dbt Tests
# Run all dbt tests
./dbt-run.sh test

# Available tests
- unique_coin_id: No duplicate IDs
- positive_prices: All prices > 0
- market_cap_positive: All market caps > 0
- valid_performance_category: Valid category values

crypto-data-project/
├── docker/
│   ├── docker-compose.yml
│   └── postgres/init/
├── ingestion/
│   ├── Dockerfile
│   ├── requirements.txt
│   └── src/main.py
├── dbt/
│   ├── models/
│   │   ├── staging/
│   │   └── marts/
│   ├── tests/
│   └── macros/
├── scripts/
│   ├── cron_etl.sh
│   ├── cron_dbt.sh
│   ├── cron_alerts.sh
│   ├── export_data.sh
│   ├── health_check.sh
│   └── run_all.sh
├── logs/
├── reports/
├── .env
├── .gitignore
├── dbt-run.sh
└── README.md

📊 Performance Metrics
Current pipeline performance:

Data volume: 250+ cryptocurrencies

Update frequency: Every 12 hours

Response time: < 1 second for queries

Data freshness: Near real-time (12h delay)

Test coverage: 100% for critical fields

🎯 Future Improvements
Add real-time streaming (Kafka/Debezium)

Implement Airflow for advanced orchestration

Add more data sources (stock market, news)

Machine learning for price predictions

Kubernetes deployment

CI/CD pipeline (GitHub Actions)

More sophisticated anomaly detection

📄 License
MIT License - feel free to use and modify

👨‍💻 Author
[Andrii] - Data Engineer

