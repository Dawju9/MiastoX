---
layout: default
title: README
desc: MiastoX – Roblox climbing game
url: /README
---

# MiastoX

**MiastoX** is a Roblox "climb to the top" game built with the **Luau** language and the **CityX** framework. Players race to ascend a procedurally‑generated city, overcoming obstacles, weather effects, and competing in PvP.

## Features
- Six progressive levels (Tutorial → Chaos)
- Multiple weather types (sunny, rainy, foggy, night, etc.)
- PvP combat with kill tracking
- Power‑ups (speed, jump, shield, invincibility, double coins & XP)
- Dynamic level generation using `LevelGenerator` and `LevelManager`

## Tech Stack
| Component | Details |
|---|---|
| Language | Luau (Roblox scripting) |
| Framework | CityX (custom modular framework) |
| Build tool | Rojo (syncs Lua code to Roblox) |
| Package manager | Wally |
| Linter | Selene |
| Formatter | StyLua |

## Repository Structure
```
MiastoX/
├─ src/                 # Game source code
│  ├─ server/           # Server‑side scripts
│  ├─ ReplicatedStorage/  # Shared modules
│  ├─ ReplicatedFirst/    # Client initialization
│  ├─ StarterPlayerScripts/
│  └─ StarterCharacterScripts/
├─ Packages/            # Wally dependencies
├─ scripts/             # Helper scripts (setup, build, release)
├─ .github/             # CI/CD workflows
├─ config.toml          # Site configuration (Jekyll)
├─ stylua.toml          # Formatter config
└─ wally.toml           # Package definition
```

## Setup & Development
```bash
# Clone the repository
git clone https://github.com/Dawju9/MiastoX.git
cd MiastoX

# Install Lua dependencies via Wally
wally install

# Install helper scripts (requires bash)
./scripts/setup.sh

# Sync to Roblox Studio using Rojo
rojo serve
```
> **Note:** The project does not use npm; all tooling is Lua‑based.

## Contributing
Feel free to open issues or submit pull requests. Follow the contribution guidelines in `.github/CONTRIBUTING.md`.

## License
MIT © 2024 Whitekali