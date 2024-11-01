local datetime = require("@lune/datetime")
local fs = require("@lune/fs")
local luau = require("@lune/luau")
local net = require("@lune/net")
local process = require("@lune/process")
local regex = require("@lune/regex")
local roblox = require("@lune/roblox")
local serde = require("@lune/serde")
local stdio = require("@lune/stdio")
local task = require("@lune/task")
--table
local function validateProcessArgs()
	if not process.args then
		error("usage: lune run sandbox [SCRIPT_PATH] -- [ARGS]")
	end
	local filePath = table.remove(process.args, 1)
	if not filePath then
		error("usage: lune run sandbox [SCRIPT_PATH] -- [ARGS]")
	end
	return filePath
end

local function createSandboxEnvironment(filePath)
	return {
		debugName = filePath,
		environment = {
			require = nil,
			getfenv = nil,
			setfenv = nil,
			print = nil,
			warn = nil,
		},
	}
end

local function createSandboxedPrint(debugName, defaultPrint)
	return function(...: any)
		defaultPrint(`---- Output from {debugName} ----`)
		defaultPrint(tostring(...))
		defaultPrint(`---------------------------------------`)
	end
end

local function constructProtectedMt<T>(library: T)
	return {
		__index = library,
		__metatable = "Locked",
		__tostring = function()
			return stdio.format(library)
		end,
	}
end

local function discoverAndReadScript(filePath: string): string
	if fs.isFile(filePath) then
		return fs.readFile(filePath)
	end

	if fs.isDir(filePath) then
		for _, initFile in {"init.luau", "init.lua"} do
			local fullPath = filePath .. "/" .. initFile
			if fs.isFile(fullPath) then
				return fs.readFile(fullPath)
			end
		end
	end

	for _, ext in {".luau", ".lua"} do
		local filePathExt = filePath .. ext
		if fs.isFile(filePathExt) then
			return fs.readFile(filePathExt)
		end
	end

	error(`No such file or directory \`{filePath}\``)
end

local function createSandboxedLuneStdLib(sandboxPrint, debugName)
	return {
		["@lune/fs"] = setmetatable({}, constructProtectedMt(fs)),
		["@lune/luau"] = setmetatable({}, constructProtectedMt(luau)),
		["@lune/process"] = setmetatable({}, constructProtectedMt(process)),
		["@lune/stdio"] = setmetatable({
			write = sandboxPrint,
			ewrite = sandboxPrint,
		}, constructProtectedMt(stdio)),
		["@lune/net"] = setmetatable({}, constructProtectedMt(net)),
		["@lune/roblox"] = setmetatable({
			getAuthCookie = function(...)
				local allowAuthCookie = stdio.prompt(
					"confirm",
					`allow {debugName} to access your .ROBLOSECURITY token?`
				)
				if allowAuthCookie then
					return require("@lune/roblox").getAuthCookie(...)
				end
				error(`{debugName} attempted to access .ROBLOSECURITY token even when denied`)
			end,
		}, constructProtectedMt(roblox)),
		["@lune/serde"] = serde,
		["@lune/task"] = task,
		["@lune/regex"] = regex,
		["@lune/datetime"] = datetime,
	}
end

local function createSandboxedRequire(sandboxedLuneStdLib, debugName, sandboxEnv)
	return function(path: string)
		local module = sandboxedLuneStdLib[path]
		if module then
			local allowed = stdio.prompt("confirm", string.format(`allow {debugName} to access %s?`, path))
			if allowed then
				return module
			end
			error(string.format(`{debugName} tried to access disallowed library %s!`, path))
		else
			local contents = discoverAndReadScript(path)
			local evalChunk = luau.load(contents, sandboxEnv)
			return evalChunk()
		end
	end
end

local function main()
	local filePath = validateProcessArgs()
	local sandboxEnv = createSandboxEnvironment(filePath)
	local sandboxPrint = createSandboxedPrint(sandboxEnv.debugName, print)
	local sandboxedLuneStdLib = createSandboxedLuneStdLib(sandboxPrint, sandboxEnv.debugName)
		sandboxEnv.environment.require = createSandboxedRequire(sandboxedLuneStdLib, sandboxEnv.debugName, sandboxEnv)
		sandboxEnv.environment.getfenv = function()
			return sandboxEnv.environment
		end
		sandboxEnv.environment.setfenv = function()
			error("cannot call setfenv from sandbox")
		end
		sandboxEnv.environment.print = sandboxPrint
		sandboxEnv.environment.warn = sandboxPrint

		if not process.args[1] then
			error("usage: lune run sandbox [SCRIPT_PATH] -- [ARGS]")
		end

		local scriptContents = discoverAndReadScript(filePath)
		luau.load(scriptContents, sandboxEnv)()
	end

	main()
