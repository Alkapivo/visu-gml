///@package io.alkapivo.visu.service.bullet.BulletService

///@type {Number}
#macro BULLET_MAX_DISTANCE 3.0

global.BULLET_TEMPLATE = {
  name: "bullet_default",
  lifespawn: 10,
  sprite: {
    name: "texture_test",
  },
  behaviours: {
    base: {
      speed: {
        factor: 0.001
      },
    },
  },
  conditions: [
    {
      name: "base",
      when: null
    }
  ]
}

function _BulletEvent(): Enum() constructor {
  ADD = "spawn-bullet"
  REMOVE = "remove-bullet"
}
global.__BulletEvent = new _BulletEvent()
#macro BulletEvent global.__BulletEvent

///@param {Controller} _controller
///@param {Struct} [config]
function BulletService(_controller, config = {}): Service() constructor {

  ///@type {Controller}
  controller = Assert.isType(_controller, Struct)

  ///@type {Array<Bullet>}
  bullets = new Array(Bullet)

  ///@type {Map<String, BulletTemplate>}
  templates = new Map(String, BulletTemplate)

  ///@type {Stack<Number>}
  gc = new Stack(Number)

  ///@type {EventDispatcher}
  dispatcher = new EventDispatcher(this, new Map(String, Callable, {
    "spawn-bullet": function (event, dispatcher) {
      var bulletTemplate = new BulletTemplate(global.BULLET_TEMPLATE)
      Struct.set(bulletTemplate, "x", event.data.x)
      Struct.set(bulletTemplate, "y", event.data.y)
      Struct.set(bulletTemplate, "angle", event.data.angle)
      Struct.set(bulletTemplate, "speed", event.data.speed)
      Struct.set(bulletTemplate, "producer", event.data.producer)
      dispatcher.context.bullets.add(new Bullet(bulletTemplate))
    },
  }))

  ///@override
  ///@return {BulletService}
  static update = function () { 
    static updateBullets = function (bullet, index, context) {
      bullet.update(context.controller)
      if (bullet.signals.kill) {
        context.gc.push(index)
      }
    }

    this.dispatcher.update()
    this.bullets.forEach(updateBullets, this)
    if (this.gc.size() > 0) {
      this.gc.forEach(function (index, gcIndex, bullets) {
        bullets.set(index, null)
      }, this.bullets)
      this.bullets.container = this.bullets.filter(function (item) {
        return item != null
      }).container
    }
    return this
  }
}
