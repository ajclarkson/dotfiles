#!/usr/bin/env sh

ROOT_DIR=$1
CONFIG_DIR="$ROOT_DIR/config"
SCRIPTS_DIR="$ROOT_DIR/scripts"
SETUP_MODE=$2
SUB_COMMAND=$3

source "$ROOT_DIR/commands/__util.sh"

if [ -n "$3" ]; then
  log_start "Running install subcommand $SUB_COMMAND with SETUP_MODE=$SETUP_MODE"
  bash "$SCRIPTS_DIR/$SUB_COMMAND.sh" "$ROOT_DIR" "$SETUP_MODE"
else
  log_start "Running install script with SETUP_MODE=$SETUP_MODE"
  bash "$SCRIPTS_DIR/dots.sh" "$ROOT_DIR" "$SETUP_MODE"
  bash "$SCRIPTS_DIR/brew.sh" "$ROOT_DIR" "$SETUP_MODE"
  bash "$SCRIPTS_DIR/cask.sh" "$ROOT_DIR" "$SETUP_MODE"
  bash "$SCRIPTS_DIR/fish.sh" "$ROOT_DIR" "$SETUP_MODE"
  bash "$SCRIPTS_DIR/node.sh" "$ROOT_DIR" "$SETUP_MODE"
  bash "$SCRIPTS_DIR/mac.sh" "$ROOT_DIR" "$SETUP_MODE"
  bash "$SCRIPTS_DIR/mas.sh" "$ROOT_DIR" "$SETUP_MODE"
fi

log_start "Reloading fish"
fish
