#!/bin/bash

# Переходим в директорию docker
cd "$(dirname "$0")/../docker"

echo "🚀 Starting Crypto Data Platform..."

# Проверяем наличие .env файла
if [ ! -f ../.env ]; then
    echo "⚠️  .env file not found, creating from template..."
    cp ../.env.example ../.env
fi

# Загружаем переменные окружения
set -a
source ../.env
set +a

# Останавливаем старые контейнеры
echo "🛑 Stopping old containers..."
docker-compose down

# Собираем и запускаем
echo "🏗️  Building and starting containers..."
docker-compose up -d --build

# Ждем готовности сервисов
echo "⏳ Waiting for services to be ready..."
sleep 10

# Проверяем статус
echo "✅ Container status:"
docker-compose ps

# Проверяем MinIO
echo ""
echo "📦 MinIO Console: http://localhost:9001"
echo "   Access: ${MINIO_ROOT_USER} / ${MINIO_ROOT_PASSWORD}"

# Проверяем PostgreSQL
echo "🐘 PostgreSQL: localhost:5432"
echo "   Database: ${POSTGRES_DB}"
echo "   User: ${POSTGRES_USER}"

# Проверяем Metabase
echo "📊 Metabase: http://localhost:3000"

# Показываем логи
echo ""
echo "📋 Logs (Ctrl+C to stop viewing):"
docker-compose logs -f