--!native
--!strict

local WeatherSystem = {}
WeatherSystem.__index = WeatherSystem

export type WeatherType = "sunny" | "rainy" | "foggy" | "snowy" | "cloudy" | "night" | "smog" | "drizzle" | "overcast"

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
	smog = {
		skybox = "Gray",
		ambient = Color3.new(0.35, 0.3, 0.25),
		brightness = 0.5,
		fogEnabled = true,
		fogColor = Color3.new(0.5, 0.45, 0.4),
		fogDensity = 0.6,
	},
	drizzle = {
		skybox = "Gray",
		ambient = Color3.new(0.35, 0.35, 0.4),
		brightness = 0.7,
		fogEnabled = true,
		fogColor = Color3.new(0.3, 0.3, 0.35),
		fogDensity = 0.15,
	},
	overcast = {
		skybox = "Gray",
		ambient = Color3.new(0.4, 0.4, 0.45),
		brightness = 0.6,
		fogEnabled = false,
	},
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

return WeatherSystem
