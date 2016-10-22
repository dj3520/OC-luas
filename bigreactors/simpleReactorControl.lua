-- Runs a BigReactors reactor based on how full it's internal battery is.

local component = require("component")
local react = component.br_reactor

-- Config settings. Feel free to change!
local ignoreTop = 90 -- At this level, reactor will shut down and stay off until levels drop again

while true do
  perc = reactor.getEnergyStored() / 100000 -- Max is actually 10,000,000 but convert to percent!
  if perc > ignoreTop then
    react.setActive(false)
    react.setAllControlRodLevels(100)
  else
    react.setActive(true)
    react.setAllControlRodLevels(perc)
  end
end