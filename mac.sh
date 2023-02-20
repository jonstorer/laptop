#!/bin/sh

# Welcome to the laptop script!
# Be prepared to turn your laptop (or desktop, no haters here)
# into an awesome development machine.

dotFilesPath="$HOME/.laptop";

if [ ! -d $dotFilesPath ]; then
  git clone git@github.com:jonstorer/laptop.git $dotFilesPath;
  action="install";
else
  cd $dotFilesPath && git pull;
  action="update";
fi

cd $dotFilesPath && make && $(make $action)
