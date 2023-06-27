# dotfiles

These dotfiles are an ongoing configuration of my machine setups. It holds configuration for regularly used tools such as Fish and NeoVim, but it also contains setup scripts to install all of my commonly used tools and applications.

As the repository is used across several machines it has support for installing on Mac (intel + arm) and Debian to meet my needs.

## Usage


### Pre-requisites

You must have a `.env` file at the root of the repository before running the install script. You can find a `.env.sample` which outlines the options.

When running the `appliations` installer on mac, it will use the [`mas`](https://github.com/mas-cli/mas) client to interact with the AppStore. The `mas signin` command does not work on recent versions of OSX, so you must have recently opened the Mac App Store so that the credentials are refreshed in order for this to work. 

**N.B** When I run this on a machine with cloudflare WARP running, some of the tools fail with certificate errors.

## Installing

The `./dotfiles` script at the root of the repository is the entry point to everything. To bootstrap everything:

```bash
~/path/to/repo/dotfiles install
```

The install script has been modularised, so you can also provide a script argument to run one module in isolation.

```bash
~/path/to/repo/dotfiles install [SCRIPT]
```

The `[SCRIPT]` argument can be the name of any script in the `scripts/` directory.

## Configuration

The `.env` file supports the following options for configuring the setup

### SETUP_MODE

`SETUP_MODE=[default,home,work]`

This variable controls applying specific settings for each of my machines. Some scripts (particularly the `utils` and `applications` setup scripts) contain conditional blocks to control which dependencies are installed based on this variable.

## Manual steps

### Applications install script
- logitune is installed by cask, but right now the formula only grabs the installer. The logs will output a command to open it **but this is a manual step which must be completed on the first run**. If it isn't completed, subsequent runs will still display the "logitune is already installed" message, even though it actually isn't.

### Obsidian
- vimrc plugin is required, and needs to be configured with a relative path to look for its `.obsidian.vimrc` under `~/.config/obsidian`

## Credit

Much inspiration taken from the approaches in:
- [stefanjudis](https://github.com/stefanjudis/dotfiles)
- [mihaliak](https://github.com/mihaliak/dotfiles/blob/master/bin/dotfiles)
- [ThePrimeagen NeoVim setup](https://www.youtube.com/watch?v=w7i4amO_zaE)
