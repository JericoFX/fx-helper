local QBCore = exports["qb-core"]:GetCoreObject()
local PlayerData = {}
local puntos = {
	stash = {},
	boss = {},
	blip = {}
}
if Config.Debug then
	AddEventHandler('onResourceStart', function(resourceName)
		PlayerData = QBCore.Functions.GetPlayerData()
	end)
end

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
	PlayerData = val
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
	PlayerData.job = job
end)

RegisterNetEvent('QBCore:Client:OnGangUpdate', function(job)
	PlayerData.gang = job
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
	PlayerData = QBCore.Functions.GetPlayerData()
end)

local function openStash(k)
	if not k then return end
	exports.ox_inventory:openInventory('stash', { id = k })
end



local function inside(self)
	local PlayerCoords = GetEntityCoords(cache.ped)
	local currentDistance = #(self.coords - PlayerCoords)
	DrawMarker(2, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0, 0.0, 0.0, 180.0,
		0.0,
		0.5, 0.5, 0.5,
		200,
		255, 255, 255, false, true, 2, false, nil, nil, false)
	if currentDistance <= 2 and IsControlJustReleased(0, 38) then
		if self.data.job then
			local jere = PlayerData.job.name == tostring(self.data.job)
			if jere then
				openStash(self.data.id)
			end
		end
	end
end
local function onExit(self)
	lib.hideMenu()
end

local function insideGang(self)
	local PlayerCoords = GetEntityCoords(cache.ped)
	local currentDistance = #(self.coords - PlayerCoords)
	DrawMarker(2, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0, 0.0, 0.0, 180.0,
		0.0,
		0.5, 0.5, 0.5,
		200,
		255, 255, 255, false, true, 2, false, nil, nil, false)
	if currentDistance <= 1 and IsControlJustReleased(0, 38) then
		if self.data.gang then
			local jere = PlayerData.gang.name == tostring(self.data.gang)
			if jere then
				openStash(self.data.id)
			end
		end
	end
end
local function onEnterGang(self)

end
local function onExitGang(self)
	lib.hideMenu()
end

