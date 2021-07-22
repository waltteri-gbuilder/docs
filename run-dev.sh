#!/bin/bash
SRC_PATH="/usr/src/docs"
CONTAINER_NAME="docs-dev"

docker build . --build-arg SRC_PATH="${SRC_PATH}" --target=dev-env -t gbuildercom/docs:dev
docker rm -f $CONTAINER_NAME
docker run -d -p 8000:80 -v $(pwd):$SRC_PATH --name $CONTAINER_NAME gbuildercom/docs:dev