#! /bin/bash

cd "$(dirname "$0")" || exit

docker container ls -a
printf "\n\n"

read -r -p "NGINX REBOOT? [y/N] " response

case "$response" in
    [yY][eE][sS]|[yY])
        sh r-nginx-down.sh && sh r-nginx-up.sh
        printf "\n\n🎉  NGINX REBOOOOOOOOOT!\n\n"
        ;;
    *)
        # shellcheck disable=SC2028
        printf "\nCancel\n"
        ;;
esac



