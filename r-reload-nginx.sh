#! /bin/bash

cd "$(dirname "$0")" || exit

if [ -f .env ]
  then
    # shellcheck disable=SC2046
    # shellcheck disable=SC2002
    export $(cat .env | sed 's/#.*//g' | xargs)

    C_NAME="${__ENV__}_${NGINX_CONTAINER_NAME}"

    docker exec -it ${C_NAME} nginx -t
    echo "\n"

    echo "---- <${C_NAME}> logs tail 10 ----"
    docker logs ${C_NAME} --tail 10
    echo "\n"

    docker exec -it ${C_NAME} nginx -s reload
    docker top ${C_NAME}
    echo "\n\n"

    docker container ls -a
    echo "\n\n"
  else
    echo "Not Found .env File"
fi
