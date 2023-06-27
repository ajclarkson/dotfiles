#!/bin/bash

ARROW="￫"
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m'

log_start() {
  echo ""
  echo ""
  echo -e "${CYAN} $ARROW $1 ${NC}"
  echo ""
}

log_success() {
  echo ""
  echo ""
  echo -e "${GREEN} $ARROW $1 ${NC}"
  echo ""
}

log_warn() {
  echo ""
  echo ""
  echo -e "${YELLOW} $ARROW $1 ${NC}"
  echo ""
}

log_error() {
    echo ""
    echo ""
    echo -e "${RED} $ARROW $1 ${NC}"
    echo ""
}

function symlink_dir() {
  echo "**** Sym linking directory from $1 to $2"
  if [ -L "$2" ]; then
    echo "found old $2 - removing ..."
    rm "$2"
  fi

  echo "linking $1 -> $2"
  ln -s "$1" "$2"
  echo ""
}

function symlink_files() {
  echo "**** Sym linking files from $1 to $2"
  for FILE in $1/{.[!.]*,*}
  do
    if [ -f "$FILE" ]; then
      echo "Processing $FILE file"
      FILE_NAME=$(basename -- "$FILE")

      if [ -L "$2/$FILE_NAME" ]; then
        echo "found old $2/$FILE_NAME - removing ..."
        rm "$2/$FILE_NAME"
      fi

      echo "linking $FILE -> $2/$FILE_NAME"
      ln -s "$FILE" "$2/$FILE_NAME"
      echo ""
    fi
  done
}

function symlink() {
  ln -s "$1" "$2";
}

function check_os_compatibility() {
    script=$1
    os=$2
    valid=$3

    if [[ ! " ${valid[*]} " =~ " ${os} " ]]; then
        echo $os
        log_warn "$script does not support OS=$os, skipping execution. Valid os values are: ${valid[*]}"
        exit 0
    fi
}
