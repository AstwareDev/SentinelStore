local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Library = {}
local Notification_Library = loadstring(request({Url = "https://github.com/ScripterTSBG/Notification-System/raw/refs/heads/main/notification.lua", Method = 'GET'}).Body)()

Library.AccessKey = "PlaceHolder@Secret"
Library.API = "https://astware-sentinelapi.vercel.app/"

local Signal = {}
Signal.__index = Signal

function Signal.new()
    return setmetatable({ _binds = {} }, Signal)
end

function Signal:Connect(fn)
    table.insert(self._binds, fn)
    return {
        Disconnect = function()
            for i, v in ipairs(self._binds) do
                if v == fn then
                    table.remove(self._binds, i)
                    break
                end
            end
        end
    }
end

function Signal:Fire(...)
    for _, fn in ipairs(self._binds) do
        task.spawn(fn, ...)
    end
end

Library.OnDataReceived = Signal.new()

function Library.SetAccessKey(target)
    if typeof(target) ~= "string" then
        Notification_Library.createNotification("Error", "AccessKey must be a string", 5)
        return false
    end
    if target == "" or target == nil then
        Notification_Library.createNotification("Error", "AccessKey can't be nil", 5)
        return false
    end
    Library.AccessKey = target
    return true
end

function Library.Send(data)
    if typeof(Library.AccessKey) ~= "string" then
        Notification_Library.createNotification("Error", "AccessKey must be a string", 5)
        return false
    elseif Library.AccessKey == "" or Library.AccessKey == nil then
        Notification_Library.createNotification("Error", "AccessKey can't be nil", 5)
        return false
    end
    local res = request({
        Url = Library.API.."/send",
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = HttpService:JSONEncode({
            accessKey = Library.AccessKey,
            data = data
        })
    })
    return HttpService:JSONDecode(res.Body)
end

function Library.LatestData()
    if typeof(Library.AccessKey) ~= "string" then
        Notification_Library.createNotification("Error", "AccessKey must be a string", 5)
        return false
    elseif Library.AccessKey == "" or Library.AccessKey == nil then
        Notification_Library.createNotification("Error", "AccessKey can't be nil", 5)
        return false
    end
    local res = request({
        Url = Library.API.."/latest",
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = HttpService:JSONEncode({
            accessKey = Library.AccessKey
        })
    })
    return HttpService:JSONDecode(res.Body)
end

function Library.AllData()
    if typeof(Library.AccessKey) ~= "string" then
        Notification_Library.createNotification("Error", "AccessKey must be a string", 5)
        return false
    elseif Library.AccessKey == "" or Library.AccessKey == nil then
        Notification_Library.createNotification("Error", "AccessKey can't be nil", 5)
        return false
    end
    local res = request({
        Url = Library.API.."/all",
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = HttpService:JSONEncode({
            accessKey = Library.AccessKey
        })
    })
    return HttpService:JSONDecode(res.Body)
end

local function pollLatest()
    local lastId = nil
    while task.wait(2) do
        local success, result = pcall(Library.LatestData)
        if success and result and result._id and result._id ~= lastId then
            lastId = result._id
            Library.OnDataReceived:Fire(result)
        end
    end
end

task.spawn(pollLatest)

return Library
