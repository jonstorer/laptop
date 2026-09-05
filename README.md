Laptop
======

Laptop is a script to set up a laptop for web development.

It can be run multiple times on the same machine safely.
It installs, upgrades, or skips packages
based on what is already installed on the machine.

Requirements
------------

Support For:

* macOS (Apple Silicon) — `mac-agentic`
* macOS (Apple Silicon or Intel x86_64) — `mac-bluebubbles`
* macOS (Apple Silicon) — `mac-headless`
* macOS (Intel x86_64) — `mac-x86_64`
* Ubuntu 26.04 LTS (amd64) — `ubuntu`
* Ubuntu (via WSL2 on Windows) — `ubuntu-wsl`
* Raspberry Pi (Ubuntu-based)
* Debian 12+ (aarch64/amd64) — `debian-jumpbox`
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

#### Mac — BlueBubbles iMessage Bridge (Apple Silicon or Intel x86_64)

Sets up a Mac as an iMessage bridge via BlueBubbles, which exposes Messages.app via a web API for other machines to connect to over Tailscale.

```sh
curl -H "Cache-Control: no-cache" -fsS 'https://raw.githubusercontent.com/jonstorer/laptop/main/mac-bluebubbles' | sh
```

#### Mac — Headless Devbox (Apple Silicon)

Sets up a MacBook Pro to run lid-closed, screen-off, as a Claude Code automation box: MCP-connected agent work (e.g. Jira cleanup) now, general dev work later. Reachable via SSH, Screen Sharing, and Tailscale.

```sh
curl -H "Cache-Control: no-cache" -fsS 'https://raw.githubusercontent.com/jonstorer/laptop/main/mac-headless' | sh
```

#### Mac — Intel (x86_64)

```sh
curl -H "Cache-Control: no-cache" -fsS 'https://raw.githubusercontent.com/jonstorer/laptop/main/mac-x86_64' | sh
```

#### Ubuntu

Headless Ubuntu 26.04 LTS dev box, no desktop. Two jobs: a dev environment reached over SSH (vim + Claude
Code CLI) and a GitHub Actions self-hosted runner that deploys to another machine over Tailscale.

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

#### Debian Jumpbox

Headless Tailscale relay VM (ProxyJump target only, no other workloads), reachable by Tailscale IP or by
`<hostname>.local` on the LAN. Run as root on a fresh minimal install. Run this in a real terminal, not in
the background — it walks you through Tailscale login interactively. See "What it sets up" below for
details.

```sh
curl -H "Cache-Control: no-cache" -fsS 'https://raw.githubusercontent.com/jonstorer/laptop/main/debian-jumpbox' | sh
```

#### Windows (two steps required)

**Step 1 – Windows setup** (run PowerShell as Administrator):

```ps1
Invoke-RestMethod -Uri https://raw.githubusercontent.com/jonstorer/laptop/main/windows | Invoke-Expression
```

This installs WSL2, Ubuntu, Chocolatey, and Windows apps. Reboot if prompted.

**Step 2 – Ubuntu setup** (from inside WSL, e.g. run `wsl` or open Windows Terminal):

