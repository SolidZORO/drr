#! /bin/bash

cd "$(dirname "$0")" || exit

docker-compose -f docker-compose.nginx.yml down
echo "\n\n🎉  NGINX DOWN!\n\n"

docker container ls -a
echo "\n\n"
