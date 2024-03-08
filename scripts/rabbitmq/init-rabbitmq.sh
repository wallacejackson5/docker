#!/bin/bash
sleep 5

# RabbitMQ configuration commands
rabbitmqctl import_definitions /etc/rabbitmq/definitions.json

echo "Script execution started" >> /var/log/rabbitmq/init-script.log
