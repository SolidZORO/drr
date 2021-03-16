#!/usr/bin/env bash

cd "$(dirname "$0")" || exit

cd ..
sh ./r-nginx-reload.sh

# Log
# shellcheck disable=SC2046
echo $(date +%Y%m%d-%H%M%S) nginx-reload >>"$HOME/.crontab.log" 2>&1
