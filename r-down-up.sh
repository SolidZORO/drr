#! /bin/bash

CURRENT_DIR="$(dirname "$0")"

cd "$CURRENT_DIR" || exit

sh "$CURRENT_DIR/r-down.sh"
sh "$CURRENT_DIR/r-up.sh"
