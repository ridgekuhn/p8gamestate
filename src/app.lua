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
