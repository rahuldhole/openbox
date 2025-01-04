# Openbox Remote Desktop Environment

Setup a minimal virtual remote desktop environment with Openbox, XRDP, Kitty, Diodon, and Tailscale for private remote access.

[![Open in Codespaces](https://github.com/codespaces/badge.svg)](https://github.com/codespaces/new?hide_repo_select=true&ref=main&repo=rahuldhole/openbox)

> **Note:** Gitpod and OpenShift are currently using raw scripts for setup. Contributions to improve these configurations and transition to package-based setups are welcome.

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/new#https://github.com/rahuldhole/openbox)

<a href="https://devspaces.apps.sandbox-m3.1530.p1.openshiftapps.com/#https://github.com/rahuldhole/openbox">
    <img src="https://www.svgrepo.com/show/354143/openshift.svg" alt="Open in OpenShift" width="25px"/> Open in OpenShift (Currently not stable)
</a>

---

### Free Tier Overview
- **GitHub Codespaces:** 60 hours/month on 2 cores (120 CPU hours total).
- **Gitpod:** 50 hours/month.

**Total:** 110 hours/month of powerful remote desktop usage.
- **Working days:** Approximately 15.7 days/month on free tier (based on 7-hour workdays).

---

## Installation
Add the following to your `.devcontainer/devcontainer.json` file:

```json
{
  "name": "Openbox",
  "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
  "runArgs": [
    "--device=/dev/net/tun", // Required for Tailscale
    "--shm-size=2g" // Recommended for browsers
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

1. **Check Service Status:**
   ```sh
   sudo service xrdp status
   sudo tailscale status
   # (Optional) Restart service if necessary
   # sudo service xrdp restart
   ```

2. **Login to Tailscale:**
   ```sh
   # For Gitpod, start the Tailscale daemon if not running
   # sudo tailscaled

   sudo tailscale up
   ```

3. **Open RDP Client:**
   - Use the Tailscale VPN IP of your Codespaces or Gitpod environment.
   - RDP credentials:
     - **Codespaces:** `vscode:vscode`
     - **Gitpod:** `gitpod:gitpod`

4. **Interact with Openbox:**
   - Right-click on the blue screen to access more options.

---

## Openbox Shortcuts

### Window Management
- **`Alt+t`**: Switch between windows in the current workspace (similar to `Alt+Tab`)
- **`Alt+d`**: Show or hide the desktop
- **`Alt+<Left/Right Arrow>`**: Switch between adjacent workspaces
- **`Alt+Shift+<Left/Right Arrow>`**: Move current window to an adjacent workspace
- **`Alt+<Number>`**: Jump to the nth workspace (**Note:** Do not use numpad numbers)

### Application Shortcuts
- **`Alt+Ctrl+k`**: Open Kitty terminal (`kitty`)
- **`Alt+Ctrl+g`**: Open Google Chrome browser (`google-chrome --no-sandbox`)
- **`Alt+Ctrl+e`**: Open Microsoft Edge browser (`microsoft-edge --no-sandbox`)
- **`Alt+Ctrl+v`**: Open Visual Studio Code (`code --no-sandbox .`)
- **`Alt+v`**: Open Diodon clipboard manager (`diodon`)

> **Note:** Customize shortcuts in `~/.config/openbox/rc.xml`.

---

## Warnings
1. **Avoid Opening Codespaces Repository Inside RDP:**
   - May cause recursive network traffic leading to system hangs, even on high-spec machines.

2. **Resource Requirements:**
   - 2 cores are sufficient for most development tasks.

---

## Troubleshooting

### Gitpod Specific
- If Tailscale is not started:
  ```sh
  sudo tailscaled
  sudo -E tailscale up --hostname "gitpod-${GITPOD_GIT_USER_NAME// /-}-$(echo ${GITPOD_WORKSPACE_CONTEXT} | jq -r .repository.name)"
  ```

---

Contributions are welcome! Feel free to submit pull requests to enhance functionality or improve documentation.
