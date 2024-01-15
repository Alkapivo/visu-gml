///@package io.alkapivo.visu.service.shroom

///@type {Struct}
global.__SHROOM_GAME_MODES = {
  "bulletHell": function(config) {
    return new ShroomGameModeBulletHell(config)
  },
  "platformer": function(config) {
    return new ShroomGameModePlatformer(config)
  }
}
#macro SHROOM_GAME_MODES global.__SHROOM_GAME_MODES


///@interface
///@param {Struct} json
function ShroomGameMode(json) {

  ///@type {Map<String, GridItemFeature>}
  features = Struct.toMap(json).map(function(feature, key) {
    return Callable.run(Assert.isType(Struct
      .get(SHROOM_FEATURES, key), Callable), feature)
  })

  ///@private
  ///@param {String} name
  ///@param {VisuController} controller
  ///@param {Shroom} shroom
  runFeature = method(this, function(name, controller, shroom) {
    var feature = this.features.get(name)
    if (Core.isType(feature, GridItemFeature)) {
      feature.update(shroom, controller)
    }
  })

  ///@param {Shroom} shroom
  ///@param {VisuController} controller
  update = method(this, function(shroom, controller) { })

  ///@return {Struct}
  serialize = function() {
    return this.features.toStruct(function(feature) {
      return feature.serialize()
    })
  }
}


///@param {Struct} json
function ShroomGameModeBulletHell(json): ShroomGameMode(json) constructor {

  ///@override
  ///@param {Shroom} shroom
  ///@param {VisuController} controller
  update = method(this, function(shroom, controller) {
    this.runFeature(ShroomFeatureType.SHOOT, controller, shroom)
    this.runFeature(GridItemFeatureType.SPEED, controller, shroom)

    if (shroom.signals.bulletCollision) {
      shroom.signal("kill")
    }

    if (shroom.signals.playerCollision) {
      shroom.signal("kill")
    }

    if (shroom.signals.kill) {
      this.runFeature(GridItemFeatureType.FINISH, controller, shroom)
    }
  })
}


///@param {Struct} json
function ShroomGameModePlatformer(json): ShroomGameMode(json) constructor {

  ///@override
  ///@param {Shroom} shroom
  ///@param {VisuController} controller
  update = method(this, function(shroom, controller) {
    runFeature(GridItemFeatureType.SPEED)
    if (shroom.signals.kill) {
      runFeature(GridItemFeatureType.FINISH)
    }
  })
}
