///@package io.alkapivo.visu.service.bullet

///@param {String}
///@param {Struct} json
function BulletTemplate(_name, json) constructor {

  ///@type {String}
  name = Assert.isType(_name, String)

  ///@type {Struct}
  sprite = Assert.isType(Struct.get(json, "sprite"), Struct)

  ///@type {?Number}
  lifespawn = Struct.contains(json, "lifespawn")
    ? Assert.isType(json.lifespawn, Number)
    : null


  ///@type {Sprite}
  //sprite = SpriteUtil.parse(json.sprite)
  //Assert.isType(this.sprite, Sprite, "sprite")

  ///@type {Struct}
  /*
  behaviours = Struct.toMap(json.behaviours).map(function(behaviour, key) {
    Struct.toMap(behaviour).map(function(_behaviour, behaviourName) {
      return _behaviour
    })
  })
  */

  ///@return {Struct}
  serialize = function() {
    var json = {
      sprite: this.sprite,
    }

    if (Optional.is(this.lifespawn)) {
      Struct.set(json, "lifespawn", this.lifespawn)
    }
    return json
  }
}

///@param {Struct} config
function Bullet(config): GridItem(config) constructor {

  ///@type {?Number}
  lifespawn = Struct.getDefault(config, "lifespawn", null)
  if (lifespawn != null) {
    Assert.isType(this.lifespawn, Number, "lifespawn")
  }

  ///@private
  ///@type {?Timer}
  lifespawnTimer = lifespawn != null ? new Timer(this.lifespawn) : null

  //behaviours

  //conditions

  ///@type {Player|Shroom}
  producer = config.producer
  
  ///@todo refactor and extract to gridItems
  static healthcheck = function(grid) {
    /*
    var distance = Math.getDistance(this.x, this.y,
      grid.view.x + (grid.view.width / 2.0),
      grid.view.y + (grid.view.height / 2.0)
    )
    if (distance > BULLET_MAX_DISTANCE) {
      var event = new Event(BulletEvent.REMOVE, key)
      service.dispatcher.send(service.dispatcher, event)
    }
    */
  }

  ///@param {VisuController} controller
  ///@return {Bullet}
  static update = function(controller) {
    return this
  }
}
