# 🎫 TicketGhost Installers

![Platform](https://img.shields.io/badge/platform-Bash%20%7C%20PowerShell-blue)
![Built for](https://img.shields.io/badge/built%20for-NOC%20II-orange)
![License](https://img.shields.io/badge/license-MIT-green)
![Status](https://img.shields.io/badge/status-Active-brightgreen)
![WSL](https://img.shields.io/badge/WSL-Compatible-informational)

Cross-platform installers for the **TicketGhost** NOC utility — a lightweight alerting, logging, and summary tool built for ServiceDesk Plus monitoring by NOC II technicians.

---

## 🚀 Installers Included

| File                             | Platform     | Purpose                                 |
|----------------------------------|--------------|-----------------------------------------|
| `ticketghost_bash_installer.sh` | Linux / WSL  | Installs the TicketGhost script into your Ubuntu/WSL environment |
| `ticketghost_windows_installer.ps1` | Windows | Creates a scheduled job and shortcut to run TicketGhost via WSL from Windows |

---

## 🛠️ Features

- 🔔 Desktop alerts for **new tickets**
- 💬 Notifications for **member replies**
- 📑 Auto-logging into daily `.csv` files
- 📄 Generate markdown & Excel **summaries**
- 🧪 Built for **WSL**, Bash, PowerShell, and cross-platform NOC workflows

---

## 📦 Quick Start

### 🔧 Bash (Ubuntu/WSL)

```bash
bash ticketghost_bash_installer.sh
```

You’ll be prompted to enter your ServiceDesk API key — that’s it.

### 🪟 PowerShell (Windows)

```powershell
Right-click -> Run with PowerShell
```

The installer:
- Adds a desktop shortcut
- Optionally sets a scheduled task
- Automatically passes the API key

---

## 🔐 Requirements

- `jq` (for Bash installer): `sudo apt install jq`
- `unzip`: installer will auto-download if missing
- GitHub personal access token (for pushing updates, optional)

---

## 📁 Project Structure

```
ticketghost-installers/
├── ticketghost_bash_installer.sh
├── ticketghost_windows_installer.ps1
└── README.md
```

---

## 📣 Screenshots / GIFs

> _(Coming soon — show off how alerts look, .csv logs, and the shortcut in action!)_

---

## 📘 License

MIT — use it, modify it, share it.

---
