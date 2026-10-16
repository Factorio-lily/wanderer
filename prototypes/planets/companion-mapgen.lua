
data:extend({
	{
		type = "noise-expression",
		name = "companion_radius",
		expression = 512,
	},

    {
        type = "noise-expression",
        name = "distance_from_center",
        expression = "sqrt(x * x + y * y)",
    },


    {
        type = "noise-expression",
        name = "companion_spikes",
        expression =
        "(companion_radius + len) * max((angle % (360 / num))^2,  ((360-angle + (0.5*360 / num)) % (360 / num))^2) / (360 / num)^2",
        local_expressions = {
            ["num"] = 16,
            ["len"] = 50,
            ["angle"] = "360 * atan2(x, y) / (2 * pi)",
        }
    },


    {
        type = "noise-expression",
        name = "companion_out_of_map",
        expression = "if((max(companion_radius, companion_spikes) - distance_from_center) < 0, 1000, -1000)",
    
    },

    {
        type = "noise-expression",
        name = "companion_artificial",
        expression =
        "if(companion_out_of_map < 0 ,if(max((elevation + 10 > 0),  (min(distance_from_center > companion_radius, companion_out_of_map < 0))), 100, -1000), -1000)",

    },

})
