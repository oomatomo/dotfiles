#!/bin/bash

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

if [ ! -e $HOME/.local/share/nvim/site/autoload/plug.vim ]; then
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi


if [ ! -d $HOME/.oh-my-zsh ]; then
    echo 'install oh-my-zsh'
    curl -L https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
fi

# oh-my-zshの設定
rm -rf $HOME/.oh-my-zsh/custom
ln -s $HOME/git/dotfiles/oh-my-zsh $HOME/.oh-my-zsh/custom

# plugins
if [ ! -d $HOME/git/dotfiles/oh-my-zsh/plugins ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/git/dotfiles/oh-my-zsh/plugins/zsh-syntax-highlighting
  git clone https://github.com/tarruda/zsh-autosuggestions $HOME/git/dotfiles/oh-my-zsh/plugins/zsh-autosuggestions
fi
