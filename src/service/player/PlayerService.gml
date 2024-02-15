///@package io.alkapivo.visu.service.player

///@param {Controller} _controller
///@param {Struct} [config]
function PlayerService(_controller, config = {}): Service() constructor {

  ///@type {Controller}
  controller = Assert.isType(_controller, Struct)

  ///@type {?Player}
  player = null

  ///@type {?GameMode}
  gameMode = null

  ///@type {EventPump}
  dispatcher = new EventPump(this, new Map(String, Callable, {
    "spawn-player": function(event) {
      if (!Core.isType(this.player, Player)) {
        var view = this.controller.gridService.view
        this.set(this.factoryPlayer(
          view.x + (view.width / 2.0),
          view.y + (view.height / 2.0)
        ))

        this.player.updateGameMode(this.controller.gameMode)
      }
    },
  }))

  ///@private
  ///@param {Number} [x]
  ///@param {Number} [y]
  ///@param {PlayerTemplate} [_template]
  ///@return {Player}
  factoryPlayer = function(x = 0, y = 0, _template = null) {
    var template = Core.isType(_template, PlayerTemplate) 
      ? _template
      : new PlayerTemplate({
        name: "player_default",
        sprite: {
          name: "texture_player",
          animate: true,
        },
        keyboard: {
          up: "W",
          down: "S",
          left: "A",
          right: "D",
          action: "E",
        },
        gameModes: {
          idle: {},
          bulletHell: {
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
          platformer: {
            x: {
              speed: 0,
              speedMax: 2.1 * 0.01,
              acceleration: 3.2 * 0.0006,
              friction: 3.1 * 0.0003,
            },
            y: {
              speed: 0,
              speedMax: 0.25,
              acceleration: 0.0015,
              friction: 0,
            },
            jumpSize: 0.035,
          },
        },
      })
    Struct.set(template, "x", x)
    Struct.set(template, "y", y)
    return new Player(template)
  }

  ///@param {Player}
  ///@return {PlayerService}
  set = function(player) {
    if (!Core.isType(player, Player)) {
      return this
    }
    this.remove().player = player
    return this
  }

  ///@return {PlayerService}
  remove = function() {
    this.player = null
    return this
  }

  ///@param {Event} event
  ///@return {Promise}
  send = function(event) {
    if (!Core.isType(event.promise, Promise)) {
      event.promise = new Promise()
    }
    return this.dispatcher.send(event)
  }

  ///@override
  ///@return {PlayerService}
  update = function() {
    this.dispatcher.update()
    if (Core.isType(this.player, Player)) {
      if (this.controller.gameMode != this.gameMode) {
        this.gameMode = this.controller.gameMode
        this.player.updateGameMode(this.gameMode)
      }
      
      this.player.update(this.controller)
    }
    return this
  }
}
