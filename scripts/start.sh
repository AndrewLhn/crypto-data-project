#!/bin/bash


cd "$(dirname "$0")/../docker"

echo "🚀 Starting Crypto Data Platform..."


if [ ! -f ../.env ]; then
    echo "⚠️  .env file not found, creating from template..."
    cp ../.env.example ../.env
fi


set -a
source ../.env
set +a


echo "🛑 Stopping old containers..."
docker-compose down


echo "🏗️  Building and starting containers..."
docker-compose up -d --build


echo "⏳ Waiting for services to be ready..."
sleep 10


echo "✅ Container status:"
docker-compose ps


echo ""
echo "📦 MinIO Console: http://localhost:9001"
echo "   Access: ${MINIO_ROOT_USER} / ${MINIO_ROOT_PASSWORD}"


echo "🐘 PostgreSQL: localhost:5432"
echo "   Database: ${POSTGRES_DB}"
echo "   User: ${POSTGRES_USER}"


echo "📊 Metabase: http://localhost:3000"


echo ""
echo "📋 Logs (Ctrl+C to stop viewing):"
docker-compose logs -f