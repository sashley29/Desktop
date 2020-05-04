from google.cloud import pubsub_v1

PROJECT_ID = "spry-sentry-237521"
TOPIC_NAME = "desktop-topic"

def publish_desktop_message(message):
	publisher = pubsub_v1.PublisherClient()
	# The `topic_path` method creates a fully qualified identifier
	# in the form `projects/{project_id}/topics/{topic_name}`
	topic_path = publisher.topic_path(PROJECT_ID, TOPIC_NAME)

	
	data = message
	# Data must be a bytestring
	data = data.encode("utf-8")
	# When you publish a message, the client returns a future.
	future = publisher.publish(topic_path, data=data)
	print(future.result())

	print("Published messages.")
