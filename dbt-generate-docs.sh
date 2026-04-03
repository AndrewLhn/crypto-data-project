#!/bin/bash
cd ~/crypto-data-project
docker run --rm \
  -v $(pwd)/dbt:/dbt \
  -v $(pwd)/.dbt:/root/.dbt \
  --network docker_crypto_network \
  -w /dbt \
  python:3.11-slim \
  bash -c "pip install -q dbt-postgres==1.5.0 && dbt docs generate"
