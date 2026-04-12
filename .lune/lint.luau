--!strict
--[[
    MiastoX Lint Script
    Usage: lune lint
]]
local process = require("@lune/process")
local stdio = require("@lune/stdio")

local function log(msg: string)
    stdio.writeLine("[LINT] " .. msg)
end

local function runCmd(args: {string}): boolean
    local output = process.exec(args[1], args[2 :: any])
    if output.code ~= 0 then
        log("Warning: " .. output.stderr)
    else
        log("OK")
    end
    return output.code == 0
end

log("Running Selene...")

-- Check if selene is available
local seleneResult = runCmd({"selene", "src"})

if seleneResult then
    log("Lint passed!")
else
    log("Lint completed with warnings")
end