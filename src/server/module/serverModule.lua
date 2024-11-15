local Server = {}

function Server:new()
    local instance = setmetatable({}, { __index = Server })
    instance.name = "Example Server"
    instance.port = 8080
    instance.clients = {}
    return instance
end

function Server:start()
    print("Server started on port " .. self.port)
    -- Start listening for incoming connections
end

function Server:stop()
    print("Server stopped")
    -- Stop listening for incoming connections
end

function Server:handleClient(client)
    table.insert(self.clients, client)
    print("Client connected")
    -- Handle client communication
end

function Server:broadcast(message)
    for _, client in ipairs(self.clients) do
        -- Send message to client
    end
end

function Server:sendToClient(client, message)
    -- Send message to specific client
end

function Server:disconnectClient(client)
    -- Disconnect client
end

function Server:getClientCount()
    return #self.clients
end

function Server:getClientList()
    return self.clients
end

function Server:isClientConnected(client)
    for _, c in ipairs(self.clients) do
        if c == client then
            return true
        end
    end
    return false
end

return Server