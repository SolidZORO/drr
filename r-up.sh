#! /bin/bash

cd "$(dirname "$0")" || exit

# .env `COMPOSE_FILE` can skip this step
#docker-compose -f docker-compose.mysql.yml up -d
#docker-compose -f docker-compose.nginx.yml up -d

docker-compose up -d
echo "\n\n"

docker-compose ps
echo "\n\n"

docker container ls -a
echo "\n\n"
