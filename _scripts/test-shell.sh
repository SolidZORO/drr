#!/bin/bash

SHELL=/bin/bash

cd "$(dirname "$0")" || exit

# shellcheck disable=SC2005
# shellcheck disable=SC2028
# shellcheck disable=SC2230
echo "docker-path2   : $(which docker)"
echo "docker-path1   : $(whereis docker)"
echo ""
echo "docker-version : $(docker --version)"
