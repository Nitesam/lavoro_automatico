ESX               = nil
local giocatori = {}
local farmOggetti = {
	[0] = {
		AttrezziNecessari = 1,
		Strumenti = {
			["piccone_di_ferro"] = {
				label = "Piccone di Ferro",
				qty = 5,
				pesoItem = 5000
			}
		},
		Minerali =  {
			["marna_da_cemento"] = {
				label = "Marna da Cemento",
				farm = 60,
				pesoItem = 2500
			}
		}
	},
	[1] = {
		AttrezziNecessari = 1,
		Strumenti = {
			["piccone_di_ferro"] = {
				label = "Piccone di Ferro",
				qty = 7,
				pesoItem = 5000
			}
		},
		Minerali =  {
			["marna_da_cemento"] = {
				label = "Marna da Cemento",
				farm = 36,
				pesoItem = 2500
			},
			["carbone"] = {
				label = "Carbone",
				farm = 24,
				pesoItem = 2500
			}
		}
	},
	[2] = {
		AttrezziNecessari = 2,
		Strumenti = {
			["piccone_di_ferro"] = {
				label = "Piccone di Ferro",
				qty = 20,
				pesoItem = 5000
			},
			["lampade"] = {
				label = "Lampade",
				qty = 5,
				pesoItem = 1500
			}
		},
		Minerali =  {
			["marna_da_cemento"] = {
				label = "Marna da Cemento",
				farm = 24,
				pesoItem = 2500
			},
			["carbone"] = {
				label = "Carbone",
				farm = 24,
				pesoItem = 2500
			},
			["ferro_grezzo"] = {
				label = "Ferro Grezzo",
				farm = 12,
				pesoItem = 5000
			}
		}
	},
	[3] = {
		AttrezziNecessari = 3,
		Strumenti = {
			["piccone_di_ferro"] = {
				label = "Piccone di Ferro",
				qty = 30,
				pesoItem = 5000
			},
			["carretto_di_ferro"] = {
				label = "Carretto di Ferro",
				qty = 3,
				pesoItem = 50000
			},
			["lampade"] = {
				label = "Lampade",
				qty = 10,
				pesoItem = 1500
			}
		},
		Minerali =  {
			["carbone"] = {
				label = "Carbone",
				farm = 30,
				pesoItem = 2500
			},
			["ferro_grezzo"] = {
				label = "Ferro Grezzo",
				farm = 18,
				pesoItem = 5000
			},
			["oro_grezzo"] = {
				label = "Ferro Grezzo",
				farm = 12,
				pesoItem = 5000
			}
		}
	},
	[4] = {
		AttrezziNecessari = 4,
		Strumenti = {
			["attrezzatura_da_scavi"] = {
				label = "Attrezzatura da Scavi",
				qty = 10,
				pesoItem = 10000
			},
			["carretto_di_ferro"] = {
				label = "Carretto di Ferro",
				qty = 2,
				pesoItem = 50000
			},
			["lampadine"] = {
				label = "Lampadine",
				qty = 5,
				pesoItem = 500
			},
			["benzina_industriale"] ={
				label = "Benzina Industriale",
				qty = 10,
				pesoItem = 5000
			}
		},
		Minerali =  {
			["carbone"] = {
				label = "Carbone",
				farm = 48,
				pesoItem = 2500
			},
			["ferro_grezzo"] = {
				label = "Ferro Grezzo",
				farm = 36,
				pesoItem = 5000
			},
			["oro_grezzo"] = {
				label = "Oro Grezzo",
				farm = 24,
				pesoItem = 5000
			},
			["argento_grezzo"] = {
				label = "Argento Grezzo",
				farm = 12,
				pesoItem = 5000
			}
		}
	},
	[5] = {
		AttrezziNecessari = 3,
		Strumenti = {
			["attrezzatura_da_scavi"] = {
				label = "Attrezzatura da Scavi",
				qty = 40,
				pesoItem = 10000
			},
			["cavi_industriali"] = {
				label = "Cavi Industriali",
				qty = 15,
				pesoItem = 5000
			},
			["benzina_industriale"] ={
				label = "Benzina Industriale",
				qty = 35,
				pesoItem = 5000
			}
		},
		Minerali =  {
			["carbone"] = {
				label = "Carbone",
				farm = 60,
				pesoItem = 2500
			},
			["ferro_grezzo"] = {
				label = "Ferro Grezzo",
				farm = 48,
				pesoItem = 5000
			},
			["oro_grezzo"] = {
				label = "Oro Grezzo",
				farm = 48,
				pesoItem = 5000
			},
			["argento_grezzo"] = {
				label = "Argento Grezzo",
				farm = 36,
				pesoItem = 5000
			},
			["platino_grezzo"] = {
				label = "Platino Grezzo",
				farm = 24,
				pesoItem = 5000
			},
			["pietre_preziose"] = {
				label = "Pietre Preziose",
				farm = 24,
				pesoItem = 2500
			}
		}
	}
}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


