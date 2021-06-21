ESX = nil 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('pos', function()
    local pos = GetEntityCoords(PlayerPedId())
    print(pos.x..', '..pos.y..', '..pos.z)
end)

local weedentry = {
        { ballas = vector3(119.49, -1994.05, 17.35)}
        
}
local exit = {
    { exit1 = vector3(1065.86, -3183.37, -40.16)}
}
local coffre = {
    { cff1 = vector3(1036.37, -3204.36, -39.07)}
}
mdr = false
local open = false
local LaundererMenu = RageUI.CreateMenu("Laboratoire", "Choix :")
RegisterNetEvent('message:labo')
AddEventHandler('message:labo', function(message)
    ESX.ShowNotification(message)
end)
---------------------------------------------------------------------------------------------------------------------------
--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||-----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
function openMenu(allow)
    if open then 
        open = false 
        RageUI.Visible(LaundererMenu,false)
        return
    else
        open = true 
        RageUI.Visible(LaundererMenu, true)

        Citizen.CreateThread(function ()
            while open do 
                RageUI.IsVisible(LaundererMenu, function()
                    if allow then
            
                    RageUI.Button('Entrez le laboratoire', "Selectioner pour ~b~acheter~s~ le laboratoire." , {}, true , {

                        onSelected = function ()
                            SetEntityCoords(PlayerPedId(), 1065.86, -3183.37, -40.16)
                                RageUI.CloseAll()
                                Citizen.SetTimeout(1000, function()
                                    time = false
                                     mdr = true
                                end)
                        end 
                    })
                    else
                        RageUI.Button('Visiter le laboratoire', "Selectioner pour ~b~entrer~s~ dans le laboratoire." , {}, true , {

                            onSelected = function ()
                                SetEntityCoords(PlayerPedId(), 1065.86, -3183.37, -40.16)
                                RageUI.CloseAll()
                                Citizen.SetTimeout(1000, function()
                                    time = false
                                    mdr = false
                                end)
                            end 
                        })
                        RageUI.Button('Acheter le laboratoire', "Selectioner pour ~b~acheter~s~ le laboratoire." , {RightLabel = "~g~14843$"}, true , {
    
                            onSelected = function ()
                                TriggerServerEvent('labo:buy')
                                mdr = false
                                
                                RageUI.CloseAll()

                            end 
                        })
                    end
                
                    
                    if Progress == true then
                        RageUI.PercentagePanel(PercentagePannel, 'Blanchiment en cours', '', '', {}, 2)
                        if PercentagePannel < 1.0 then
                            PercentagePannel = PercentagePannel + 0.0008
                        else
                        
                        end
                    end

                end)

                Wait(0)
            end
        end)


    end
end
prop = false
function OpenMenKey(allow)
    if open then 
        open = false 
        RageUI.Visible(LaundererMenu,false)
        return
    else
        open = true 
        RageUI.Visible(LaundererMenu, true)

        Citizen.CreateThread(function ()
            while open do 
                ESX.TriggerServerCallback('getrole', function(result)
                    for k,v in pairs(result) do
                        if v.buy == "2" then
                            prop = true
                        end
                    end
                
                end)
                RageUI.IsVisible(LaundererMenu, function()
                    if prop == true then
                    RageUI.Button('Donner un paire de clef', "Selectioner pour donner les ~b~clé~s~ à la personne a coté de vous." , {}, true , {

                        onSelected = function ()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                                    TriggerServerEvent('give:key', GetPlayerServerId(closestPlayer))
                                else
                                    ESX.ShowNotification("~r~Il n'y a personne a proximité.")
                                end 
                        end 
                    })
                end

                end)
                

                Wait(0)
            end
        end)


    end
end

