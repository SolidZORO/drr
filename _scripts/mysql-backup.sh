#! /bin/bash

cd "$(dirname "$0")" || exit

__ROOT_PATH__="$(
  cd "$(dirname "$0")"
  cd ".."
  pwd
)" || exit

getEnvVar() {
  if [ -z "$1" ]; then
    echo "environment variable name is required"
    return
  fi

  local ENV_FILE="$__ROOT_PATH__/.env"
  if [ -n "$2" ]; then
    ENV_FILE="$2"
  fi

  # shellcheck disable=SC2155
  local VAR="$(grep $1 "$ENV_FILE" | xargs)"
  IFS="=" read -ra VAR <<<"$VAR"
  echo ${VAR[1]}
}

MYSQL_CONTAINER="$(getEnvVar __ENV__)_$(getEnvVar MYSQL_CONTAINER_NAME)"

MYSQL_BACKUP_KEEP_DAYS=$(getEnvVar MYSQL_BACKUP_KEEP_DAYS)
MYSQL_BACKUP_TABLES=$(getEnvVar MYSQL_BACKUP_TABLES)
IFS=',' read -ra BAK <<<"$MYSQL_BACKUP_TABLES"

#
#

for i in "${BAK[@]}"; do
  echo "✅ BACKUP DB $i"

  # http://dev.mysql.com/doc/refman/5.5/en/password-security-user.html
  CMD_BACKUP="MYSQL_PWD='$(getEnvVar MYSQL_PASSWORD)' mysqldump --defaults-extra-file=/etc/mysql/conf.d/mysql.cnf -u$(getEnvVar MYSQL_USER) $i"
  CMD_ZIP="gzip > /var/backups/$i-$(date +%Y%m%d-%H%M%S).sql.gz"

  docker exec -i "$MYSQL_CONTAINER" sh -c "$CMD_BACKUP | $CMD_ZIP"
done

cd "$__ROOT_PATH__/$(getEnvVar DATA_DIR)/mysql/backups" || exit

printf "\n\n"

printf "📌 MYSQL_BACKUP_KEEP_DAYS: %s\n" $MYSQL_BACKUP_KEEP_DAYS
printf "📌 MYSQL_BACKUP_TABLES: %s\n" $MYSQL_BACKUP_TABLES
printf "📌 BACKUPSDIR: %s\n" "$(pwd)"

# delete > N day backups
find . -name "*.sql.gz" -mtime +$MYSQL_BACKUP_KEEP_DAYS -exec rm -rf {} \;
