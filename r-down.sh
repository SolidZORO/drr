#! /bin/bash

cd "$(dirname "$0")" || exit

docker-compose down
echo "\n\n"

docker container ls -a
echo "\n\n"
