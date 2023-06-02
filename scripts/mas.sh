#!/usr/bin/env sh
ROOT_DIR=$1
source "$ROOT_DIR/commands/__util.sh"

log_start "Installing apps from mac app store"

# Adguard for Safari
mas install 1440147259
# 1Password for Safari
mas install 1569813296
# Things
mas install 904280696

log_success "Successfully installed apps from mac app stores"