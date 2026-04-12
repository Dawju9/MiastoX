--!strict
--[[
    MiastoX Format Script
    Usage: lune format
]]
local process = require("@lune/process")
local stdio = require("@lune/stdio")

local function log(msg: string)
    stdio.writeLine("[FORMAT] " .. msg)
end

local function runCmd(args: {string}): boolean
    local output = process.exec(args[1], args[2 :: any])
    if output.code ~= 0 then
        log("Error: " .. output.stderr)
        return false
    end
    log("OK")
    return true
end

log("Running StyLua...")

local success = runCmd({"stylua", "src"})

if success then
    log("Format complete!")
else
    log("Format failed")
    process.exit(1)
end