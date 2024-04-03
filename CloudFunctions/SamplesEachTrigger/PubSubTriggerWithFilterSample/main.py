import base64
import json
import logging
import google.cloud.logging
from datetime import timedelta, timezone
from google.auth.transport import requests
from google.auth import jwt
from google.oauth2 import id_token

logging.basicConfig(format="[%(asctime)s][%(levelname)s] %(message)s", level=logging.INFO)
logger = logging.getLogger()

logging_client = google.cloud.logging.Client()
logging_client.setup_logging()
logger.setLevel(logging.INFO)
JST = timezone(timedelta(hours=+9), "JST")


# Pub/Sub Subscription側で「認証を有効にする」を選択していれば、
# SA認証をPub/Sub>CF間で自動でやってくれるので、このメソッドはまるごと不要
def verify(bearer_token):
    """
    google_oauth2_cert.jsonとrequest.header.bearer_tokenを認証する
    google_oauth2_cert.jsonの中身が古い場合、エラーになるので、
    https://www.googleapis.com/oauth2/v1/certsから公開鍵を取得し、
    再度認証をテストする
    """
    public_cert = open("./google_oauth2_cert.json")
    public_cert_data = json.load(public_cert)

    try:
        if bearer_token is None:
            logger.error("bearer_token is None, skip.")
            return False
        logger.info(f"bearer_token: {bearer_token}")
        token = bearer_token.split(" ")[1]
    except Exception as e:
        logger.error(f"Invalid token: {e}")
        return False
    try:
        claim = jwt.decode(token, certs=public_cert_data)
        logger.info(f"claim by offline cert: {claim}")
    except Exception as e:
        logger.warning("jwt.decode exception: %s", e)
        logger.warning(
            "token verified by google_oauth_cert.json has exired. \
            Get token by requesting Google API."
        )
        claim = id_token.verify_oauth2_token(token, requests.Request())
        logger.info(f"claim by verify_oauth2_token: {claim}")
    return True


# Triggered from a message on a Cloud Pub/Sub topic.
@functions_framework.http
def hello_pubsub(request):
    # if verify(request.headers.get("Authorization")) is False:
    #    return "Verification Failed.", 403
    request_json = request.get_json()
    logger.info(f"request: {request_json}")
    # 暗号化されたmessageの中身を解凍する
    message = base64.b64decode(request_json["message"]["data"]).decode()
    logger.info(f"{message=}")

    return "OK", 200

