

local empty = table.deepcopy(data.raw["tile"]["empty-space"])
empty.name = "companion-empty-space"
empty.autoplace = {
    probability_expression = "companion_out_of_map",
    richness_expression = "companion_out_of_map"
}
local artificial = table.deepcopy(data.raw["tile"]["space-platform-foundation"])
artificial.name = "companion-artificial-tile"
artificial.autoplace = {
    probability_expression = "artificial",
    richness_expression = "artificial"
}
artificial.minable = nil

data:extend({
---@diagnostic disable-next-line: assign-type-mismatch
    empty, artificial
})