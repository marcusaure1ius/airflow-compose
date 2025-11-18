# Установка Airflow<br/>

Особенности:
- Режим установки - LocalExecutor
- Dockerfile для сборки образа
- Версия Airflow 2.11.0 для Python 3.12 (последняя актуальная версия перед релизом Airflow 3)
- Необходим предустановленный PostgreSQL

### Сервисы

- `airflow-init` - контейнер, который запускается один раз для подготовки базы данных 
- `airflow-webserver` - Web UI
- `airflow-scheduler` - запускает DAGи
- `airflow-triggerer` - контейнер, который работает с "откладываемыми" операторами

### Установка

1. Клонируйте репозиторий и перейдите в папку с проектом

```bash
git clone https://github.com/marcusaure1ius/airflow-compose.git && cd airflow-compose
```

2. Для создания БД для метаданных airflow выполните следующие пункты

    
    2.1 Заходим под пользователем postgres:
    ```bash
    sudo -i -u postgres
    ```

    2.2 Запускаем консоль psql:
    ```bash
    psql
    ```

    2.3 Внутри консоли создаем нового пользователя с паролем:
    ```sql
    CREATE USER airflow_tech WITH ENCRYPTED PASSWORD 'airflow_pass';
    ```

    ```sql
    CREATE DATABASE airflow_db OWNER airflow_tech;
    ```

    ```sql
    GRANT ALL PRIVILEGES ON DATABASE airflow_db TO airflow_tech;
    ```

3. Опционально. В файл `requirements.txt` можно внести необходимые библиотеки, которые будут установлены во время развертывания airflow.

4. Сделайте исполняемым файл `clean_install.sh`, который сделает все необходимые приготовления и запустит контенейры

```bash
chmod +x clean_install.sh
```

```bash
sudo ./clean_install.sh
```

> [!IMPORTANT]
> При запуске скрипта `clean_install.sh` удаляются все папки с данными и логами. В случае, если вам необходимо, например, добавить новые библиотеки и сделать новый билд, выполните команду `docker compose down && docker compose up --build -d`


### Использование

Перейдите по адресу `http://YOUR_HOST/:8080` и, если все успешно, вы увидите страницу входа, используйте логин и пароль из файла `.env`

##### Автор - https://github.com/marcusaure1ius