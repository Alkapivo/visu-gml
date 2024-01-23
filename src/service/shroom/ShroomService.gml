///@package io.alkapivo.visu.service.shroom

///@static
///@type {Struct}
global.SHROOM_TEMPLATE = {
  name: "shroom_default",
  sprite: {
    name: "texture_particle_default",
    animate: false,
  },
  lifespawn: 50,
  gameModes: {
    bulletHell: {
      shoot: {
        bullet: "bullet_default",
        speed: 0.01,
        interval: 1,
        bullets: 10,
        aimPlayer: true,
        angleRange: 30,

      },
      speed: {
        target: 0.028,
        factor: 0.0001
      },
      finish: {
        particle: "particle_default",
      }
    },
    platformer: {
      onPlayerLanded: {
        sprite: {
          frame: "next",
          scaleX: {
            target: 2.0,
            factor: 0.1,
          },
          scaleY: {
            target: 2.0,
            factor: 0.1,
          }
        }
      },
      onPlayerLeave: {
        sprite: {
          frame: "next",
          scaleX: {
            target: 1.0,
            factor: 0.1,
          },
          scaleY: {
            target: 1.0,
            factor: 0.1,
          }
        }
      },
      finish: {
        particle: "particle_default",
      }
    },
  },
}


///@param {VisuController} _controller
///@param {Struct} [config]
function ShroomService(_controller, config = {}): Service() constructor {

  ///@type {VisuController}
  controller = Assert.isType(_controller, VisuController)

  ///@type {Array<Shroom>} 
  shrooms = new Array(Shroom)

  ///@type {Map<String, ShroomTemplate>}
  templates = new Map(String, ShroomTemplate)

  ///@type {Stack<Number>}
  gc = new Stack(Number)

  ///@type {?Struct}
  spawner = null

  ///@param {?Struct} [json]
  ///@return {Struct}
  factorySpawner = function(json = null) {
    return Struct.appendUnique(
      json, 
      {
        sprite: SpriteUtil.parse({ name: "texture_baron" }),
        x: 0.5,
        y: 0,
      }
    )
  }

  ///@type {EventPump}
  dispatcher = new EventPump(this, new Map(String, Callable, {
    "spawn-shroom": function(event) {
      var view = this.controller.gridService.view
      var template = Assert.isType(this.templates.get(Struct
        .getDefault(event.data, "template", "shroom-01")), ShroomTemplate)
      var spawnX = Assert.isType(Struct
        .getDefault(event.data, "spawnX", choose(1, -1) * random(3) * (random(100) / 100)), Number)
      var spawnY = Assert.isType(Struct
        .getDefault(event.data, "spawnY", -1 * random(2) * (random(100) / 100)), Number)
      var angle = Assert.isType(Struct
        .getDefault(event.data, "angle", 270), Number)
      var spd = Assert.isType(Struct
        .getDefault(event.data, "speed", 5), Number)

      Struct.set(template, "x", view.x + spawnX)
      Struct.set(template, "y", view.y + spawnY)
      Struct.set(template, "speed", spd / 1000.0)
      Struct.set(template, "angle", angle)
      
      this.shrooms.add(new Shroom(template))
    },
  }))

  ///@param {Event} event
  ///@return {?Promise}
  send = function(event) {
    return this.dispatcher.send(event)
  }

  ///@return {ShroomService}
  update = function() {
    static updateShroom = function (shroom, index, context) {
      shroom.update(context.controller)
      if (shroom.signals.kill) {
        context.gc.push(index)
      }
    }

    this.dispatcher.update()
    this.shrooms.forEach(updateShroom, this)
    if (this.gc.size() > 0) {
      this.shrooms.removeMany(this.gc)
    }
    return this
  }
}
