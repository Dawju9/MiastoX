--!strict
--[[
    MiastoX Lune Build Script
    Builds game without Rojo - uses roblox module for place manipulation
    
    Usage: lune build-lune [dev|prod]
]]
local process = require("@lune/process")
local fs = require("@lune/fs")
local roblox = require("@lune/roblox")
local stdio = require("@lune/stdio")

local BUILD_TYPE = process.args[1] or "prod"

local function log(msg: string)
    stdio.writeLine("[LUNE-BUILD] " .. msg)
end

local function logError(msg: string)
    stdio.writeLine("[ERROR] " .. msg)
end

-- Configuration per build type
local CONFIG = {
    prod = {
        project = "default.project.json",
        output = "MiastoX-Lune.rbxl",
        filteringEnabled = true,
        shadows = true,
        lighting = "Voxel"
    },
    dev = {
        project = "dev.project.json", 
        output = "MiastoX-Lune-Dev.rbxl",
        filteringEnabled = false,
        shadows = false,
        lighting = "Legacy"
    }
}

local config = CONFIG[BUILD_TYPE]

if not config then
    logError("Invalid build type: " .. BUILD_TYPE)
    logError("Valid types: prod, dev")
    process.exit(1)
end

log("=== MiastoX Lune Build ===")
log("Build type: " .. BUILD_TYPE)
log("Project: " .. config.project)
log("Output: " .. config.output)
log("")

-- Check if project file exists
if not fs.exists(config.project) then
    logError("Project file not found: " .. config.project)
    logError("Run 'rojo init' first or use rojo build instead")
    process.exit(1)
end

log("Starting Lune-based build...")

-- Try to use Rojo first (more reliable)
local function tryRojoBuild(): boolean
    local result = process.exec("rojo", {"build", config.project, "--output", config.output})
    return result.code == 0
end

-- Fallback: Try using roblox module directly (experimental)
local function tryRobloxModuleBuild(): boolean
    log("Attempting direct roblox module build...")
    
    -- This is experimental - Lune's roblox module can read/write .rbxl files
    -- but cannot fully replicate Rojo's project.json features
    
    local projectPath = config.project
    
    if fs.exists(projectPath) then
        -- Read the place file if exists
        local placeFile = "Game.rbxl" -- existing place
        if fs.exists(placeFile) then
            log("Using existing place: " .. placeFile)
            -- roblox.readPlaceFile would go here
            -- For now, fallback to rojo
            return false
        end
    end
    
    return false
end

-- Main build logic
local buildSuccess = false

-- Try Rojo first
if tryRojoBuild() then
    log("Build successful with Rojo!")
    buildSuccess = true
else
    log("Rojo build failed, trying Lune roblox module...")
    if tryRobloxModuleBuild() then
        log("Build successful with Lune!")
        buildSuccess = true
    else
        logError("Both build methods failed")
        logError("Install Rojo: cargo install rojo")
    end
end

if buildSuccess then
    log("")
    log("=== Build Complete ===")
    log("Output: " .. config.output)
    
    -- Show file info
    local stat = fs.stat(config.output)
    if stat then
        log("Size: " .. tostring(stat.size) .. " bytes")
    end
else
    logError("Build failed!")
    process.exit(1)
end