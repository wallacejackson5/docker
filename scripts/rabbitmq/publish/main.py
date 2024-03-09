from publisher import RabbitMQPublisher
from load import get_config
from load import get_json
from load import get_dump
from mock import get_mock
import os

def main():
    config = get_config()
    publisher = RabbitMQPublisher(config)
    publisher.connect()

    for i in range(5):
        payload = get_payload(i)
        publisher.publish_message(payload)

    publisher.close()

def get_payload(index):
    scheme = get_json('payload.json')
    mock = get_mock(scheme, id=index)
    return get_dump(mock)

def define_root():
    try:
        os.chdir("/app/publish")
    except:
        os.chdir(".")

if __name__ == '__main__':
    define_root()
    main()
