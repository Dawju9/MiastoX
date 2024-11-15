-- serialize.lua
local game = workspace -- lub inne obiekty, które chcesz serializować
local serialized = lune.serialize(game)
local file = io.open("game.rbxl", "wb")
file:write(serialized)
file:close()
