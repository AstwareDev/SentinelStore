# SentinelStore LuaU Client

A lightweight client for interfacing with the SentinelStore API in Roblox exploits. Designed for real-time data exchange between multiple clients using access keys.

[Preview](https://raw.githubusercontent.com/AstwareDev/SentinelStore/refs/heads/main/image%20(5).png)

## Features

* Send data (only strings and numbers)
* Retrieve the latest entry for your access key
* Fetch all entries tied to your access key
* Automatically discards entries older than 2 hours
* Lightweight and simple integration

## API Endpoints

* `POST /send` — Save data
* `POST /latest` — Get most recent data
* `POST /all` — Get all data
* All endpoints require an `accessKey` in the body

## Installation
```lua
local SentinelStore = loadstring(request({Url = "https://github.com/AstwareDev/SentinelStore/raw/refs/heads/main/SentinelStore_Library.lua", Method = 'GET'}).Body)()
SentinelStore.SetAccessKey("My@SecretKey")
```

## Example Usage

```lua
local SentinelStore = loadstring(request({Url = "https://github.com/AstwareDev/SentinelStore/raw/refs/heads/main/SentinelStore_Library.lua", Method = 'GET'}).Body)()
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

## Access Key Rules

* Must be a string
* Cannot be an instance or non-serializable value
* Each key stores its own data securely

## Requirements

* Executor with `request` support
* JSON-compatible data (only strings and numbers)

## Hosting

The API is deployed on Vercel and uses MongoDB Atlas for data storage. Data older than 2 hours is purged automaticall.
