fx_version 'adamant'
games { 'rdr3', 'gta5' }

author 'Benzo#6565, xz-scripts'


shared_scripts  {
	'@es_extended/imports.lua',
	'shared/config.lua',
}

client_scripts { 
	'client/client.lua',
	'client/qtarget.lua',
}
server_scripts {
  'server/server.lua',
}

