#!/bin/bash

cd "$(dirname "$0")/../docker"
docker-compose down

echo "✅ All services stopped"