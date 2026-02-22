Laptop
======

Laptop is a script to set up a laptop for web development.

It can be run multiple times on the same machine safely.
It installs, upgrades, or skips packages
based on what is already installed on the machine.

Requirements
------------

Support For:

* macOs Catalina 10.15
* macOs Big Sur  11
* macOs Monterey 12
* Ubuntu 20.04
* Raspberry Pi (Ubuntu-based)
* Windows 11

Older versions may work but aren't regularly tested.
Bug reports for older versions are welcome.

Install
-------

Download, review, then execute the script:

#### Mac

```sh
curl -H "Cache-Control: no-cache" -fsS 'https://raw.githubusercontent.com/jonstorer/laptop/main/mac' | sh
```
#### Ubuntu

```sh
curl -H "Cache-Control: no-cache" -fsS 'https://raw.githubusercontent.com/jonstorer/laptop/main/ubuntu' | sh
```
or
```sh
wget --no-cache -qO- 'https://raw.githubusercontent.com/jonstorer/laptop/main/ubuntu' | sh
```

#### Raspberry Pi

```sh
curl -H "Cache-Control: no-cache" -fsS 'https://raw.githubusercontent.com/jonstorer/laptop/main/pi' | sh
```

#### Windows (two steps required)

**Step 1 – Windows setup** (run PowerShell as Administrator):

```ps1
Invoke-RestMethod -Uri https://raw.githubusercontent.com/jonstorer/laptop/main/windows | Invoke-Expression
```

This installs WSL2, Ubuntu, Chocolatey, and Windows apps. Reboot if prompted.

**Step 2 – Ubuntu setup** (from inside WSL, e.g. run `wsl` or open Windows Terminal):

```sh
LAPTOP_SKIP_DOCKER=1 curl -H "Cache-Control: no-cache" -fsS 'https://raw.githubusercontent.com/jonstorer/laptop/main/ubuntu' | sh
```

The `LAPTOP_SKIP_DOCKER=1` skips Docker installation (Docker Desktop provides it to WSL).

Debugging
---------

Your last Laptop run will be saved to `~/laptop.log`.
Read through it to see if you can debug the issue yourself.
If not, copy the lines where the script failed into a
[new GitHub Issue](https://github.com/jonstorer/laptop/issues/new) for us.
Or, attach the whole log file as an attachment.

What it sets up
---------------

#### Mac

Uses [Homebrew](http://brew.sh/) for package management. Supports Intel (x86_64) and Apple Silicon (Rosetta installed if needed).

**Casks:** alfred, docker, vagrant, google-chrome, iterm2, licecap, postman, rectangle, slack, spotify, macdown, textmate, karabiner-elements, ngrok, qlstephen

**CLI tools:** gnupg, openssl, shellcheck, reattach-to-user-namespace, gcc, git, htop, watch, the_silver_searcher, tmux, vim, zsh, tmate, grep, jq, forego, asdf

**Node.js:** asdf with asdf-nodejs plugin; installs current LTS and sets as global default. Supports `.nvmrc` and `.node-version` via `legacy_version_file` in `~/.asdfrc`.

Sets zsh as the default shell.

#### Ubuntu

For desktop machines (with display). Installs Docker (CE, compose, buildx) and common development tools: build-essential, gcc, zsh, exuberant-ctags, git, htop, hub, jq, gnupg2, libssl-dev, openssl, openssh-server, silversearcher-ag, shellcheck, tmate, tmux, vim, watch. asdf with Node.js LTS (same as Mac). Sets zsh as the default shell.

#### Raspberry Pi

Same as Ubuntu plus **headless setup**: enables and starts the SSH service and configures iptables rules for port 22 so you can access the Pi remotely.

#### Windows (two steps)

**Step 1** sets up [WSL2](https://learn.microsoft.com/en-us/windows/wsl/) with Ubuntu, [Chocolatey](https://chocolatey.org/), and Windows apps: git, vscode, docker-desktop, googlechrome, slack, powershell. **Requires Administrator**; reboot if prompted.

**Step 2** runs the Ubuntu script inside WSL (see Install section above). Use `LAPTOP_SKIP_DOCKER=1`—Docker Desktop provides Docker to WSL. After both steps you get the same environment as Mac/Ubuntu (asdf, Node.js LTS, zsh, tmux, etc.).

It should take less than 15 minutes to install (depends on your machine).

Contributing
------------

Edit the mac, ubuntu, pi, or windows file as appropriate.
Document in the `README.md` file.
Follow shell style guidelines by using [ShellCheck] and [Syntastic].

```sh
brew install shellcheck
```

[ShellCheck]: http://www.shellcheck.net/about.html
[Syntastic]: https://github.com/scrooloose/syntastic
