pico-8 cartridge // http://www.pico-8.com
version 27
__lua__
--app

app = {}
app.state = 'title'

function _init()
	if(app.state == 'title') then
		title_init()
		
	elseif(app.state == 'config') then
		config_init()
	
	elseif(app.state == 'game') then
		game_init()
		
	end
end
-->8
--title state

function title_init()
	_update = title_update
	_draw = title_draw
end

function title_update()
	if(btnp(🅾️)) then
		app.state = 'game'
		game.state = 'init'
		_init()
	elseif(btnp(❎)) then
		app.state = 'config'
		_init()
	end
end

function title_draw()
	cls()
	print('hello, world!')
	print('🅾️ - start game')
	print('❎ - config')
end
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
-->8
--game state

game = {}
game.state = 'init'

function game_init()
	if(game.state == 'init') then
		game.clock = 0
		level.state = 'start'
		level.n = cfg.lvl > 1 and cfg.lvl or 1
		game.state = 'running'
		_init()
		
	elseif(game.state == 'running') then
		_update = game_running_update
		_draw = game_running_draw
		
	elseif(game.state == 'over') then
		_update = game_over_update
		_draw = game_over_draw
	end
end

function game_running_update()
	if(level.state == 'start') then
		level_start_update()
		
	elseif(level.state == 'running') then
		level_running_update()
		
	elseif(level.state == 'end') then
		level_end_update()
	end
	
	level.clock = level.clock + 1
end

function game_running_draw()
	cls()
	print('level #:'..tostr(level.n))
	print('lvlstate:'..level.state)
	print('lvlname:'..levels[level.n].name)
	print('lvldiff:'..tostr(levels[level.n].difficulty))
	print('lvlclock:'..tostr(level.clock))
end

function game_over_update()
	if(btnp(🅾️)) then
		game.state = 'init'
		_init()
		
	elseif(btnp(❎)) then
		app.state = 'title'
		_init()
	end
end

function game_over_draw()
	cls()
	print('game over!')
	print('🅾️ - restart game')
	print('❎ - title screen')
end
-->8
--level state

level = {}
level.n = 1
level.state = 'start'
level.clock = 0

levels = {
	[1] = {
		name = 'foo',
		difficulty = 50
	},
	[2] = {
		name = 'bar',
		difficulty = 100
	},
	[3] = {
		name = 'whatever',
		difficulty = 9999
	}
}

function level_start_update()
	if(level.clock >= 90) then
		level.state = 'running'
		level.clock = 0
		_init()
	end
end

function level_running_update()
	if(level.clock >= 90) then
		level.state = 'end'
		level.clock = 0
		_init()
	end
end

function level_end_update()
	if(level.clock >= 90) then
		level.n = level.n + 1
		
		if(level.n > #levels) then
			game.state = 'over'
			_init()
		end
		
		level.state = 'start'
		level.clock = 0
		_init()
	end
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
