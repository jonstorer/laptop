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

  git config --global core.compression 0
  git config --global http.postBuffer 1048576000
fi

sudo mkdir -p "$HOMEBREW_PREFIX"
sudo chflags norestricted "$HOMEBREW_PREFIX"
sudo chown -R "$LOGNAME:admin" "$HOMEBREW_PREFIX"

if ! command -v brew > /dev/null 2>&1; then
  fancy_echo "Installing Homebrew ..."
   NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL 'https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh')"

  #append_to_zshrc "eval \"\$($HOMEBREW_PREFIX/bin/brew shellenv)\""
  eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
fi

if brew list | grep -Fq brew-cask; then
  fancy_echo "Uninstalling old Homebrew-Cask ..."
  brew uninstall --force brew-cask
fi

fancy_echo "Updating Homebrew formulae ..."
brew update --force
