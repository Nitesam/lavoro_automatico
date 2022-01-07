-----------------------------------------------------------------------

--[[ESX.RegisterServerCallback('lavoro_automatico:OttieniAttrezzatura', function(source, cb, name)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM nitesam_customstashs WHERE stashname = @stashname', {['@stashname'] = name}, function(stash)
		if stash[1] ~= nil then
			local invtable = json.decode(stash[1].data)

			local weight1 = 2500000 * 0.15
			if giocatori[xPlayer.getIdentifier()].agg5 == 1 then
				weight1 = 5000000 * 0.15
			elseif giocatori[xPlayer.getIdentifier()].agg5 == 2 then
				weight1 = 7500000 * 0.15
			elseif giocatori[xPlayer.getIdentifier()].agg5 == 3 then
				weight1 = 10000000 * 0.15
			end

			cb({inventario = invtable, peso = peso})
		else
			MySQL.Async.execute('INSERT INTO nitesam_customstashs (stashname, data) VALUES (@stashname, @data)', {['@stashname'] = name, ['@data'] = '[]'})
			cb(nil, nil)
		end
	end)
end)

RegisterServerEvent('lavoro_automatico:inserisciAttrezzatura')
AddEventHandler('lavoro_automatico:inserisciAttrezzatura', function(oggetto, count, stashname)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local item = xPlayer.getInventoryItem(oggetto)
	local invtable = {}
	
	if count < 0 then
		return
	end
	
	local removecount = count

	MySQL.Async.fetchAll('SELECT * FROM nitesam_customstashs WHERE stashname = @stashname', {['@stashname'] = stashname}, function(stash)
		if stash[1] ~= nil then
			invtable = json.decode(stash[1].data)

			local totalweight = 0
			local PesoAttuale = (2500000 * 0.15)

			if giocatori[xPlayer.getIdentifier()].agg5 == 1 then
				PesoAttuale = (5000000 * 0.15)
			elseif giocatori[xPlayer.getIdentifier()].agg5 == 2 then
				PesoAttuale = (7500000 * 0.15)
			elseif giocatori[xPlayer.getIdentifier()].agg5 == 3 then
				PesoAttuale = (10000000 * 0.15)
			end

			for i=1, #invtable, 1 do
				if invtable[i].weight ~= nil and invtable[i].type == 'item_standard' then
					totalweight = totalweight + (invtable[i].weight * invtable[i].count)
				end
			end


			if PesoAttuale < totalweight + (item.weight * count) then
				TriggerClientEvent('esx:showAdvancedNotification', src, "Dog Pillar", "Miniera", 'Limite Magazzino Raggiunto!', "CHAR_MULTIPLAYER", 2)
				return
			end


			for i=1, #invtable, 1 do
				if invtable[i].name == item.name then
					count = count + invtable[i].count


					
					if item.count >= removecount then
						xPlayer.removeInventoryItem(item.name, removecount)
						if Config.UseWeight then
							table.insert(invtable, i, {name = item.name, label = item.label, type = 'item_standard', count = count, weight = item.weight})
						else
							table.insert(invtable, i, {name = item.name, label = item.label, type = 'item_standard', count = count})
						end
					else
						if Config.UseWeight then
							table.insert(invtable, i, {name = item.name, label = item.label, type = 'item_standard', count = invtable[i].count, weight = item.weight})
						else
							table.insert(invtable, i, {name = item.name, label = item.label, type = 'item_standard', count = invtable[i].count})
						end
					end


					table.remove(invtable, i + 1)
					MySQL.Async.execute('UPDATE nitesam_customstashs SET data = @data WHERE stashname = @stashname', {['@stashname'] = stashname, ['@data'] = json.encode(invtable)}, function(status)
						if status then
						end
					end)

					return
				end
			end

			if item.count >= removecount then
				xPlayer.removeInventoryItem(item.name, removecount)
				table.insert(invtable, {name = item.name, label = item.label, type = 'item_standard', count = count, weight = item.weight})
			end


			MySQL.Async.execute('UPDATE nitesam_customstashs SET data = @data WHERE stashname = @stashname', {['@stashname'] = stashname, ['@data'] = json.encode(invtable)}, function(status)
				if status then
				end
			end)
		else

		end
	end)
end)

RegisterServerEvent('lavoro_automatico:ritiraAttrezzatura')
AddEventHandler('lavoro_automatico:ritiraAttrezzatura', function(oggetto, count, stashname)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local item = xPlayer.getInventoryItem(oggetto)
	local invtable = {}

	if count < 0 then
		return
	end

	if not xPlayer.canCarryItem(item.name, count) or not xPlayer.verificaLimite(item.name, count) then
		TriggerClientEvent('esx:showNotification', src, 'Non hai abbastanza spazio nell\'inventario!')
		return
	end

	MySQL.Async.fetchAll('SELECT * FROM nitesam_customstashs WHERE stashname = @stashname', {['@stashname'] = stashname}, function(stash)
		if stash[1] ~= nil then
			invtable = json.decode(stash[1].data)
			for i=1, #invtable, 1 do
				if invtable[i].name == item.name then
					if count <= invtable[i].count then
						xPlayer.addInventoryItem(item.name, count)
						if invtable[i].count - count > 0 then
							table.insert(invtable, i, {name = item.name, label = item.label, type = 'item_standard', count = invtable[i].count - count, weight = item.weight})
							table.remove(invtable, i + 1)
						else
							table.remove(invtable, i)
						end
						MySQL.Async.execute('UPDATE nitesam_customstashs SET data = @data WHERE stashname = @stashname', {['@stashname'] = stashname, ['@data'] = json.encode(invtable)}, function(status)
							if status then

							end
						end)
					end
					return
				end
			end		
		end
	end)
end)]]




