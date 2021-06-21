ESX = nil
TriggerEvent("esx:getSharedObject", function(obj) 
    ESX = obj 
end)
ESX.RegisterServerCallback('getrole', function(source, cb)
    MySQL.Async.fetchAll('SELECT * FROM labos', {}, function(result)
        cb(result)  
    end)
end)
RegisterNetEvent('labo:buy')
AddEventHandler('labo:buy', function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)

    MySQL.Async.fetchAll("SELECT * FROM labos WHERE identifier = @a", {
        ["a"] = xPlayer.identifier
    }, function(result)
            if result[1] then
                TriggerClientEvent('labo:main', _src, true)
                print('buymenu')
            else        
                MySQL.Async.insert("INSERT INTO labos (identifier,name,buy) VALUES (@a,@b,@c)", {
                    ["a"] = xPlayer.identifier, ["b"] = GetPlayerName(_src), ["c"] = "2"
                }, function()
                end)
                TriggerClientEvent('message:labo', _src, "~g~Vous venez d'acheter un laboratoire")
                TriggerClientEvent('labo:main', _src, true)
                

            end
        end)

end)

RegisterNetEvent('request:labmenu')
AddEventHandler('request:labmenu', function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    MySQL.Async.fetchAll("SELECT * FROM labos WHERE identifier = @a", {
        ["a"] = xPlayer.identifier
    }, function(result)
            if result[1] then
                TriggerClientEvent('labo:openMenu', _src, true)
            else
                TriggerClientEvent('labo:openMenu', _src, false)
            end
        end)
end)
RegisterNetEvent('request:loca')
AddEventHandler('request:loca', function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    MySQL.Async.fetchAll("SELECT * FROM labos WHERE proprietaire = @a", {
        ["a"] = xPlayer.identifier
    }, function(result)
            if result[1] then
                TriggerClientEvent('labo:openMenu', _src, true)
            else
                TriggerClientEvent('labo:openMenu', _src, false)
            end
        end)
end)
RegisterNetEvent('give:key')
AddEventHandler('give:key', function(target)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local target = GetPlayerIdentifier(target)
    MySQL.Async.fetchAll("SELECT * FROM labos WHERE proprietaire, buy = @a,@b", {
        ["a"] = target, ["b"] = "1"
    }, function(result)
            if result[1] then
                TriggerClientEvent('message:labo', _src, "~r~Cette personne a déjà une paire des clef.")
            else
                MySQL.Async.insert("INSERT INTO labos (proprietaire,buy) VALUES (@a,@b)", {
                    ["a"] = target, ["b"] = "1"
                }, function()
                end)
                TriggerClientEvent('message:labo', _src, "~g~Vous venez de donner une paire de clef a une personne.")
            end
        end)
end)

RegisterServerEvent('getStockItems')
AddEventHandler('getStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
    local inv ={}
    for k,v in pairs(xPlayer.getInventory()) do
    print(xPlayer.getInventory())
    inv[k] = {v.name, v.count}
    end
end)