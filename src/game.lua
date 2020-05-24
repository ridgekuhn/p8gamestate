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
	level_init()

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

