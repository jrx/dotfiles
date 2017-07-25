# dotfiles

## Installation


clone this repo to your home directory

```
cd ~
git clone git@github.com:jrx/dotfiles.git
```

make symlinks

```
ln -s ~/dotfiles/vimrc .vimrc
ln -s ~/dotfiles/zshrc .zshrc
```


## MacVim

```
brew install macvim --override-system-vim
```

## Tool: Pathogen

```
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
```

## Plugin: Lightline

```
git clone https://github.com/itchyny/lightline.vim ~/.vim/bundle/lightline.vim
```

## Plugin: NERDTree

```
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
```

## Other Tools

```
brew install htop
brew install ncdu
```

