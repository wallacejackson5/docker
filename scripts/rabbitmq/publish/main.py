from publisher import RabbitMQPublisher
from generator.load import get_config
from generator.payload import get_payload
import os

def main():
    config = get_config()
    publisher = RabbitMQPublisher(config)
    publisher.connect()

    for i in range(5):
        payload = get_payload()
        publisher.publish_message(payload)

    publisher.close()

def define_root():
    try:
        os.chdir("/app/publish")
    except:
        os.chdir(".")

if __name__ == '__main__':
    define_root()
    main()
