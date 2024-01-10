///@package com.alkapivo.visu.service.grid.GridItem

function GridItemSignals() constructor {
  
  ///@type {Boolean}
  kill = false
  
  ///@type {Boolean}
  bulletCollision = false
  
  ///@type {Boolean}
  shroomCollision = false
  
  ///@type {Boolean}
  playerCollision = false

  ///@param {String} key
  ///@param {any} value
  ///@return {GridItemSignals}
  static set = function(key, value) {
    Struct.set(this, key, value)
    return this
  }

  ///@return {GridItemSignals}
  static reset = function() {
    this.kill = false
    this.bulletCollision = false
    this.shroomCollision = false
    this.playerCollision = false
    return this
  }
}

///@interface
///@param {Struct} [config]
///@return {GridItem}
function GridItem(config = {}) constructor {

  ///@type {Number}
  x = Assert.isType(Struct.get(config, "x"), Number)

  ///@type {Number}
  y = Assert.isType(Struct.get(config, "y"), Number)

  ///@type {Number}
  z = Assert.isType(Struct.getDefault(config, "z", 0), Number)

  ///@type {Sprite}
  sprite = Assert.isType(SpriteUtil.parse(Struct
    .getDefault(config, "sprite", { name: "texture_test" })), Sprite)

  ///@type {Number}
  speed = Assert.isType(Struct.getDefault(config, "speed", 0), Number)

  ///@type {Number}
  angle = Assert.isType(Struct.getDefault(config, "angle", 0), Number)

  ///@type {GridItemSignals}
  signals = new GridItemSignals()

  ///@param {GridItem} target
  ///@return {Bollean} collide?
  static collide = function(target) { 
    var halfSourceWidth = (this.sprite.texture.width * this.sprite.scaleX) / 2.0
    var halfSourceHeight = (this.sprite.texture.height * this.sprite.scaleY) / 2.0
    var halfTargetWidth = (target.sprite.texture.width * target.sprite.scaleX) / 2.0
    var halfTargetHeight = (target.sprite.texture.height * target.sprite.scaleY) / 2.0
    var sourceX = this.x * GRID_SERVICE_PIXEL_WIDTH
    var sourceY = this.y * GRID_SERVICE_PIXEL_HEIGHT
    var targetX = target.x * GRID_SERVICE_PIXEL_WIDTH
    var targetY = target.y * GRID_SERVICE_PIXEL_HEIGHT
    return Math.rectangleOverlaps(
      sourceX - halfSourceWidth, sourceY - halfSourceHeight,
      sourceX + halfSourceWidth, sourceY + halfSourceHeight,
      targetX - halfTargetWidth, targetY - halfTargetHeight,
      targetX + halfTargetWidth, targetY + halfTargetHeight
    )
  }

  ///@return {GridItem}
  static move = function() {
    this.signals.reset()
    this.x += Math.fetchCircleX(this.speed, this.angle)
    this.y += Math.fetchCircleY(this.speed, this.angle)
    return this
  }

  ///@param {any} name
  ///@param {any} [value]
  ///@return {GridItem}
  static signal = function(name, value = true) { 
    this.signals.set(name, value)
    return this
  }

  ///@param {VisuController} controller
  ///@return {GridItem}
  static update = function(controller) { 
    return this
  }
}
