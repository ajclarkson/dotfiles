#!/usr/bin/env sh

# get current location
ROOT_DIR=$1
CONFIG_DIR="$ROOT_DIR/config"
SCRIPTS_DIR="$ROOT_DIR/scripts"
SETUP_MODE=$2

source "$ROOT_DIR/commands/__util.sh"

########################
# oh-my-zsh
########################

# log_section_start "Installing oh-my-zsh"
# if [ -d ~/.oh-my-zsh/ ]; then
#   echo "Cleaning up ~/.oh-my-zsh/"
#   rm -rf ~/.oh-my-zsh/
# fi
# RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# FROM_DIR="$CONFIG_DIR/oh-my-zsh"
# TARGET_DIR=~/.oh-my-zsh/custom/
# symlink_files "$FROM_DIR/*" "$TARGET_DIR"
# rm ~/.zshrc

########################
# root config files (.gitconfig, .npmrc, ...)
########################

FROM_FILES="$CONFIG_DIR/home/.*"
TARGET_DIR=~
log_section_start "Sym linking files from $FROM_FILES to $TARGET_DIR"

symlink_files "$FROM_FILES" "$TARGET_DIR"


########################
# run other config scripts
########################

# bash "$SCRIPTS_DIR/brew.sh" "$ROOT_DIR" "$SETUP_MODE"
bash "$SCRIPTS_DIR/cask.sh" "$ROOT_DIR" "$SETUP_MODE"
# bash "$SCRIPTS_DIR/node.sh" "$ROOT_DIR" "$SETUP_MODE"

log_section_start "Reloading zshrc"
zsh