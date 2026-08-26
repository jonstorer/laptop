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
* macOS (Apple Silicon or Intel x86_64) — `mac-openclaw`
* macOS (Apple Silicon) — `mac-headless`
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

#### Mac — OpenClaw iMessage Bridge (Apple Silicon or Intel x86_64)

Sets up a Mac as an iMessage bridge for a ubuntu-openclaw installation. BlueBubbles exposes Messages.app via web API; ubuntu-openclaw connects via the `@openclaw/imessage` plugin over Tailscale.

```sh
curl -H "Cache-Control: no-cache" -fsS 'https://raw.githubusercontent.com/jonstorer/laptop/main/mac-openclaw' | sh
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

**Node.js:** [mise](https://mise.jdx.dev) sets a global LTS default; per-repo pinned versions (e.g. mono-node's `mise.toml`/`.nvmrc`) take over automatically when you `cd` in.

**SSH:** Remote Login enabled for remote access.

**Screen Sharing:** enabled for remote desktop — the fallback for interactive steps (browser OAuth for Claude/MCP login, or just working on the box directly with Alfred/iTerm2/Rectangle/TextMate) since the box has no physical display.

**Tailscale:** installed and daemon started; run `sudo tailscale up` to authenticate.

**Power management:** `pmset` tuned for unattended operation — `disablesleep` keeps the system awake independent of the display (which stays off with the lid closed), plus wake-on-network-access and auto-restart-after-power-failure. No third-party keep-awake app needed.

Sets zsh as the default shell and applies the automation-friendly subset of macOS defaults (no confirmation dialogs, no iCloud doc sync, no Time Machine new-disk prompts).

Writes a `TODO.md` to `$HOME` with live status checks for each manual step (Claude auth, Atlassian MCP, Tailscale auth, git identity, gh auth).

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

**Remote access:** SSH (password auth, key-based configured manually), RDP via gnome-remote-desktop (port 3389), Tailscale

**Claude CLI:** installed via official apt repository; authenticate with `claude` after install

**OpenClaw:** installed via official installer; wire to Claude CLI with `openclaw models auth login --provider anthropic --method cli --set-default`, then run `openclaw onboard --install-daemon`

**Browser:** Google Chrome stable (via Google's official apt repository) — a real browser for OpenClaw's QR-code login and browser automation

**WhatsApp channel:** set up after onboarding by scanning QR code in browser (use RDP if no physical display)

**iMessage channel:** connect to a mac-openclaw iMessage bridge via the `@openclaw/imessage` plugin over Tailscale

**Node.js:** v22 via NodeSource

**Shell:** zsh

**Git snapshots:** user crontab entry commits and pushes `~/.openclaw` every 15 minutes (initialize the repo and add a remote first)

#### Raspberry Pi

Same as Ubuntu plus **headless setup**: enables and starts the SSH service and configures iptables rules for port 22 (persisted via netfilter-persistent) so you can access the Pi remotely.

#### Windows (two steps)

**Step 1** sets up [WSL2](https://learn.microsoft.com/en-us/windows/wsl/) with Ubuntu, [Chocolatey](https://chocolatey.org/), and Windows apps: git, vscode, docker-desktop, googlechrome, slack, powershell. **Requires Administrator**; reboot if prompted.

**Step 2** runs the Ubuntu script inside WSL (see Install section above). Use `LAPTOP_SKIP_DOCKER=1` — Docker Desktop provides Docker to WSL. After both steps you get the same environment as Mac/Ubuntu (asdf, Node.js LTS, zsh, tmux, etc.).

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
2026-06-04T11:42:07-0700	ubuntu-openclaw	openclaw-box	38149cd1f0a2	ok	214s	exit=0
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
