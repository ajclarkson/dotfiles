#!/usr/bin/env sh
ROOT_DIR=$1
CONFIG_DIR="$ROOT_DIR/config"
SCRIPTS_DIR="$ROOT_DIR/scripts"
SETUP_MODE=$2
SUB_COMMAND=$3

source "$ROOT_DIR/commands/__util.sh"

unameOut="$(uname -s)"
case "${unameOut}" in 
    Linux*)     OS=linux;;
    Darwin*)    OS=mac;;
    *)          exit 1
esac

ARCH="$(arch)"

if [ -n "$3" ]; then
  log_start "Running install subcommand $SUB_COMMAND with SETUP_MODE=$SETUP_MODE, OS=$OS, ARCH=$ARCH"
  bash "$SCRIPTS_DIR/$SUB_COMMAND.sh" "$ROOT_DIR" "$SETUP_MODE" "$OS" "$ARCH"
echo "$SHELL $FISH_PATH $OS $ARCH"
else
  log_start "Running install script with SETUP_MODE=$SETUP_MODE, OS=$OS, ARCH=$ARCH"
  bash "$SCRIPTS_DIR/dots.sh" "$ROOT_DIR" "$SETUP_MODE" "$OS" "$ARCH"
  bash "$SCRIPTS_DIR/utils.sh" "$ROOT_DIR" "$SETUP_MODE" "$OS" "$ARCH"
  bash "$SCRIPTS_DIR/applications.sh" "$ROOT_DIR" "$SETUP_MODE" "$OS" "$ARCH"
  bash "$SCRIPTS_DIR/kitty.sh" "$ROOT_DIR" "$SETUP_MODE" "$OS" "$ARCH"
  bash "$SCRIPTS_DIR/fish.sh" "$ROOT_DIR" "$SETUP_MODE" "$OS" "$ARCH"
  bash "$SCRIPTS_DIR/node.sh" "$ROOT_DIR" "$SETUP_MODE" "$OS" "$ARCH"
  bash "$SCRIPTS_DIR/mac.sh" "$ROOT_DIR" "$SETUP_MODE" "$OS" "$ARCH"
  bash "$SCRIPTS_DIR/nvim.sh" "$ROOT_DIR" "$SETUP_MODE" "$OS" "$ARCH"
  bash "$SCRIPTS_DIR/tmux.sh" "$ROOT_DIR" "$SETUP_MODE" "$OS" "$ARCH"
  bash "$SCRIPTS_DIR/qmk.sh" "$ROOT_DIR" "$SETUP_MODE" "$OS" "$ARCH"
  bash "$SCRIPTS_DIR/bat.sh" "$ROOT_DIR" "$SETUP_MODE" "$OS" "$ARCH"
fi


log_start "Reloading fish"
fish
