--settings.startup["fb-spawn-planet"].value = "nauvis"
local setting = data.raw["string-setting"]["fb-spawn-planet"]
local remove = {}
setting.allowed_values = {"nauvis"}
for _, value in ipairs(setting.allowed_values) do
    if value == "aquilo" or value == "both" then
        remove[value] = _
    end    
end
for _, value in ipairs(remove) do
    setting.allowed_values[_] = nil
end
setting.default_value = "nauvis"