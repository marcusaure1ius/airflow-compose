#!/usr/bin/env bash

echo "1. Cleaning up old directories..."
rm -rf ./dags ./logs ./plugins

echo "2. Creating new directories..."
mkdir -p dags logs plugins

echo "3. Generating .env file with keys and UID..."
echo "Generating keys..."

rm .env
touch .env

cat << EOF > .env
AIRFLOW__CORE__FERNET_KEY=$(openssl rand -base64 32)
AIRFLOW__WEBSERVER__SECRET_KEY=$(openssl rand -hex 16)
AIRFLOW_UID=$(id -u)
AIRFLOW_GID=0
_AIRFLOW_WWW_USER_USERNAME=airflow
_AIRFLOW_WWW_USER_PASSWORD=airflow
EOF

# 4. Стартуем контейнеры
echo "Starting containers..."

docker compose down --volumes --remove-orphans && docker compose up --build -d