MySQL.ready(function()
    MySQL.Async.fetchAll('SELECT * FROM automatico WHERE premium = 1', {}, function(risultato)
		if risultato[1] then 
			for k,v in pairs(risultato) do
				local valoreFinale = 0

				if v.agg1 == 3 and v.agg2 == 5 and v.agg3 == 3 then
					valoreFinale = 5
				elseif v.agg1 == 3 and v.agg2 == 4 and v.agg3 == 3 then
					valoreFinale = 4
				elseif v.agg1 == 3 and v.agg2 == 3 and v.agg3 == 3 then
					valoreFinale = 3
				elseif v.agg1 >= 2 and v.agg2 >= 2 and v.agg3 >= 2 then
					valoreFinale = 2
				elseif v.agg1 >= 1 and v.agg2 >= 1 and v.agg3 >= 1 then
					valoreFinale = 1
				end

				print("\n\n----------------\n")
				print("UTENTE PREMIUM INSERITO NELLA LISTA RACCOLTA AUTOMATICAMENTE\n")
				print("Identificativo 		 :", v.identifier)
				print("Aggiornamento 1		 :" , v.agg1)
				print("Aggiornamento 2		 :" , v.agg2)
				print("Aggiornamento 3		 :" , v.agg3)
				print("Aggiornamento Storage   :" , v.agg5)
				print("Utente Premium 		 :" , v.premium)
				print("\n\nLivello Miniera del giocatore " .. v.identifier .. " = " .. valoreFinale)
				print("\n----------------\n\n")
				

				giocatori[steamid] = {
					identificatore = v.identifier,
					agg1 = v.agg1,
					agg2 = v.agg2,
					agg3 = v.agg3,
					agg4 = v.agg4,
					livello = valoreFinale,
					storage = v.agg5,
					premium = v.premium
				}
			end
		end
	end)
end)

local TempoAttesa = (15 * 60) * 1000

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(TempoAttesa)
		print('\n--------------\n')
		for k,v in pairs(giocatori) do
			Citizen.Wait(100)
			daiOggettiGiocatore(k, v.livello, v.storage)
			print(v.identificatore .. " servito.")
		end
		print('\n['.. os.date("%H:%M") .. '] '..'- [Dog Pillar] Consegne Completate.')
		print('\n--------------\n')
	end
end)

function daiOggettiGiocatore(identificatoreGiocatore, minieraLV, storage)
	local invtable = {}

	MySQL.Async.fetchAll('SELECT * FROM nitesam_customstashs WHERE stashname = @stashname', {['@stashname'] = identificatoreGiocatore}, function(stash)
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
						testoGiocatore.triggerEvent('esx:showAdvancedNotification', "~h~~y~Dog Pillar~w~", "~o~Miniera", "Il tuo ~g~Deposito Minerario~s~ ha raggiunto il suo ~r~limite~s~!", "CHAR_MULTIPLAYER", 2)
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
										testoGiocatore.triggerEvent('esx:showAdvancedNotification', "~h~~y~Dog Pillar~w~", "~o~Miniera", "Non è possibile prelevare dalla tua ~g~Miniera~s~ poichè la quantità di ~r~".. v.label .."~s~ non è sufficiente!", "CHAR_BLOCKED", 2)
									end
								end
								hint = true
								break
							end
						end

						if not hint then
							testoGiocatore.triggerEvent('esx:showAdvancedNotification', "~h~~y~Dog Pillar~w~", "~o~Miniera", "Non è possibile prelevare dalla tua ~g~Miniera~s~ poichè la quantità di ~r~".. v.label .."~s~ non è sufficiente!", "CHAR_BLOCKED", 2)
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
						testoGiocatore.triggerEvent('esx:showAdvancedNotification', "~h~~y~Dog Pillar~w~", "~o~Miniera", "Dei ~o~Materiali~s~ sono stati consegnati nel tuo ~g~Deposito Minerario~s~!", "CHAR_MULTIPLAYER", 2)
					end
				end
			end)
		end
	end)
