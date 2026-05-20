# MiastoX

**MiastoX** is a Roblox "climb to the top" game built with **Luau** and the **CityX** framework. Players race to ascend a procedurally-generated city, overcoming obstacles, weather effects, and competing in PvP.

## 🎮 Features
- **30+ Floors** — Progressive difficulty from tutorial to chaos
- **Dynamic Weather** — Sunny, rain, storm, snow, fog, and more
- **Power-ups** — Speed, Jump, Shield, Invincibility, Double Coins & XP
- **PvP System** — Arena combat with kill tracking and rankings
- **Procedural Generation** — Unique levels every time you play

## 🛠️ Tech Stack
| Component | Details |
|---|---|
| Language | Luau (Roblox) |
| Framework | CityX (modular server framework) |
| Build Tool | Rojo |
| Package Manager | Wally |
| Linter | Selene |
| Formatter | StyLua |

## 📁 Project Structure
```
MiastoX/
├── src/                    # Game source code
│   ├── server/             # Server-side scripts
│   ├── client/             # Client-side scripts
│   ├── ReplicatedStorage/  # Shared modules
│   └── ReplicatedFirst/    # Client initialization
├── Packages/               # Wally dependencies
├── styles/                 # Website CSS
├── _layouts/               # Jekyll layouts
└── index.html              # Main website page
```

## 🚀 Quick Start

### Prerequisites
- Roblox Studio
- [Rojo](https://rojo.space/)
- [Wally](https://wally.run/)

### Setup
```bash
# Clone repository
git clone https://github.com/Dawju9/MiastoX.git
cd MiastoX

# Install dependencies
wally install

# Sync to Roblox Studio
rojo serve
```

### Development
```bash
# Start dev server
npm run dev

# Build production
npm run build

# Format code
npm run format

# Lint code
npm run lint
```

## 🌐 Website
The project includes a simple website hosted on GitHub Pages:
- **URL**: https://Dawju9.github.io/MiastoX
- **Deploy**: Automatic on push to `web` branch

## 🤝 Contributing
1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License
MIT © 2024-2026 MiastoX Team

## 🔗 Links
- [Play on Roblox](https://www.roblox.com/pl/games/11633610328/MiastoX-Updated-24th)
- [GitHub Repository](https://github.com/Dawju9/MiastoX)
- [CityX Framework](https://github.com/whitekali/cityx)
