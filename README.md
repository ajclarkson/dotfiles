# dotfiles

## Usage

### Pre-requisites

- For the `mas` commands to succeed, you must have recently opened the Mac App Store so that your credentials are refreshed. The `mas signin` command does not work on newer versions of OSX :(
- **N.B** (For my own situation) If running this on cloudflare WARP some of the tools fail with certificate errors.

The `./dotfiles` script at the root of the install is the binary entry point to everything. To quickly get up and running:

```bash
~/path/to/dotfiles/dotfiles install
```
This binary supports loading an `.env` file to customise some behaviours, listed below

### Setup Mode

`SETUP_MODE=[default,home,work]`

The `SETUP_MODE` variable allows control over different environments for different machines. Default will run anything that doesn't have a specific environment attached. At the moment I also have `home` and `work` setups to prevent installing dependencies and applications on machines where they aren't needed. 

If no `SETUP_MODE` variable is found in the `.env` file, then it will revert to `default`.


## What's included?

- oh-my-zsh, plugins, prompt customisation
- brew setup and utility installation
- casks for commonly used applications
- nvm installation and default node setup
- global mac configuration setups for consistency across machines

## Manual steps

- iterm2 is installed by cask, however the profile is not automatically configured and should be done manually. For convenience, the profile json is saved in the `~/.oh-my-zsh/custom/iterm-profile-config.json` location after `install` is run.
- logitune is installed by cask, but right now the formula only grabs the installer. The logs will output a command to open it **but this is a manual step which must be completed on the first run**. If it isn't completed, subsequent runs will still display the "logitune is already installed" message, even though it actually isn't.

## Credit

Much inspiration taken from the approaches in:
- (stefanjudis)[https://github.com/stefanjudis/dotfiles]
- (mihaliak)[https://github.com/mihaliak/dotfiles/blob/master/bin/dotfiles]