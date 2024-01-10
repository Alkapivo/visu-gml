///@package com.alkapivo.visu.service.grid.GridView

///@param {Struct} [config]
function GridView(config = {}) constructor {

  ///@type {Number}
  x = Assert.isType(Struct.getDefault(config, "x", 0.0), Number)

  ///@type {Number}
  y = Assert.isType(Struct.getDefault(config, "y", 0.0), Number)

  ///@type {Number}
  width = Assert.isType(Struct.getDefault(config, "width", 1.0), Number)

  ///@type {Number}
  height = Assert.isType(Struct.getDefault(config, "height", 1.0), Number)

  ///@type {Number}
  worldWidth = Assert.isType(Struct.getDefault(config, "worldWidth", 2.0) , Number)

  ///@type {Number}
  worldHeight = Assert.isType(Struct.getDefault(config, "worldHeight", 2.0) , Number)

  ///@type {Struct}
  follow = {
    target: null,
    xMargin: Assert.isType(Struct.getDefault(config, "follow.xMargin", 0.35), Number),
    yMargin: Assert.isType(Struct.getDefault(config, "follow.yMargin", 0.40), Number),
    smooth: Assert.isType(Struct.getDefault(config, "follow.smooth", 32), Number),
  }

  ///@param {GridItem} target
  ///@return {GridView}
  static setFollowTarget = function(target) {
    this.follow.target = target
    return this
  }
  
  ///@return {GridView}
  static update = function() {
    if (Core.isType(this.follow.target, Struct)) {
      var targetX = this.follow.target.x
      if (targetX >= this.x + this.width - this.follow.xMargin) {
        var viewXTarget = targetX + this.follow.xMargin - this.width
        this.x += ((targetX - 1.0 / 2.0) - this.x) / this.follow.smooth
      }
      if (targetX <= this.x + this.follow.xMargin) {
        var viewXTarget = targetX - this.follow.xMargin
        this.x += ((targetX - 1.0 / 2.0) - this.x) / this.follow.smooth
      }
      
      var targetY = this.follow.target.y
      if (targetY >= this.y + this.height - this.follow.yMargin) {
        this.y += ((targetY - 1.0 / 2.0) - this.y) / this.follow.smooth
      }
      if (targetY <= this.y + this.follow.yMargin) {
        this.y += ((targetY - 1.0 / 2.0) - this.y) / this.follow.smooth
      }

      this.follow.target.x = clamp(targetX, 0, this.worldWidth)
      this.follow.target.y = clamp(targetY, 0, this.worldHeight)
    }

    this.x = clamp(this.x, -1 * this.width, this.worldWidth)
    this.y = clamp(this.y, 0.0, this.worldHeight - this.height)
    return this
  }
}
