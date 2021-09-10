#!/usr/bin/env bash

cd "$(dirname "$0")" || exit

docker-compose -f docker-compose.nginx.yml up -d && printf "\n\n✴️  Nginx is Up!\n\n"
docker-compose -f docker-compose.mysql.yml up -d && printf "\n\n✴️  MySQL is Up!\n\n"
#docker-compose -f docker-compose.acme.yml up -d && printf "\n\n✴️  Acme is Up!\n\n"

docker container ls | grep nginx && printf "\n\n"
