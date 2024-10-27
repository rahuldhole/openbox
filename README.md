# Openbox

To setup a minimal virtual remote desktop environment Openbox+XRDP+Kitty+Diodon and Tailscale for private remote access.

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/new#https://github.com/rahuldhole/openbox)

[![Open in Codespaces](https://github.com/codespaces/badge.svg)](https://github.com/codespaces/new?hide_repo_select=true&ref=main&repo=rahuldhole/openbox)

<a href="https://devspaces.apps.sandbox-m3.1530.p1.openshiftapps.com/#https://github.com/rahuldhole/openbox">
    <img src="https://www.svgrepo.com/show/354143/openshift.svg" alt="Open in OpenShift" width="25px"/> Open in OpenShift (NOt working well)
</a>

<br>

- Github codespaces free tier is 60 Hours per month on 2 Cores (means 120 cpu hrs)
- Gitpod give 50 hours per month.
- So in total you may get 60+50 = 110 Hours per month on and powerful remote desktop
- If you work 7 Hours a day on average then 110/7 = 15.71 working days will be perfect for a month on free tier.

## Installation
```json
// .devcontainer/devcontainer.json
{
  "name": "Openbox",
  "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
  "runArgs": [
    "--device=/dev/net/tun",// needed to tailscale
    "--shm-size=2g" // needed for browsers
  ],
  "features": {
    "ghcr.io/tailscale/codespace/tailscale:latest": {},
    "ghcr.io/rahuldhole/openbox/xrdp:latest": {},
    "ghcr.io/rahuldhole/openbox/google-chrome:latest": {},
    "ghcr.io/rahuldhole/openbox/microsoft-edge:latest": {},
    "ghcr.io/rahuldhole/openbox/vscode:latest": {}
  },
  "postCreateCommand": "/bin/bash -c 'echo \"vscode:vscode\" | sudo chpasswd'",
  "postStartCommand": "/usr/local/sbin/xrdp-entrypoint",
  "remoteUser": "vscode"
}
```

## Steps to connect RDP

After successfully started the Codespaces/Gitpod, wait for entrypoint script to run.

0. Check status
```sh
sudo service xrdp status
#sudo service xrdp restart

sudo tailscale status
```

1. login and connect to tailscale
```sh
# sudo tailscaled # this is only for Gitpod, when the `tailscaled` service is not started

sudo tailscale up
```

2. Open RDP client and type tailscaled VPN IP of the codespaces or gitpod
- RDP User for Codespaces `vscode:vscode`
- RDP User for Gitpod `gitpod:gitpod`

3. Right click on blue screen for more options

# Openbox Shortcuts
- `Alt+t` to switch between windows in the current workspace like `Alt+TAB`
- `Alt+d` Show or hide desktop
- `Alt+<Left Right Arrow>` to switch between the adjecent workspaces.
- `Alt+Shift+<Left Right Arrow>` to move current window to the adjecent workspaces.
- `Alt+<Number>` to jump over the nth workspace. **Note**: Don't use numpad numbers.

# Applications Shortcuts
- `Alt+Ctrl+k` open Kitty terminal `kitty`
- `Alt+Ctrl+g` open Google Chrome browser `google-chrome --no-sandbox`
- `Alt+Ctrl+e` open Edge browser `microsoft-edge --no-sandbox`
- `Alt+Ctrl+v` open VS Code `code --no-sandbox .`
- `Alt+v`      open Didon clipboard manager `diodon`
**Note** Customise the shortcuts `~/.config/openbox/rc.xml`


# WARNINGS
1. Do not open codespaces repository inside RDP!!! It may triggers some kind of network traffic recursion as a result system will hang no matter if you use all 32 cores.
2. Ideally 2 cores is more than sufficient for most of the development work.

# Troubleshoot
1. In Gitpod, if tailscaled is not started then follow:
    - `sudo tailscaled`
    - `sudo -E tailscale up --hostname "gitpod-${GITPOD_GIT_USER_NAME// /-}-$(echo ${GITPOD_WORKSPACE_CONTEXT} | jq -r .repository.name)"`
