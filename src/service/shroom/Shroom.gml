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
    if (Optional.is(gameMode)) {
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

  ///@return {Struct}
  serialize = function() {
    var shroom = this
    var json = {
      name: shroom.name,
      sprite: shroom.sprite,
      gameModes: shroom.gameModes.toStruct(function(gameMode) {
        return gameMode.serialize()
      })
    }

    if (Optional.is(this.lifespawn)) {
      Struct.set(json, "lifespawn", this.lifespawn)
    }

    return json
  }
}

 