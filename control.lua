
script.on_event(defines.events.on_surface_created, function(event)
    local wanderer = game.planets.wanderer
    local companion = game.planets.companion

    if wanderer.surface then
        if wanderer.surface.index == event.surface_index then
            wanderer.surface.freeze_daytime = true
            wanderer.surface.daytime = 0.5
        end
    end
    if companion.surface then
        if companion.surface.index == event.surface_index then
            companion.surface.freeze_daytime = true
            companion.surface.daytime = 0.5
        end
    end


end)