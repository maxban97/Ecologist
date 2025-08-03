local pollution_triggered = false
local nests_destroyed = 0

script.on_event(defines.events.on_entity_damaged, function(event)
  if event.cause and event.cause.force.name == "enemy"
     and event.entity.type == "player" then
    if event.entity.surface.get_pollution(event.entity.position) > 0 then
      pollution_triggered = true
    end
  end
end)

script.on_event(defines.events.on_entity_died, function(event)
  if event.entity and event.entity.type == "unit-spawner"
     and event.entity.force.name == "enemy" then
    nests_destroyed = nests_destroyed + 1
  end
end)

script.on_event(defines.events.on_rocket_launched, function(event)
  if not pollution_triggered and nests_destroyed == 0 then
    local player = game.get_player(event.player_index or 1)
    if player then
      player.unlock_achievement("ecologist-no-pollution-trigger")
    end
  end
end)
