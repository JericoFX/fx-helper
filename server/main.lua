local ox_inventory = exports.ox_inventory


CreateThread(function()
    Wait(100)
    for k, v in pairs(Config.Job) do
        local el = Config.Job[k]
        if type(el.stash) == "table" then
            for i = 1, #el.stash do
                local wa = el.stash[i]
                ox_inventory:RegisterStash(el.id .. i, el.label .. " " .. i, 1000, 900000, false, el.job, wa)
            end
        else
            ox_inventory:RegisterStash(el.id, el.label, 1000, 900000, false, el.job, el.stash)
        end
        if el.shop then
            ox_inventory:RegisterShop(k, {
                name = el.shop.name,
                inventory = el.shop.inventory,
                locations = el.shop.locations,
                groups = false
            })
        end
        Wait(0)
    end
    for k, v in pairs(Config.Gangs) do
        local el = Config.Gangs[k]
        ox_inventory:RegisterStash(el.id, el.label, 20, 900000, false, el.gang, el.coords)
        if el.shop then
            ox_inventory:RegisterShop(k, {
                name = el.shop.name,
                inventory = el.shop.inventory,
                locations = el.shop.locations,
                groups = false
            })
        end
        Wait(0)
    end
end)
