--data.lua
local asteroid_util = require("__space-age__.prototypes.planet.asteroid-spawn-definitions")
require("prototypes.planets.wanderer")

data.extend({
{
    type = "surface-property",
    name = "cosmic-shielding",
    default_value = 0.0,
    order = "j[cs]",
}})


local meld = require("meld")

--START MAP GEN
function MapGen_Wanderer()
    local map_gen_setting = table.deepcopy(data.raw.planet.aquilo.map_gen_settings) or {}
    meld.meld(map_gen_setting.property_expression_names,
    {
        
        ["entity:calcite:probability"] = "vulcanus_calcite_probability",
        ["entity:calcite:richness"] = "vulcanus_coal_richness",
        ["entity:coal:probability"] = "vulcanus_calcite_probability",
        ["entity:coal:richness"] = "vulcanus_coal_richness",
    })
    meld.meld(map_gen_setting.autoplace_controls, 
{
        
        ["wanderer_frost_enemy_base"] = { frequency = 2, size = 1.25, richness = 1.25 },
        ["coal"] = { frequency = 2, size = 1, richness = 0.75},
        ["crude-oil"] = { frequency = 1.25, size = 1, richness = 1},
        ["water"] = { frequency = 1.75, size = 1.75, richness = 1.75},
        ["nauvis_cliff"] = { frequency = 0.75, size = 1, richness = 1},
        ["vulcanus_volcanism"] = {},
        ["calcite"] = { frequency = 1, size = 2, richness = 2 },
        
    })


    meld.meld(map_gen_setting.autoplace_settings["tile"],
    {
        settings =
        {
            ["sand-1"] = {},
            ["sand-2"] = {},
            ["sand-3"] = {},
            ["red-desert-0"] = {},
            ["red-desert-1"] = {},
            ["red-desert-2"] = {},
            ["red-desert-3"] = {},
            ["water"] = {},
            ["deepwater"] = {},

          --nauvis tiles
          ["volcanic-soil-dark"] = {},
          ["volcanic-soil-light"] = {},
          ["volcanic-ash-soil"] = {},
          --end of nauvis tiles
          ["volcanic-ash-flats"] = {},
          ["volcanic-ash-light"] = {},
          ["volcanic-ash-dark"] = {},
          ["volcanic-cracks"] = {},
          ["volcanic-cracks-warm"] = {},
          ["volcanic-folds"] = {},
          ["volcanic-folds-flat"] = {},
          ["lava"] = {},
          ["lava-hot"] = {},
          ["volcanic-folds-warm"] = {},
          ["volcanic-pumice-stones"] = {},
          ["volcanic-cracks-hot"] = {},
          ["volcanic-jagged-ground"] = {},
          ["volcanic-smooth-stone"] = {},
          ["volcanic-smooth-stone-warm"] = {},
          ["volcanic-ash-cracks"] = {},
        }
    })

    meld.meld(
    map_gen_setting.autoplace_settings["decorative"],
    {
      settings =
      {
        -- end of nauvis
        ["vulcanus-rock-decal-large"] = {},
        ["vulcanus-crack-decal-large"] = {},
        ["vulcanus-crack-decal-huge-warm"] = {},
        ["vulcanus-dune-decal"] = {},
        ["vulcanus-sand-decal"] = {},
        ["vulcanus-lava-fire"] = {},
        ["calcite-stain"] = {},
        ["calcite-stain-small"] = {},
        ["sulfur-stain"] = {},
        ["sulfur-stain-small"] = {},
        ["sulfuric-acid-puddle"] = {},
        ["sulfuric-acid-puddle-small"] = {},
        ["crater-small"] = {},
        ["crater-large"] = {},
        ["pumice-relief-decal"] = {},
        ["small-volcanic-rock"] = {},
        ["medium-volcanic-rock"] = {},
        ["tiny-volcanic-rock"] = {},
        ["tiny-rock-cluster"] = {},
        ["small-sulfur-rock"] = {},
        ["tiny-sulfur-rock"] = {},
        ["sulfur-rock-cluster"] = {},
        ["waves-decal"] = {},
      }
    })

    meld.meld(
    map_gen_setting.autoplace_settings["entity"],
    {
        settings =
        {
        ["calcite"] = {},
        ["coal"] = {},
        ["crude-oil"] = {},
        ["huge-volcanic-rock"] = {},
        ["big-volcanic-rock"] = {},
        ["crater-cliff"] = {},
        }
    })
     

    return map_gen_setting
end


function MapGen_Companion()
    local map_gen_setting = table.deepcopy(data.raw.planet.aquilo.map_gen_settings) or {}
    

    local tiles = map_gen_setting.autoplace_settings["tile"]
    tiles.settings["ammoniacal-ocean"] = nil
    tiles.settings["ammoniacal-ocean-2"] = nil
    tiles.settings["brash-ice"] = nil
    tiles.settings["ice_rough"] = nil
    tiles.settings["ice_smooth"] = nil


    return map_gen_setting
end



-- increse stone patch size in start area
-- data.raw["resource"]["stone"]["autoplace"]["starting_area_size"] = 5500 * (0.005 / 3)

--END MAP GEN

local nauvis = data.raw["planet"]["nauvis"]
local planet_lib = require("__PlanetsLib__.lib.planet")