function openCoffre()
    if open then 
        open = false 
        RageUI.Visible(LaundererMenu,false)
        return
    else
        open = true 
        RageUI.Visible(LaundererMenu, true)

        Citizen.CreateThread(function ()
            while open do 
                RageUI.IsVisible(LaundererMenu, function()
                    if allow then
            
                    RageUI.Button('Entrez le laboratoire', "Selectioner pour ~b~acheter~s~ le laboratoire." , {}, true , {

                        onSelected = function ()
                            SetEntityCoords(PlayerPedId(), 1065.86, -3183.37, -40.16)
                                RageUI.CloseAll()
                                Citizen.SetTimeout(1000, function()
                                    time = false
                                     mdr = true
                                end)
                        end 
                    })
                    else
                        RageUI.Button('Visiter le laboratoire', "Selectioner pour ~b~entrer~s~ dans le laboratoire." , {}, true , {

                            onSelected = function ()
                                SetEntityCoords(PlayerPedId(), 1065.86, -3183.37, -40.16)
                                RageUI.CloseAll()
                                Citizen.SetTimeout(1000, function()
                                    time = false
                                    mdr = false
                                end)
                            end 
                        })
                        RageUI.Button('Acheter le laboratoire', "Selectioner pour ~b~acheter~s~ le laboratoire." , {RightLabel = "~g~14843$"}, true , {
    
                            onSelected = function ()
                                TriggerServerEvent('labo:buy')
                                mdr = false

                            end 
                        })
                    end
                
                    
                    if Progress == true then
                        RageUI.PercentagePanel(PercentagePannel, 'Blanchiment en cours', '', '', {}, 2)
                        if PercentagePannel < 1.0 then
                            PercentagePannel = PercentagePannel + 0.0008
                        else
                        
                        end
                    end

                end)

                Wait(0)
            end
        end)


    end
end

Citizen.CreateThread(function()
    
    while true do 
        local PlyPos = GetEntityCoords(PlayerPedId())
        Wait(0)
        for _,v in pairs(weedentry) do
            if #(PlyPos - v.ballas) < 10.2 then
                DrawMarker(25, v.ballas, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.9, 0.9, 0.9, 27, 155, 207, 150, false, true, 2, false, false, false, false)
                
            end
            if #(PlyPos - v.ballas) < 1.2 then
                time = true
                ESX.ShowHelpNotification('Appuyez sur ~INPUT_CONTEXT~ pour entrez dans le ~b~laboratoire')
                if IsControlJustReleased(0,51) then
                    TriggerServerEvent('request:labmenu')          
                    --[[SetEntityCoords(PlayerPedId(), 1065.86, -3183.37, -40.16)
                    Citizen.SetTimeout(1000, function()
                        time = false
                    end)]]
                end
            end
        end
        for _,v in pairs(exit) do
            if #(PlyPos - v.exit1) < 10.2 and time == false then
                DrawMarker(25, v.exit1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.9, 0.9, 0.9, 27, 155, 207, 150, false, true, 2, false, false, false, false)
            end
            if #(PlyPos - v.exit1) < 1.2  and time == false then
                ESX.ShowHelpNotification('Appuyez sur ~INPUT_CONTEXT~ pour sortir dans le ~b~laboratoire')
                if IsControlJustReleased(0,51) then
                    SetEntityCoords(PlayerPedId(), 119.49, -1994.05, 17.35)
                end
            end
        end
        for _,v in pairs(coffre) do
            if #(PlyPos - v.cff1) < 10.2 and mdr == true then
                DrawMarker(25, v.cff1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.9, 0.9, 0.9, 27, 155, 207, 150, false, true, 2, false, false, false, false)
            end
            if #(PlyPos - v.cff1) < 1.2 and mdr == true then
                ESX.ShowHelpNotification('Appuyez sur ~INPUT_CONTEXT~ pour acceder au ~b~coffre')
                if IsControlJustReleased(0,51) then
                    ESX.ShowNotification("Du calme ! ce n'est que la ~y~V1~s~. La suite sortirat ~y~prochainement")
                end
            end
            if #(PlyPos - v.cff1) < 40.2 and mdr == true then
                if IsControlJustPressed(0, 47) then
                OpenMenKey()
            end
            end
        end

    end
end)
--[[
    RMenu.Add(cat, name, RageUI.CreateMenu(menu.title,menu.desc))
RMenu:Get(cat, name).Closed = function()end

RMenu.Add(cat, name, RageUI.CreateSubMenu(RMenu:Get(fromcat, fromname), title, desc))
RMenu:Get(cat, name).Closed = function()end

RageUI.Visible(RMenu:Get(cat,name), state)

RageUI.IsVisible(RMenu:Get(cat,name),true,true,true,function()
end, function()end, 1)

RageUI.ButtonWithStyle(title, desc, {}, state,function(h,a,s)end)

RageUI.List(title, array, arrayIndex, desc, {}, state, function(h, a, s, i) arrayIndex = i end)

RageUI.Checkbox(title, desc, bol, { Style = RageUI.CheckboxStyle.Tick }, function(h, s, a, c)
  bol = c;
end, function()
  -- true
end, function()
  -- false
end)
]]
RegisterNetEvent("labo:openMenu")
AddEventHandler("labo:openMenu", openMenu)
