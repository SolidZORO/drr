#!/usr/bin/env bash

cd "$(dirname "$0")" || exit

docker-compose -f docker-compose.mysql.yml down && printf "\n\n✴️  MySQL is Down!\n\n"

docker container ls | grep mysql && printf "\n\n"
