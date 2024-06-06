import os
import json
import logging
import google.cloud.logging
import pandas as pd
from sqlalchemy import create_engine, text, pool
from sqlalchemy.engine.url import URL
from sqlalchemy.orm import sessionmaker

# 環境変数
GCP_PROJECT = os.getenv("GCP_PROJECT")
DB_SECRET = os.getenv("DB_SECRET")

# Logger設定
logging.basicConfig(format="[%(asctime)s][%(levelname)s] %(message)s", level=logging.DEBUG)
logger = logging.getLogger()

# Cloud Logging ハンドラを logger に接続
logging_client = google.cloud.logging.Client()
logging_client.setup_logging()
logger.setLevel(logging.INFO)


def set_engine(database):
    dict = json.loads(DB_SECRET)
    engine = create_engine(
        URL.create(
            drivername="mysql+pymysql",
            username=dict["USERNAME"],
            password=dict["PASSWORD"],
            database=database,
            #query={"unix_socket": dict["UNIX_SOCKET"]},
            host=dict["HOST"]
        ),
        poolclass=pool.NullPool,
    )
    return engine


def hello_http(request):
    engine = set_engine(f"information_schema")
    connection = engine.connect()
    query = "SELECT count(*) FROM TABLES"
    df = pd.read_sql_query(sql=text(query), con=connection)
    logger.info(f"{df=}")
    connection.close()
    return 'OK'
