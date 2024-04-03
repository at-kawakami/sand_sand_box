import logging
import pprint
from google.cloud import bigquery
import google.cloud.logging

logging.basicConfig(format="[%(asctime)s][%(levelname)s] %(message)s", level=logging.INFO)
logger = logging.getLogger()

logging_client = google.cloud.logging.Client()
logging_client.setup_logging()
logger.setLevel(logging.INFO)


def main(request):
    request_json = request.get_json(silent=True)
    if request_json and "member" not in request_json:
        logger.warn('Bad Request: "member" is required')
        return 'Bad Request: "member" is required', 400
    member = request_json["member"]
    # Construct a BigQuery client object.
    client = bigquery.Client()
    datasets = list(client.list_datasets())  # Make an API request.
    project = client.project
    l = []
    if datasets:
        for i in datasets:
            dataset = client.get_dataset(i.dataset_id)  # Make an API request.
            entries = list(dataset.access_entries)
            dataset.access_entries = [entry for entry in entries if entry.entity_id == member]
            if dataset.access_entries:
                l.append(f"{i.dataset_id}: {dataset.access_entries=}")
                logger.info(f"{i.dataset_id}: {dataset.access_entries=}")
            else:
                logger.debug(f"{i.dataset_id}: target user does not exist.")
    else:
        logger.info("{} project does not contain any datasets.".format(project))
    return pprint.pprint(l)

