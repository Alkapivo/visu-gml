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
      var view = this.controller.gridService.view
      var _x = view.x + (view.width / 2.0)
      var _y = view.y + (view.height / 2.0)
      if (Core.isType(this.player, Player)) {
        _x = this.player.x
        _y = this.player.y
      }

      var template = {
        name: "player_default",
        sprite: {
          name: "texture_player",
          animate: true,
        },
        keyboard: {
          up: KeyboardKeyType.ARROW_UP,
          down: KeyboardKeyType.ARROW_DOWN,
          left: KeyboardKeyType.ARROW_LEFT,
          right: KeyboardKeyType.ARROW_RIGHT,
          action: "Z",
        },
        gameModes: {
          idle: Struct.getDefault(event.data, "idle", {}),
          bulletHell: Struct.getDefault(event.data, "bulletHell", {}),
          platformer: Struct.getDefault(event.data, "platformer", {}),
        },
      }

      this.set(this.factoryPlayer(_x, _y, new PlayerTemplate(template)))
      this.player.updateGameMode(this.controller.gameMode)
    },
    "clear-player": function(event) {
      this.player = null
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
          up: KeyboardKeyType.ARROW_UP,
          down: KeyboardKeyType.ARROW_DOWN,
          left: KeyboardKeyType.ARROW_LEFT,
          right: KeyboardKeyType.ARROW_RIGHT,
          action: "Z",
        },
        gameModes: {
          idle: {},
          bulletHell: {},
          platformer: {},
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
