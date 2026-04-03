#!/bin/bash
BACKUP_FILE="backup_$(date +%Y%m%d_%H%M%S).sql"
docker exec crypto_postgres pg_dump -U crypto_user crypto_db > backups/$BACKUP_FILE
echo "Backup created: $BACKUP_FILE"
