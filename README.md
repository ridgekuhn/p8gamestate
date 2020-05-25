An unnecessarily verbose framework for managing game state in [Pico-8](https://www.lexaloffle.com/pico-8.php), inspired by @MBoffin's much less verbose [Game States](https://mboffin.itch.io/pico8-game-states) demo carts. Most likely a perpetual work-in-progress!

Also see:
* [Lexaloffle BBS Post](https://www.lexaloffle.com/bbs/?tid=38107)
* [GitHub Repo](https://github.com/ridgekuhn/p8gamestate)

## Features
* Title Menu
* Config Menu
* Multiple Game States
* Multiple Game Level States

### Finite State Machine Hierarchy
```
App
|_App States
  |_Title Menu App State
  |_Config Menu App State
  |_Game App State
    |_Init
      |_(Game)

Game
|_Game States
  |_Running
  | |_(Level)
  |_Over

Level
|_Level States
  |_Start
  |_Running
  |_Over
```

## Usage
### App State
App state is handled by a central function, [set_p8loop()](https://github.com/ridgekuhn/p8gamestate/blob/master/src/app.lua#L48-L55), which replaces the default Pico-8 `_update()` and `_draw()` functions with ones we define in a Lua table representing a finite state machine (FSM):
```
function set_p8loop(fsm, state, init)
  _update = fsm.states[state].update
  _draw = fsm.states[state].draw

  if(init and type(fsm.states[state].init == 'function')) then
    fsm.states[state].init()
  end
end
```

The FSM should follow this structure for it to work:
```
my_cool_fsm = {
  states = {
    my_cool_state = {
      init = //optional init function,
      update = //the new update() function,
      draw = //the new _draw() function
    }
  }
}
```

Now we can call `set_p8loop()` and pass in our new FSM and desired state as parameters. After the function exits, `_update()` and `_draw()` will be reassigned to `my_cool_fsm.states.my_cool_state.update()` and `my_cool_fsm.states.my_cool_state.draw()`.
```
set_p8loop(my_cool_fsm, 'my_cool_state')
```

If this is the first time we've changed the app to this state, or if we want to reinitialize the state, we can also pass `true` as the third parameter to run `my_cool_fsm.states.my_cool_state.init()` (if it exists).
```
set_p8loop(my_cool_fsm, 'my_cool_state', true)
```

### Level State
The framework contains a similar method for handling level state.

While the game is running, we call a placeholder function `level.update()` in [game.states.running.update()](	level.update()), and a placeholder function `level.draw()` in [game.states.running.draw()](https://github.com/ridgekuhn/p8gamestate/blob/997beef50cd213ea055598244bc39b32651015b1/src/game.lua#L43).

Each is assigned to the appropriate function when we call [level.change_state()](https://github.com/ridgekuhn/p8gamestate/blob/997beef50cd213ea055598244bc39b32651015b1/src/levels.lua#L42-L51), and we can also optionally run an init function:
```
function level.change_state(state, init)
  level.update = level.states[state].update
  level.draw = level.states[state].draw

  if(init) then
    level.init()
  end

  level.clock = 0
end
```

This allows us to inject anything we need to update or draw the level into the Pico-8 loop while our game is running, like incrementing a level clock, printing messages like 'Ready...Go!', or tabulating the player's score at the end of the level. 

This pattern could also be replicated for other FSMs which you might want to inject into the Pico-8 loop while the game is running, like updating/drawing characters, etc, and might be a good candidate for an actor method in an OOP paradigm.

## Drawbacks
### Tokens
This framework is very verbose and consumes many tokens in Pico-8. I wrote it this way because it's my first Pico-8 (and Lua) project and I wanted it to be easy to read, but I also believe that it's easier to remove complexity than to add it! Maybe. 😅

### Draw Before Update
One other drawback is that when we reassign `_update()` and `_draw()` in the middle of the Pico-8 loop, the new `_draw` will run before the new `_update()`. (Because `_draw()` is reassigned before it runs in the current Pico-8 loop, but the new `_update()` won't have a chance to run until the next loop.)

One possible workaround would be to call `_update()` at the end of `set_p8loop()`, but this risks a recursion if the new state's `_update()` tries to change back to the old state. One example of this is when trying to switch between the title menu and the config menu. Each relies on the user pushing ❎ to switch between them, but when we enter the new state, the user input is still active and the app switches back to the old state, and back again, etc.

The best workaround is probably to run the appropriate `.init()` function when entering the state, and make sure anything we need to be drawn is declared there rather than in the new `_update()` function.

I hope this is all useful to someone! Happy coding! 😃