end


ESX.RegisterServerCallback('automatico:checkAcquisto', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local steamid = xPlayer.getIdentifier()

	if giocatori[steamid] == nil then

		MySQL.Async.fetchAll('SELECT * FROM automatico WHERE identifier = @identificativo', {
			['identificativo'] = steamid
		}, function(risultato)
			if risultato[1] then 
				local valoreFinale = 0

				if risultato[1].agg1 == 3 and risultato[1].agg2 == 5 and risultato[1].agg3 == 3 then
					valoreFinale = 5
				elseif risultato[1].agg1 == 3 and risultato[1].agg2 == 4 and risultato[1].agg3 == 3 then
					valoreFinale = 4
				elseif risultato[1].agg1 == 3 and risultato[1].agg2 == 3 and risultato[1].agg3 == 3 then
					valoreFinale = 3
				elseif risultato[1].agg1 >= 2 and risultato[1].agg2 >= 2 and risultato[1].agg3 >= 2 then
					valoreFinale = 2
				elseif risultato[1].agg1 >= 1 and risultato[1].agg2 >= 1 and risultato[1].agg3 >= 1 then
					valoreFinale = 1
				end

				print("\n\n----------------\n")
				print("Identificativo 		 :",risultato[1].identifier)
				print("Aggiornamento 1		 :" , risultato[1].agg1)
				print("Aggiornamento 2		 :" , risultato[1].agg2)
				print("Aggiornamento 3		 :" , risultato[1].agg3)
				print("Aggiornamento 4		 :" , risultato[1].agg4)
				print("Aggiornamento Storage   :" , risultato[1].agg5)
				print("Utente Premium 		 :" , risultato[1].premium)
				print("\n\nLivello Miniera del giocatore " .. GetPlayerName(source) .. " = " .. valoreFinale)
				print("\n----------------\n\n")
				

				giocatori[steamid] = {
					identificatore = risultato[1].identifier,
					agg1 = risultato[1].agg1,
					agg2 = risultato[1].agg2,
					agg3 = risultato[1].agg3,
					agg4 = risultato[1].agg4,
					livello = valoreFinale,
					storage = risultato[1].agg5,
					premium = risultato[1].premium
				}

				cb({
					attivo = true,
					agg1 = risultato[1].agg1,
					agg2 = risultato[1].agg2,
					agg3 = risultato[1].agg3,
					agg4 = risultato[1].agg4,
					agg5 = risultato[1].agg5,
					livello = valoreFinale,
					premium = risultato[1].premium
				})
			else
				cb(nil)
			end
		end)	
	elseif giocatori[steamid].premium == 1 then 
		
		print("\n\n----------------\n")
		print("L'Utente Premium "..GetPlayerName(source))
		print("Identificativo :",giocatori[steamid].identificatore)
		print("Utente Premium :" , giocatori[steamid].premium)
		print("\n\nLivello Miniera del giocatore " .. GetPlayerName(source) .. " uguale a " .. giocatori[steamid].livello)
		print("\n----------------\n\n")
		
		cb({
			attivo = true,
			agg1 = giocatori[steamid].agg1,
			agg2 = giocatori[steamid].agg2,
			agg3 = giocatori[steamid].agg3,
			agg4 = giocatori[steamid].agg4,
			agg5 = giocatori[steamid].storage,
			livello = giocatori[steamid].livello,
			premium = giocatori[steamid].premium
		})
	end
end)

