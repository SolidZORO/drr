#!/usr/bin/env bash

CURRENT_DIR="$(dirname "$0")"

cd "$CURRENT_DIR" || exit

docker container ls
printf "\n\n"

read -r -p "⚠️ ⚠️ ⚠️ Reboot ALL Containers? [y/N] " response

case "$response" in
  [yY][eE][sS]|[yY])
    sh "$CURRENT_DIR/r-mysql-reboot.sh"
    sh "$CURRENT_DIR/r-nginx-reboot.sh"
    printf "🎉  Reboot All Containers!\n\n"
    ;;
  *)
    printf "\nCancel\n"
    ;;
esac
