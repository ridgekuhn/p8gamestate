--app

--describe the app fsm
app = {
  states = {
    title = {},
    config = {},
    game = {}
  }
}

---initialize the app
function _init()
  set_p8loop(app, 'title')
end

---override the p8 game loop
--replaces the default
--_draw() and _update()
--functions with ones from
--a specified fsm,
--and optionally runs
--an init function
--
--@todo the previous _draw()
--  function will still run
--  after this. we could
--  call the new _update()
--  at the end of the function,
--  but this risks recursion if
--  the new state tries to
--  switch back to
--  the old state.
--  eg, active user input
--  when switching between
--  the title and config states
--
--@param fsm table (required)
--  the fsm to load the
--  override functions from
--
--@param state string (required)
--  the state to set the fsm to
--
--@param init boolean (optional)
--  whether to run
--  the .init() function or not
function set_p8loop(fsm, state, init)
	_update = fsm.states[state].update
	_draw = fsm.states[state].draw

	if(init and type(fsm.states[state].init == 'function')) then
		fsm.states[state].init()
	end
end
