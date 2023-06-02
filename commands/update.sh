#!/usr/bin/env sh

ROOT_DIR=$1
sudo softwareupdate -i -a
nvm install --lts --latest-npm # install last lts node instance
brew update
brew upgrade
echo -e "${GREEN}$ARROW Success! Update command finished.${NC}"