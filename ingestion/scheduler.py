#!/usr/bin/env python3
import time
from datetime import datetime
from loguru import logger

def run_etl():
    try:
        from main import main
        logger.info(f"Running scheduled ETL at {datetime.now()}")
        main()
        logger.info(f"Scheduled ETL completed at {datetime.now()}")
    except Exception as e:
        logger.error(f"Scheduled ETL failed: {e}")

if __name__ == "__main__":
    logger.info("Scheduler started")
    
    # Run once at start
    run_etl()
    
    # Keep container alive
    while True:
        time.sleep(3600)  # Sleep for 1 hour
        run_etl()
