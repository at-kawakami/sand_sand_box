import json
import time
from concurrent import futures
from google import pubsub_v1
# pubsub_v1 from google.cloud has no PublishRequest(),
# only publish 1 message per publish
#from google.cloud import pubsub_v1

project_id = "myproject"
topic_id = "topic"

publisher = pubsub_v1.PublisherClient()
topic_id = "projects/myproject/topics/test-topic",

messages = []
for n in range(0, 1001):
    data_str = f'Message number {n}'
    data = json.dumps(data_str).encode("utf-8")
    print(f'{data_str=}')
    #print(f'{data=}')
    message = {'data': data}
    messages.append(message)
print(len(messages))
request =pubsub_v1.PublishRequest(
        topic = topic_id,
        messages = messages
        )
publish_future = publisher.publish(request=request)

print(f"Published messages with batch settings to {topic}.")

