#!/usr/bin/env bash

CURRENT_DIR="$(dirname "$0")"

cd "$CURRENT_DIR" || exit

docker container ls
printf "\n\n"

read -r -p "⚠️ ⚠️ ⚠️ Reboot ALL Containers? [y/N] " response

case "$response" in
  [yY][eE][sS] | [yY])
    sh "$CURRENT_DIR/mysql-reboot.sh" -y
    sh "$CURRENT_DIR/nginx-reboot.sh" -y
    printf "✅  All Containers [Reboot] is Done!\n\n"
    ;;
  *)
    printf "\nCancel\n\n"
    ;;
esac