ESX.RegisterServerCallback('automatico:ottieniIdentificativo', function(source, cb)
	local giocatore = ESX.GetPlayerFromId(source)

	cb(giocatore.getIdentifier())
	
end)

ESX.RegisterServerCallback('automatico:acquistoTrivella', function(source, cb)
	local giocatore = ESX.GetPlayerFromId(source)

	if giocatore.getAccount('bank').money >= 500000 then
		local steamid = giocatore.getIdentifier()

		acquistoTrivella(steamid, source)

		giocatore.removeAccountMoney('bank', 500000)

		cb(true)
	else
		cb(false)
	end
	
end)

ESX.RegisterServerCallback('automatico:acquistaAggiornamenti', function(source, cb, val, denaro, livello)
	local giocatore = ESX.GetPlayerFromId(source)

	if giocatore.getAccount('bank').money >= denaro then
		local steamid = giocatore.getIdentifier()

		acquistoAggiornamento(steamid, source, val, livello)

		giocatore.removeAccountMoney('bank', denaro)

		cb(true)
	else
		cb(false)
	end
	
end)

function acquistoTrivella(valore, source)
	local steamid = valore
	MySQL.Async.fetchAll('SELECT identifier FROM automatico WHERE identifier = @identificativo', {
		['identificativo'] = steamid
	}, function(risultato)
		if risultato[1] == nil then
			MySQL.Async.fetchAll('INSERT INTO automatico (identifier) VALUES (@identifier)',
			{ 
				["@identifier"] = steamid
			}, function(result)
				if result then
					TriggerClientEvent('esx:showAdvancedNotification', source, "~h~~y~Dog Pillar~w~", "~o~Miniera", '~g~Salve!~s~ Noi di Dog Pillar depositeremo ogni ~r~15 minuti~s~ le risorse ricavate nel ~g~tuo magazzino~s~!', "CHAR_MULTIPLAYER", 2)
					
					giocatori[steamid] = {
						identificatore = steamid,
						agg1 = 0,
						agg2 = 0,
						agg3 = 0,
						agg4 = 0,
						livello = 0,
						storage = 0,
						premium = 0
					}

					TriggerClientEvent('automatico:aggiornaPossiedi', source, {
						attivo = true,
						agg1 = 0,
						agg2 = 0,
						agg3 = 0,
						agg4 = 0,
						agg5 = 0,
						livello = 0,
						premium = 0
					})

					print("\n\n----------------\n")
					print("\nL'Utente "..GetPlayerName(source))
					print("\nIdentificativo :", steamid)
					print("\nHa acquistato una Trivella!")
					print("\n----------------\n\n")
				end
			end)
		end
	end)
end

