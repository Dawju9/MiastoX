--!strict
--[[
    MiastoX Build Script (Lune)
    Alternative build using Lune + Rojo
    
    Usage: lune run src/lune-build.luau [dev|prod]
]]
local process = require("@lune/process")
local fs = require("@lune/fs")
local stdio = require("@lune/stdio")

local BUILD_TYPE = process.args[1] or "prod"

local function log(msg: string)
	stdio.writeLine("[BUILD] " .. msg)
end

local function errorLog(msg: string)
	stdio.writeLine("[ERROR] " .. msg)
end

-- Build configurations
local PROJECTS = {
	prod = { file = "default.project.json", output = "MiastoX.rbxl" },
	dev = { file = "dev.project.json", output = "MiastoX-Dev.rbxl" },
	test = { file = "test.project.json", output = "MiastoX-Test.rbxl" },
}

local config = PROJECTS[BUILD_TYPE]

if not config then
	errorLog("Unknown build type: " .. BUILD_TYPE)
	errorLog("Valid: prod, dev, test")
	process.exit(1)
end

log("=== MiastoX Build (Lune) ===")
log("Type: " .. BUILD_TYPE)
log("Project: " .. config.file)
log("Output: " .. config.output)
log("")

-- Check project file exists
if not fs.exists(config.file) then
	errorLog("Project file not found: " .. config.file)
	process.exit(1)
end

-- Check if rojo is available
local hasRojo = process.exec("rojo", { "--version" }).code == 0

if hasRojo then
	log("Using Rojo for build...")
	local result = process.exec("rojo", { "build", config.file, "--output", config.output })

	if result.code == 0 then
		log("Build successful!")

		if fs.exists(config.output) then
			local stat = fs.stat(config.output)
			log("Output: " .. config.output .. " (" .. tostring(stat.size) .. " bytes)")
		end
	else
		errorLog("Build failed: " .. (result.stderr or "Unknown error"))
		process.exit(1)
	end
else
	errorLog("Rojo not found!")
	errorLog("Install: cargo install rojo")
	errorLog("Or use: rokit add rojo")
	process.exit(1)
end

log("=== Done ===")
