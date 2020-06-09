#! /bin/bash

cd "$(dirname "$0")" || exit

read -r -p "Remove All Containers? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
        CIDS=$(docker container ls -aq)

        if [ -n "$CIDS" ]; then
            docker container stop $CIDS
            docker container rm -f $CIDS
            echo "\n\n"

            docker-compose ps
            echo "\n\n"

            docker container ls -a
            echo "\n\n"
          else
            # shellcheck disable=SC2028
            echo '\nNot Found Containers\n'
        fi

        # docker container prune -f
        ;;
    *)
        # shellcheck disable=SC2028
        echo "\nCancel\n"
        ;;
esac
