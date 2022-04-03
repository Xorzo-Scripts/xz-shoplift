local CooldownTime = Config.Time
local Wait = Wait
local Cooldown = false
local shelves = {
  [`v_ret_247shelves05`] = true,
  [`v_ret_247shelves04`] = true,
  [`v_ret_247shelves03`] = true
}

function FindNearbyShelf()
	local coords = GetEntityCoords(PlayerPedId())
    local shelfObject = 0
	local shelfDistance = 1000
	local objects = GetGamePool("CObject")
	local staat, resultaat = xpcall(function()
		local tel = 0
		for i=1, #objects do
			if tel % 30 == 0 then
				Wait(0)
			end
			tel = tel + 1
			if shelves[GetEntityModel(objects[i])] then
				local controlDistance = #(coords - GetEntityCoords(objects[i]))
			
				if controlDistance < shelfDistance then
					shelfDistance = controlDistance
					shelfObject = objects[i]
				end
			end
		end
	end, debug.traceback)
	if not staat then
		print(("Error" .. resultaat))
	end
	return shelfObject, shelfDistance
end

CreateThread(function()
	while true do
		Wait(1000)
		local shelfObject, shelfDistance = FindNearbyShelf()
		if shelfDistance < 1.5 then
      if not alreadySend then
        alreadySend = true
			isNearShelf = shelfObject
      SetNuiFocus(true, true)
      SendNUIMessage({
        part = "interaction"
      })
    end
		else
			isNearShelf = false
			Wait(math.ceil(shelfDistance * 3))
      alreadySend = false
		end
	end
end)
 
RegisterNetEvent("xz-steal")
AddEventHandler("xz-steal", function()
  ESX.TriggerServerCallback('xz-Getcops', function(cops)
  if cops >= 1 then
  if Cooldown == false then
  Anim()
  TriggerEvent('xz-notify')
  TaskPlayAnim(PlayerPedId(),"anim@gangops@facility@servers@","hotwire_intro",1.0,-1.0, -1, 1, 1, true, true, true)
  SendNUIMessage({
    prog = true,
    time = 5500
  })
  Wait(5500)
  local Item = Config.Items[math.random(1, #Config.Items)]
  TriggerServerEvent('xz-shoplift', Item.item)
  ESX.ShowNotification(Config.Trans.Done .. Config.Amount .. " ".. Item.item .. "")
  ClearPedTasks(PlayerPedId())
  Coooldown()
  elseif Cooldown == true then
  ESX.ShowNotification(Config.Trans.Cooldown .. " " ..timeRemaining .. " Seconds" )
  end
  else
  ESX.ShowNotification(Config.Trans.NoCops)
    end
  end)
end)

RegisterNUICallback('close', function()
  SetNuiFocus(false, false)
end)

RegisterNUICallback('steal', function()
  TriggerEvent('xz-steal')
end)


RegisterNetEvent("xz-notify")
AddEventHandler("xz-notify", function()
  if Config.EsxPhone == true then
  TriggerServerEvent('esx_phone:send', 'police', Config.Trans.NotifyPolice, true)
  else
    TriggerServerEvent('xz-notifycops')
  end
end)

function Anim()
  RequestAnimDict("anim@gangops@facility@servers@")
  while (not HasAnimDictLoaded("anim@gangops@facility@servers@")) do 
  Wait(0) 
  end
end

---- Steal Cooldown
function Coooldown()
    Cooldown = true
    timeRemaining = CooldownTime
    local temp = CooldownTime
    for i = 1, temp do
        Wait(2000)
        timeRemaining = timeRemaining - 1
    end
    Cooldown = false
end



