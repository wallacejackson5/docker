#!/bin/bash
echo "Script is running"

sleep 5

# RabbitMQ credentials
RABBITMQ_USER="myuser"
RABBITMQ_PASSWORD="mypassword"
RABBITMQ_CREDENTIALS="${RABBITMQ_USER}:${RABBITMQ_PASSWORD}"
RABBITMQ_VHOST="my_vhost"
RABBITMQ_EXCHANGE="my_exchange"
RABBITMQ_QUEUE="myqueue1"
RABBITMQ_ROUTING_KEY="key1"

# RabbitMQ server address
RABBITMQ_ENDPOINT="http://localhost:15672/api"

# RabbitMQ configuration commands
rabbitmqctl add_user ${RABBITMQ_USER} ${RABBITMQ_PASSWORD}
rabbitmqctl add_vhost ${RABBITMQ_VHOST}
rabbitmqctl set_permissions -p ${RABBITMQ_VHOST} ${RABBITMQ_USER} ".*" ".*" ".*"
rabbitmqctl set_permissions -p ${RABBITMQ_VHOST} ${RABBITMQ_DEFAULT_USER} ".*" ".*" ".*"
rabbitmqctl set_user_tags ${RABBITMQ_USER} management

# Install curl (if not already installed)
apt update && apt install -y curl

# RabbitMQ configuration commands using HTTP API
curl -i -u ${RABBITMQ_CREDENTIALS} -H "content-type:application/json" \
  -XPUT ${RABBITMQ_ENDPOINT}/exchanges/${RABBITMQ_VHOST}/${RABBITMQ_EXCHANGE} -d '{"type": "direct"}'
curl -i -u ${RABBITMQ_CREDENTIALS} -H "content-type:application/json" \
  -XPUT ${RABBITMQ_ENDPOINT}/queues/${RABBITMQ_VHOST}/${RABBITMQ_QUEUE} -d '{}'
curl -i -u ${RABBITMQ_CREDENTIALS} -H "content-type:application/json" \
  -XPOST ${RABBITMQ_ENDPOINT}/bindings/${RABBITMQ_VHOST}/e/${RABBITMQ_EXCHANGE}/q/${RABBITMQ_QUEUE} -d "{\"routing_key\": \"${RABBITMQ_ROUTING_KEY}\"}"
curl -i -u ${RABBITMQ_CREDENTIALS} -H "content-type:application/json" \
  -XPUT ${RABBITMQ_ENDPOINT}/queues/${RABBITMQ_VHOST}/myqueue2 -d '{}'
curl -i -u ${RABBITMQ_CREDENTIALS} -H "content-type:application/json" \
  -XPOST ${RABBITMQ_ENDPOINT}/bindings/${RABBITMQ_VHOST}/e/${RABBITMQ_EXCHANGE}/q/myqueue2 -d '{"routing_key": "key2"}'

