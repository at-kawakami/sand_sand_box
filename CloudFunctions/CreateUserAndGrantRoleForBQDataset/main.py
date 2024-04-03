import logging
import os
import re
import google.auth
import googleapiclient.discovery
import google.cloud.logging
from google.cloud import bigquery
from google.cloud.bigquery.enums import EntityTypes

logging.basicConfig(
    format="[%(asctime)s][%(levelname)s] %(message)s", level=logging.INFO
)
logger = logging.getLogger()

logging_client = google.cloud.logging.Client()
logging_client.setup_logging()
logger.setLevel(logging.INFO)

project_id = os.environ["GCP_PROJECT"]
# Role for User
iam_user_roles = [
    "roles/bigquery.jobUser",
    "roles/bigquery.readSessionUser"
    ]
# role for Dataset
role_read_only = [
    "READER",
    "roles/bigquery.user"
    ]

roles_write = [
    "WRITER",
    "roles/bigquery.user"
    ]

policy_list = []


def main(request):
    """IAM Roleにユーザをバインド、データセットにユーザ：権限をバインドする

    Args:
        member (str): e.g. hoge@gmail.com
        dataset (list): e.g. ["dataset_xxxxxxxx", "dataset_xxxxxxxx_read_only", "dataset_xxxxxxxx_writable"]
    """
    request_json = request.get_json(silent=True)
    if request_json and 'member' not in request_json:
        logger.warn('Bad Request: \"member\" is required')
        return "Bad Request: \"member\" is required", 400
    member = request_json['member']
    if request_json and 'dataset' not in request_json:
        logger.warn('Bad Request: \"dataset\" is required')
        return "Bad Request: \"dataset\" is required", 400
    dataset = request_json['dataset']
    # Initializes service.
    target_prj_service = initialize_service()

    # Roleに対してユーザがバインドされているので、ユーザに付与するRole分回す
    for r in iam_user_roles:
        # Grants your member the 'Log Writer' role for the project.
        if modify_policy_add_role(target_prj_service, project_id, r, member) is False:
            return "Failed to create IAM user.", 500
        # Gets project's policy and prints all members with the target role.
        policy = get_policy(target_prj_service, project_id)
        binding = next(b for b in policy["bindings"] if b["role"] == r)
        for m in binding["members"]:
            logger.info("Member(s) in {}: {}".format(binding["role"], m))
    # データセットにユーザ：Roleがバインドされているので、データセット分回す
    for d in dataset:
        if not re.match(r'.*dataset.*', d):
            logger.warn("{} is not target dataset. skip it.".format(d))
            continue
        if grant_role_to_dataset(member, d) is False:
            logger.error("failed to grant role:{}".format(d))
            return "Grant Role to Datase failed", 500
    return 'OK\n', 200


def grant_role_to_dataset(member, dataset):
    entity_type = EntityTypes.USER_BY_EMAIL
    dataset_id = "{}.{}".format(project_id, dataset)
    if re.match(r'.*_read_only', dataset_id):
        target_roles = role_read_only
    elif re.match(r'.*_writable', dataset_id):
        target_roles = roles_write
    else:
        target_roles = role_read_only

    client = bigquery.Client()
    dataset = client.get_dataset(dataset_id)
    entries = list(dataset.access_entries)
    for r in target_roles:
        entries.append(
            bigquery.AccessEntry(
                role=r,
                entity_type=entity_type,
                entity_id=member,
            )
        )
    dataset.access_entries = entries
    policy_list.append(dataset.access_entries)
    try:
        dataset = client.update_dataset(dataset, ["access_entries"])
        logger.info(
            "Updated dataset '{}' with modified user permissions."
            .format(dataset_id)
            )
        logger.info("policy: {}".format(entries))
    except Exception as e:
        logger.error('Update dataset policy failed: %s', e)
        return False

    return True


def initialize_service() -> dict:
    """Initializes a Cloud Resource Manager service."""

    credentials, _ = google.auth.default(
        scopes=["https://www.googleapis.com/auth/cloud-platform"]
    )
    target_prj_service = googleapiclient.discovery.build(
        "cloudresourcemanager", "v1", credentials=credentials
    )
    return target_prj_service


def modify_policy_add_role(
    target_prj_service: str, project_id: str, role: str, member: str
) -> None:
    """Adds a new role binding to a policy."""
    # get_policyは仕様上、projectに紐づく全権限を取得する
    # Role x member(s)の構造
    policy = get_policy(target_prj_service, project_id)
    member = "user:{}".format(member)
    binding = None
    for b in policy["bindings"]:
        if b["role"] == role:
            binding = b
            break
    if binding is not None:
        binding["members"].append(member)
    else:
        binding = {"role": role, "members": [member]}
        policy["bindings"].append(binding)

    if set_policy(target_prj_service, project_id, policy) is False:
        return "Failed to create IAM user.", 500
    return True


def get_policy(target_prj_service: str, project_id: str, version: int = 3) -> dict:
    """Gets IAM policy for a project."""

    policy = (
        target_prj_service.projects()
        .getIamPolicy(
            resource=project_id,
            body={"options": {"requestedPolicyVersion": version}},
        )
        .execute()
    )
    return policy


def set_policy(target_prj_service: str, project_id: str, policy: str) -> dict:
    """Sets IAM policy for a project."""
    try:
        policy = (
            target_prj_service.projects()
            .setIamPolicy(resource=project_id, body={"policy": policy})
            .execute()
        )
    except Exception as e:
        logger.error("Update IAM policy failed: %s", e)
        return False
    return policy
