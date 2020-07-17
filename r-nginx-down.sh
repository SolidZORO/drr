#! /bin/sh

cd "$(dirname "$0")" || exit

docker-compose -f docker-compose.nginx.yml down && printf "\n\n✴️  NGINX DOWN!\n\n"

docker container ls -a && printf "\n\n"