```sh
LAPTOP_SKIP_DOCKER=1 curl -H "Cache-Control: no-cache" -fsS 'https://raw.githubusercontent.com/jonstorer/laptop/main/ubuntu-wsl' | sh
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

**Casks:** alfred, docker-desktop, google-chrome, iterm2, postman, rectangle, slack, spotify, textmate, karabiner-elements, ngrok, claude, claude-code, visual-studio-code

**CLI tools:** gnupg, openssl, shellcheck, gcc, git, htop, watch, the_silver_searcher, ripgrep, tmux, vim, zsh, tmate, grep, jq, forego, nodenv

**Node.js:** nodenv installs the latest LTS (even-numbered major version) and sets it as the global default.

**AI tools:** Claude Code installed via the official Homebrew cask. VS Code extension `anthropic.claude-code` installed automatically.

Sets zsh as the default shell and applies macOS defaults (including disabling Time Machine new-disk prompts).

#### Mac — OpenClaw iMessage Bridge (Apple Silicon or Intel x86_64)

Uses [Homebrew](http://brew.sh/) for package management. Works on both Apple Silicon and Intel x86_64 (including the 2013 Mac Pro).

**Casks:** alfred, bluebubbles, google-chrome, iterm2, rectangle

**CLI tools:** jq, yq, curl, wget, tailscale, tmux

**SSH:** Remote Login enabled for remote access.

**Screen Sharing:** enabled for remote desktop.

**Tailscale:** installed and daemon started; run `sudo tailscale up` to authenticate.

**BlueBubbles keep-alive:** a LaunchAgent (`poke-messages`) pokes Messages.app every 5 minutes to keep it responsive for BlueBubbles.

Sets zsh as the default shell and applies macOS defaults optimized for autonomous/headless operation.

Writes a `TODO.md` to the working directory with live status checks for each manual step.

#### Mac — Headless Devbox (Apple Silicon)

Uses [Homebrew](http://brew.sh/) for package management. Apple Silicon only.

**Casks:** claude-code, google-chrome, alfred, iterm2, rectangle, textmate

**CLI tools:** curl, forego, git, gnupg, openssl, shellcheck, jq, yq, htop, the_silver_searcher, tmate, tmux, vim, wget, zsh, gh, mise, tailscale

**Node.js:** [mise](https://mise.jdx.dev) sets a global LTS default; per-repo pinned versions (`mise.toml`/`.nvmrc`) take over automatically when you `cd` in.

**SSH:** attempts to enable Remote Login via `systemsetup`; macOS requires Full Disk Access for the terminal running the script to actually allow this, so it's also a live-checked manual step in `TODO.md` if it doesn't take.

**Screen Sharing:** enabled for remote desktop — the fallback for interactive steps (browser OAuth for Claude/MCP login, or just working on the box directly with Alfred/iTerm2/Rectangle/TextMate) since the box has no physical display.

**Tailscale:** installed and daemon started; run `sudo tailscale up` to authenticate.

**Power management:** `pmset` tuned for unattended operation — `disablesleep` keeps the system awake independent of the display (which stays off with the lid closed), plus wake-on-network-access and auto-restart-after-power-failure.

Sets zsh as the default shell and applies the automation-friendly subset of macOS defaults (no confirmation dialogs, no iCloud doc sync).

Writes a `TODO.md` to `$HOME` with live status checks for each manual step (Claude auth, Atlassian MCP, Tailscale auth, git identity, gh auth).

#### Mac — Intel (x86_64)

Uses [Homebrew](http://brew.sh/) for package management. Intel x86_64 only.

**Casks:** alfred, docker-desktop, google-chrome, iterm2, kap, postman, rectangle, slack, spotify, macdown, textmate, karabiner-elements, ngrok, qlstephen

**CLI tools:** gnupg, openssl, shellcheck, gcc, git, htop, watch, the_silver_searcher, tmux, vim, zsh, tmate, grep, jq, forego, mise

**Node.js:** [mise](https://mise.jdx.dev) sets a global LTS default; per-repo pinned versions (`mise.toml`/`.nvmrc`) take over automatically when you `cd` in.

Sets zsh as the default shell and applies macOS defaults.

#### Ubuntu

Headless Ubuntu 26.04 LTS dev box, no desktop session (boots to `multi-user.target`). Two jobs: a dev
environment reached over SSH, and a GitHub Actions self-hosted runner that deploys to another machine over
Tailscale (runner install itself is a manual step — see below).

**Packages:** build-essential, ca-certificates, curl, git, gnupg, htop, jq, pipx, python3-pip, ripgrep, tmux, trash-cli, vim, wget, yq, zsh (apt)

**GitHub CLI:** via official apt repository

**Node.js:** [mise](https://mise.jdx.dev) re-resolves to the latest LTS on every run and sets it as the global default

**Claude Code CLI:** installed via official apt repository; authenticate with `claude` after install

**Browser:** Google Chrome stable (via Google's official apt repository) — headless browser automation for Claude Code

**Docker:** Docker CE (cli, containerd, buildx, compose) via Docker's official apt repository; the service is enabled and the current user is added to the `docker` group — log out and back in (or `newgrp docker`) before running `docker` without sudo

**Tailscale:** installed and enabled; run `sudo tailscale up` to authenticate

**SSH:** openssh-server enabled and started; generates `~/.ssh/id_ed25519` if not present

**Shell:** zsh

Sets `systemd-timesyncd` running and the default boot target to `multi-user.target`.

Manual steps printed at the end: git identity, `gh auth login`, `claude` auth, `tailscale up`, and setting up the GitHub Actions self-hosted runner.

#### Ubuntu (WSL2)

General-purpose Ubuntu dev environment for WSL2 on Windows. Installs Docker (CE, compose, buildx) and common development tools: build-essential, gcc, zsh, universal-ctags, git, htop, gh, jq, gnupg, libssl-dev, openssl, openssh-server, silversearcher-ag, shellcheck, tmate, tmux, vim, watch. [mise](https://mise.jdx.dev) with Node.js LTS. Sets zsh as the default shell. Use `LAPTOP_SKIP_DOCKER=1` when Docker Desktop already provides Docker to the WSL guest.

#### Raspberry Pi

Same as Ubuntu (WSL2) plus **headless setup**: enables and starts the SSH service and configures iptables rules for port 22 (persisted via netfilter-persistent) so you can access the Pi remotely.

#### Debian Jumpbox

Headless Debian relay box: `ssh`, `tailscaled`, and `avahi-daemon` as systemd services, no login session
required.

**Packages:** openssh-server, avahi-daemon, ca-certificates, curl, gnupg, sudo (apt). Tailscale via its
official install script (`tailscale.com/install.sh`), skipped if already installed. No desktop packages.

**Services:** `ssh`, `tailscaled`, and `avahi-daemon` enabled and started via `systemctl enable --now`.

**mDNS:** Avahi is configured with `host-name` matching `/etc/hostname`, so the box is reachable at
`<hostname>.local` from the Mac with no extra config there (Bonjour resolves it automatically) — same as
the macOS VM this replaces.

**User:** creates `LAPTOP_SSH_USER` (default `jumpbox`) with `useradd -m` if it doesn't exist yet, adds it
to the `sudo` group, and drops a NOPASSWD sudoers.d entry for that group (validated with `visudo -cf`
before being trusted) since the account has no password.

**SSH keys:** creates `~<user>/.ssh/authorized_keys` (mode 600) if it doesn't exist, seeded with
jonathon's public key; an existing file is never overwritten.

**SSH hardening:** disables password auth (pubkey only, no root login) unconditionally via a drop-in at
`/etc/ssh/sshd_config.d/99-jumpbox.conf`.

**Tailscale:** installed and enabled. If not already authenticated, the script runs `tailscale up`
interactively — Tailscale has no username/password login, so this prints a URL for browser-based SSO and
waits for you to complete it there. Once authenticated, it prints the Tailscale IP plus a ready-to-paste
`~/.ssh/config` block for use as a `ProxyJump` target.

#### Windows (two steps)

**Step 1** sets up [WSL2](https://learn.microsoft.com/en-us/windows/wsl/) with Ubuntu, [Chocolatey](https://chocolatey.org/), and Windows apps: git, vscode, docker-desktop, googlechrome, slack, powershell. **Requires Administrator**; reboot if prompted.

**Step 2** runs the `ubuntu-wsl` script inside WSL (see Install section above). Use `LAPTOP_SKIP_DOCKER=1` — Docker Desktop provides Docker to WSL. After both steps you get a general dev environment (mise, Node.js LTS, zsh, tmux, etc.).

Run log
-------

Every install script appends one line to `~/.laptop/runs.log` each time it runs,
so you can see which script ran on which box, when, and whether it worked —
without having to remember. Each line is tab-separated:

```
<timestamp>	<script>	<hostname>	<commit>	<outcome>	<duration>	exit=<code>
```

For example:

```
2026-06-04T11:42:07-0700	ubuntu	devbox	38149cd1f0a2	ok	214s	exit=0
2026-06-02T09:15:33-0700	mac-agentic	Jonathons-MBP	5a6c09ebc7d1	fail	   8s	exit=1
```

- **commit** is the `main` HEAD short SHA fetched from GitHub at run time (the
  version the piped script came from); `unknown` when offline.
- **outcome** is `ok` / `fail` (`reboot` on Windows when WSL needs a restart).
- **duration** is wall-clock seconds for the run.

The Windows script writes the same format to `%USERPROFILE%\.laptop\runs.log`.

View the most recent runs with:

```sh
column -t -s "$(printf '\t')" ~/.laptop/runs.log | tail
```

Contributing
------------

Edit the relevant script file and document changes in `README.md`.
Follow shell style guidelines using [ShellCheck].

```sh
brew install shellcheck
```

[ShellCheck]: http://www.shellcheck.net/about.html
