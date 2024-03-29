#!/usr/bin/env bash

SHELL=/bin/bash

cd "$(dirname "$0")" || exit

__ROOT_DIR__="$(
  cd ".."
  pwd
)" || exit

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

# shellcheck disable=SC2046
# shellcheck disable=SC2005
__DATA_DIR__="$(echo "$(getEnvVar DATA_DIR)" | sed 's/^.[/]//g')"

# shellcheck disable=SC2230
__DOCKER_PATH__="$(which docker)"
__DOCKER_VERSION__="$(docker --version)"
__BACKUP_DIR__="$__ROOT_DIR__/$__DATA_DIR__/_backup/mysql"
__BACKUP_LOG__="$__BACKUP_DIR__/_backup.log"

if [ ! -d ${__BACKUP_DIR__} ]; then
  printf "🔰 MKDIR: %s\n" $__BACKUP_DIR__
  mkdir -p $__BACKUP_DIR__
  chmod -R 777 $__BACKUP_DIR__
fi

cd $__BACKUP_DIR__ || exit

MYSQL_CONTAINER="$(getEnvVar __ENV__)_$(getEnvVar MYSQL_CONTAINER_NAME)"
MYSQL_BACKUP_KEEP_DAYS=$(getEnvVar MYSQL_BACKUP_KEEP_DAYS)
MYSQL_BACKUP_TABLES=$(getEnvVar MYSQL_BACKUP_TABLES)

IFS=',' read -ra BAK <<<"$MYSQL_BACKUP_TABLES"

printf "\n"
printf "🔰 __ROOT_DIR__       : %s\n" "$__ROOT_DIR__"
printf "🔰 __BACKUP_DIR__     : %s\n" "$__BACKUP_DIR__"
printf "🔰 __DOCKER_PATH__    : %s\n" "$__DOCKER_PATH__"
printf "🔰 __DOCKER_VERSION__ : %s\n" "$__DOCKER_VERSION__"
printf "\n"
printf "📌 MYSQL_BACKUP_KEEP_DAYS : %s\n" "$MYSQL_BACKUP_KEEP_DAYS"
printf "📌 MYSQL_BACKUP_TABLES    : %s\n" "$MYSQL_BACKUP_TABLES"
printf "\n"

# shellcheck disable=SC2129
printf "$(date +%Y-%m-%d-%H:%M:%S) [Note] __ROOT_DIR__       : %s\n" "$__ROOT_DIR__" >>"$__BACKUP_LOG__"
printf "$(date +%Y-%m-%d-%H:%M:%S) [Note] __BACKUP_DIR__     : %s\n" "$__BACKUP_DIR__" >>"$__BACKUP_LOG__"
printf "$(date +%Y-%m-%d-%H:%M:%S) [Note] __DOCKER_PATH__    : %s\n" "$__DOCKER_PATH__" >>"$__BACKUP_LOG__"
printf "$(date +%Y-%m-%d-%H:%M:%S) [Note] __DOCKER_VERSION__ : %s\n\n" "$__DOCKER_VERSION__" >>"$__BACKUP_LOG__"

# shellcheck disable=SC2028
#echo "$(date +%Y-%m-%d-%H:%M:%S) [Note] __ENV__: $(env)\n\n" >>"$__BACKUP_LOG__"

for i in "${BAK[@]}"; do
  printf "BACKUP DB %s\n" "$i"

  #e.g. 2020-06-08T16:39:15 [Backup] mysqlœ
  printf "$(date +%Y-%m-%d-%H:%M:%S) [Note] -- %s --\n" "$i" >>"$__BACKUP_LOG__"

  # http://dev.mysql.com/doc/refman/5.5/en/password-security-user.html
  CMD_BACKUP="MYSQL_PWD='$(getEnvVar MYSQL_PASSWORD)' mysqldump -u$(getEnvVar MYSQL_USER) $i"
  CMD_ZIP="gzip > /var/backups/$i-$(date +%Y%m%d-%H%M%S).sql.gz"

  echo "$(date +%Y-%m-%d-%H:%M:%S) [Note] CMD: $CMD_ZIP" >>"$__BACKUP_LOG__"

  # docker us `ABS-PATH`
  "$__DOCKER_PATH__" exec -i "$MYSQL_CONTAINER" sh -c "$CMD_BACKUP | $CMD_ZIP"

  echo "$(date +%Y-%m-%d-%H:%M:%S) [Note] Mysql Backup is Done!" >>"$__BACKUP_LOG__"
done

# shellcheck disable=SC2028
printf "\n\n\n\n" >>"$__BACKUP_LOG__"

# delete > N day backups
find . -name "*.sql.gz" -mtime +$MYSQL_BACKUP_KEEP_DAYS -exec rm -rf {} \;

printf "\n\n✅  MySQL Backup is Done!\n\n\n\n"

# Log
# shellcheck disable=SC2046
echo $(date +%Y%m%d-%H%M%S) mysql-backup >>"$HOME/.crontab.log" 2>&1
