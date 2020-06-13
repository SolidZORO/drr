#! /bin/bash

cd "$(dirname "$0")" || exit

docker-compose -f docker-compose.mysql.yml down
echo "\n\n🎉  MYSQL DOWN!\n\n"

docker container ls -a
echo "\n\n"
