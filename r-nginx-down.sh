#!/usr/bin/env bash

cd "$(dirname "$0")" || exit

docker-compose -f docker-compose.nginx.yml down && printf "\n\n✴️  NGINX DOWN!\n\n"

docker container ls | grep nginx && printf "\n\n"
