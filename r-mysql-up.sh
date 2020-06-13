#! /bin/bash

cd "$(dirname "$0")" || exit

docker-compose -f docker-compose.mysql.yml up -d
echo "\n\n🎉  MYSQL UP!\n\n"

docker container ls -a
echo "\n\n"
