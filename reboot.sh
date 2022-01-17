#!/usr/bin/env bash

cd "$(dirname "$0")" || exit

docker container ls | grep "$1"
printf "\n"

yesFlag=''

# 第一参数形式 sh ./reboot.sh -y，跳过 read 询问
while getopts 'y' flag; do
  case "${flag}" in
    y) yesFlag='y' ;;
    *) exit 1 ;;
  esac
done

# 第二参数形式 sh ./reboot.sh nginx -y，跳过 read 询问
if [ "$2" = "-y" ]; then
  yesFlag='y'
fi

if [ "$yesFlag" != "y" ]; then
  read -r -p "⚠️  $1 reboot? [y/N] " response

  if [ "$response" != "y" ]; then
    printf "\nCancel\n\n"
    exit 1
  fi
fi

if [ -z "$1" ]; then
  printf "\nMissing Name!\n\n"
  exit 1
fi

sh down.sh "$1"
sh up.sh "$1"
