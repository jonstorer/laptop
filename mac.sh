#!/bin/sh

# Welcome to the laptop script!
# Be prepared to turn your laptop (or desktop, no haters here)
# into an awesome development machine.

# Ask for sudo upfront so we don't have to get it later
sudo -v

# Keep using sudo so the permissions don't time out
while true; do sudo -n true; sleep 10; kill -0 "$$" || exit; done 2>/dev/null &

# Catch, print, exit
# shellcheck disable=SC2154
trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

# fail fast
set -e

dotFilesPath="$HOME/.dotfiles";

if [ ! -d $dotFilesPath ]; then
  #git clone git@github.com:jonstorer/laptop.git $dotFilesPath;
  git clone git@github.com:jonstorer/dotfiles.git $dotFilesPath;
  action="install";
else
  cd $dotFilesPath && git pull && cd -p;
  action="update";
fi

#git checkout js/change-strategy

cd $dotFilesPath && make && make $action
