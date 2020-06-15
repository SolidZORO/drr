#! /bin/bash

cd "$(dirname "$0")" || exit

if [ -f .env ]
  then
    # shellcheck disable=SC2046
    export $(cat < .env | sed 's/#.*//g' | xargs)

    C_NAME="${__ENV__}_${NGINX_CONTAINER_NAME}"

    echo "---- <${C_NAME}> -t test ----"
    docker exec -it "${C_NAME}" nginx -t
    printf "\n"

    echo "---- <${C_NAME}> logs tail 5 ----"
    docker logs "${C_NAME}" --tail 5
    printf "\n"

    echo "---- <${C_NAME}> reload ----"
    # nginx -s `force-reload` for acme.sh
    # https://github.com/acmesh-official/acme.sh#3-install-the-cert-to-apachenginx-etc
    docker exec -it "${C_NAME}" nginx -s force-reload
    docker top "${C_NAME}"
    printf  "\n\n🎉  NGINX RELOAD!\n\n"

    docker container ls -a
    printf "\n\n"
  else
    echo "Not Found .env File"
fi
