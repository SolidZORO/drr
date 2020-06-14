#! /bin/bash

cd "$(dirname "$0")" || exit

read -r -p "Init Docker Config (create *.example files)? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])

        DOTENV_FILE=".env"
        if [ -f "${DOTENV_FILE}" ]; then
            printf "\n👌  Already %s, do NOT Init :)\n\n" $DOTENV_FILE
          else
            cp ./.env.example $DOTENV_FILE
        fi

        MYSQL_FILE="./etc/mysql/conf.d/mysql.cnf"
        if [ -f "${MYSQL_FILE}" ]; then
            printf "\n👌  Already %s, do NOT Init :)\n\n" MYSQL_FILE
          else
            cp "$MYSQL_FILE.example" $MYSQL_FILE
        fi

        MYSQLD_FILE="./etc/mysql/mysql.conf.d/mysqld.cnf"
        if [ -f "${MYSQLD_FILE}" ]; then
            printf "\n👌  Already %s, do NOT Init :)\n\n" MYSQLD_FILE
          else
            cp "$MYSQLD_FILE.example" $MYSQLD_FILE
        fi

        ;;
    *)
        # shellcheck disable=SC2028
        echo "\nCancel\n"
        ;;
esac
