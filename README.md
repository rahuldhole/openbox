# Openbox: Minimal Remote Desktop Environment

**Setup a private remote desktop environment** with Openbox, XRDP, Kitty, Diodon, and Tailscale for secure remote access.

[![Open in Codespaces](https://github.com/codespaces/badge.svg)](https://github.com/codespaces/new?hide_repo_select=true&ref=main&repo=rahuldhole/openbox)

**Note:** Gitpod and OpenShift currently use raw scripts. Contributions to update these to packaged solutions are welcome.

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/new#https://github.com/rahuldhole/openbox)

<a href="https://devspaces.apps.sandbox-m3.1530.p1.openshiftapps.com/#https://github.com/rahuldhole/openbox">
    <img src="https://www.svgrepo.com/show/354143/openshift.svg" alt="Open in OpenShift" width="25px"/> Open in OpenShift (Currently not stable)
</a>

---

## Free Remote Desktop Hours

- **GitHub Codespaces:** 60 hours/month (2 cores) = 120 CPU hours
- **Gitpod:** 50 hours/month

**Total:** 110 hours/month (~15.7 working days at 7 hours/day)

---

## Sample installation for customizing your private dev container

```json
{
  "name": "Openbox",
  "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
  "runArgs": [
    "--device=/dev/net/tun", // needed for Tailscale
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

---

## Steps to Connect via RDP

### 1. Verify Status
```sh
sudo service xrdp status
```

### 2.1 Option 1: TCP Connect via Tailscale VPN

```sh
sudo tailscale status
sudo tailscale up
```

### 2.2 Option 2: TCP Connect via SSH tunnels

If you prefer not to use Tailscale, you can tunnel XRDP traffic via Serveo.net.

Add `sshd` server feature

```sh
"features": {
  "ghcr.io/devcontainers/features/sshd:1.0.10": {}
}
// this starts ssh server at port 2222
```

On the container/machine run:

`ssh -R myalias:22:localhost:2222 serveo.net`

Then, from your local machine:

`ssh -L 8888:localhost:3389 -J serveo.net vscode@myalias`

Now connect your RDP client to `localhost:8888`

Read more: [https://serveo.net/](https://serveo.net/)



### 3. Connect Using RDP Client

- Use the Tailscale VPN IP of the Codespaces or Gitpod instance.
- **RDP User Credentials:**
  - Codespaces: `vscode:vscode`
  - Gitpod: `gitpod:gitpod`

### 4. Openbox Navigation

- Right-click on the blue screen to access more options.

---

## Openbox Shortcuts

| Shortcut                      | Action                                      |
|-------------------------------|---------------------------------------------|
| `Alt + T`                     | Switch between windows in the current workspace |
| `Alt + D`                     | Show or hide the desktop                   |
| `Alt + <Left/Right Arrow>`    | Switch between adjacent workspaces         |
| `Alt + Shift + <Left/Right>`  | Move current window to adjacent workspaces |
| `Alt + <Number>`              | Jump to the nth workspace (non-numpad keys)|

---

## Application Shortcuts

| Shortcut            | Application                        |
|---------------------|------------------------------------|
| `Alt + Ctrl + K`    | Open Kitty terminal (`kitty`)      |
| `Alt + Ctrl + G`    | Open Google Chrome (`--no-sandbox`)|
| `Alt + Ctrl + E`    | Open Microsoft Edge (`--no-sandbox`)|
| `Alt + Ctrl + V`    | Open VS Code (`code --no-sandbox .`)|
| `Alt + V`           | Open Diodon clipboard manager     |

**Note:** Customize shortcuts in `~/.config/openbox/rc.xml`.

---

## Warnings

1. **Do not open the Codespaces repository inside RDP.**
   - This may trigger excessive network traffic and system hangs.
2. **Resource Usage:**
   - 2 cores are sufficient for most development tasks.

---

## Troubleshooting

1. In Gitpod, if Tailscale is not started:
    ```sh
    sudo tailscaled
    sudo -E tailscale up --hostname "gitpod-${GITPOD_GIT_USER_NAME// /-}-$(echo ${GITPOD_WORKSPACE_CONTEXT} | jq -r .repository.name)"
    ```

Contributions are welcome! Feel free to submit pull requests to enhance functionality or improve documentation.
