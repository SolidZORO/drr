#! /bin/bash

cd "$(dirname "$0")" || exit

__ROOT_DIR__="$(pwd)" || exit

getEnvVar() {
  if [ -z "$1" ]; then
    echo "environment variable name is required"
    return
  fi

  local ENV_FILE="$__ROOT_DIR__/.env"
  if [ -n "$2" ]; then
    ENV_FILE="$2"
  fi

  # shellcheck disable=SC2155
  local VAR="$(grep $1 "$ENV_FILE" | xargs)"
  IFS="=" read -ra VAR <<<"$VAR"
  echo ${VAR[1]}
}

# shellcheck disable=SC2039
read -r -p "Init Docker Config (create *.example files)? [y/N] " response
case "$response" in
[yY][eE][sS] | [yY])

  DOTENV_FILE=".env"
  if [ -f $DOTENV_FILE ]; then
    printf "\n👌  Already %s, do NOT Init :)\n\n" $DOTENV_FILE
  else
    cp ./.env.example $DOTENV_FILE
    printf "\n✅  Created %s\n\n" $DOTENV_FILE
  fi

  MYSQL_FILE="./etc/mysql/conf.d/mysql.cnf"
  if [ -f $MYSQL_FILE ]; then
    printf "\n👌  Already %s, do NOT Init :)\n\n" $MYSQL_FILE
  else
    cp "$MYSQL_FILE.example" $MYSQL_FILE
    printf "\n✅  Created %s\n\n" $MYSQL_FILE
  fi

  MYSQLD_FILE="./etc/mysql/mysql.conf.d/mysqld.cnf"
  if [ -f $MYSQLD_FILE ]; then
    printf "\n👌  Already %s, do NOT Init :)\n\n" $MYSQLD_FILE
  else
    cp "$MYSQLD_FILE.example" $MYSQLD_FILE
    printf "\n✅  Created %s\n\n" $MYSQLD_FILE
  fi

  LOCALTIME_FILE="./etc/localtime"
  if [ -f $LOCALTIME_FILE ]; then
    printf "\n👌  Already %s, do NOT Init :)\n\n" $LOCALTIME_FILE
  else
    cp "$LOCALTIME_FILE.example" $LOCALTIME_FILE
    printf "\n✅  Created %s\n\n" $LOCALTIME_FILE
  fi

  TIMEZONE_FILE="./etc/timezone"
  if [ -f $TIMEZONE_FILE ]; then
    printf "\n👌  Already %s, do NOT Init :)\n\n" $TIMEZONE_FILE
  else
    cp "$TIMEZONE_FILE.example" $TIMEZONE_FILE
    printf "\n✅  Created %s\n\n" $TIMEZONE_FILE
  fi

  # shellcheck disable=SC2005
  __DATA_DIR__="$(echo "$(getEnvVar DATA_DIR)" | sed 's/^.[/]//g')"
  if [ ! -d $__DATA_DIR__ ]; then
    mkdir -p $__DATA_DIR__
    mkdir -p "$__DATA_DIR__/mysql"
    mkdir -p "$__DATA_DIR__/nginx"

    printf "\n✅  Created %s\n\n" $__DATA_DIR__
  else
    printf "\n👌  Already %s, do NOT Init :)\n\n" $__DATA_DIR__
  fi

  __BACKUP_DIR__="$__ROOT_DIR__/$__DATA_DIR__/_backup"
  if [ ! -d $__BACKUP_DIR__ ]; then
    mkdir -p $__BACKUP_DIR__
    mkdir -p "$__BACKUP_DIR__/mysql"
    mkdir -p "$__BACKUP_DIR__/nginx"

    chmod -R 777 $__BACKUP_DIR__
    printf "\n✅  Created %s\n\n" $__BACKUP_DIR__
  else
    printf "\n👌  Already %s, do NOT Init :)\n\n" $__BACKUP_DIR__
  fi

  ;;
*)
  printf "\nCancel\n"
  ;;
esac
