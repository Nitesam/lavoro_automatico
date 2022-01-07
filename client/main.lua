
local PlayerData                = {}
local possiede                  = {}
local JobBlips                  = {}

local peso                      = 2500000
local tabAttivo                 = false
local identificativo            = nil
local minieraCaricata           = false

ESX                             = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
    
    blipProcessi()
    Wait(500)
    retrieveInformation()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
    retrieveInformation()
end)

function retrieveInformation()
    while PlayerData == nil do
        Wait(10)
    end
    if not minieraCaricata then 
        minieraCaricata = true
        ESX.TriggerServerCallback('automatico:ottieniIdentificativo', function(valore)
            identificativo = nil
            if valore ~= nil then
                identificativo = valore
            end
        end)

        ESX.TriggerServerCallback('automatico:checkAcquisto', function(valore)
            if valore ~= nil then
                possiede = valore
                if possiede.agg5 == 1 then 
                    peso = 5000000
                elseif possiede.agg5 == 2 then
                    peso = 7500000
                elseif possiede.agg5 == 3 then
                    peso = 10000000
                end

                attivaMagazzino()

                Wait(10000)

                if possiede.premium == 1 then
                    TriggerEvent("esx:showNotification", 'Dog Pillar continua a scavare per te!')
                else
                    TriggerEvent("esx:showNotification", 'Dog Pillar ha ripreso a scavare per te!')
                end

                TriggerEvent("menuGenerale:menuAutomatico", true)
            else
                possiede = {attivo = false}
            end
        end)
    end
end

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function(source,callback)
  identificativo = {}
  possiede = {}
  peso = 2500000
end)

RegisterNetEvent('automatico:aggiornaPossiedi')
AddEventHandler('automatico:aggiornaPossiedi', function(val)
  possiede = val
end)

function blipProcessi()   
    for k,v in pairs(Config.Posti) do
        local blip = AddBlipForCoord(v.Blip.x, v.Blip.y, v.Blip.z)
            
        SetBlipSprite (blip, v.Tipologia.Sprite)
        SetBlipDisplay(blip, v.Tipologia.Display)
        SetBlipScale  (blip, v.Tipologia.Scale)
        SetBlipColour (blip, v.Tipologia.Colour)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.Blip.nome)
        EndTextCommandSetBlipName(blip)
        table.insert(JobBlips, blip)
    end
end
                
-- TABLET CENTER

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
    Citizen.Wait(2)
    if not IsEntityDead( ped ) then
        if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.Posti.Tablet.Blip.x, Config.Posti.Tablet.Blip.y, Config.Posti.Tablet.Blip.z, true) < 25 and not tabAttivo then
            DrawMarker(0, Config.Posti.Tablet.Blip.x, Config.Posti.Tablet.Blip.y, Config.Posti.Tablet.Blip.z + 2.3, 0, 0, 0, 0, 0, 90.0, 0.4, 0.4, 0.4, 0, 155, 253, 155, 1, 1, 2, 0, 0, 0, 0)
            if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.Posti.Tablet.Blip.x, Config.Posti.Tablet.Blip.y, Config.Posti.Tablet.Blip.z, true) < 3 then
                ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per aprire il menu Trivelle')
                    if IsControlJustReleased(1, 51) then
                        tabAttivo = true 
                        REQUEST_NUI_FOCUS(tabAttivo, possiede)
                        disabilitaComandi()
                    end
                end
            end
        else
            Citizen.Wait(500)
        end
    end
end)

function attivaMagazzino()
    Citizen.CreateThread(function()
        while true do
        local ped = PlayerPedId()
        Citizen.Wait(2)
        if not IsEntityDead(ped) then
            if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.Posti.Magazzino.Blip.x, Config.Posti.Magazzino.Blip.y, Config.Posti.Magazzino.Blip.z, true) < 25 then
                DrawMarker(0, Config.Posti.Magazzino.Blip.x, Config.Posti.Magazzino.Blip.y, Config.Posti.Magazzino.Blip.z + 1.3, 0, 0, 0, 0, 0, 90.0, 0.9, 0.9, 0.9, 0, 155, 253, 155, 1, 1, 2, 0, 0, 0, 0)
                if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.Posti.Magazzino.Blip.x, Config.Posti.Magazzino.Blip.y, Config.Posti.Magazzino.Blip.z, true) < 4 then
                    ESX.ShowHelpNotification('Premi ~INPUT_CONTEXT~ per aprire l\'Inventario Aziendale')
                        if IsControlJustReleased(1, 51) then
                            apriMenu()
                        end
                    end
                end
            else
                Citizen.Wait(500)
            end
        end
    end)
end

