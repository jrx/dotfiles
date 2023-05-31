# dotfiles

## Installation

clone this repo to your home directory

```bash
cd ~
git clone git@github.com:jrx/dotfiles.git
```

make symlinks

```bash
ln -s ~/dotfiles/vimrc .vimrc
ln -s ~/dotfiles/zshrc .zshrc
ln -s ~/dotfiles/tmux.conf .tmux.conf
```


## MacVim

```bash
brew install macvim --override-system-vim
```

## Tool: Pathogen

```bash
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
```

## Plugin: Lightline

```bash
git clone https://github.com/itchyny/lightline.vim ~/.vim/bundle/lightline.vim
```

## Plugin: NERDTree

```bash
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
```

## Other Tools

```bash
brew install htop
brew install ncdu
```

## Fonts

```bash
brew tap homebrew/cask-fontss
brew install font-fira-code
```
