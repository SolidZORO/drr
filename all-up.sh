#!/usr/bin/env bash

cd "$(dirname "$0")" || exit

#docker-compose -f docker-compose.nginx.yml up -d && printf "\n\n✴️  Nginx is Up!\n\n"
#docker-compose -f docker-compose.mysql.yml up -d && printf "\n\n✴️  MySQL is Up!\n\n"
#docker-compose -f docker-compose.adminer.yml up -d && printf "\n\n✴️  Adminer is Up!\n\n"
#docker-compose -f docker-compose.acme.yml up -d && printf "\n\n✴️  Acme is Up!\n\n"

sh ./up.sh nginx -y
sh ./up.sh mysql -y
sh ./up.sh adminer -y

docker container ls && printf "\n\n"