function apriMenu()
    local elements = {
        {label = 'Apri Magazzino', value = 'magazzino'},
        {label = 'Apri Deposito Attrezzatura', value = 'attrezzatura'}
    }

    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'apriMenu', {
        title    = 'Deposito',
        align    = 'top-left',
        elements = elements,
    }, function(data, menu)

        if data.current.value == 'magazzino' then
            ESX.UI.Menu.CloseAll()
            TriggerEvent("inventario:apriDeposito", "deposito_miniera", "Deposito Miniera", "raccolta_miniera_"..identificativo, peso)
        end

        if data.current.value == 'attrezzatura' then
            ESX.UI.Menu.CloseAll()
            TriggerEvent("inventario:apriDeposito", "deposito_miniera", "Deposito Attrezzatura", "miniera_"..identificativo, (peso * 0.15))
        end
        
    end, function(data, menu)
        menu.close()
    end)
end

-- GESTIONE NPC

Citizen.CreateThread(function()
	for k,v in ipairs(Config.Ped) do
	    local hash = GetHashKey(v.valore)

	    if not HasModelLoaded(hash) then
	        RequestModel(hash)
	        Citizen.Wait(100)
	    end

	    while not HasModelLoaded(hash) do
	        Citizen.Wait(0)
	    end

        local npc = CreatePed(6, hash, v.x, v.y, v.z, v.heading, false, false)
        SetEntityInvincible(npc, true)
        FreezeEntityPosition(npc, true)
        SetPedDiesWhenInjured(npc, false)
        SetPedCanRagdollFromPlayerImpact(npc, false)
        SetPedCanRagdoll(npc, false)
        SetEntityAsMissionEntity(npc, true, true)
        SetEntityDynamic(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
	end
end)


function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100 
    SetTextScale(0.35, 0.35)
    SetTextFont(fontId)
    SetTextProportional(0)
    SetTextColour(255, 255, 255, 215)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()   
end

-- SEZIONE NUI

function REQUEST_NUI_FOCUS(bool, data)
    SetNuiFocus(bool, bool) 
    if bool == true then
        print(data.attivo)
        if data.attivo == true then
            SendNUIMessage({
                showtab = true,
                acquisto = 1,
                agg1 = data.agg1,
                agg2 = data.agg2,
                agg3 = data.agg3,
                agg4 = data.agg4,
                agg5 = data.agg5,
                livello = data.livello
            })
        else
            SendNUIMessage({
                showtab = true,
                acquisto = 0
            })
        end
    else
        SendNUIMessage({hidetab = true})
    end
    return bool
end

RegisterNUICallback(
    "Acquisto",
    function()
        ESX.TriggerServerCallback('automatico:acquistoTrivella', function(valore)
            if valore then
                ChiudiUI()

                attivaMagazzino()
                TriggerEvent("menuGenerale:menuAutomatico", true)
            else
                TriggerEvent('esx:showNotification', "Non hai abbastanza denaro per Acquistare una Miniera.", "error", 5000, "Dog Pillar")
            end
        end)
    end
)

RegisterNUICallback("AcquistoAggiornamento", function(data)
    ESX.TriggerServerCallback('automatico:acquistaAggiornamenti', function(risultato)
        if risultato then
            ChiudiUI()
            ESX.ShowNotification("La transazione è andata a buon fine, Aggiornamento Installato!", "success")

            if possiede.agg5 == 1 then 
                peso = 5000000
            elseif possiede.agg5 == 2 then
                peso = 7500000
            elseif possiede.agg5 == 3 then
                peso = 10000000
            end

        else
            TriggerEvent('esx:showNotification', "Hai bisogno di più denaro per acquistare questo Aggiornamento.", "error", 5000, "Dog Pillar")
        end
    end, data.valore, data.denaro, data.livello) 
end)

RegisterNUICallback("ottieniAggiornamenti", function(data)
    SendNUIMessage({
        agg1 = possiede.agg1,
        agg2 = possiede.agg2,
        agg3 = possiede.agg3,
        agg4 = possiede.agg4,
        agg5 = possiede.agg5,
        livello = possiede.livello
    })
end)

RegisterNUICallback(
    "Nascondi-Tablet",
    function(data)
        if data.hide then
            SendNUIMessage({hidetab = true})
            SetNuiFocus(false, false) 
            tabAttivo = false
        end
    end
)

function ChiudiUI() 
    SendNUIMessage({hidetab = true})
    SetNuiFocus(false, false) 
    tabAttivo = false
end

function disabilitaComandi()
    Citizen.CreateThread(function()
        while tabAttivo do
            local ped = PlayerPedId()
            DisableControlAction(0, 1, true) -- LookLeftRight
            DisableControlAction(0, 2, true) -- LookUpDown
            DisableControlAction(0, 24, true) -- Attack
            DisablePlayerFiring(ped, true) -- Disable weapon firing
            DisableControlAction(0, 142, true) -- MeleeAttackAlternate
            DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
            Citizen.Wait(2)
        end
    end)
end
