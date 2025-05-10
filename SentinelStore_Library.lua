local HttpService = game:GetService("HttpService")
local Library = {}
local Notification_Library = loadstring(request({Url = "https://github.com/ScripterTSBG/Notification-System/raw/refs/heads/main/notification.lua", Method = 'GET'}).Body)()

Library.AccessKey = "PlaceHolder@Secret"
Library.API = "https://astware-sentinelapi.vercel.app/"

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
    local res = syn.request({
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
    local res = syn.request({
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
    local res = syn.request({
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

return Library
