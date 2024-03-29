#!/usr/bin/env bash

cd "$(dirname "$0")" || exit

if [ -f .env ]
  then
    # shellcheck disable=SC2046
    export $(cat < .env | sed 's/#.*//g' | xargs)

    C_NAME="${__ENV__}_${NGINX_CONTAINER_NAME}"

    echo "---- <${C_NAME}> -t test ----"
    docker exec -it "${C_NAME}" nginx -t
    printf "\n"

    echo "---- <${C_NAME}> reload ----"
    # nginx -s `force-reload` for acme.sh
    # https://github.com/acmesh-official/acme.sh#3-install-the-cert-to-apachenginx-etc
    docker exec -it "${C_NAME}" nginx -s reload
    docker top "${C_NAME}"
    printf  "\n\n✅  Nginx is -s reload!\n\n"

    docker container ls | grep nginx
    printf "\n\n"
  else
    echo "Not Found .env File"
fi
