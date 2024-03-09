#!/bin/bash
set -eo pipefail
shopt -s nullglob

# RabbitMQ configuration commands
rabbitmqctl import_definitions /etc/rabbitmq/definitions.json

echo "Script execution started" >> /var/log/rabbitmq/init-script.log
