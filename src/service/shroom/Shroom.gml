///@package io.alkapivo.visu.service.shroom

///@param {ShroomTemplate} config
function Shroom(config = {}): GridItem(config) constructor {

  ///@type {?Number}
  lifespawn = Struct.getDefault(config, "lifespawn", null)

  ///@private
  ///@type {?Timer}
  lifespawnTimer = lifespawn != null ? new Timer(this.lifespawn) : null
  
  ///@type {Map<String, ShroomGameMode>}
  gameModes = Struct.getDefault(config, "gameModes", new Map(String, ShroomGameMode))

  ///@private
  ///@type {Map<String, any>}
  state = Struct.getDefault(config, "state", new Map(String, any))

  ///@param {VisuController} controller
  ///@return {Shroom}
  update = function(controller) {
    if (lifespawnTimer != null && lifespawnTimer.update().finished) {
      this.signal("kill")
    }

    var gameMode = this.gameModes.get(controller.gameMode)
    if (Core.isType(gameMode, ShroomGameMode)) {
      gameMode.update(this, controller)
    }
    return this
  }
}

///@param {String} _name
///@param {Struct} json
function ShroomTemplate(_name, json) constructor {

  ///@private
  ///@param {Struct} json
  ///@param {String} key
  ///@return {Map<String, ShroomGameMode>}
  static mapGameMode = function(json, key) {
    return Callable.run(Assert.isType(Struct
      .get(SHROOM_GAME_MODES, key), Callable), json)
  }
  
  ///@type {String}
  name = Assert.isType(_name, String)
  
  ///@type {Struct}
  sprite = Assert.isType(Struct.get(json, "sprite"), Struct)
  
  ///@type {?Number}
  lifespawn = Struct.contains(json, "lifespawn")
    ? Assert.isType(Struct.get(json, "lifespawn"), Number)
    : null
  
  ///@type {Map<String, ShroomGameMode>}
  gameModes = Struct.toMap(json.gameModes).map(this.mapGameMode)
}

///@param {Struct} [config]
function ShroomSpawn(config = {}) constructor {

  ///@type {Number}
  x = Struct.get(config, "x")
  Assert.isType(this.x, Number, "x")

  ///@type {Number}
  y = Struct.get(config, "y")
  Assert.isType(this.y, Number, "y")

  ///@type {String}
  template = Struct.get(config, "template")
  Assert.isType(this.x, ShroomTemplate, "template")
  
  ///@type {Number}
  speed = Struct.getDefault(config, "speed", 0)
  Assert.isType(this.speed, Number, "speed")
  
  ///@type {Number}
  angle = Struct.getDefault(config, "angle", 270)
  Assert.isType(this.angle, Number, "angle")
}
 