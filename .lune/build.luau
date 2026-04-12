--!strict
--[[
    MiastoX Build Script
    Usage: lune build
]]
local process = require("@lune/process")
local fs = require("@lune/fs")
local stdio = require("@lune/stdio")

local function log(msg: string)
    stdio.writeLine("[BUILD] " .. msg)
end

local function run(args: {string}, env: {{string}: string}?)
    local output = process.exec(args[1], args[2 :: any], env)
    if output.code ~= 0 then
        log("Error: " .. output.stderr)
        process.exit(1)
    end
    if #output.stdout > 0 then
        log(output.stdout)
    end
    return output
end

local project = "default.project.json"
local output = "MiastoX.rbxl"

-- Check project exists
if not fs.exists(project) then
    log("Project file not found: " .. project)
    process.exit(1)
end

log("Building: " .. project)

-- Run rojo build
run({"rojo", "build", project, "--output", output})

log("Built: " .. output)
log("Done!")