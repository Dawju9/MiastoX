local net = require("@lune/net")
local UniverseID = 4125094708
local PlaceID = 11633610328

-- Read the file data (make sure the file exists and is accessible)
-- local placeFile = 11633610328

local apiUrl = "https://apis.roblox.com/universes/v1/" .. UniverseID .. "/places/" .. PlaceID .. "/versions?versionType=Published"

local API_KEY = "lxu4LCFBYkulMjhUSx/NRheNQm6IF2OxRW0ugW8XZvvbS54pZXlKaGJHY2lPaUpTVXpJMU5pSXNJbXRwWkNJNkluTnBaeTB5TURJeExUQTNMVEV6VkRFNE9qVXhPalE1V2lJc0luUjVjQ0k2SWtwWFZDSjkuZXlKaVlYTmxRWEJwUzJWNUlqb2liSGgxTkV4RFJrSlphM1ZzVFdwb1ZWTjRMMDVTYUdWT1VXMDJTVVl5VDNoU1Z6QjFaMWM0V0ZwMmRtSlROVFJ3SWl3aWIzZHVaWEpKWkNJNklqUXdOemMxTnpnMU5USWlMQ0poZFdRaU9pSlNiMkpzYjNoSmJuUmxjbTVoYkNJc0ltbHpjeUk2SWtOc2IzVmtRWFYwYUdWdWRHbGpZWFJwYjI1VFpYSjJhV05sSWl3aVpYaHdJam94TnpNeE5qSTBNRGM0TENKcFlYUWlPakUzTXpFMk1qQTBOemdzSW01aVppSTZNVGN6TVRZeU1EUTNPSDAuS2xoZS1mbnR2dU0yMUJ5cTV3NTFVM2E5clpRcVNzeU94M1RIZEJWOW1oZm4tY095eTNrVllBWWI0RU4zUy00WVlmMU1rYnZ6WUhUekxZM0ZtczhUc3NZRm03ZlBzQ2tFMXNGYVlCeVVpZmh4MlRQcTh1WlhIOXd1T3o4Z2NYOFZZN2ZGRjZqMlI4NEh2R0Y2TFh4N3FnUVROU3NkN0pkOERLSmZjN0dSbEJWTXJodzJMWlc3YS1OaWJ3a3I5S2tOM21HWHJNYUtwMVAtQWdZR3NYRnRFZGMzcW9TZTFYWGs0M2RXM1dZWXphbHNXMWZlN1MzUmJfaXRNa2lvaUs1Z29ZWTdaZk1tdHJmZEJQaXRwMzUwYmpkLXllWWs2WUdNeVB0MUJjM3ZkV2FEZlJXWmFIdEtULWI4R21uUVJLTjlJaUdQMDZ4TEcybWFFZElfWGROdFRR"

local headers = {
    ["x-api-key"] = API_KEY,
    ["Content-Type"] = "application/octet-stream"  -- Set the correct content type for binary data
}
local net = require("@lune/net")
 
local counter = 0
net.serve(8080, function()
	counter += 1
	return {
		status = 200,
		body = "Hello! This is response #" .. tostring(counter),
	}
end)
 
print("Listening on port 8080 🚀")
local success, response = pcall(function()
    local apiResponse = net.request({
        url = apiUrl,
        method = "POST",
        headers = headers,
    })

    if not apiResponse.ok then
        error(
            string.format(
                "%s\n%d (%s)\n%s",
                "Failed to send network request!",
                apiResponse.statusCode,
                apiResponse.statusMessage,
                apiResponse.body
            )
        )
    end

    return apiResponse.body
end)
if success then
    print("Response: ", response)
else
    print("Error: ", response)
end
