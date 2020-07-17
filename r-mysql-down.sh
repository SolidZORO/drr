#! /bin/sh

cd "$(dirname "$0")" || exit

docker-compose -f docker-compose.mysql.yml down && printf "\n\n✴️  MYSQL DOWN!\n\n"

docker container ls -a && printf "\n\n"
