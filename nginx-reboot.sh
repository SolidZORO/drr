#!/usr/bin/env bash

cd "$(dirname "$0")" || exit

docker container ls | grep nginx
printf "\n"

yesFlag=''

while getopts 'y' flag; do
  case "${flag}" in
    y) yesFlag='y' ;;
    *) exit 1 ;;
  esac
done

if [ "$yesFlag" != "y" ]; then
  read -r -p "⚠️  Nginx reboot? [y/N] " response

  if [ "$response" != "y" ]; then
    printf "\nCancel\n\n"
    exit 1
  fi
fi

sh nginx-down.sh
sh nginx-up.sh
