#! /bin/bash

USER="$DB_USER"

# Check environment variable DB_USER
if [ -z "$USER" ]; then
    echo "Environment variable DB_USER is not set."
    exit 1
fi

echo "Environment variable DB_USER was setted correct"

PASSWORD="$DB_PASSWORD"

# Check environment variable DB_PASSWORD
if [ -z "$PASSWORD" ]; then
    echo "Environment variable DB_PASSWORD is not set."
    exit 1
fi

echo "Environment variable DB_PASSWORD was setted correct"

# Create backup file for database ShopDB
mysqldump --user="$USER" --password="$PASSWORD" ShopDB --result-file=ShopDB_backup.sql

# Create backup file for database ShopDB without database schema (structure). Only data.
mysqldump --user="$USER" --password="$PASSWORD" ShopDB --no-create-info --result-file=ShopDB_only_data_backup.sql

# Restore the backup of ShopDB to the database ShopDBReserve
mysql --user="$USER" --password="$PASSWORD" ShopDBReserve < ShopDB_backup.sql

# Restore the data backup of ShopDB to the database ShopDBDevelopment
mysql --user="$USER" --password="$PASSWORD" ShopDBDevelopment < ShopDB_only_data_backup.sql

# In order to set a schedule for backuping you need to execute the next steps:
# Execute command:
# crontab -e
# you open file for editing
# write there the next code
# 0 0 * * * /path_to_script/task.sh
# safe crone file
# Note! This (0 0 * * *) pattern starts backup every night at 00:00 every day

