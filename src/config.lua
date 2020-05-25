-->8
--config menu app state
--@see /src/app.lua

--set config vars
cfg = {
  level = 1
}

---update config menu
--allow user to select
--a starting level
--and begin the game,
--or exit to title menu
function app.states.config.update()
	if(btnp(⬆️) and cfg.level < 3) then
		cfg.level = cfg.level + 1
	elseif(btnp(⬇️) and cfg.level > 1) then
		cfg.level = cfg.level - 1
	end

	if(btnp(🅾️)) then
		set_p8loop(app, 'game', true)

	elseif(btnp(❎)) then
    set_p8loop(app, 'title')
	end
end

---draw config menu
function app.states.config.draw()
	cls()
	print('level: '..tostr(cfg.level))
	print('⬆️,⬇️ - change level')
	print('🅾️ - start game')
	print('❎ - title menu')
end

