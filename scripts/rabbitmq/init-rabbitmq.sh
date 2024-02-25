#!/bin/bash
echo "Script is running"

# RabbitMQ credentials
RABBITMQ_USER="myuser"
RABBITMQ_PASSWORD="mypassword"
RABBITMQ_CREDENTIALS="${RABBITMQ_USER}:${RABBITMQ_PASSWORD}"
RABBITMQ_VHOST="myvhost"

# RabbitMQ server address
RABBITMQ_ENDPOINT="http://localhost:15672/api"

# RabbitMQ configuration commands
rabbitmqctl add_user ${RABBITMQ_USER} ${RABBITMQ_PASSWORD}
rabbitmqctl add_vhost myvhost
rabbitmqctl set_permissions -p myvhost ${RABBITMQ_USER} ".*" ".*" ".*"
rabbitmqctl set_permissions -p myvhost ${RABBITMQ_DEFAULT_USER} ".*" ".*" ".*"
rabbitmqctl set_user_tags ${RABBITMQ_USER} management

# Install curl (if not already installed)
apt update && apt install -y curl

# RabbitMQ configuration commands using HTTP API
curl -i -u ${RABBITMQ_CREDENTIALS} -H "content-type:application/json" \
  -XPUT ${RABBITMQ_ENDPOINT}/exchanges/${RABBITMQ_VHOST}/myexchange -d'{"type": "direct"}'
curl -i -u ${RABBITMQ_CREDENTIALS} -H "content-type:application/json" \
  -XPUT ${RABBITMQ_ENDPOINT}/queues/${RABBITMQ_VHOST}/myqueue1 -d'{}'
curl -i -u ${RABBITMQ_CREDENTIALS} -H "content-type:application/json" \
  -XPUT ${RABBITMQ_ENDPOINT}/queues/${RABBITMQ_VHOST}/myqueue2 -d'{}'
curl -i -u ${RABBITMQ_CREDENTIALS} -H "content-type:application/json" \
  -XPOST ${RABBITMQ_ENDPOINT}/bindings/${RABBITMQ_VHOST}/e/myexchange/q/myqueue1 -d'{"routing_key": "key1"}'
curl -i -u ${RABBITMQ_CREDENTIALS} -H "content-type:application/json" \
  -XPOST ${RABBITMQ_ENDPOINT}/bindings/${RABBITMQ_VHOST}/e/myexchange/q/myqueue2 -d'{"routing_key": "key2"}'

