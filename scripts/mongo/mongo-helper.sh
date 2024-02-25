#!/bin/bash

echo "Script is running"
source .env

# MongoDB server address
MONGODB_HOST=localhost
MONGODB_PORT=27017
DATABASE_NAME=mydatabase
COLLECTION_NAME=book
USERNAME=root
PASSWORD=secret

# Function to set up MongoDB connection
setupMongodbConnection() {
    MONGODB_ENDPOINT="mongodb://${MONGODB_HOST}:${MONGODB_PORT}/${DATABASE_NAME}"
    echo "MongoDB Connection String: ${MONGODB_ENDPOINT}"
}

# Function to execute find operation
executeFind() {
    docker exec -it ${CONTAINER_NAME} mongosh "${MONGODB_ENDPOINT}" -u ${USERNAME} -p ${PASSWORD} --authenticationDatabase admin --eval "db.${COLLECTION_NAME}.find()"
}

# Call the setupMongoConnection function
setupMongodbConnection
executeFind

