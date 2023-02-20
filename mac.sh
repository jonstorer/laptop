#!/bin/sh

# Welcome to the laptop script!
# Be prepared to turn your laptop (or desktop, no haters here)
# into an awesome development machine.

dotFilesPath="$HOME/.dotfiles";

if [ ! -d $dotFilesPath ]; then
  #git clone git@github.com:jonstorer/laptop.git $dotFilesPath;
  git clone git@github.com:jonstorer/dotfiles.git $dotFilesPath;
  action="install";
else
  cd $dotFilesPath && git pull && cd -p;
  action="update";
fi

git checkout js/change-strategy

cd $dotFilesPath && make && make $action
