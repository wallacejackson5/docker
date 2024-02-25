import pika

class RabbitMQPublisher:
    def __init__(self, config):
        self.host = config['rabbitmq']['host']
        self.queue = config['rabbitmq']['queue']
        self.vhost = config['rabbitmq']['vhost']
        self.exchange = config['rabbitmq']['exchange']
        self.routing_key = config['rabbitmq']['routing_key']
        self._connection = None
        self._channel = None

    def connect(self):
        parameters = pika.ConnectionParameters(host=self.host, virtual_host=self.vhost)
        self._connection = pika.BlockingConnection(parameters)
        self._channel = self._connection.channel()
        self._channel.queue_declare(queue=self.queue, durable=False)

    def publish_message(self, message, content_type='application/json'):
        if not self._channel:
            raise RuntimeError('Not connected to RabbitMQ')
        self._channel.basic_publish(exchange=self.exchange,
                                    routing_key=self.routing_key,
                                    body=message,
                                    properties=pika.BasicProperties(
                                        content_type=content_type
                                    ))
        print(f" [x] Message sent: {message}")

    def close(self):
        if self._connection:
            self._connection.close()
