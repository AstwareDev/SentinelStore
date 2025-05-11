# SentinelStore LuaU Client

A lightweight client for interfacing with the SentinelStore API in Roblox exploits. Designed for real-time data exchange between multiple clients using access keys.

![Preview](https://raw.githubusercontent.com/AstwareDev/SentinelStore/refs/heads/main/image%20(5).png)

## Features

- Send data (supports strings and numbers)  
- Retrieve the latest entry for your access key  
- Fetch all entries associated with your access key  
- Automatically discards entries older than 2 hours  
- Lightweight and easy to integrate  
- Supports `.OnDataReceived(callback)` like RemoteEvents

## API Endpoints

All endpoints require an `accessKey` in the body.

- `POST /send` — Save data  
- `POST /latest` — Get most recent entry  
- `POST /all` — Get all entries

## Installation

```lua
local SentinelStore = loadstring(request({
    Url = "https://raw.githubusercontent.com/AstwareDev/SentinelStore/refs/heads/main/SentinelStore.lua",
    Method = "GET"
}).Body)()

SentinelStore.SetAccessKey("My@SecretKey")
```

## OnDataReceived

The callback will run whenever new data is detected. This works like `.OnServerEvent` and polls every second for new changes.

```lua
SentinelStore.OnDataReceived:Connect(function(data)
    print("New data received!")
    print(data)
end)
```

## Example Usage

```lua
local SentinelStore = loadstring(request({
    Url = "https://raw.githubusercontent.com/AstwareDev/SentinelStore/refs/heads/main/SentinelStore.lua",
    Method = "GET"
}).Body)()

SentinelStore.SetAccessKey("My@SecretKey")

SentinelStore.Send({
    name = "Player1",
    level = 42,
    location = "DesertZone"
})

local latest = SentinelStore.Latest()
print(latest)

local all = SentinelStore.All()
for i, entry in ipairs(all) do
    print(entry)
end
```

## Access Key Requirements

* Must be a string
* Cannot be nil or empty
* Cannot be an Instance or unsupported value
* Each access key has isolated storage

## Requirements

* Executor with `request` support
* JSON-compatible data only (strings and numbers)

## Hosting Info

SentinelStore API is hosted on **Vercel** and uses **MongoDB Atlas** for backend storage.
Old data (over 2 hours) is automatically deleted to keep things fast and clean.
