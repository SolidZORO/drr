#!/usr/bin/env bash

cd "$(dirname "$0")" || exit

read -r -p "⚠️ ⚠️ ⚠️ Remove ALL Containers? [y/N] " response

case "$response" in
  [yY][eE][sS] | [yY])
    CIDS=$(docker container ls -aq)

    if [ -n "$CIDS" ]; then
      docker container stop $CIDS
      docker container rm -f $CIDS
      printf "✅  All Containers [Remove] is Done!\n\n"

      docker container ls -a
      printf "\n\n"
    else
      printf '\nNot Found Containers\n'
    fi

    # docker container prune -f
    ;;
  *)
    printf "\nCancel\n\n"
    ;;
esac
