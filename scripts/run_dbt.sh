#!/bin/bash
cd ~/crypto-data-project
./dbt-run.sh run
./dbt-run.sh test
