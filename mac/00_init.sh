#!/bin/sh

sudo -v                                                                         # Ask for sudo upfront so we don't have to get it later
while true; do sudo -n true; sleep 10; kill -0 "$$" || exit; done 2>/dev/null & # Keep using sudo so the permissions don't time out
# shellcheck disable=SC2154
trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT       # Catch, print, exit
set -e                                                                          # fail fast

if [[ "$(uname -m)" != "x86_64" ]]; then
  # Check if Rosetta is installed
  checkRosettaStatus=$(/bin/launchctl list | /usr/bin/grep "com.apple.oahd-root-helper")
  if [[ -e "/Library/Apple/usr/share/rosetta" && "${checkRosettaStatus}" != "" ]]; then
    echo "Rosetta Folder exists and Rosetta Service is running."
  else
    echo "Rosetta Folder does not exist or Rosetta service is not running. Installing Rosetta..."
    sudo softwareupdate --install-rosetta --agree-to-license
  fi
fi
