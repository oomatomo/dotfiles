#!/bin/bash

# brew
brew install git
brew install tmux
brew install zsh
brew install jq
brew install peco
brew install nvm
brew install neovim
brew install reattach-to-user-namespace
brew install wget
brew install mysql
brew install tfenv

# SDKMAN!
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk version

files=(.tmux.conf)

for file in ${files[@]}
do
   if [ ! -e $HOME/$file ]; then
     ln -s $HOME/git/dotfiles/$file $HOME/$file
     echo "crate $file"
   fi
done

# for neovim
if [ ! -e $HOME/.config/nvim/init.vim ]; then
    mkdir -p $HOME/.config/nvim/
    ln -s $HOME/git/dotfiles/nvim/init.vim $HOME/.config/nvim/init.vim
fi

if [ ! -e $HOME/.config/nvim/base.vim ]; then
    mkdir -p $HOME/.config/nvim/
    ln -s $HOME/git/dotfiles/nvim/base.vim $HOME/.config/nvim/base.vim
fi

if [ ! -e $HOME/.config/nvim/plugin.vim ]; then
    mkdir -p $HOME/.config/nvim/
    ln -s $HOME/git/dotfiles/nvim/plugin.vim $HOME/.config/nvim/plugin.vim
fi

if [ ! -e $HOME/.local/share/nvim/site/autoload/plug.vim ]; then
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi


if [ ! -d $HOME/.oh-my-zsh ]; then
    echo 'install oh-my-zsh'
    curl -L https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
fi

# plugins
if [ ! -d $HOME/git/dotfiles/oh-my-zsh/plugins ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/git/dotfiles/oh-my-zsh/plugins/zsh-syntax-highlighting
  git clone https://github.com/tarruda/zsh-autosuggestions $HOME/git/dotfiles/oh-my-zsh/plugins/zsh-autosuggestions
fi

# oh-my-zshの設定
rm -rf $HOME/.oh-my-zsh/custom
ln -s $HOME/git/dotfiles/oh-my-zsh/ $HOME/.oh-my-zsh/custom

# neovim
# PlugInstallを実行
# https://github.com/junegunn/vim-plug

# oh-my-zsh
# zshrcのテーマをoomatomoに変更
# ZSH_THEME="oomatomo"

# tmux
# iterm2でcopy&pasteの許可を行う
# General -> Selection -> Applications interminal may access clipboard

