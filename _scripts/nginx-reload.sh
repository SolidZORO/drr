#!/usr/bin/env bash

SHELL=/bin/bash

cd "$(dirname "$0")" || exit

__ROOT_DIR__="$(
  cd ".."
  pwd
)" || exit

getEnvVar() {
  if [ -z "$1" ]; then
    echo "environment variable name is required"
    return
  fi

  local ENV_FILE="$__ROOT_DIR__/.env"
  if [ -n "$2" ]; then
    ENV_FILE="$2"
  fi

  # shellcheck disable=SC2155
  local VAR="$(grep $1 "$ENV_FILE" | xargs)"
  IFS="=" read -ra VAR <<<"$VAR"
  echo ${VAR[1]}
}


NGINX_CONTAINER="$(getEnvVar __ENV__)_$(getEnvVar NGINX_CONTAINER_NAME)"

docker exec -it $NGINX_CONTAINER nginx -v
docker exec -it $NGINX_CONTAINER nginx -s reload
docker exec -it $NGINX_CONTAINER nginx -t

printf "\n\n✅  RELOAD DONE!\n\n"
