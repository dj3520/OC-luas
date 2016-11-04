-- Runs a BigReactors reactor based on how full it's internal battery is.

local component = require("component")
local event = require("event")
local shell = require("shell")
local computer = require("computer")
local react = component.br_reactor
local running = true
local perc = 0

-- Config settings. Feel free to change!
local ignoreTop = 90 -- At this level, reactor will shut down and stay off until levels drop again

local function doloop()
  perc = react.getEnergyStored() / 100000 -- Max is actually 10,000,000 but convert to percent!
  if perc > ignoreTop and running then
    react.setActive(false)
    react.setAllControlRodLevels(100)
    event.timer(1, doloop)
  elseif running then
    react.setActive(true)
    react.setAllControlRodLevels(perc)
    event.timer(1, doloop)
  else react.setActive(false) end
end

function start()
  print("Simple reactor control service running.")
  running = true
  doloop()
end

function stop()
  print("Simple reactor control service stopping.")
  running = false
end

function perc()
  print("Percent: "..perc)
end