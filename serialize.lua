local HttpService = game:GetService("HttpService")
local UniverseID =  4125094708
local PlaceID = 11633610328 
-- Read the file data (make sure the file exists)
local placeFile = game:GetService("ContentProvider"):PreloadAsync({"ayachapter.rbxl"})

local apiUrl = "https://apis.roblox.com/universes/v1/" .. UniverseID .. "/places/" .. PlaceID .. "/versions?versionType=Published"

local API_KEY = "lxu4LCFBYkulMjhUSx/NRheNQm6IF2OxRW0ugW8XZvvbS54pZXlKaGJHY2lPaUpTVXpJMU5pSXNJbXRwWkNJNkluTnBaeTB5TURJeExUQTNMVEV6VkRFNE9qVXhPalE1V2lJc0luUjVjQ0k2SWtwWFZDSjkuZXlKaVlYTmxRWEJwUzJWNUlqb2liSGgxTkV4RFJrSlphM1ZzVFdwb1ZWTjRMMDVTYUdWT1VXMDJTVVl5VDNoU1Z6QjFaMWM0V0ZwMmRtSlROVFJ3SWl3aWIzZHVaWEpKWkNJNklqUXdOemMxTnpnMU5USWlMQ0poZFdRaU9pSlNiMkpzYjNoSmJuUmxjbTVoYkNJc0ltbHpjeUk2SWtOc2IzVmtRWFYwYUdWdWRHbGpZWFJwYjI1VFpYSjJhV05sSWl3aVpYaHdJam94TnpNeE5qSTBNRGM0TENKcFlYUWlPakUzTXpFMk1qQTBOemdzSW01aVppSTZNVGN6TVRZeU1EUTNPSDAuS2xoZS1mbnR2dU0yMUJ5cTV3NTFVM2E5clpRcVNzeU94M1RIZEJWOW1oZm4tY095eTNrVllBWWI0RU4zUy00WVlmMU1rYnZ6WUhUekxZM0ZtczhUc3NZRm03ZlBzQ2tFMXNGYVlCeVVpZmh4MlRQcTh1WlhIOXd1T3o4Z2NYOFZZN2ZGRjZqMlI4NEh2R0Y2TFh4N3FnUVROU3NkN0pkOERLSmZjN0dSbEJWTXJodzJMWlc3YS1OaWJ3a3I5S2tOM21HWHJNYUtwMVAtQWdZR3NYRnRFZGMzcW9TZTFYWGs0M2RXM1dZWXphbHNXMWZlN1MzUmJfaXRNa2lvaUs1Z29ZWTdaZk1tdHJmZEJQaXRwMzUwYmpkLXllWWs2WUdNeVB0MUJjM3ZkV2FEZlJXWmFIdEtULWI4R21uUVJLTjlJaUdQMDZ4TEcybWFFZElfWGROdFRR"

-- Check if HttpService is available (mocked)
if HttpService then
    print("HttpService is available for testing!")
else
    print("HttpService is not available.")
end
local headers = {
    ["x-api-key"] = API_KEY,
    ["Content-Type"] = "application/octet-stream"  -- Manually set the Content-Type header for binary data
}

-- Use pcall to handle errors safely

local success, response = pcall(function()
    return HttpService:PostAsync(apiUrl, placeFile, Enum.HttpContentType.ApplicationJson, false, headers)
end)
if success then
    print("Response: ", response)
else
    print("Error: ", response)
end
if success then
    print("Response: ", response)
else
    print("Error: ", response)
end