# SentinelStore LuaU Client

A lightweight client for interfacing with the SentinelStore API in Roblox exploits. Designed for real-time data exchange between multiple clients using access keys.

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

## Example Usage

```lua
local Store = loadstring(game:HttpGet("https://yourdomain.com/sentinelstore.lua"))()

Store.SetAccessKey("My@SecretKey")

Store.Send({
    name = "Player1",
    level = 42,
    location = "DesertZone"
})

local latest = Store.Latest()
print(latest)

local all = Store.All()
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
