# За основу берем официальный образ Airflow
FROM apache/airflow:slim-2.11.0-python3.12

# Копируем файл с зависимостями в контейнер
COPY requirements.txt /requirements.txt

# Устанавливаем зависимости
RUN pip install --no-cache-dir -r /requirements.txt