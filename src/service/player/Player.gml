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
  keyboard = new Keyboard(json.keyboard)

  ///@type {Struct}
  gameModes = Struct.appendUnique(
    Struct.filter(Struct.getDefault(json, "gameModes", {}), function(gameMode, key) { 
      return Core.isType(gameMode, Struct) && Core.isEnum(key, GameMode)
    }),
    PLAYER_GAME_MODES.toStruct(function() { return {} })
  )

  ///@return {Struct}
  serialize = function() {
    var json = {
      sprite: this.sprite,
      gameModes: this.gameModes,
      keyboard: this.keyboard,
    }

    return JSON.clone(json)
  }
}

///@param {PlayerTemplate} json
function Player(template): GridItem(template) constructor {

  ///@type {Keyboard}
  keyboard = Assert.isType(template.keyboard, Keyboard)

  ///@private
  ///@param {VisuController} controller
  ///@return {GridItem}
  _update = method(this, this.update)
  
  ///@override
  ///@return {GridItem}
  update = function(controller) {
    this.keyboard.update()
    this._update(controller)
    return this
  }

  this.gameModes
    .set(GameMode.IDLE, PlayerIdleGameMode(Struct
      .getDefault(Struct.get(template, "gameModes"), "idle", {})))
    .set(GameMode.BULLETHELL, PlayerBulletHellGameMode(Struct
      .getDefault(Struct.get(template, "gameModes"), "bulletHell", {})))
    .set(GameMode.PLATFORMER, PlayerPlatformerGameMode(Struct
      .getDefault(Struct.get(template, "gameModes"), "platformer", {})))
}
