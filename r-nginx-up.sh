#! /bin/sh

cd "$(dirname "$0")" || exit

docker-compose -f docker-compose.nginx.yml up -d && printf "\n\n✅  NGINX UP!\n\n"

docker container ls -a && printf "\n\n"


# if : port is already allocated, you can check use:
# sudo lsof -i :80
# sudo lsof -i :443
