lib.callback.register("cdn-wiretap:scanRadioChannels", function(source)
    local src = source
    local channels = {}

    if Config.itemCheck then
        local scanner = exports.ox_inventory:Search(src, 'count', Config.scanRadioChannelsItem)
        if not scanner or scanner < 1 then
            return channels
        end
    end

    local pCoords = GetEntityCoords(GetPlayerPed(src))
    local myPlayerPed = GetPlayerPed(src)

    for _, player in ipairs(GetActivePlayers()) do
        local dist = #(pCoords - GetEntityCoords(GetPlayerPed(player)))

        if player ~= src then
            if dist <= Config.ScanRadius then
                local playerPed = GetPlayerPed(player)
                local radioChannel = Player(player).state.radioChannel

                if radioChannel ~= 0 then
                    local min = radioChannel - math.random(10, Config.ScanRangeAccuracyMin * 10) / 10
                    local max = radioChannel + math.random(10, Config.ScanRangeAccuracyMax * 10) / 10

                    channels[radioChannel] = { min = min, max = max }
                end
            else
                TriggerClientEvent('cdn-wiretap:dcRadio', src)
            end
        end
    end

    return channels
end)

lib.callback.register("cdn-wiretap:scanPhoneCalls", function(source)
    local src = source
    local calls = {}

    if Config.itemCheck then
        local scanner = exports.ox_inventory:Search(src, 'count', Config.scanPhoneCallsItem)
        if not scanner or scanner < 1 then
            return calls
        end
    end

    local pCoords = GetEntityCoords(GetPlayerPed(src))

    for _, player in ipairs(GetActivePlayers()) do
        local dist = #(pCoords - GetEntityCoords(GetPlayerPed(player)))

        if player ~= src then
            if dist <= Config.ScanRadius then
                local playerPed = GetPlayerPed(player)
                local callChannel = Player(player).state.callChannel

                if callChannel ~= 0 then
                    local min = callChannel - math.random(10, Config.ScanRangeAccuracyMin * 10) / 10
                    local max = callChannel + math.random(10, Config.ScanRangeAccuracyMax * 10) / 10

                    calls[callChannel] = { min = min, max = max }
                end
            else
                TriggerClientEvent('cdn-wiretap:dcPhone', src)
            end
        end
    end

    return calls
end)
