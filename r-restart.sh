#! /bin/bash

cd "$(dirname "$0")" || exit

docker-compose restart
echo "\n\n"

docker-compose ps
echo "\n\n"

docker container ls -a
echo "\n\n"
