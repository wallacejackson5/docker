#!/bin/bash
echo "Script is running"

# RabbitMQ credentials
RABBITMQ_CREDENTIALS="myuser:mypassword"
RABBITMQ_VHOST="my_vhost"

# RabbitMQ server address
RABBITMQ_ENDPOINT="http://localhost:15672/api"

# Function to generate random message content
generate_message_content() {
    local routing_key=$1
    local random_number=$((RANDOM % 100))
    local json_content='{\"id\":'$random_number',\"key\":\"value\",\"routingKey\":\"'$routing_key'\"}'
    echo "${json_content}"
}

# Function to publish messages to a queue
publish_to_queue() {
    local routing_key=$1
    local num_messages=$2

    for ((i=1; i<=num_messages; i++)); do
        message_content="$(generate_message_content ${routing_key})"
        # Quote the message_content as a JSON string
        payload='{"properties":{},"routing_key":"'"${routing_key}"'","payload":"'${message_content}'","payload_encoding":"string"}'
        curl -i -u ${RABBITMQ_CREDENTIALS} -H "content-type:application/json" \
            -XPOST ${RABBITMQ_ENDPOINT}/exchanges/${RABBITMQ_VHOST}/my_exchange/publish \
            -d "${payload}"
    done
}

while true; do
    messageQuantity=$((RANDOM % 100))
    publish_to_queue "key1" 100
    publish_to_queue "key2" 50
done
