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

function level_init()
	if(level.state == 'start') then
		level_start_update()

	elseif(level.state == 'running') then
		level_running_update()

	elseif(level.state == 'end') then
		level_end_update()
	end
end

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

