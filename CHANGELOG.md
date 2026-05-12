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

## [Unreleased]

### Planned
- Player statistics tracking
- Leaderboard integration
- Weather system
- Power-up system
- PvP zones