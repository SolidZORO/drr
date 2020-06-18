#! /bin/bash

cd "$(dirname "$0")" || exit

docker-compose -f docker-compose.nginx.yml up -d
printf "\n\n🎉  NGINX UP!\n\n"

docker container ls -a
printf "\n\n"
