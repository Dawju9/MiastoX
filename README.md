# MiastoX

<div align="center">

![MiastoX Banner](https://img.shields.io/badge/MiastoX-Climb%20to%20the%20Top-d4d4d4?style=for-the-badge&logo=roblox&logoColor=0a0a0a&labelColor=0a0a0a)

**Procedural climbing game on Roblox** — 30 floors, dynamic weather, PvP & rank system.

[![Play on Roblox](https://img.shields.io/badge/Play%20Now-Roblox-d4d4d4?style=for-the-badge&logo=roblox&logoColor=0a0a0a)](https://www.roblox.com/pl/games/11633610328/MiastoX-Updated-24th)
[![Website](https://img.shields.io/badge/Website-GitHub%20Pages-d4d4d4?style=for-the-badge&logo=githubpages&logoColor=0a0a0a)](https://Dawju9.github.io/MiastoX)
[![License](https://img.shields.io/badge/License-MIT-d4d4d4?style=for-the-badge)](LICENSE)
[![Version](https://img.shields.io/badge/Version-1.0.1-d4d4d4?style=for-the-badge)](https://github.com/Dawju9/MiastoX/releases)

</div>

---

## 🎮 Features

| Feature | Description |
|---|---|
| 🏢 **30+ Floors** | Progressive difficulty from tutorial to chaos |
| 🌦️ **Dynamic Weather** | Sunny, rain, storm, snow, fog — conditions change mid-game |
| ⚡ **Power-ups** | Speed, Jump, Shield, Invincibility, Double Coins & XP |
| ⚔️ **PvP System** | Arena combat with kill tracking, rankings & rewards |
| 👑 **Rank System** | From Civilian to Owner — earn prestige and climb the hierarchy |
| 🔄 **Prestige** | Complete the game, earn a point, restart with bigger rewards |
| 🏗️ **Procedural Generation** | Unique city blocks every time you play |

---

## 🛠️ Tech Stack

| Component | Details |
|---|---|
| **Language** | Luau (Roblox) |
| **Framework** | CityX (modular server framework by Whitekali) |
| **Build Tool** | Rojo |
| **Package Manager** | Wally (Promise, Trove, Signal) |
| **Linter** | Selene |
| **Formatter** | StyLua |
| **CI/CD** | GitHub Actions |
| **Data** | Firebase |
| **Website** | Jekyll + GitHub Pages |

---

## 📁 Project Structure

```
MiastoX/
├── src/                    # Game source code
│   ├── server/             # Server-side scripts
│   ├── client/             # Client-side scripts
│   ├── ReplicatedStorage/  # Shared modules
│   └── ReplicatedFirst/    # Client initialization
├── Packages/               # Wally dependencies
├── .github/workflows/      # CI/CD pipelines
├── styles/                 # Website CSS (grayscale design)
├── _layouts/               # Jekyll layouts
├── api/                    # Game data APIs
│   └── ranks.json          # Player ranks & prestige
├── assets/                 # Static assets
├── index.html              # One-page website
└── map.html                # Interactive 2D/3D floor map
```

---

## 🚀 Quick Start

### Prerequisites
- Roblox Studio
- [Rojo](https://rojo.space/)
- [Wally](https://wally.run/)
- Node.js (for website dev)

### Setup
```bash
# Clone repository
git clone https://github.com/Dawju9/MiastoX.git
cd MiastoX

# Install dependencies
npm run install

# Sync to Roblox Studio
rojo serve
```

### Development
```bash
# Start dev server (client only)
npm run dev

# Start dev server (with server)
npm run dev:server

# Build production
npm run build

# Format code
npm run format

# Lint code
npm run lint
```

### Release
```bash
# Full production release
npm run release

# Full dev setup
npm run full:dev
```

---

## 🌐 Website

The project includes a one-page website with grayscale glass-morphism design.

**URL**: https://Dawju9.github.io/MiastoX

**Sections**:
- Hero with live stats
- Game features
- Project architecture visualization
- Interactive floor map (2D grid + 3D Three.js view)
- Player rank hierarchy
- Game statistics
- Quick start guide

**Deploy**: Automatic on push to `web` branch via GitHub Actions.

---

## 📊 Game Statistics

| Stat | Value |
|---|---|
| Total Visits | 14,247 |
| Average Play Time | 2.4 hours |
| Server Uptime | 2d 4h |
| Commits | 187 |
| Completed Floor 1 | 1,247 players |
| Completed Game (F30) | 89 players |
| Players with Prestige | 34 |
| Invited Players | 562 |
| Roblox Rating | 94% |
| Favorites | 3,891 |

---

## 🏗️ Architecture

```
┌──────────┐    ┌──────────┐    ┌──────────┐
│  Server  │───▶│Generator │───▶│ Weather  │
│ GameLoop │    │Procedural│    │  9 types │
└──────────┘    └──────────┘    └──────────┘
       │                               │
       ▼                               ▼
┌──────────┐    ┌──────────┐    ┌──────────┐
│ Players  │◀───│DataStore │◀───│   PvP    │
│Replication│    │ Firebase │    │  Arena   │
└──────────┘    └──────────┘    └──────────┘
```

---

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

MIT © 2024-2026 MiastoX Team

---

## 🔗 Links

- [Play on Roblox](https://www.roblox.com/pl/games/11633610328/MiastoX-Updated-24th)
- [Website](https://Dawju9.github.io/MiastoX)
- [CityX Framework](https://github.com/whitekali/cityx)

---

<div align="center">

### 👨‍💻 Developer Stats

![Dawju9's GitHub Stats](https://awesome-github-stats.azurewebsites.net/user-stats/Dawju9?cardType=github&theme=github-dark&preferLogin=true)

![Dawju9's Level](https://awesome-github-stats.azurewebsites.net/user-stats/Dawju9?cardType=level&theme=github-dark&preferLogin=true)

</div>
