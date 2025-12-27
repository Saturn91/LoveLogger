--[[
main.lua:
This example will directly crash on execution (because of the Log.error) and create a "log.log" file on crash
--]]

-- Now you can require modules from the submodule
Log = require("loveLogger.Log")

function love.load()
    Log.init({
        onError = onError,          -- optional on error handler
        logFilePath = "log.log"     -- override default log file name
    })
    Log.log("game initialized")
end

function love.update(dt)
    Log.log("update")
    local player = {
        x = 1,
        y = 2,
        hp = 10,
        inventory = { "dagger", "apple" }
    }
    Log.log(player)
    Log.warn("a warning")
    Log.error("an error")
end

function onError()
    Log.log("optional error handler, for additional logic")
end