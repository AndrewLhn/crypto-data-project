
CREATE SCHEMA IF NOT EXISTS staging;
CREATE SCHEMA IF NOT EXISTS marts;
CREATE SCHEMA IF NOT EXISTS intermediate;
CREATE SCHEMA IF NOT EXISTS raw;


ALTER DEFAULT PRIVILEGES IN SCHEMA staging GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO crypto_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA marts GRANT SELECT ON TABLES TO crypto_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA intermediate GRANT SELECT ON TABLES TO crypto_user;


CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


CREATE TABLE IF NOT EXISTS raw.etl_metadata (
    etl_id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    pipeline_name VARCHAR(100) NOT NULL,
    source_system VARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL,
    records_processed INTEGER,
    started_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    finished_at TIMESTAMP WITH TIME ZONE,
    error_message TEXT,
    metadata JSONB
);


CREATE INDEX idx_etl_metadata_started_at ON raw.etl_metadata(started_at DESC);
CREATE INDEX idx_etl_metadata_status ON raw.etl_metadata(status);


GRANT ALL ON ALL TABLES IN SCHEMA raw TO crypto_user;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA raw TO crypto_user;