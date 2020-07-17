#! /bin/sh

cd "$(dirname "$0")" || exit

docker container ls -a
printf "\n\n"

read -r -p "⚠️  MYSQL reboot? [y/N] " response

case "$response" in
    [yY][eE][sS]|[yY])
        sh r-mysql-down.sh && sh r-mysql-up.sh
        printf "\n\n🔄  MYSQL rebooooooooot!\n\n"
        ;;
    *)
        # shellcheck disable=SC2028
        printf "\nCancel\n"
        ;;
esac



