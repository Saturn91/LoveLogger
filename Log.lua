require("util.JsonUtil")

local Log = {}
local logFileLines = {}
local prefixLog = "LOG: "
local prefixWarn = "WARN: "
local prefixError = "ERR: "

function Log.init(config)
    config = config or {}
    Log.onError = config.onError
    Log.logFilePath = config.logFilePath or "log.log"
    prefixLog = config.prefixLog or prefixLog
    prefixWarn = config.prefixWarn or prefixWarn
    prefixError = config.prefixError or prefixError

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

    table.insert(logFileLines, prefixLog .. msgStr)
    print(prefixLog .. msgStr)
end

function Log.warn(message)
    table.insert(logFileLines, prefixWarn .. message)
    print(prefixWarn .. message)
end

function Log.error(message)
    table.insert(logFileLines, prefixError .. message .. "\n" .. debug.traceback())
    Log.saveLog()
    error(message)
    
end

function Log.saveLog()
    Log.log("print log file")
    love.filesystem.write(Log.logFilePath, table.concat(logFileLines, "\n"))
end

return Log