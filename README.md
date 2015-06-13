# ajclarkson dotfiles

## dotfiles

These are my dotfiles. There are many like them, but these ones are mine.

It was high time my dotfiles got properly organised, and when making the leap to `zsh` as my shell I thought I'd take advantage of the opportunity to set up a new structure. I went for the topic centric approach used by [holman](https://github.com/holman/dotfiles) - and I almost just forked that repo and got on with it. I think there's a good chance mine will divert at some point though so decided to roll my own heavily inspired by those.

## installing

```git clone https://github.com/ajclarkson/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap```

This symlinks anything named `*.symlink` into your home directory and makes the magic happen.