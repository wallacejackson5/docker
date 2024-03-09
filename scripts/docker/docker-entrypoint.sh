#!/bin/sh
tail -f /dev/null &

docker exec -it ${CONTAINER_NAME_PYTHON} sh -c 'for req_file in $(find . -name "requirements.txt"); do
  req_dir=$(dirname "$req_file")
  pip install -r "$req_file"
done'

until nc -z -v -w30 rabbitmq 5672; do
  sleep 3
done
docker exec -it ${CONTAINER_NAME_RABBITMQ} ./docker-entrypoint-initdb.d/init-rabbitmq.sh

echo "Docker started"
# Keep the container running
wait
