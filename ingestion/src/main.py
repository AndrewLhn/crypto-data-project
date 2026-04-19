import os
import pandas as pd
import requests
from datetime import datetime
from loguru import logger
from tenacity import retry, stop_after_attempt, wait_exponential
from sqlalchemy import create_engine


POSTGRES_HOST = os.getenv('POSTGRES_HOST', 'postgres')
POSTGRES_DB = os.getenv('POSTGRES_DB', 'crypto_db')
POSTGRES_USER = os.getenv('POSTGRES_USER', 'crypto_user')
POSTGRES_PASSWORD = os.getenv('POSTGRES_PASSWORD', 'crypto_pass123')

@retry(stop=stop_after_attempt(3), wait=wait_exponential(multiplier=1, min=2, max=10))
def fetch_crypto_data():
    """Fetch cryptocurrency data from CoinGecko API"""
    url = "https://api.coingecko.com/api/v3/coins/markets"
    params = {
        'vs_currency': 'usd',
        'order': 'market_cap_desc',
        'per_page': 250,
        'page': 1,
        'sparkline': 'false',
        'price_change_percentage': '24h'
    }
    
    logger.info("Fetching data from CoinGecko API...")
    response = requests.get(url, params=params)
    response.raise_for_status()
    
    data = response.json()
    logger.info(f"Fetched {len(data)} cryptocurrencies")
    return data

def save_to_postgres(df):
    """Save DataFrame to PostgreSQL"""
    try:
        conn_string = f"postgresql://{POSTGRES_USER}:{POSTGRES_PASSWORD}@{POSTGRES_HOST}:5432/{POSTGRES_DB}"
        engine = create_engine(conn_string)
        
        
        df.to_sql('stg_crypto_markets', engine, schema='crypto_dbt', 
                  if_exists='replace', index=False)
        
        logger.success(f"Saved {len(df)} records to PostgreSQL")
        return True
    except Exception as e:
        logger.error(f"Failed to save to PostgreSQL: {e}")
        return False

def main():
    """Main ETL pipeline"""
    try:
        logger.info("Starting ETL pipeline...")
        
       
        raw_data = fetch_crypto_data()
        
        
        df = pd.DataFrame(raw_data)
        
       
        columns = ['id', 'symbol', 'name', 'current_price', 'market_cap',
                   'market_cap_rank', 'price_change_percentage_24h',
                   'total_volume', 'high_24h', 'low_24h', 'last_updated']
        df = df[columns]
        
        
        df['_loaded_at'] = datetime.utcnow().isoformat()
        df['_etl_id'] = df['id'] + '_' + df['_loaded_at']
        df['last_updated'] = pd.to_datetime(df['last_updated'])
        
        logger.info(f"Transformed {len(df)} records")
        
        
        if save_to_postgres(df):
            logger.success(f"ETL completed! {len(df)} records saved to PostgreSQL")
            
            
            print("\n" + "="*50)
            print(f"📊 Data Summary:")
            print(f"   Total records: {len(df)}")
            print(f"   Top coin: {df.iloc[0]['name']} (${df.iloc[0]['current_price']:,.2f})")
            print(f"   Total market cap: ${df['market_cap'].sum():,.0f}")
            print("="*50 + "\n")
        else:
            logger.error("Failed to save data to PostgreSQL")
            
    except Exception as e:
        logger.error(f"ETL pipeline failed: {e}")
        raise

if __name__ == "__main__":
    main()
