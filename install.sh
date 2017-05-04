#!/bin/bash
ln -nfs $PWD/vim/vimrc ~/.vimrc
ln -nfs $PWD/otherfiles/cowzen.py ~/cowzen.py
ln -nfs $PWD/zsh/env.sh ~/.env.sh
ln -nfs $PWD/zsh/zshrc ~/.zshrc
./homebrew/install.sh
