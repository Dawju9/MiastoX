--!native
--!strict

local WeatherSystem = {}
WeatherSystem.__index = WeatherSystem

export type WeatherType = "sunny" | "rainy" | "foggy" | "stormy" | "snowy" | "cloudy" | "night" | "eclipse" | "apocalyptic" | "tornado" | "earthquake" | "meteor"

local WeatherEffects = {
	sunny = {
		skybox = "Default",
		ambient = Color3.new(0.5, 0.5, 0.5),
		brightness = 1.5,
		fogEnabled = false,
	},
	rainy = {
		skybox = "Gray",
		ambient = Color3.new(0.3, 0.3, 0.35),
		brightness = 0.8,
		fogEnabled = true,
		fogColor = Color3.new(0.2, 0.2, 0.25),
		fogDensity = 0.3,
	},
	foggy = {
		skybox = "Gray",
		ambient = Color3.new(0.4, 0.4, 0.4),
		brightness = 0.6,
		fogEnabled = true,
		fogColor = Color3.new(0.6, 0.6, 0.6),
		fogDensity = 0.7,
	},
	stormy = {
		skybox = "Dark",
		ambient = Color3.new(0.15, 0.15, 0.2),
		brightness = 0.4,
		fogEnabled = true,
		fogColor = Color3.new(0.1, 0.1, 0.15),
		fogDensity = 0.5,
	},
	snowy = {
		skybox = "White",
		ambient = Color3.new(0.7, 0.7, 0.75),
		brightness = 1.0,
		fogEnabled = true,
		fogColor = Color3.new(0.9, 0.9, 0.95),
		fogDensity = 0.2,
	},
	cloudy = {
		skybox = "Gray",
		ambient = Color3.new(0.45, 0.45, 0.5),
		brightness = 0.9,
		fogEnabled = false,
	},
	night = {
		skybox = "Night",
		ambient = Color3.new(0.1, 0.1, 0.2),
		brightness = 0.3,
		fogEnabled = false,
	},
	eclipse = {
		skybox = "Dark",
		ambient = Color3.new(0.05, 0.05, 0.1),
		brightness = 0.2,
		fogEnabled = true,
		fogColor = Color3.new(0, 0, 0.05),
		fogDensity = 0.4,
	},
	apocalyptic = {
		skybox = "Hell",
		ambient = Color3.new(0.3, 0.1, 0),
		brightness = 0.5,
		fogEnabled = true,
		fogColor = Color3.new(0.4, 0.1, 0),
		fogDensity = 0.6,
	},
	tornado = {
		skybox = "Dark",
		ambient = Color3.new(0.2, 0.2, 0.25),
		brightness = 0.3,
		fogEnabled = true,
		fogColor = Color3.new(0.15, 0.15, 0.2),
		fogDensity = 0.8,
		shakeIntensity = 5,
	},
	earthquake = {
		skybox = "Dark",
		ambient = Color3.new(0.3, 0.2, 0.1),
		brightness = 0.6,
		fogEnabled = true,
		fogColor = Color3.new(0.25, 0.15, 0.1),
		fogDensity = 0.3,
		shakeIntensity = 10,
	},
	meteor = {
		skybox = "Hell",
		ambient = Color3.new(0.4, 0.1, 0),
		brightness = 0.4,
		fogEnabled = true,
		fogColor = Color3.new(0.5, 0.15, 0),
		fogDensity = 0.5,
		shakeIntensity = 15,
		particles = "fire",
	}
}

function WeatherSystem.new()
	local self = setmetatable({}, WeatherSystem)
	self.currentWeather = "sunny" :: WeatherType
	self.shakeOffset = Vector3.zero
	return self
end

function WeatherSystem:apply(weatherType: WeatherType)
	if not WeatherEffects[weatherType] then
		warn(`[WeatherSystem] Unknown weather type: {weatherType}`)
		return
	end

	self.currentWeather = weatherType
	local effect = WeatherEffects[weatherType]

	local lighting = game:GetService("Lighting")
	lighting.Ambient = effect.ambient
	lighting.Brightness = effect.brightness

	if effect.fogEnabled then
		lighting.FogEnabled = true
		lighting.FogColor = effect.fogColor
		lighting.FogDensity = effect.fogDensity
	else
		lighting.FogEnabled = false
	end

	print(`[WeatherSystem] Applied weather: {weatherType}`)
end

function WeatherSystem:getEffects(weatherType: WeatherType)
	return WeatherEffects[weatherType]
end

function WeatherSystem:getRandomDisaster(): WeatherType
	local disasters = {"tornado", "earthquake", "meteor"}
	return disasters[math.random(#disasters)]
end

return WeatherSystem