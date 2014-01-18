#!/bin/bash

files=(.vimrc .vimrc.bundle .vimrc.plugins_settings .tmux.conf)

for file in ${files[@]}
do
   if [ ! -e $HOME/$file ]; then
     ln -s $HOME/dotfiles/$file $HOME/$file
     echo "crate $file"
   fi
done

# install neobundle
if [ ! -d $HOME/.vim/bundle/neobundle.vim ]; then
    echo 'get neobundle'
    mkdir -p $HOME/.vim/bundle
    git clone https://github.com/Shougo/neobundle.vim.git $HOME/.vim/bundle/neobundle.vim
fi


# oh-my-zshの設定
rm -rf $HOME/.oh-my-zsh/custom
ln -s $HOME/dotfiles/oh-my-zsh $HOME/.oh-my-zsh/custom

# plugins
if [ ! -d $HOME/dotfiles/oh-my-zsh/plugins ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/dotfiles/oh-my-zsh/plugins/zsh-syntax-highlighting
  git clone https://github.com/tarruda/zsh-autosuggestions $HOME/dotfiles/oh-my-zsh/plugins/zsh-autosuggestions
fi
