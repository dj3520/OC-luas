-- Runs a BigReactors reactor based on how full it's internal battery is.

local component = require("component")
local event = require("event")
local react = component.br_reactor

local debug = false

-- Config settings. Feel free to change!
local ignoreTop = 90 -- At this level, reactor will shut down and stay off until levels drop again

local function reactAI()
  perc = react.getEnergyStored() / 100000 -- Max is actually 10,000,000 but convert to percent!
  if perc > ignoreTop then
    react.setActive(false)
    react.setAllControlRodLevels(100)
  else
    react.setActive(true)
    react.setAllControlRodLevels(perc)
  end
  if debug == true then print("Reactor percent: "..perc) end
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

function debug(setting)
  debug = setting
end