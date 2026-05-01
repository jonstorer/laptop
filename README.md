Laptop
======

Laptop is a script to set up a laptop for web development.

It can be run multiple times on the same machine safely.
It installs, upgrades, or skips packages
based on what is already installed on the machine.

Requirements
------------

Support For:

* macOS (Apple Silicon) — `mac-agentic`, `mac-openclaw`
* macOS (Intel x86_64) — `mac-x86_64`
* Ubuntu 20.04+ — `ubuntu`
* Ubuntu 26.04 LTS Desktop (amd64) — `ubuntu-openclaw`
* Raspberry Pi (Ubuntu-based)
* Windows 11

Older versions may work but aren't regularly tested.
Bug reports for older versions are welcome.

Install
-------

Download, review, then execute the script:

#### Mac — Agentic Dev (Apple Silicon)

Human dev machine with AI workflows: Claude, Ollama, VS Code, Claude Code.

```sh
curl -H "Cache-Control: no-cache" -fsS 'https://raw.githubusercontent.com/jonstorer/laptop/main/mac-agentic' | sh
```

#### Mac — OpenClaw Agent (Apple Silicon)

Sets up a Mac to run [OpenClaw](https://openclaw.ai) as a persistent autonomous agent. After the script completes, run `openclaw onboard --install-daemon`.

```sh
curl -H "Cache-Control: no-cache" -fsS 'https://raw.githubusercontent.com/jonstorer/laptop/main/mac-openclaw' | sh
```

#### Mac — Intel (x86_64)

```sh
curl -H "Cache-Control: no-cache" -fsS 'https://raw.githubusercontent.com/jonstorer/laptop/main/mac-x86_64' | sh
```

#### Ubuntu

```sh
curl -H "Cache-Control: no-cache" -fsS 'https://raw.githubusercontent.com/jonstorer/laptop/main/ubuntu' | sh
```
or
```sh
wget --no-cache -qO- 'https://raw.githubusercontent.com/jonstorer/laptop/main/ubuntu' | sh
```

#### Ubuntu — OpenClaw Agent

Sets up Ubuntu 26.04 LTS Desktop as a complete standalone OpenClaw installation — gateway, Claude CLI backend, and WhatsApp channel. No Mac required.

```sh
wget --no-cache -qO- 'https://raw.githubusercontent.com/jonstorer/laptop/main/ubuntu-openclaw' | sh
```
or
```sh
curl -H "Cache-Control: no-cache" -fsS 'https://raw.githubusercontent.com/jonstorer/laptop/main/ubuntu-openclaw' | sh
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

If a script fails, copy the lines where it failed into a
[new GitHub Issue](https://github.com/jonstorer/laptop/issues/new).

What it sets up
---------------

#### Mac — Agentic Dev (Apple Silicon)

Uses [Homebrew](http://brew.sh/) for package management. Apple Silicon only.

**Casks:** alfred, docker-desktop, google-chrome, iterm2, kap, postman, rectangle, slack, spotify, macdown, textmate, karabiner-elements, ngrok, qlstephen, claude, ollama, visual-studio-code

**CLI tools:** gnupg, openssl, shellcheck, gcc, git, htop, watch, the_silver_searcher, tmux, vim, zsh, tmate, grep, jq, forego, asdf

**Node.js:** asdf with asdf-nodejs plugin; installs current LTS and sets as global default.

**AI tools:** Claude Code (`@anthropic-ai/claude-code`) installed globally via npm. VS Code extension `anthropic.claude-code` installed automatically.

Sets zsh as the default shell and applies macOS defaults.

#### Mac — OpenClaw Agent (Apple Silicon)

Uses [Homebrew](http://brew.sh/) for package management. Apple Silicon only.

**Casks:** alfred, bluebubbles, google-chrome, iterm2, rectangle, slack, textmate

**CLI tools:** node@22, gogcli, jq, yq, curl, wget, nmap, netcat, tailscale, ripgrep, fzf, gh, libpq, python, ffmpeg, imagemagick

**Claude CLI:** installed via npm (`@anthropic-ai/claude-code`) — the native binary requires AVX2 which the 2013 Mac Pro Xeon doesn't support. Authenticate with `claude` after install.

**OpenClaw:** installed via the official installer. Run `openclaw onboard --install-daemon` to configure.

**SSH:** Remote Login enabled so the machine is accessible over the network.

**Internet Sharing:** WiFi → Ethernet sharing configured via a launchd daemon (`openclaw-ics`). Detects the active Ethernet interface at boot and shares the WiFi connection over the 192.168.2.0/24 subnet.

**BlueBubbles keep-alive:** a LaunchAgent (`poke-messages`) pokes Messages.app every 5 minutes to keep it responsive for BlueBubbles.

Sets zsh as the default shell and applies macOS defaults optimized for autonomous/headless operation.

#### Mac — Intel (x86_64)

Uses [Homebrew](http://brew.sh/) for package management. Intel x86_64 only.

**Casks:** alfred, docker-desktop, google-chrome, iterm2, kap, postman, rectangle, slack, spotify, macdown, textmate, karabiner-elements, ngrok, qlstephen

**CLI tools:** gnupg, openssl, shellcheck, gcc, git, htop, watch, the_silver_searcher, tmux, vim, zsh, tmate, grep, jq, forego, asdf

**Node.js:** asdf with asdf-nodejs plugin; installs current LTS and sets as global default.

Sets zsh as the default shell and applies macOS defaults.

#### Ubuntu

For desktop machines (with display). Installs Docker (CE, compose, buildx) and common development tools: build-essential, gcc, zsh, universal-ctags, git, htop, gh, jq, gnupg, libssl-dev, openssl, openssh-server, silversearcher-ag, shellcheck, tmate, tmux, vim, watch. asdf with Node.js LTS. Sets zsh as the default shell.

#### Ubuntu — OpenClaw Agent

Standalone [OpenClaw](https://openclaw.ai) machine on Ubuntu 26.04 LTS Desktop (amd64). Everything runs here — no Mac involved.

**Remote access:** SSH (password auth, key-based configured manually), VNC via gnome-remote-desktop (port 5900), Tailscale

**Claude CLI:** installed via official apt repository; authenticate with `claude` after install

**OpenClaw:** installed via official installer; wire to Claude CLI with `openclaw models auth login --provider anthropic --method cli --set-default`, then run `openclaw onboard --install-daemon`

**WhatsApp channel:** set up after onboarding by scanning QR code in browser (use VNC if no physical display)

**Node.js:** v22 via NodeSource

**Shell:** zsh

**Git snapshots:** user crontab entry commits and pushes `~/.openclaw` every 15 minutes (initialize the repo and add a remote first)

#### Raspberry Pi

Same as Ubuntu plus **headless setup**: enables and starts the SSH service and configures iptables rules for port 22 (persisted via netfilter-persistent) so you can access the Pi remotely.

#### Windows (two steps)

**Step 1** sets up [WSL2](https://learn.microsoft.com/en-us/windows/wsl/) with Ubuntu, [Chocolatey](https://chocolatey.org/), and Windows apps: git, vscode, docker-desktop, googlechrome, slack, powershell. **Requires Administrator**; reboot if prompted.

**Step 2** runs the Ubuntu script inside WSL (see Install section above). Use `LAPTOP_SKIP_DOCKER=1` — Docker Desktop provides Docker to WSL. After both steps you get the same environment as Mac/Ubuntu (asdf, Node.js LTS, zsh, tmux, etc.).

Contributing
------------

Edit the relevant script file and document changes in `README.md`.
Follow shell style guidelines using [ShellCheck].

```sh
brew install shellcheck
```

[ShellCheck]: http://www.shellcheck.net/about.html
