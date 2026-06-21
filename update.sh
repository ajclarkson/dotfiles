#!/usr/bin/env sh
set -e

sudo softwareupdate -i -a
fnm install --lts --latest
brew update
brew upgrade
