# dotfiles

## How to get started

```bash
~/path/to/dotfiles/dotfiles install
```

If you provide the command with the `home` option, it will skip installing work dependencies
```bash
~/path/to/dotfiles/dotfiles install home
```

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

Much of my new refreshed approach to my dotfiles has been lifted and adapted directly from (stefanjudis)[https://github.com/stefanjudis/dotfiles]