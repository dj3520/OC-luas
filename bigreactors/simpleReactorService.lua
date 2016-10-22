-- Runs a BigReactors reactor based on how full it's internal battery is.

local component = require("component")
local term = require("term")
local reactor = component.br_reactor

-- Config settings. Feel free to change!
local ignoreTop = 90 -- At this level, reactor will shut down and stay off until levels drop again


local function reactAI()
  perc = reactor.getEnergyStored() / 100000 -- Max is actually 10,000,000 but convert to percent!
  if perc > ignoreTop then
    react.setActive(false)
    react.setAllControlRodLevels(100)
  else
    react.setActive(true)
    react.setAllControlRodLevels(perc)
  end
end

local function doloop()
  reactorAI()
  if running == true then 
    event.timer(1, doloop)
  end
end

function stop()
  print("Simple reactor control service stopping.")
  running = false
  reactor.setActive(false)
end

function start()
  running = true
  print("Simple reactor control service running.")
  event.timer(1, doloop)
end