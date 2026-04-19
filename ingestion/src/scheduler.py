import time
import schedule
from main import main
from loguru import logger

def run_etl():
    """Run the ETL pipeline"""
    try:
        logger.info("Running scheduled ETL job...")
        main()
        logger.info("Scheduled ETL job completed successfully")
    except Exception as e:
        logger.error(f"Scheduled ETL job failed: {e}")


schedule.every(12).hours.do(run_etl)


run_etl()

logger.info("Scheduler started. Will run ETL every 12 hours")


while True:
    schedule.run_pending()
    time.sleep(60)
