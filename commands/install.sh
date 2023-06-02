#!/usr/bin/env sh

# get current location
ROOT_DIR=$1
CONFIG_DIR="$ROOT_DIR/config"
SCRIPTS_DIR="$ROOT_DIR/scripts"
SETUP_MODE=$2

source "$ROOT_DIR/commands/__util.sh"

bash "$SCRIPTS_DIR/oh-my-zsh.sh" "$ROOT_DIR" "$SETUP_MODE"
bash "$SCRIPTS_DIR/dots.sh" "$ROOT_DIR" "$SETUP_MODE"
bash "$SCRIPTS_DIR/brew.sh" "$ROOT_DIR" "$SETUP_MODE"
bash "$SCRIPTS_DIR/cask.sh" "$ROOT_DIR" "$SETUP_MODE"
bash "$SCRIPTS_DIR/node.sh" "$ROOT_DIR" "$SETUP_MODE"
bash "$SCRIPTS_DIR/mac.sh" "$ROOT_DIR" "$SETUP_MODE"

log_start "Reloading zshrc"
zsh
