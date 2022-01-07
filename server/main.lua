ESX               = nil
local giocatori = {}
local farmOggetti = {
	[0] = {
		Strumenti = {
			["piccone_di_ferro"] = {
				label = "Piccone di Ferro",
				qty = 5
			}
		},
		Minerali =  {
			["marna_da_cemento"] = {
				label = "Marna da Cemento",
				farm = 75,
				pesoItem = 2500
			}
		}
	},
	[1] = {
		Strumenti = {
			["piccone_di_ferro"] = {
				label = "Piccone di Ferro",
				qty = 7
			}
		},
		Minerali =  {
			["marna_da_cemento"] = {
				label = "Marna da Cemento",
				farm = 40,
				pesoItem = 2500
			},
			["carbone"] = {
				label = "Carbone",
				farm = 30,
				pesoItem = 2500
			}
		}
	},
	[2] = {
		Strumenti = {
			["piccone_di_ferro"] = {
				label = "Piccone di Ferro",
				qty = 20
			},
			["lampade"] = {
				label = "Lampade",
				qty = 5
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
		Strumenti = {
			["piccone_di_ferro"] = {
				label = "Piccone di Ferro",
				qty = 30
			},
			["carretto_di_ferro"] = {
				label = "Carretto di Ferro",
				qty = 3
			},
			["lampade"] = {
				label = "Lampade",
				qty = 10
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
		Strumenti = {
			["attrezzatura_da_scavi"] = {
				label = "Attrezzatura da Scavi",
				qty = 10
			},
			["carretto_di_ferro"] = {
				label = "Carretto di Ferro",
				qty = 2
			},
			["lampadine"] = {
				label = "Lampadine",
				qty = 5
			},
			["benzina_industriale"] ={
				label = "Benzina Industriale",
				qty = 10
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
		Strumenti = {
			["attrezzatura_da_scavi"] = {
				label = "Attrezzatura da Scavi",
				qty = 40
			},
			["cavi_industriali"] = {
				label = "Cavi Industriali",
				qty = 15
			},
			["carretto_di_ferro"] = {
				label = "Carretto di Ferro",
				qty = 5
			},
			["benzina_industriale"] ={
				label = "Benzina Industriale",
				qty = 30
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
				

				giocatori[v.identifier] = {
					identificatore = v.identifier,
					agg1 = v.agg1,
					agg2 = v.agg2,
					agg3 = v.agg3,
					agg4 = v.agg4,
					livello = valoreFinale,
					storage = v.agg5,
					premium = v.premium
				}

				threadGiocatore(v.identifier)
			end
		end
	end)
end)

local ThreadAttivi = 0

function threadGiocatore(_k)
	local k = _k
	local TempoAttesa = (15 * 60) * 1000
	local TempoIniziale = TempoAttesa

	ThreadAttivi = ThreadAttivi + 1

	print("[Dog Pillar] - Thread Numero [".. ThreadAttivi .."] per [" .. k .. "] Attivato.")

	Citizen.CreateThread(function()
		while true do
			local Avvisi = {
				[1] = false, 
				[2] = false
			}

			while TempoAttesa > 0 do 
				Citizen.Wait(10000)
				TempoAttesa = TempoAttesa - 10000

				if TempoAttesa <= (TempoIniziale * 0.75) and not Avvisi[1] then
					Avvisi[1] = true
					AvvisoAttrezzi()
				end
				
				if TempoAttesa <= (TempoIniziale * 0.5) and not Avvisi[2] then 
					Avvisi[2] = true
					AvvisoAttrezzi()
				end

				if not giocatori[k] then 
					print("[Dog Pillar] - Thread Numero [".. ThreadAttivi .."] per [" .. k .. "] Chiuso.")
					ThreadAttivi = ThreadAttivi - 1
					return
				end
			end

			print('\n--------------\n')
			daiOggettiGiocatore(k, giocatori[k].livello, giocatori[k].storage)
			print('\n['.. os.date("%H:%M") .. '] '..'- [Dog Pillar] ' .. k .. ' servito.')
			print('\n--------------\n')
			TempoAttesa = TempoIniziale
		end
	end)

	function AvvisoAttrezzi()
		local Giocatore =  ESX.GetPlayerFromIdentifier(k)
		if Giocatore then
			if Giocatore.getNotifyStatus() then
				ottieniInventario("miniera_" .. k, function(risultato) 
					if risultato then 
						local puo = isAbleToMine(k, risultato, Giocatore)

						if not puo then 
							if Giocatore then
								if Giocatore.getNotifyStatus() then
									Giocatore.triggerEvent('esx:showNotification', "Non possiedi abbastanza attrezzi per continuare ad estrarre risorse, hai [" .. string.format("%.1f", ((TempoAttesa/(1000*60))%60)) .. "m] per rimediare!")
								end
							end
						end
					else
						print("[Dog Pillar] - Errore nel caricamento dell'Inventario Attrezzi per il Giocatore " .. k .. "!!!")
			
						if Giocatore then
							Giocatore.showNotification("Errore durante il Caricamento del tuo Deposito Attrezzi, Contatta lo Staff!")
						end
					end
				end)
			end
		end
	end
end

RegisterCommand("threadMiniera", function(source, args, raw)
	if source > 0 then 
		local Giocatore = ESX.GetPlayerFromId(source)

		if Giocatore then
			if Giocatore.controllaGrado("helper") then
				--[[if args[1] then 
					for i = 1, tonumber(args[1]), 1 do
						threadGiocatore(Giocatore.getIdentifier())
					end
				end]]

				Giocatore.showNotification("I Thread attualmente Attivi sono [" .. ThreadAttivi .. "]")
			end
		end
	else
		print("[Dog Pillar] - Thread Attualmente Attivi: " .. ThreadAttivi)
	end
end, true)

function daiOggettiGiocatore(identificatoreGiocatore, minieraLV, storage)
	local inventario = nil
	local oggetti    = nil 
	local testoGiocatore = nil

	if ESX.GetPlayerFromIdentifier(identificatoreGiocatore) ~= nil then
		testoGiocatore = ESX.GetPlayerFromIdentifier(identificatoreGiocatore)
	end

	ottieniInventario("raccolta_miniera_" .. identificatoreGiocatore, function(risultato)
		if risultato then 
			inventario = risultato
		else
			print("[Dog Pillar] - Errore nel caricamento dell'Inventario per il Giocatore " .. identificatoreGiocatore .. "!!!")

			if testoGiocatore then
				testoGiocatore.showNotification("Errore durante il Caricamento del tuo Deposito Minerali, Contatta lo Staff!")
			end
		end
	end)

	ottieniInventario("miniera_" .. identificatoreGiocatore, function(risultato) 
		if risultato then 
			oggetti = risultato
		else
			print("[Dog Pillar] - Errore nel caricamento dell'Inventario Attrezzi per il Giocatore " .. identificatoreGiocatore .. "!!!")

			if testoGiocatore then
				testoGiocatore.showNotification("Errore durante il Caricamento del tuo Deposito Attrezzi, Contatta lo Staff!")
			end
		end
	end)

	local hint = 0
	while inventario == nil or oggetti == nil do 
		Wait(100)
		if hint == 10000 then
			print("[Dog Pillar] - Errore durante il caricamento degli Inventari per il giocatore [" .. identificatoreGiocatore .. "]!")
			testoGiocatore.showNotification("Errore durante il caricamento degli Inventari Miniera, Contatta lo Staff!")
			return
		else
			hint = hint + 100
		end
	end
	
	local pesoDeposito = 0

	for i=1, #inventario, 1 do 
		if ESX.Items[inventario[i].name] ~= nil and ESX.Items[inventario[i].name].weight ~= nil and inventario[i].type == 'item_standard' then 
			pesoDeposito = pesoDeposito + (ESX.Items[inventario[i].name].weight * inventario[i].count)
		end
	end

	local pesoLimite = Config.PesoBase

	if storage == 1 then
		pesoLimite = pesoLimite * 2
	elseif storage == 2 then
		pesoLimite = pesoLimite * 3
	elseif storage == 3 then
		pesoLimite = pesoLimite * 4
	end
	
	oggetti = isAbleToMine(identificatoreGiocatore, oggetti, testoGiocatore)

	if oggetti then
		local ArrayMessaggero = {}
		local oggettiFarmati = 0 

		for k,v in pairs(farmOggetti[minieraLV].Minerali) do 
			local qty = v.farm
			local pesoDepositoNuovo = pesoDeposito + (v.pesoItem * qty)

			if pesoLimite >= pesoDepositoNuovo then 
				pesoDeposito = pesoDepositoNuovo
			else
				qty = 0
				for i = 1, v.farm , 1 do 
					pesoDepositoNuovo = pesoDeposito + v.pesoItem

					if pesoLimite >= pesoDepositoNuovo then
						pesoDeposito = pesoDepositoNuovo
						qty = i 
					else
						break
					end
				end
			end
			
			if qty > 0 then 
				oggettiFarmati = oggettiFarmati + 1 
				table.insert(ArrayMessaggero, {
					nomeItem = k,
					daAggiungere = qty,
					testo = "Depositati <span style='color:#ff00ff'>[" .. qty .. "x]</span>  di <span style='color:#00ff00'>[" .. v.label .. "]</span> nel tuo Deposito Minerario.",
					testoDiscord = "**[" .. v.label .. "]** - Inserite " .. "**[" .. qty .. "]** unità."
				})
			else
				table.insert(ArrayMessaggero, {
					nomeItem = nil,
					daAggiungere = nil,
					testo = "Non è stato possibile depositare <span style='color:#9400D3'>[" .. v.label .. "]</span>, spazio non sufficiente.",
					testoDiscord = "**[".. v.label .."]** - **Impossibile** depositare **nuove unità**."
				})
			end
		end
		
		
		local discordMessage = {}
		for i = 1, #ArrayMessaggero, 1 do 
			if ArrayMessaggero[i].nomeItem ~= nil then 
				local trovato = false
				for j = 1, #inventario, 1 do 
					if ArrayMessaggero[i].nomeItem == inventario[j].name then
						inventario[j].count = inventario[j].count + ArrayMessaggero[i].daAggiungere
						trovato = true 
						break
					end
				end

				if not trovato then
					table.insert(inventario,{
						type = "item_standard",
						name = ArrayMessaggero[i].nomeItem,
						count = ArrayMessaggero[i].daAggiungere
					})
				end
			end

			if ArrayMessaggero[i].testoDiscord then
				table.insert(discordMessage, ArrayMessaggero[i].testoDiscord)
			end
		end
		
		if oggettiFarmati > 0 then 
			TriggerEvent("inventario:aggiornaMiniera", {identificativo = "raccolta_miniera_" .. identificatoreGiocatore, tipologia = "deposito_miniera"}, inventario)
			TriggerEvent("inventario:aggiornaMiniera", {identificativo = "miniera_" .. identificatoreGiocatore, tipologia = "deposito_miniera"}, oggetti)
		else
			if testoGiocatore then 
				Wait(2000)
				if testoGiocatore.getNotifyStatus() then
					testoGiocatore.triggerEvent('esx:showNotification', "Non è stato possibile estrarre risorse poichè non vi è abbastanza Spazio Disponibile!", "error", 10000, "Dog Pillar")
				end
			end
		end

		if testoGiocatore then
			Wait(100)
			TriggerClientEvent('inventario:refresh', testoGiocatore.source) -- Previene Bug Abusing
			inviaMessaggi(ArrayMessaggero, testoGiocatore)
			inviaEmbeded("**[".. identificatoreGiocatore .."]**", 2067276, discordMessage)
		end
	else
		if testoGiocatore then 
			Wait(2000)
			if testoGiocatore.getNotifyStatus() then
				testoGiocatore.triggerEvent('esx:showNotification', "Non è stato possibile estrarre risorse poichè non vi sono abbastanza Attrezzi!", "error", 10000, "Dog Pillar")
			end
		end
	end
end

function inviaMessaggi(arrayMessaggi, giocatore)
	if giocatore.getNotifyStatus() then
		Citizen.CreateThread(function()
			for i = 1, #arrayMessaggi, 1 do 
				Citizen.Wait(math.random(1000,2500))
				if giocatore then 
					giocatore.triggerEvent('esx:showNotification', arrayMessaggi[i].testo, "info", 5000, "Dog Pillar")
				else
					break
				end
			end
		end)
	end
end

function ottieniInventario(deposito, callback)
	local inventario = exports.inventario:prendiInventario(deposito, "deposito_miniera")
	callback(inventario)
end

function isAbleToMine(identifica, _inventario, _testoGiocatore)
	local inventario = _inventario
	local testoGiocatore = _testoGiocatore

	if giocatori[identifica] then
		local hint = 0

		for k,v in pairs(farmOggetti[giocatori[identifica].livello].Strumenti) do 
			local trovato = {
				presente = false,
				differenza = 0
			}

			for i = 1, #inventario, 1 do 
				if inventario[i].name == k then 
					if inventario[i].count >= v.qty then 
						inventario[i].count = inventario[i].count - v.qty
						trovato.presente = true
					else
						trovato.differenza = v.qty - inventario[i].count
					end

					break
				end
			end

			if not trovato.presente then 
				if testoGiocatore then 
					if testoGiocatore.getNotifyStatus() then 
						if trovato.differenza == 0 then trovato.differenza = v.qty end
						testoGiocatore.triggerEvent('esx:showNotification', "Quantità di <span style='color:#00ff00'>".. v.label .."</span> nella tua <span style='color:#3399ff'>Miniera</span> insufficiente! <span style='color:#ff00ff'>[x".. trovato.differenza .." Mancanti!]</span>", "error", 7500, "Dog Pillar")
						Citizen.Wait(1000)
					end
				end
				hint = hint + 1
			end
		end

		if hint > 0 then
			return false
		else
			return inventario
		end
	end
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
				
				threadGiocatore(steamid)

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
					TriggerClientEvent('esx:showNotification', source, 'Salve! Noi di Dog Pillar depositeremo ogni 15 minuti le risorse ricavate nel tuo magazzino!', "success", 6000, "Dog Pillar")
					
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

					threadGiocatore(steamid)

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

RegisterCommand("printUtentiMiniera", function(source, raw, args)
	print(ESX.DumpTable(giocatori))
end, true)

RegisterCommand("tickMiniera", function(source, args, raw)
	if source > 0 then 
		local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer.controllaGrado("admin") then
			if args[1] then 
				if GetPlayerName(tonumber(args[1])) then 
					local xTarget = ESX.GetPlayerFromId(tonumber(args[1]))
					local steamid = xTarget.getIdentifier()

					if giocatori[steamid] then 
						daiOggettiGiocatore(steamid, giocatori[steamid].livello, giocatori[steamid].storage)
						xTarget.showNotification("Tick Miniera")
					else
						xTarget.showNotification("Non possiedi una Miniera")
					end
				else
					xPlayer.showNotification("Giocatore non Trovato!")
				end
			else
				local steamid = xPlayer.getIdentifier()

				if giocatori[steamid] then 
					daiOggettiGiocatore(steamid, giocatori[steamid].livello, giocatori[steamid].storage)
					xPlayer.showNotification("Tick Miniera")
				else
					xPlayer.showNotification("Non possiedi una Miniera")
				end
			end
		end
	else
		if args[1] then 
			local xTarget = ESX.GetPlayerFromId(tonumber(args[1]))
			local steamid = xTarget.getIdentifier()

			if giocatori[steamid] then 
				daiOggettiGiocatore(steamid, giocatori[steamid].livello, giocatori[steamid].storage)
				xTarget.showNotification("Tick Miniera")
			else
				xTarget.showNotification("Non possiedi una Miniera")
			end
		end
	end
end, true)

function inviaEmbeded(nome, color, messaggio)
	local descrizione = ""

	for i = 1, #messaggio, 1 do
		descrizione = descrizione .. "\n" .. messaggio[i]
	end

	local tabella = {
		{
			["color"] = color,
			["title"] = "Tick Miniera " .. nome,
			["description"] = descrizione,
			["footer"] = {
				["text"] = "SGG Log | " .. os.date("%d/%m/%Y - %X"),
			},
		}
	}

	PerformHttpRequest(Config.DiscordChannel, function(err, text, headers) end, 'POST', json.encode({username = "Dog Pillar", embeds = tabella, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end