function acquistoAggiornamento(steam, source, aggiornamento, livello)
	local steamid = steam
	MySQL.Async.fetchAll('SELECT identifier FROM automatico WHERE identifier = @identificativo', {
		['identificativo'] = steamid
	}, function(risultato)
		if risultato[1] then
			MySQL.Async.fetchAll('UPDATE automatico SET agg'.. aggiornamento ..' = '.. livello ..' WHERE identifier = @identifier;',
			{ 
				["@identifier"] = steamid
			}, function(risultato2)
				if risultato2 then
					local stringa = ''
					if aggiornamento == 1 then
						stringa = 'Personale Qualificato LV '.. livello
					elseif aggiornamento == 2 then
						stringa = 'Struttura Migliorata LV '.. livello
					elseif aggiornamento == 3 then
						stringa = 'Attrezzatura Migliorata LV '.. livello
					end

					print('Il Giocatore ' .. GetPlayerName(source) .. ' ha acquistato l\'aggiornamento : ' .. stringa)

					MySQL.Async.fetchAll('SELECT * FROM automatico WHERE identifier = @identificativo', {
						['identificativo'] = steamid
					}, function(risultato3)
						if risultato3[1] then
							local valoreFinale = 0

							if risultato3[1].agg1 == 3 and risultato3[1].agg2 == 5 and risultato3[1].agg3 == 3 then
								valoreFinale = 5
							elseif risultato3[1].agg1 == 3 and risultato3[1].agg2 == 4 and risultato3[1].agg3 == 3 then
								valoreFinale = 4
							elseif risultato3[1].agg1 == 3 and risultato3[1].agg2 == 3 and risultato3[1].agg3 == 3 then
								valoreFinale = 3
							elseif risultato3[1].agg1 >= 2 and risultato3[1].agg2 >= 2 and risultato3[1].agg3 >= 2 then
								valoreFinale = 2
							elseif risultato3[1].agg1 >= 1 and risultato3[1].agg2 >= 1 and risultato3[1].agg3 >= 1 then
								valoreFinale = 1
							end

							print("\n\n----------------\n")
							print("Aggiornamento Acquistato da:", GetPlayerName(source))
							print("Identificativo 		 :", risultato3[1].identifier)
							print("Aggiornamento 1		 :" , risultato3[1].agg1)
							print("Aggiornamento 2		 :" , risultato3[1].agg2)
							print("Aggiornamento 3		 :" , risultato3[1].agg3)
							print("Aggiornamento 4		 :" , risultato3[1].agg4)
							print("Aggiornamento Storage   :" , risultato3[1].agg5)
							print("Utente Premium 		 :" , risultato3[1].premium)
							print("\n\nLivello della Miniera di " .. GetPlayerName(source) .. " = " .. valoreFinale)
							print("\n----------------\n\n")
							
							
							while giocatori[steamid] ~= nil do
								Wait(1)
								giocatori[steamid] = nil
							end

							giocatori[steamid] = {
								identificatore = risultato[1].identifier,
								agg1 = risultato3[1].agg1,
								agg2 = risultato3[1].agg2,
								agg3 = risultato3[1].agg3,
								agg4 = risultato3[1].agg4,
								livello = valoreFinale,
								storage = risultato3[1].agg5,
								premium = risultato3[1].premium
							}

							TriggerClientEvent('automatico:aggiornaPossiedi', source, {
								attivo = true,
								agg1 = risultato3[1].agg1,
								agg2 = risultato3[1].agg2,
								agg3 = risultato3[1].agg3,
								agg4 = risultato3[1].agg4,
								agg5 = risultato3[1].agg5,
								livello = valoreFinale,
								premium = risultato3[1].premium
							})
						end
					end)
				end
			end)
		end
	end)
end

ESX.RegisterServerCallback('lavoro_automatico:OttieniAttrezzatura', function(source, cb, name)
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
				TriggerClientEvent('esx:showAdvancedNotification', src, "~h~~y~Dog Pillar~s~", "~o~Miniera", '~r~Limite~s~ Magazzino Raggiunto!', "CHAR_MULTIPLAYER", 2)
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
		TriggerClientEvent('esx:showNotification2', src, 'Non hai ~g~abbastanza spazio~w~ nell\'~r~inventario!')
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
end)

AddEventHandler('esx:playerLogout', function(source,callback)
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.getIdentifier()

	Wait(250)

	if giocatori[identifier] ~= nil then
		if giocatori[identifier].premium == 0 then
			print('Il Giocatore ' .. GetPlayerName(source) .. ' rimosso dalla tabella trivellazioni')
			giocatori[identifier] = nil
		else
			print('Il Giocatore ' .. GetPlayerName(source) .. ' è uscito ma non viene rimosso poiche\' utente premium!')
		end
	end
end)

AddEventHandler('playerDropped', function(reason)
	local _source = source

	if _source == nil or _source == 0 or ESX.GetPlayerFromId(_source) == nil then
		return
	end

	local xPlayer = ESX.GetPlayerFromId(_source)
	local identifier = xPlayer.getIdentifier()
	
	if giocatori[identifier] ~= nil then
		if giocatori[identifier].premium == 0 then
			print('Il Giocatore ' .. GetPlayerName(_source) .. ' rimosso dalla tabella trivellazioni')
			giocatori[identifier] = nil
		else
			print('Il Giocatore ' .. GetPlayerName(_source) .. ' è uscito ma non viene rimosso poiche\' utente premium!')
		end
	end
end)