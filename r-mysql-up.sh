#!/usr/bin/env bash

cd "$(dirname "$0")" || exit

docker-compose -f docker-compose.mysql.yml up -d && printf "\n\n✅  MYSQL UP!\n\n"

docker container ls | grep mysql && printf "\n\n"
