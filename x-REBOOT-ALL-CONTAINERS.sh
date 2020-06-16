#! /bin/bash

CURRENT_DIR="$(dirname "$0")"

cd "$CURRENT_DIR" || exit

docker container ls -a
printf "\n\n"

read -p "Reboot All Containers? (Enter/n)" -n 1 -r KEY


if [ "$KEY" = "" ]; then
    sh "$CURRENT_DIR/r-mysql-reboot.sh" && sh "$CURRENT_DIR/r-nginx-reboot.sh"
    printf "🎉  Reboot All Containers!\n\n"
else
    # shellcheck disable=SC2028
    printf "\n\nCancel\n"
fi
