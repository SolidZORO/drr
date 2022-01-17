#!/usr/bin/env bash

cd "$(dirname "$0")" || exit

if [ -z "$1" ]; then
  printf "\nMissing Name!\n\n"
  exit 1
fi

CONFIG_FILE="docker-compose.${1}.yml"

if [ ! -f "$CONFIG_FILE" ]; then
  printf "\nMissing %s!\n\n" "$CONFIG_FILE"
  exit 1
fi

docker-compose -f "$CONFIG_FILE" down && printf "\n\n🚫 %s is Down!\n\n" "$1"

docker container ls | grep "$1" && printf "\n\n"
