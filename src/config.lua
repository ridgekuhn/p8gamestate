-->8
--config state

cfg = {}
cfg.lvl = 1

function config_init()
	_update = config_update
	_draw = config_draw
end

function config_update()
	if(btnp(⬆️) and cfg.lvl < 3) then
		cfg.lvl = cfg.lvl + 1
	elseif(btnp(⬇️) and cfg.lvl > 1) then
		cfg.lvl = cfg.lvl - 1
	end

	if(btnp(🅾️)) then
		app.state = 'game'
		game.state = 'init'
		level.n = cfg.lvl
		_init()

	elseif(btnp(❎)) then
		app.state = 'title'
		_init()
	end
end

function config_draw()
	cls()
	print('level: '..tostr(cfg.lvl))
	print('⬆️,⬇️ - change level')
	print('🅾️ - start game')
	print('❎ - title screen')
end

