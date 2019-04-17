# My dotfiles

You should not use this repo as is, but well, here are the steps necessary to install these
dotfiles:

### Install rcm

I am using rcm for dotfile management. See https://github.com/thoughtbot/rcm for details.

### Clone the repo and update submodules

```
git clone git@github.com:mattiasgiese/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
git submodule update
```

### Deploy config files

```
rcup -v
```

### Install vim/neovim plugins

```
nvim +PlugUpdate
```

### Update .dircolors

```
wget https://raw.github.com/trapd00r/LS_COLORS/master/LS_COLORS -O $HOME/.dircolors
```
