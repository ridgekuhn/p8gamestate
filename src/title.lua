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

