#!/bin/sh

sudo -v                                                                         # Ask for sudo upfront so we don't have to get it later
while true; do sudo -n true; sleep 10; kill -0 "$$" || exit; done 2>/dev/null & # Keep using sudo so the permissions don't time out
# shellcheck disable=SC2154
trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT       # Catch, print, exit
set -e                                                                          # fail fast

fancy_echo() {
  printf "\n$1\n";
}

if [[ "$(uname -m)" == "x86_64" ]]; then
  HOMEBREW_PREFIX="/usr/local"
else
  HOMEBREW_PREFIX="/opt/homebrew"
fi

if [[ "$(command -v zsh)" != "$HOMEBREW_PREFIX/bin/zsh" ]]; then
  shell_path="$(command -v zsh)"

  if ! grep "$shell_path" /etc/shells > /dev/null 2>&1 ; then
    fancy_echo "Adding '$shell_path' to /etc/shells"
    sudo sh -c "echo $shell_path >> /etc/shells"
  fi

  fancy_echo "Changing your shell to zsh ..."
  sudo chsh -s "$shell_path" "$USER"
fi
