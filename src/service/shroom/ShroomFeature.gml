///@package io.alkapivo.visu.service.shroom

///@enum
function _ShroomFeatureType(): _GridItemFeatureType() constructor {
  SHOOT = "shoot"
  ON_PLAYER_LANDED = "onPlayerLanded"
  ON_PLAYER_LEAVE = "onPlayerLeave"
}
global.__ShroomFeatureType = new _ShroomFeatureType()
#macro ShroomFeatureType global.__ShroomFeatureType


function _SHROOM_FEATURES(): _GRID_ITEM_FEATURES() constructor {

  ///@param {Struct} json
  ///@return {GridItemFeature}
  shoot = method(this, function(json) {
    return new ShroomFeatureShoot(json)
  })

  ///@param {Struct} json
  ///@return {GridItemFeature}
  onPlayerLanded = method(this, function(json) {
    return new ShroomFeatureOnPlayerLanded(json)
  })

  ///@param {Struct} json
  ///@return {GridItemFeature}
  onPlayerLeave = method(this, function(json) {
    return new ShroomFeatureOnPlayerLeave(json)
  })
}
global.__SHROOM_FEATURES = new _SHROOM_FEATURES()
#macro SHROOM_FEATURES global.__SHROOM_FEATURES


///@param {Struct} json
function ShroomFeatureShoot(json): GridItemFeature() constructor {

  ///@type {?String}
  bullet = Assert.isType(Struct.get(json, "bullet"), String)

  ///@type {?Number}
  bullets = Struct.contains(json, "bullets")
    ? Assert.isType(Struct.get(json, "bullets"), Number)
    : null

  ///@type {Number}
  speed = Assert.isType(Struct.getDefault(json, "speed", 1.0), Number)

  ///@type {Number}
  interval = Assert.isType(Struct.getDefault(json, "interval", GAME_FPS), Number)

  ///@type {Boolean}
  aimPlayer = Assert.isType(Struct.getDefault(json, "aimPlayer", false), Boolean)

  ///@type {Number}
  angleRange = Assert.isType(Struct.getDefault(json, "angleRange", 0.0), Number)

  ///@private
  ///@type {Timer}
  timer = new Timer(this.interval, { 
    loop: this.bullets != null ? this.bullets : Infinity 
  })

  ///@override
  ///@param {VisuController} controller
  update = method(this, function(shroom, controller) {
    if (this.timer.update().finished) {
      var event = new Event("spawn-bullet", {
        x: shroom.x,
        y: shroom.y,
        angle: shroom.angle,
        speed: shroom.speed * 1.5,
        producer: Shroom,
      })
      controller.bulletService.dispatcher.send(event)
    }
  })

  ///@override
  ///@return {Struct}
  serialize = function() {
    var feature = this
    var json = {
      "bullet": feature.bullet,
      "speed": feature.speed,
      "interval": feature.interval,
      "aimPlayer": feature.aimPlayer,
      "angleRange": feature.angleRange,
    }

    if (Optional.is(this.bullets)) {
      Struct.set(json, "bullets", this.bullets)
    }

    return json
  }
}


///@param {Struct} json
function ShroomFeatureOnPlayerLanded(json): GridItemFeature() constructor { }


///@param {Struct} json
function ShroomFeatureOnPlayerLeave(json): GridItemFeature() constructor { }
