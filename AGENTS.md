# MiastoX Agent Guide

## Setup
- Install npm dependencies: `npm install`
- Install Wally dependencies: `npm run install` (runs `wally install`)

## Development
- Start dev server (client only): `npm run dev`
- Start dev server (with server): `npm run dev:server`
- Build production place: `npm run build` (outputs MiastoX.rbxl)
- Build for testing: `npm run test` (outputs MiastoX-Test.rbxl)

## Code Quality
- Format Lua: `npm run format`
- Check formatting: `npm run format:check`
- Lint Lua: `npm run lint`
- Preprocess with Darklua: `npm run preprocess`
- Validate config: `npm run validate:config`

## Release
- Full production release: `npm run release` (preprocess, format, lint, build:prod)
- Full Lune production release: `npm run release:lune` (uses Lune build)
- Full dev setup: `npm run full:dev` (install, dev cycle, build:dev)
- Full prod setup: `npm run full:prod` (install, release)
- Full Lune prod setup: `npm run full:lune:prod` (install, release:lune)

## Notes
- The project uses Rojo for Roblox project synchronization and building.
- Lune is used for compiling Lune.src.lua files to Luau (see `src/lune-build.luau`).
- Wally is used for package management (dependencies in `Packages/`).
- Test builds use `test.project.json`.