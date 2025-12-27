# LoveLogger

This Repo contains code for games / applications buidl with Love2d. Specifically for a logging system.

The system supports Log files.

# Basic usage

```lua
Log.log("I am a normal log line")
Log.warn("this is a warning")
Log.error("this is an error and will crash the game")
```

All of these messages will get stored in a file (default `log.log`) in the games `%appdata%`. If an error is logged the game will crash (luas default `error(...)` will get called) but right before that the logfile will be saved.

# Setup

I recommend importing this repository as a git submodule.

1. `git submodule add https://github.com/Saturn91/LoveLogger.git libs/loveLogger`
2. in order to allow relative imports use this handy code:

```lua
local packages = {
  "libs/loveLogger/?.lua",
}

local current = love.filesystem.getRequirePath and love.filesystem.getRequirePath() or "?.lua;"
love.filesystem.setRequirePath(table.concat(packages, ";") .. ";" .. current)
```

example main.lua:

```lua
-- [[
main.lua:

This example will directly crash on execution (because of the Log.error) and create a "log.log" file on crash
--]]

-- list your submodules here
local packages = {
  "libs/loveLogger/?.lua",
}

-- fix imports in submodules
local current = love.filesystem.getRequirePath and love.filesystem.getRequirePath() or "?.lua;"
love.filesystem.setRequirePath(table.concat(packages, ";") .. ";" .. current)

-- Now you can require modules from the submodule
Log = require("loveLogger.Log")

function love.load()
    Log.init({
        onError = onError           -- optional on error handler
        logFilePath = "log.log"     -- override default log file name
    })
    Log.log("game initialized")
end

function Love.update(dt)
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
    Log.log("optional quit handler, for additional logic")
end
```