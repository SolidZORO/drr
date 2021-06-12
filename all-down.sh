#!/usr/bin/env bash

cd "$(dirname "$0")" || exit

docker-compose -f docker-compose.nginx.yml down && printf "\n\n✴️  Nginx is Down!\n\n"
docker-compose -f docker-compose.mysql.yml down && printf "\n\n✴️  MySQL is Down!\n\n"
docker-compose -f docker-compose.acme.yml down && printf "\n\n✴️  Acme is Down!\n\n"

docker container ls | grep nginx && printf "\n\n"
