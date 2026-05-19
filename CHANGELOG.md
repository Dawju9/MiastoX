# Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [v1.0.0] - 2026-04-12

### Added
- Integration with CityX framework via Wally package system
- CI/CD workflow with GitHub Actions (lint, build, security scan)
- Lune build scripts for alternative build system
- Multiple build configurations (default, dev, test)
- Config files: selene.toml, stylua.toml, .editorconfig, .pre-commit-config.yaml, .darklua.json
- GitHub Pages with Jekyll configuration (Gemfile, _config.yml)
- Game systems integration: PauseMenu, HUD, Shop, DataStore
- Build outputs: MiastoX-Final.rbxl, MiastoX-Rojo.rbxl
- Development scripts: dev.sh, release.sh, setup.sh

### Changed
- Updated client/server initialization to use CityX modules
- Enhanced project structure for modularity
- Updated documentation (index.html, about.md)

### Removed
- Deprecated src/shared/Hello.luau

## [v1.0.1] - 2026-05-12

### Added
- Luau language server configuration (.luaurc) with module aliases and strict mode

### Changed
- Updated trove dependency to v1.3.0

## [v1.1.0] - 2026-05-19

### Added
- 3D map viewer (map-3d.html) with Three.js: bloom, raycaster hover/click, animated platforms, keyboard shortcuts, floor search
- Dynamic per-floor lighting based on level type
- Floor search input in sidebar
- Keyboard shortcuts: arrows (floor nav), R (reset view), Space (auto-rotate)
- Interactive platform tooltips on hover

### Changed
- Complete website redesign: dark theme, multi-page layout (Home, Map 3D, Join, About, Donate, Contact)
- Home page: Three.js hero animation + Canvas-based CityX architecture visualization
- All subpages with responsive design and Font Awesome icons
- map-3d.html: standalone page with matching navigation, fixed tag structure

### CI/CD
- web-deploy.yml: optimized Jekyll deploy with path filtering (web branch)
- game-deploy.yml: full pipeline (analyze → build → rbxcloud deploy) for main branch
- release.yml: cleaned up for release-based builds
- main branch created from master for game source separation

## [Unreleased]

### Planned
- Player statistics tracking
- Leaderboard integration
- Weather system v2
- Power-up system
- PvP zones