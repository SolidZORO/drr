#!/usr/bin/env bash

cd "$(dirname "$0")" || exit

docker-compose -f docker-compose.nginx.yml up -d && printf "\n\n✅  Nginx is Up!\n\n"

docker container ls | grep nginx && printf "\n\n"


# if : port is already allocated, you can check use:
# sudo lsof -i :80
# sudo lsof -i :443
