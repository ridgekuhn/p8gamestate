-->8
--title menu app state

---update title menu
--allow user to enter
--game or config menu
function app.states.title.update()
	if(btnp(🅾️)) then
    set_p8loop(app, 'game', true)
	elseif(btnp(❎)) then
    set_p8loop(app, 'config')
	end
end

---draw title menu
function app.states.title.draw()
	cls()
	print('hello, world!')
	print('🅾️ - start game')
	print('❎ - config menu')
end

