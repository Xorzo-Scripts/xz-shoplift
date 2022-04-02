AddEventHandler('onResourceStart', function(xzshoplift)
   if (GetCurrentResourceName() ~= xzshoplift) then
     return
   end
   print('[^3INFO^7] ^2xz-shoplift^7 Started.')
 end)



RegisterServerEvent("xz-shoplift")
AddEventHandler('xz-shoplift', function(Item)
   local xPlayer = ESX.GetPlayerFromId(source)
   xPlayer.addInventoryItem(Item, Config.Amount)
end)

RegisterServerEvent("xz-notifycops")
AddEventHandler('xz-notifycops', function(count)
  if Config.NotifyCops == true then
  local xPlayers = ESX.GetExtendedPlayers('job', 'police')
  for _, xPlayer in pairs(xPlayers) do
    TriggerClientEvent('esx:showNotification', xPlayer.source, Config.Trans.NotifyPolice)
    end
  end
end)

ESX.RegisterServerCallback('xz-Getcops', function(source, cb)
	amount = 0
  local xPlayers = ESX.GetExtendedPlayers('job', 'police')
  for _, xPlayer in pairs(xPlayers) do
            amount = amount + 1
    end
    cb(amount)
end)

