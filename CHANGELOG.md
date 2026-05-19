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

### Added
- City block generation: buildings, scaffolding, fire escapes, cranes, bridges
- 18+ city object types (moving_scaffold, rotating_sign, collapsing_ledge, crumbling_stairs, boost_vent, bounce_tarp, rebar, elevator_shaft, wet_roof, construction_laser)
- Weather system: 9 city weather types (smog, drizzle, overcast)
- Interactive rank hierarchy page with player roster (hierarchy.html)
- Team recruitment page (jobs.html) with role collection
- Changelog page (changelog.html)
- Player roster API endpoint (api/ranks.json)
- Continuous city generation (5 blocks per level, difficulty scaling)

### Changed
- LevelGenerator.luau: full rewrite with CityObjectType enum and factory methods
- LevelManager.server.luau: continuous block generation, removed special levels
- WeatherSystem.luau: removed supernatural weather (eclipse, apocalyptic, tornado, earthquake, meteor, stormy)
- Generator.client.luau: safe LightingRiver guards, task.spawn wrappers
- init.server.luau: city config, CityX system stubs
- Nav menu: added Changelog, Nasi gracze links

### Fixed
- CityX symlink: /Development/cityx/src → /Development/projekt/cityx/src