-----------------------------------------------------------------------------------------


--[[function daiOggettiGiocatore(identificatoreGiocatore, minieraLV, storage)
	local invtable = {}

	MySQL.Async.fetchAll('SELECT * FROM inventories WHERE stashname = @stashname AND type = \'deposito_miniera\'', {['@stashname'] = identificatoreGiocatore}, function(stash)
		if stash[1] ~= nil then
			invtable = json.decode(stash[1].data)

			local totalweight = 0
			local testoGiocatore = nil

			for i=1, #invtable, 1 do
				if invtable[i].weight ~= nil and invtable[i].type == 'item_standard' then
					totalweight = totalweight + (invtable[i].weight * invtable[i].count)
				end
			end

			if ESX.GetPlayerFromIdentifier(identificatoreGiocatore) ~= nil then
				testoGiocatore = ESX.GetPlayerFromIdentifier(identificatoreGiocatore)
			end
			
			for k,v in pairs(farmOggetti[minieraLV].Minerali) do
				local count = v.farm
				local presente = nil
				local peso = 2500000

				if storage == 1 then
					peso = 5000000
				elseif storage == 2 then
					peso = 7500000
				elseif storage == 3 then
					peso = 10000000
				end

				if peso < totalweight + (v.pesoItem * count) then
					local qtyCompensato = ((totalweight + (v.pesoItem * count)) - peso)
					count = count - qtyCompensato
					if count > 0 then
						print(k, count)
						local cont = 0
						for i=1, #invtable, 1 do
							if invtable[i].name == k then
								presente = true
								cont = i
								count = count + invtable[i].count
								break
							end
						end

						if presente then
							table.insert(invtable, cont, {name = k, label = v.label, type = 'item_standard', count = math.floor(count), weight = v.pesoItem})
							table.remove(invtable, cont + 1)
						else
							table.insert(invtable, {name = k, label = v.label, type = 'item_standard', count = math.floor(count), weight = v.pesoItem})
						end

						MySQL.Async.execute('UPDATE nitesam_customstashs SET data = @data WHERE stashname = @stashname', {['@stashname'] = identificatoreGiocatore, ['@data'] = json.encode(invtable)}, function(status)
							if status then
							end
						end)
					end

					if testoGiocatore ~= nil then 
						testoGiocatore.triggerEvent('esx:showAdvancedNotification', "Dog Pillar", "Miniera", "Il tuo Deposito Minerario ha raggiunto il suo limite!", "CHAR_MULTIPLAYER", 2)
					end
					
					print("Limite raggiunto per " .. identificatoreGiocatore)
					return
				end

				local cont = 0
				for i=1, #invtable, 1 do
					if invtable[i].name == k then
						presente = true
						cont = i
						count = count + invtable[i].count
						break
					end
				end

				if presente then
					table.insert(invtable, cont, {name = k, label = v.label, type = 'item_standard', count = math.floor(count), weight = v.pesoItem})
					table.remove(invtable, cont + 1)
				else
					table.insert(invtable, {name = k, label = v.label, type = 'item_standard', count = math.floor(count), weight = v.pesoItem})
				end
			end

			MySQL.Async.fetchAll('SELECT * FROM nitesam_customstashs WHERE stashname = @stashname', {['@stashname'] = "miniera_"..identificatoreGiocatore}, function(stash2)
				if stash2[1] ~= nil then
					local invtable2 = json.decode(stash2[1].data)
					local cont = 0

					for k,v in pairs(farmOggetti[minieraLV].Strumenti) do
						local hint = false

						for i=1, #invtable2, 1 do
							if invtable2[i].name == k then
								if invtable2[i].count >= v.qty then
									local contatore = invtable2[i].count - (math.ceil(v.qty/4))
									table.insert(invtable2, i, {name = k, label = v.label, type = 'item_standard', count = math.floor(contatore), weight = (v.pesoItem * contatore)})
									table.remove(invtable2, i + 1)
									cont = cont + 1
								else
									if testoGiocatore then 
										testoGiocatore.triggerEvent('esx:showAdvancedNotification', "Dog Pillar", "Miniera", "Non è possibile prelevare dalla tua Miniera poichè la quantità di ".. v.label .." non è sufficiente!", "CHAR_BLOCKED", 2)
									end
								end
								hint = true
								break
							end
						end

						if not hint then
							testoGiocatore.triggerEvent('esx:showAdvancedNotification', "Dog Pillar", "Miniera", "Non è possibile prelevare dalla tua Miniera poichè la quantità di ".. v.label .." non è sufficiente!", "CHAR_BLOCKED", 2)
						end
					end

					if cont < farmOggetti[minieraLV].AttrezziNecessari then
						return
					end

					MySQL.Async.execute('UPDATE nitesam_customstashs SET data = @data WHERE stashname = @stashname', {['@stashname'] = "miniera_"..identificatoreGiocatore, ['@data'] = json.encode(invtable2)}, function(status)
						if status then
						end
					end)

					MySQL.Async.execute('UPDATE nitesam_customstashs SET data = @data WHERE stashname = @stashname', {['@stashname'] = identificatoreGiocatore, ['@data'] = json.encode(invtable)}, function(status)
						if status then
						end
					end)

					if testoGiocatore ~= nil then 
						testoGiocatore.triggerEvent('esx:showAdvancedNotification', "Dog Pillar", "Miniera", "Dei Materiali sono stati consegnati nel tuo Deposito Minerario!", "CHAR_MULTIPLAYER", 2)
					end
				end
			end)
		end
	end)
end]]