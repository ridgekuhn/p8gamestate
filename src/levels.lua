-->8
--level game state
--@see /src/game.lua
--@see /src/config.lua

--describe the level fsm
level = {
  --draw(), @see /src/game.lua and below
  --update(), @see /src/game.lua and below
  states = {
    start = {},
    running = {},
    over = {}
  },
  --describe level data
	[1] = {
		name = 'foo',
		difficulty = 50,
    camera = {0, 0}
	},
	[2] = {
		name = 'bar',
		difficulty = 100,
    camera = {64, 64}
	},
	[3] = {
		name = 'whatever',
		difficulty = 9999,
    camera = {0, 0}
	}
}

--set default level properties
level.n = 1
level.clock = 0

function level.init()
  --get config
  level.n = cfg.level or 1
end

function level.change_state(state, init)
  level.update = level.states[state].update
  level.draw = level.states[state].draw

  if(init) then
    level.init()
  end

  level.clock = 0
end

function level.states.start.update()
	if(level.clock >= 90) then
		level.change_state('running')
	end

	level.clock = level.clock + 1
end

function level.states.start.draw()
  print('lvlstate: start')
  print('ready...')
end

function level.states.running.update()
	if(level.clock >= 90) then
		level.change_state('over')
	end

	level.clock = level.clock + 1
end

function level.states.running.draw()
  print('lvlstate: running')
  if(level.clock < 30) then
    print('go!!!')
  end
end

function level.states.over.update()
	if(level.clock >= 90) then
		level.n = level.n + 1

		if(level.n > #level) then
			set_p8loop(game, 'over')
		end

		level.change_state('start')
	end

	level.clock = level.clock + 1
end

function level.states.over.draw()
  print('lvlstate: over')
  print('level cleared!')
end
