require("util.JsonUtil")

local Log = {}
local logFileLines = {}

function Log.init(config)
    config = config or {}
    Log.onError = config.onError
    Log.logFilePath = config.logFilePath or "log.log"

    logFileLines = {}
    
    if Log.onError then
        Log.onError()
    end
end

function Log.log(message)
    local msgStr = ""
    if type(message) == "table" then
        msgStr = json.stringify(message)
    else
        msgStr = tostring(message)
    end

    table.insert(logFileLines, "LOG : " .. msgStr)
    print("LOG: " .. msgStr)
end

function Log.warn(message)
    table.insert(logFileLines, "WARN: " .. message)
    print("WARNING: " .. message)
end

function Log.error(message)
    table.insert(logFileLines, "ERR : " .. message .. "\n" .. debug.traceback())
    Log.saveLog()
    error(message)
    
end

function Log.saveLog()
    Log.log("print log file")
    love.filesystem.write(Log.logFilePath, table.concat(logFileLines, "\n"))
end

return Log