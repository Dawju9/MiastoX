local fs = ('@lune/fs')
local roblox = ('@lune/roblox')
local HttpService = game:GetService("HttpService")

-- Wczytanie pliku gry (place file)
local placeFile = fs.readFile("ayachapter.rbxl")
local game = roblox.deserializePlace(placeFile)

-- Manipulacja instancjami (np. wypisanie obiektów w Workspace)
local workspace = game:GetService("Workspace")
for _, child in workspace:GetChildren() do
    print("Znaleziono dziecko: " .. child.Name .. " o klasie " .. child.ClassName)
end

-- Zapisanie zmodyfikowanego pliku gry
local newPlaceFile = roblox.serializePlace(game)
fs.writeFile("ayachapter_modified.rbxl", newPlaceFile)

-- Publikowanie pliku na Robloxie
local UNIVERSE_ID = "4125094708"  -- ID uniwersum
local PLACE_ID = "11633610328"    -- ID miejsca
local API_KEY = "lxu4LCFBYkulMjhUSx/NRheNQm6IF2OxRW0ugW8XZvvbS54pZXlKaGJHY2lPaUpTVXpJMU5pSXNJbXRwWkNJNkluTnBaeTB5TURJeExUQTNMVEV6VkRFNE9qVXhPalE1V2lJc0luUjVjQ0k2SWtwWFZDSjkuZXlKaVlYTmxRWEJwUzJWNUlqb2liSGgxTkV4RFJrSlphM1ZzVFdwb1ZWTjRMMDVTYUdWT1VXMDJTVVl5VDNoU1Z6QjFaMWM0V0ZwMmRtSlROVFJ3SWl3aWIzZHVaWEpKWkNJNklqUXdOemMxTnpnMU5USWlMQ0poZFdRaU9pSlNiMkpzYjNoSmJuUmxjbTVoYkNJc0ltbHpjeUk2SWtOc2IzVmtRWFYwYUdWdWRHbGpZWFJwYjI1VFpYSjJhV05sSWl3aVpYaHdJam94TnpNeE5qSTBNRGM0TENKcFlYUWlPakUzTXpFMk1qQTBOemdzSW01aVppSTZNVGN6TVRZeU1EUTNPSDAuS2xoZS1mbnR2dU0yMUJ5cTV3NTFVM2E5clpRcVNzeU94M1RIZEJWOW1oZm4tY095eTNrVllBWWI0RU4zUy00WVlmMU1rYnZ6WUhUekxZM0ZtczhUc3NZRm03ZlBzQ2tFMXNGYVlCeVVpZmh4MlRQcTh1WlhIOXd1T3o4Z2NYOFZZN2ZGRjZqMlI4NEh2R0Y2TFh4N3FnUVROU3NkN0pkOERLSmZjN0dSbEJWTXJodzJMWlc3YS1OaWJ3a3I5S2tOM21HWHJNYUtwMVAtQWdZR3NYRnRFZGMzcW9TZTFYWGs0M2RXM1dZWXphbHNXMWZlN1MzUmJfaXRNa2lvaUs1Z29ZWTdaZk1tdHJmZEJQaXRwMzUwYmpkLXllWWs2WUdNeVB0MUJjM3ZkV2FEZlJXWmFIdEtULWI4R21uUVJLTjlJaUdQMDZ4TEcybWFFZElfWGROdFRR"    -- Wstaw swój klucz API

-- Adres URL API do publikacji
local apiUrl = "https://apis.roblox.com/universes/v1/" .. UNIVERSE_ID .. "/places/" .. PLACE_ID .. "/versions?versionType=Published"

-- Wysłanie żądania POST do API Roblox z danymi binarnymi
local response = HttpService:PostAsync(apiUrl, newPlaceFile, Enum.HttpContentType.ApplicationJson, false, {
    ["x-api-key"] = API_KEY
})

-- Sprawdzenie odpowiedzi z API
if response then
    print("Miejsce zostało pomyślnie opublikowane!")
else
    print("Błąd podczas publikacji miejsca.")
end