CreateThread(function()
	for k, v in pairs(Config.Job) do
		local el = Config.Job[k]
		if el ~= nil then
			--	print("1", k, el.stash)
			if el.stash then
				if type(el.stash) == "table" then
					for i = 1, #el.stash do
						local wachin = el.stash[i]
						lib.zones.box({
							coords = wachin,
							size = vec3(5, 5, 5),
							rotation = 0,
							debug = false,
							inside = inside,
							onExit = onExit,
							data = { job = k, id = k .. i },
						})
					end
				else
					lib.zones.box({
						coords = el.stash,
						size = vec3(5, 5, 5),
						rotation = 0,
						debug = false,
						inside = inside,
						onEnter = onEnter,
						onExit = onExit,
						data = { job = k, id = k },
					})
				end
			end
			if el.shop and el.shop.locations then
				if type(el.shop.locations) == "table" then
					for i = 1, #el.shop.locations do
						local point = lib.points.new({
							coords = el.shop.locations[i],
							data = { index = i },
							distance = 5,
						})
						function point:nearby()
							if PlayerData.job.name == k then
								DrawMarker(29, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
									1.0,
									1.0, 1.0,
									40, 200, 80, 70, false, true, 2, false, nil, nil, false)

								if self.currentDistance < 1 and IsControlJustReleased(0, 38) then
									print(k, PlayerData.job.name)
									exports.ox_inventory:openInventory("shop", { type = k, id = i })
								end
							end
						end
					end
				else
					local point = lib.points.new({
						coords = el.shop.locations,
						data = { index = 1 },
						distance = 5,
					})
					function point:nearby()
						if PlayerData.job.name == k then
							DrawMarker(29, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
								1.0,
								1.0, 1.0,
								40, 200, 80, 70, false, true, 2, false, nil, nil, false)

							if self.currentDistance < 1 and IsControlJustReleased(0, 38) then
								print(k, PlayerData.job.name)
								exports.ox_inventory:openInventory("shop", { type = k, id = 1 })
							end
						end
					end
				end
			end
			if el.boss then
				local point = lib.points.new({
					coords = el.boss,
					distance = 5,
				})
				function point:nearby()
					DrawMarker(
						29,
						vector3(self.coords.x, self.coords.y, self.coords.z),
						vector3(0, 0, 0),
						vector3(89.9, 180, 0),
						vector3(1, 1, 0),
						255,
						255,
						255,
						255,
						false, --up-down anim
						true, --face cam
						0,
						false, --rotate
						nil,
						nil,
						false --[[drawon ents]]
					)

					if self.currentDistance < 2 and IsControlJustReleased(0, 38) and PlayerData.job.name == el.id and PlayerData.job.isboss then
						TriggerEvent("qb-bossmenu:client:OpenMenu")
					end
				end
			end
			if el.blip then
				CreateThread(function()
					puntos.blip[k] = AddBlipForCoord(el.stash.x, el.stash.y, el.stash.z)
					SetBlipSprite(puntos.blip[k], el.blip.sprite)
					SetBlipDisplay(puntos.blip[k], 4)
					SetBlipScale(puntos.blip[k], 0.6)
					SetBlipAsShortRange(puntos.blip[k], true)
					SetBlipColour(puntos.blip[k], el.blip.color)
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentSubstringPlayerName(el.blip.label)
					EndTextCommandSetBlipName(puntos.blip[k])
				end)
			end
			if el.cloth then
				local point = lib.points.new({
					coords = el.cloth,
					distance = 3,
				})
				function point:nearby()
					DrawMarker(25, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0,
						1.0,
						255, 255, 255, 255, false, true, 2, false, nil, nil, false)

					if self.currentDistance < 1 and IsControlJustReleased(0, 38) and PlayerData.job.name == el.id then
						TriggerEvent("qb-clothing:client:openOutfitMenu")
					end
				end
			end
			if el.garage and el.garage.sacarvehiculo then
				lib.registerMenu({
					id = el.id .. "_Menu",
					title = 'Garage Menu',
					position = 'top-right',
					options = el.garage.options
				}, function(selected, scrollIndex, args)
					if args.hash then
						QBCore.Functions.TriggerCallback('QBCore:Server:SpawnVehicle', function(netId)
							local veh = NetToVeh(netId)
							SetVehicleNumberPlateText(veh, el.id .. tostring(math.random(1000, 9999)))
							SetEntityHeading(veh, el.garage.spawn.w)
							exports['LegacyFuel']:SetFuel(veh, 100.0)
							TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
							TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
							if el.garage.livery[tostring(args.hash)] then
								QBCore.Shared.SetDefaultVehicleExtras(veh, el.garage.livery[args.hash])
							end
							SetVehicleEngineOn(veh, true, true)
						end, args.hash, el.garage.spawn, true)
					end
				end)
				local point = lib.points.new({
					coords = el.garage.sacarvehiculo,
					distance = 3,
				})
				function point:nearby()
					DrawMarker(36, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0,
						1.0,
						255, 255, 255, 255, false, true, 2, false, nil, nil, false)

					if self.currentDistance < 1 and IsControlJustReleased(0, 38) and PlayerData.job.name == el.id then
						lib.showMenu(el.id .. "_Menu")
					end
				end

				--print("6", k, el.garage.devolucion)
				local point2 = lib.points.new({
					coords = el.garage.devolucion,
					distance = 4,
				})
				function point2:onEnter()
					if cache.vehicle then
						lib.showTextUI("[E] Save Vehicle")
					end
				end

				function point2:onExit()
					lib.hideTextUI()
				end

				function point2:nearby()
					DrawMarker(24, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0,
						1.0,
						255, 0, 0, 255, false, true, 2, false, nil, nil, false)

					if self.currentDistance < 3 and IsControlJustReleased(0, 38) and PlayerData.job.name == el.id then
						local veh = cache.vehicle
						local alert = lib.alertDialog({
							header = 'Save Vehicle',
							content = '¿Save Vehicle?',
							centered = true,
							cancel = true
						})

						if veh and alert == "confirm" then
							TaskEveryoneLeaveVehicle(veh)
							Wait(1000)
							DeleteVehicle(veh)
						end
					end
				end
			end
		end
		Wait(0)
	end
	-------············································--
	-- for k, v in pairs(Config.Gangs) do

	--     local el = Config.Gangs[k]

	-- 	lib.zones.box({
	-- 		coords = el.stash,
	-- 		size = vec3(5, 5, 5),
	-- 		rotation = 0,
	-- 		debug = false,
	-- 		inside = insideGang,
	-- 		onEnter = onEnterGang,
	-- 		onExit = onExitGang,
	-- 		data = { gang = k, id = k },
	-- 	})
	-- 	if el.shop then
	-- 		local point = lib.points.new({
	-- 			coords = el.shop.locations[1],
	-- 			distance = 3,
	-- 		})
	-- 		function point:nearby()
	-- 			DrawMarker(29, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0,
	-- 				200, 20, 20, 50, false, true, 2, false, nil, nil, false)
	-- 			if self.currentDistance < 1 and IsControlJustReleased(0, 38) then
	-- 				exports.ox_inventory:openInventory("shop", { type = k, id = 1 })
	-- 			end
	-- 		end
	-- 	end
	-- 	if el.boss then
	-- 		local point = lib.points.new({
	-- 			coords = el.boss,
	-- 			distance = 3,
	-- 		})
	-- 		function point:nearby()
	-- 			DrawMarker(21, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0,
	-- 				200, 20, 20, 50, false, true, 2, false, nil, nil, false)

	-- 			if self.currentDistance < 1.5 and IsControlJustReleased(0, 38) and (PlayerData.gang.name == el.id and PlayerData.gang.isboss) then
	-- 				TriggerEvent("qb-gangmenu:client:OpenMenu")
	-- 			elseif self.currentDistance < 1.5 and IsControlJustReleased(0, 38) and (PlayerData.gang.name == el.id and not PlayerData.gang.isboss) then
	-- 				lib.notify({
	-- 					type = "error",
	-- 					description = "No sos el jefe de la banda"
	-- 				})
	-- 			end
	-- 		end
	-- 	end
	-- 	if el.blip then
	-- 		CreateThread(function()
	-- 			puntos.blip[k] = AddBlipForCoord(el.stash.x, el.stash.y, el.stash.z)
	-- 			SetBlipSprite(puntos.blip[k], el.blip.sprite)
	-- 			SetBlipDisplay(puntos.blip[k], 4)
	-- 			SetBlipScale(puntos.blip[k], 0.6)
	-- 			SetBlipAsShortRange(puntos.blip[k], true)
	-- 			SetBlipColour(puntos.blip[k], el.blip.color)
	-- 			BeginTextCommandSetBlipName("STRING")
	-- 			AddTextComponentSubstringPlayerName(el.blip.label)
	-- 			EndTextCommandSetBlipName(puntos.blip[k])
	-- 		end)
	-- 	end
	-- 	if el.cloth then
	-- 		local point = lib.points.new({
	-- 			coords = el.cloth,
	-- 			distance = 3,
	-- 		})
	-- 		function point:nearby()
	-- 			DrawMarker(23, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0,
	-- 				255, 255, 255, 255, false, true, 2, false, nil, nil, false)

	-- 			if self.currentDistance < 1 and IsControlJustReleased(0, 38) and (PlayerData.gang.name == el.id) then
	-- 				TriggerEvent("qb-clothing:client:openOutfitMenu")
	-- 			end
	-- 		end
	-- 	end
	-- 	if el.garage then
	-- 		lib.registerMenu({
	-- 			id = el.id .. "_Menu",
	-- 			title = 'Garage Menu',
	-- 			position = 'top-right',
	-- 			options = el.garage.options
	-- 		}, function(selected, scrollIndex, args)
	-- 			if args.hash then
	-- 				QBCore.Functions.TriggerCallback('QBCore:Server:SpawnVehicle', function(netId)
	-- 					local veh = NetToVeh(netId)
	-- 					SetVehicleNumberPlateText(veh, el.id .. tostring(math.random(1000, 9999)))
	-- 					SetEntityHeading(veh, el.garage.spawn.w)
	-- 					exports['LegacyFuel']:SetFuel(veh, 100.0)
	-- 					TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
	-- 					TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
	-- 					if el.garage?.livery[tostring(args.hash)] then
	-- 						QBCore.Shared.SetDefaultVehicleExtras(veh, el.garage.livery[args.hash])
	-- 					end
	-- 					SetVehicleEngineOn(veh, true, true)
	-- 				end, args.hash, el.garage.spawn, true)
	-- 			end
	-- 		end)
	-- 		local point = lib.points.new({
	-- 			coords = el.garage.sacarvehiculo,
	-- 			distance = 3,
	-- 		})
	-- 		function point:nearby()
	-- 			DrawMarker(39, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0,
	-- 				255, 255, 255, 255, false, true, 2, false, nil, nil, false)

	-- 			if self.currentDistance < 1 and IsControlJustReleased(0, 38) and PlayerData.gang.name == el.id then
	-- 				lib.showMenu(el.id .. "_Menu")
	-- 			end
	-- 		end

	-- 		local point2 = lib.points.new({
	-- 			coords = el.garage.devolucion,
	-- 			distance = 3,
	-- 		})
	-- 		function point2:onEnter()
	-- 			if cache.vehicle then
	-- 				lib.showTextUI("[E] Guardar Vehiculo")
	-- 			end
	-- 		end

	-- 		function point2:onExit()
	-- 			lib.hideTextUI()
	-- 		end

	-- 		function point2:nearby()
	-- 			DrawMarker(42, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0,
	-- 				255, 0, 0, 255, false, true, 2, false, nil, nil, false)

	-- 			if self.currentDistance < 1 and IsControlJustReleased(0, 38) and PlayerData.gang.name == el.id then
	-- 				local veh = cache.vehicle
	-- 				local alert = lib.alertDialog({
	-- 					header = 'Guardar Vehiculo',
	-- 					content = '¿Desea guardar el vehiculo?',
	-- 					centered = true,
	-- 					cancel = true
	-- 				})

	-- 				if veh and alert == "confirm" then
	-- 					TaskEveryoneLeaveVehicle(veh)
	-- 					Wait(1000)
	-- 					DeleteVehicle(veh)
	-- 				end
	-- 			end
	-- 		end
	-- 	end
	-- 	Wait(0)
	-- end
	-- Wait(0)
end)




AddEventHandler("onResourceStop", function(res)
	if res == GetCurrentResourceName() then
		for _, v in pairs(puntos.blip) do
			if DoesBlipExist(v) then
				RemoveBlip(v)
			end
		end
	end
end)

local function addBlip(coords, text, sprite, color, size, range, display)
	local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
	SetBlipSprite(blip, sprite)
	SetBlipColour(blip, color)
	SetBlipDisplay(blip, display)
	SetBlipAlpha(blip, 250)
	SetBlipScale(blip, size)
	SetBlipAsShortRange(blip, range)
	PulseBlip(blip)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)
	return blip
end
local Blips = {}

CreateThread(function()
	for i = 1, #Config.Blips do
		local el = Config.Blips[i]
		Blips[#Blips + 1] = addBlip(el.coords, el.name, el.sprite, el.color, el.size + .0, el.range, el.display)
	end
end)


AddEventHandler("onResourceStop", function(res)
	if res == GetCurrentResourceName() then
		for _, v in pairs(puntos.blip) do
			if DoesBlipExist(v) then
				RemoveBlip(v)
			end
		end
		for i = 1, #Blips do
			if DoesBlipExist(Blips[i]) then
				RemoveBlip(Blips[i])
			end
		end
	end
end)
