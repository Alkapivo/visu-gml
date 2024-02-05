///@package io.alkapivo.visu.service.player

/* 
///@todo add to VisuTrackLoader as player.json
var playerTemplate = {
  name: "player_default",
  sprite: {
    name: "texture_test",
    animate: true,
  },
  keyboard: {
    up: "W",
    down: "S",
    left: "A",
    right: "D",
  },
  gameModes: {
    bulletHell: {
      x: {
        speed: 0,
        speedMax: 1.1 * 0.01,
        acceleration: 2.2 * 0.0006,
        friction: 2.1 * 0.0003,
      },
      y: {
        speed: 0,
        speedMax: 2.1 * 0.01,
        acceleration: 3.2 * 0.0006,
        friction: 3.1 * 0.0003,
      }
    },
    platformer: {
      x: {
        speed: 0,
        speedMax: 2.1 * 0.01,
        acceleration: 3.2 * 0.0006,
        friction: 3.1 * 0.0003,
      },
      y: {
        speed: 0,
        speedMax: 2.1 * 0.01,
        acceleration: 3.2 * 0.0006,
        friction: 3.1 * 0.0003,
      }
    },
  },
}
*/

///@param {Struct} json
function PlayerTemplate(json) constructor {

  ///@type {String}
  name = Assert.isType(Struct.get(json, "name"), String)

  ///@type {Struct}
  sprite = Assert.isType(json.sprite, Struct)

  ///@type {Keyboard}
  keyboard = Assert.isType(new Keyboard(Struct.contains(json, "keyboard")
    ? json.keyboard
    : { up: "W", down: "S", left: "A", right: "D" }
    ), Keyboard)

  ///@type {Map<String, PlayerGameMode>}
  gameModes = Struct.toMap(json.gameModes).map(function(_json, key) {
    return Callable.run(Assert.isType(Struct.get(PLAYER_GAME_MODES, key),
      Callable, "gameModeFactory"), _json)
  })
}

///@param {PlayerTemplate} [config]
function Player(config = {}): GridItem(config) constructor {

  ///@type {String}
  name = config.name

  ///@type {Keyboard}
  keyboard = config.keyboard
  
  ///@type {Map<String, PlayerGameMode>}
  gameModes = config.gameModes

  ///@return {Player}
  update = method(this, function(controller) {
    this.keyboard.update()
    var gameMode = this.gameModes.get(controller.gameMode)
    if (Optional.is(gameMode)) {
      gameMode.update(this, controller)
    }
    return this
  })
}
