fx_version 'adamant'

game 'gta5'

description 'Lavoro Automatico by Nitesam'

version '1.0'

ui_page "index.html"

files {
	"index.html",
	"assets/fonts/fontawesome5-overrides.min.css",
	"assets/img/product-aeon-feature.jpg",
	"assets/css/styles.min.css",
	"assets/js/script.min.js"
}

--ui_page "nui/ui.html"

--[[files {
    "nui/ui.html",
    "nui/material-icons.ttf",
    "nui/material-icons.css",
    "nui/loadscreen.jpg",
    "nui/fancy-crap.css",
    "nui/fancy-crap.js",
    "nui/jquery.min/js",
    "nui/html/acquisto.html",
    "nui/html/aggiornamenti.html",
    "nui/bootstrap.min.css",
    "nui/html/assets/img/slide1.jpg",
    "nui/html/assets/img/slide2.jpg",
    "nui/html/assets/css/style.css",
    "nui/html/assets/css/styles.min.css",
	"nui/html/assets/bootstrap/css/bootstrap.min.css",
	"nui/html/assets/bootstrap/js/bootstrap.min.js",
	"nui/html/assets/js/script.min.js",
	"nui/html/assets/js/jquery.min.js",
	"nui/html/assets_aggiornamento/img/attrezzi.jpg",
    "nui/html/assets_aggiornamento/img/personale.jpg",
    "nui/html/assets_aggiornamento/img/doppiocavo.jpg",
    "nui/html/assets_aggiornamento/script.min.js",
    "nui/html/assets_aggiornamento/fonts/font-awesome.min.css",
    "nui/html/assets_aggiornamento/fonts/FontAwesome.otf",
    "nui/html/assets_aggiornamento/fonts/fontawesome5-overrides.min.css",
    "nui/html/assets_aggiornamento/fonts/fontawesome-all.min.css",
    "nui/html/assets_aggiornamento/fonts/fontawesome-webfont.eot",
    "nui/html/assets_aggiornamento/fonts/fontawesome-webfont.svg",
    "nui/html/assets_aggiornamento/fonts/fontawesome-webfont.ttf",
    "nui/html/assets_aggiornamento/fonts/fontawesome-webfont.woff",
    "nui/html/assets_aggiornamento/fonts/fontawesome-webfont.woff2",
    "nui/html/assets_aggiornamento/styles.min.css"
}	]]

client_scripts {
    "client/main.lua",
    "config.lua",
}

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	"@es_extended/locale.lua",
    "server/main.lua",
    "config.lua",
}








