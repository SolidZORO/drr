#!/usr/bin/env bash

CURRENT_DIR="$(dirname "$0")"

cd "$CURRENT_DIR" || exit

docker container ls
printf "\n"

yesFlag=''

while getopts 'y' flag; do
  case "${flag}" in
    y) yesFlag='y' ;;
    *) exit 1 ;;
  esac
done

if [ "$yesFlag" != "y" ]; then
  read -r -p "⚠️ ⚠️ ⚠️  Reboot ALL Containers? [y/N] " response

  if [ "$response" != "y" ]; then
    printf "\nCancel\n\n"
    exit 1
  fi
fi

sh "$CURRENT_DIR/all-down.sh" -y
sh "$CURRENT_DIR/all-up.sh" -y

printf "✅  All Containers [Reboot] is Done!\n\n"
