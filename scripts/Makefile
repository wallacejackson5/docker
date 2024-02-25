#!make
include .env

up:
	@docker-compose up --remove-orphans --detach &&\
		sleep 10 &&\
		make setUp

# SetUp
setUp:
	@docker exec -it ${CONTAINER_NAME_RABBITMQ} /docker-entrypoint-initdb.d/init-rabbitmq.sh;
	@docker exec -it ${CONTAINER_NAME_PYTHON} pip install -r requirements.txt;

#RabbitMQ Helper
publish:
	@docker exec -it ${CONTAINER_NAME_PYTHON} python3 main.py;

#Container helper
stop:
	@docker stop ${CONTAINER_NAME}

rm:
	@docker rm ${CONTAINER_NAME} --force

sh:
	@docker exec -it ${CONTAINER_NAME} /bin/sh

log:
	@docker logs -f ${CONTAINER_NAME}

#Docker Helper
dockerStopContainers:
	@docker ps -a -q | xargs docker stop && docker ps -a -q

dockerRmContainers:
	@docker ps -a -q | xargs docker stop && docker ps -a -q | xargs docker rm
	
dockerRmNetworks:
	@docker network prune -f
	
dockerRmVolumes:
	@docker volume prune -f
	
dockerClean:
	@make dockerStopContainers; make dockerRmContainers; make dockerRmNetworks; make dockerRmVolumes

dockerRmImages:
	@docker images -a --format "{{.ID}}" | xargs docker rmi -f
