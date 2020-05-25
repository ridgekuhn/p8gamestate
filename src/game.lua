-->8
--game app state
--@see /src/app.lua
--@see /src/levels.lua

--describe the game fsm
game = {
  states = {
    init = app.states.game.init,
    running = {},
    over = {}
  }
}

--set default game properties
game.clock = 0

---initialize the game app state
function app.states.game.init()
  --run the game fsm
	set_p8loop(game, 'running')
  --start the level fsm
  level.change_state('start', true)

  game.clock = 0
end

---update game while running
function game.states.running.update()
	level.update()

  game.clock = game.clock + 1
end

---draw game while running
function game.states.running.draw()
	cls()
  print('level #:'..tostr(level.n))
	print('lvlname:'..level[level.n].name)
	print('lvldiff:'..tostr(level[level.n].difficulty))
	print('lvlclock:'..tostr(level.clock))
  print('gameclock:'..tostr(game.clock))
  level.draw()
end

---update game when over
function game.states.over.update()
	if(btnp(🅾️)) then
		set_p8loop(app, 'game', true)

	elseif(btnp(❎)) then
    set_p8loop(app, 'title')
	end
end

---draw game when over
function game.states.over.draw()
	cls()
	print('game over!')
	print('🅾️ - restart game')
	print('❎ - title menu')
end

