import google.cloud.logging
from google.cloud import bigquery
from google.cloud import pubsub_v1
import json
import logging
import os
from datetime import datetime, timedelta, timezone
from sendgrid.helpers.eventwebhook import EventWebhook

logging.basicConfig(format="[%(asctime)s][%(levelname)s] %(message)s", level=logging.INFO)
logger = logging.getLogger()

logging_client = google.cloud.logging.Client()
logging_client.setup_logging()
logger.setLevel(logging.INFO)

project_id = os.environ["GCP_PROJECT"]
verification_key = os.environ["SENDGRID_VERIFICATION_KEY"]
topic_id = os.environ["TOPIC_ID"]
JST = timezone(timedelta(hours=+9), "JST")


def insert_bq(rows, bq_table):
    """
    Sendgridから受信したEvent Webhookの内容を、バックアップ用にBQに保存する
    """
    client = bigquery.Client()
    errors = client.insert_rows_json(
        bq_table, rows, retry=bigquery.DEFAULT_RETRY.with_deadline(1800)
    )
    if errors == []:
        logger.info("insert_bq: success.")
        return True
    else:
        logger.error(
            "insert_bq: failed. errors while inserting rows to {}: {}".format(bq_table, errors)
        )
        return False


def publish(dumped, event, message_type):
    """
    sendgrid_save_effectのフィルタリング用にevent(e.g. delivered, open...)を付与
    Pub/Subをpublishする
    """
    publisher = pubsub_v1.PublisherClient()
    topic_path = publisher.topic_path(project_id, topic_id)
    data_json = dumped.encode("utf-8")
    try:
        future = publisher.publish(
            topic_path, data_json, event=event, timeout=3000, message_type=message_type
        )
        logger.info(f"Published to {topic_path}: {future.result()}: {dumped}")
    except Exception as e:
        logger.error(f"Failed to publish to {topic_path} {dumped}: {e}")


def main(request):
    """
    1. GETのクエリストリング: tokenから会社IDを取得
       この会社IDをSecretのキーにして、Verification Keyをセットし、
       Sendgridが送ってきたEvent Webhookということを認証する
    2. Event Webhookの内容はすべてBQ:dataset_XXXX.sendgrid_event_backupに保存する
    3. webhook eventごとにattributeを付与して、Pub/Subをpublishする
    """
    logger.info(f"request: {request}")
    signature = request.headers.get("X-Twilio-Email-Event-Webhook-Signature")
    timestamp = request.headers.get("X-Twilio-Email-Event-Webhook-Timestamp")
    logger.debug(f"{signature=}")
    payload = request.get_data(as_text=True)
    logger.debug(f"{payload=}")

    if request.args.get("token", ""):
        company_id = request.args.get("token", "")
        logger.info(f"{company_id=}")
    else:
        logger.info("company_id does not exist, skip.")
        return "company_id does not exist, skip.", 200

    try:
        public_key = json.loads(verification_key)[company_id]
    except Exception as e:
        logger.warn("Invarid Verification Key. %s", e)
        return "Skip", 200
    ew = EventWebhook(public_key=public_key)
    verified = ew.verify_signature(payload=payload, signature=signature, timestamp=timestamp)
    if verified is False:
        logger.warn("Verification Failed.")
        return "Verification Failed.", 403

    json_list = request.get_json()
    logger.info(f"event record(s): {len(json_list)}")
    logger.info(f"{json_list=}")
    bq_table = "{}.{}.{}".format(project_id, company_id, "sendgrid_event_backup")
    dict_data = {}
    # Webhook Eventの中身から抽出しても、複数イベントが入っていて時刻はズレるので、このCFの実行時間をタイムスタンプとする
    dict_data["timestamp"] = datetime.now(JST).strftime("%Y-%m-%dT%H:%M:%S.%f")
    dict_data["event_data"] = json.dumps(json_list)
    rows = []
    rows.append(dict_data)
    logger.info(f"rows: {rows}")
    if insert_bq(rows, bq_table) is False:
        return "Error", 500  # error時は、200以外をreturnさせ、Event Webhookから再送を受ける

    for data in json_list:
        event = data["event"]
        message_type = data["message_type"]
        logger.info(f"event: {event}, company_id: {company_id}")
        dumped = json.dumps(data)
        publish(dumped, event, message_type)
    return "OK", 200
