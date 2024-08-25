local player_base_speeds = {}

local function set_speed(player)
    local name = player:get_player_name()
    local controls = player:get_player_control()
    local current_physics = player:get_physics_override()
    local base_speed = player_base_speeds[name] or 1.0

    if controls.aux1 then
        player:set_physics_override({speed = base_speed + 0.9})
    else
        player:set_physics_override({speed = base_speed})
    end
end

minetest.register_globalstep(function(dtime)
    for _, player in ipairs(minetest.get_connected_players()) do
        local name = player:get_player_name()
        if not player_base_speeds[name] then
            player_base_speeds[name] = player:get_physics_override().speed or 1.0
        end
        set_speed(player)
    end
end)
