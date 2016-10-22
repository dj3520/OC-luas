-- Runs a BigReactors reactor based on how full it's internal battery is.

local component = require("component")
local event = require("event")
local shell = require("shell")
local computer = require("computer")
local args, opts = shell.parse(...)
local react = component.br_reactor
local running = true
local perc = 0

-- Config settings. Feel free to change!
local ignoreTop = 90 -- At this level, reactor will shut down and stay off until levels drop again

function doloop()
local function doloop()
  perc = react.getEnergyStored() / 100000 -- Max is actually 10,000,000 but convert to percent!
  if perc > ignoreTop and running then
    react.setActive(false)
    react.setAllControlRodLevels(100)
  elseif running then
    react.setActive(true)
    react.setAllControlRodLevels(perc)
  else react.setActive(false) end
  os.sleep(1)
  computer.pushSignal("simpleReactorService")
end

if args[1] == "start" then
  print("Simple reactor control service running.")
  event.listen("simpleReactorService", doloop)
  running = true
  doloop()
end

if args[1] == "stop" then
  print("Simple reactor control service stopping.")
  event.ignore("simpleReactorService", doloop)
  running = false
end

if args[1] == "perc" then
  print("Percent: "..perc)
end