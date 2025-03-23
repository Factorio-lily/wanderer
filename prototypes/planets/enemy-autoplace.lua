local control_name = "wanderer_frost_enemy_base"
    data:extend({
      {
        type = "autoplace-control",
        name = control_name,
        richness = false, --??
        order = "maw",
        category = "enemy",
        can_be_disabled = false
      },
      {
        type = "noise-expression",
        name = "cb_enemy_base_radius",
        expression = "sqrt(var('control:"..control_name..":size')) * (15 + 4 * enemy_base_intensity)"
        },
        {
        type = "noise-expression",
        name = "cb_enemy_base_frequency",
        -- bases_per_km2 = 10 + 3 * enemy_base_intensity
        expression = "(0.00002 + 0.000003 * enemy_base_intensity) * var('control:"..control_name..":frequency')"
        },
        {
        type = "noise-expression",
        name = "cb_enemy_base_probability",
        expression = "spot_noise{x = x,\z
                     y = y,\z
                     density_expression = spot_quantity_expression * max(0, cb_enemy_base_frequency),\z
                     spot_quantity_expression = spot_quantity_expression,\z
                     spot_radius_expression = spot_radius_expression,\z
                     spot_favorability_expression = 1,\z
                     seed0 = map_seed,\z
                     seed1 = 735155,\z
                     region_size = 512,\z
                     candidate_point_count = 100,\z
                     hard_region_target_quantity = 0,\z
                     basement_value = -1000,\z
                     maximum_spot_basement_radius = 128} + \z
                (blob(1/8, 1) + blob(1/24, 1) + blob(1/64, 2) - 0.5) * spot_radius_expression / 150 * \z
                (0.1 + 0.9 * clamp(distance / 3000, 0, 1)) - 0.3 + min(0, 20 / starting_area_radius * distance - 20)",
        local_expressions =
        {
          spot_radius_expression = "max(0, cb_enemy_base_radius)",
          spot_quantity_expression = "pi/90 * spot_radius_expression ^ 3"
        },
        local_functions =
        {
          blob =
          {
          parameters = {"input_scale", "output_scale"},
          expression = "basis_noise{x = x, y = y, seed0 = map_seed, seed1 = 735155, input_scale = input_scale, output_scale = output_scale}"
          }
        }
        },
        {
        type = "noise-function",
        name = "cb_enemy_autoplace_base",
        parameters = {"distance_factor", "seed"},
        expression = "random_penalty{x = x + seed,\z
                       y = y,\z
                       source = min(cb_enemy_base_probability * max(0, 1 + 0.004 * distance_factor * (-312 * distance_factor - starting_area_radius + distance)),\z
                              0.25 + distance_factor * 0.05),\z
                       amplitude = 0.1}"
    },
})