local start_astroid_spawn_rate =
{
  probability_on_range_chunk =
  {
    {position = 0.1, probability = asteroid_util.nauvis_chunks, angle_when_stopped = asteroid_util.chunk_angle},
    {position = 0.9, probability = asteroid_util.nauvis_chunks, angle_when_stopped = asteroid_util.chunk_angle}
  },
  type_ratios =
  {
    {position = 0.1, ratios = asteroid_util.nauvis_ratio},
    {position = 0.9, ratios = asteroid_util.nauvis_ratio},
  }
}
local start_astroid_spawn = asteroid_util.spawn_definitions(start_astroid_spawn_rate, 0.1)


local wanderer = 
{
    type = "planet",
    name = "wanderer", 
    solar_power_in_space = 1,
    icon = "__wanderer__/graphics/planet-wanderer.png",
    icon_size = 512,
    label_orientation = 0.55,
    starmap_icon = "__wanderer__/graphics/planet-wanderer.png",
    starmap_icon_size = 512,
    magnitude = nauvis.magnitude,
    surface_properties = {
        ["solar-power"] = 0,
        ["pressure"] = 1000,
        ["magnetic-field"] = 80,
        ["day-night-cycle"] = 0,
        ["gravity"] = 20,
        ["temperature"] = 100,
        ["cosmic-shielding"] = 60

    },
    entities_require_heating = true,
    map_gen_settings = MapGen_Wanderer(),
    asteroid_spawn_influence = 1,
    asteroid_spawn_definitions = start_astroid_spawn,
    pollutant_type = "pollution",
    subgroup = data.raw["planet"]["nauvis"].subgroup,
    draw_orbit = false,
    gravity_pull = 100
}

wanderer.orbit = {
    parent = {
        type = "space-location",
        name = "solar-system-edge",
    },
    distance = 150,
    orientation = 0.3,
    sprite = util.empty_sprite()
}

local wanderer_connection = {
    type = "space-connection",
    name = "solar-system-edge-e-wanderer",
    from = "solar-system-edge",
    to = "wanderer",
    length = 200000,
    asteroid_spawn_definitions = data.raw["space-connection"]["aquilo-solar-system-edge"].asteroid_spawn_definitions
  }

PlanetsLib.borrow_music(data.raw["planet"]["aquilo"], wanderer)
--PlanetsLib.borrow_music(data.raw["planet"]["vulcanus"], wanderer)

PlanetsLib:extend({wanderer})


data:extend{wanderer_connection}


local companion = 
{
    type = "planet",
    name = "companion", 
    solar_power_in_space = 1,
    subgroup = "satellites",
    icon = "__wanderer__/graphics/moon-companion.png",
    icon_size = 512,
    label_orientation = 0.55,
    starmap_icon = "__wanderer__/graphics/moon-companion.png",
    starmap_icon_size = 512,
    magnitude = nauvis.magnitude / 2,
    surface_properties = {
        ["solar-power"] = 0,
        ["pressure"] = 500,
        ["magnetic-field"] = 110,
        ["day-night-cycle"] = 0,
        ["gravity"] = 1,
        ["temperature"] = 50,
        ["cosmic-shielding"] = 100

    },
    entities_require_heating = true,
    map_gen_settings = MapGen_Companion(),
    asteroid_spawn_influence = 1,
    asteroid_spawn_definitions = start_astroid_spawn,
    lightning_properties = meld.meld(table.deepcopy(data.raw.planet.fulgora.lightning_properties), {
        lightnings_per_chunk_per_tick = 1 / (60 * 300), --cca once per chunk every 10 seconds (600 ticks)
        search_radius = 30.0,
    })
}

companion.orbit = {
    parent = {
        type = "planet",
        name = "wanderer",
    },
    distance = 2,
    orientation = 0.123553,
    sprite = {
        type = "sprite",
        filename = "__wanderer__/graphics/orbits/orbit.png",
        size = 515,
        scale = 0.25,
    }
}

local companion_connection = {
    type = "space-connection",
    name = "wanderer-companion",
    from = "wanderer",
    to = "companion",
    length = 1000,
    asteroid_spawn_definitions = data.raw["space-connection"]["nauvis-fulgora"].asteroid_spawn_definitions
}

PlanetsLib:extend({companion})

data:extend({companion_connection})


local icons = util.technology_icon_constant_planet("__wanderer__/graphics/planet-wanderer.png")
icons[1].icon_size = 512

data:extend {{
    type = "technology",
    name = "planet-discovery-wanderer",
    icons = icons,
    icon_size = 512,
    essential = true,
    localised_description = {"space-location-description.wanderer"},
    effects = {
        {
            type = "unlock-space-location",
            space_location = "wanderer",
            use_icon_overlay_constant = true
        },
        {
            type = "unlock-space-location",
            space_location = "companion",
            use_icon_overlay_constant = true
        }
    },
    prerequisites = {
        "promethium-science-pack",
    },
    unit = {
        count = 5000,
        ingredients = {
            {"automation-science-pack",      1},
            {"logistic-science-pack",        1},
            {"chemical-science-pack",        1},
            {"space-science-pack",           1},
            { "production-science-pack",   1 },
            { "utility-science-pack",   1 },
            { "metallurgic-science-pack",   1 },
            { "electromagnetic-science-pack",   1 },
            { "agricultural-science-pack",   1 },
            { "cryogenic-science-pack",   1 },
            { "promethium-science-pack",        1 },
        },
        time = 60,
    },
    order = "ea[wanderer]",
}}


