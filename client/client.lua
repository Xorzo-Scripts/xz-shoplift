-- If you read this code you're a nerd and you have no life so im gonna tell you a fact in the meantime:
-- xorzo is a very talented developer and gets all the girls because he is really sexy. 
-- i can vouch that thats a lie, infact benzo is more talented than xorzo, he sucks!
local CooldownTime = 12
local Cooldown = false  

CreateThread(function()
  while true do 
    Wait(5)
    RequestAnimDict("anim@gangops@facility@servers@")
    while (not HasAnimDictLoaded("anim@gangops@facility@servers@")) do 
    Wait(0) 
     end
   end
 end)


RegisterNetEvent("Steal")
AddEventHandler("Steal", function()
  ESX.TriggerServerCallback('xz-Getcops', function(cops)
    if cops >= 1 then
  if Cooldown == false then
  TaskPlayAnim(PlayerPedId(),"anim@gangops@facility@servers@","hotwire_intro",1.0,-1.0, -1, 1, 1, true, true, true)
  exports['progressBars']:startUI(Config.Time, Config.Trans.shoplift)
  Wait(Config.Time)
  local Item = Config.Items[math.random(1, #Config.Items)]
  TriggerServerEvent('xz-shoplift', Item.item)
  ESX.ShowNotification(Config.Trans.Done .. #Config.Items .. " ".. Item.item .. "")
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

