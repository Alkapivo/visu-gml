///@package io.alkapivo.visu.service.grid.feature

///@param {Struct} json
///@return {GridItemFeature}
function SpriteFeature(json) {
  var data = Assert.isType(Struct.get(json, "data"), Struct)
  var sprite = Core.isType(Struct.get(data, "sprite"), Struct) 
    ? Assert.isType(SpriteUtil.parse(data.sprite), Sprite) 
    : null
  return new GridItemFeature(Struct.append(json, {

    ///@param {Callable}
    type: SpriteFeature,

    ///@type {?Sprite}
    sprite: sprite,

    ///@type {?Rectangle}
    mask: Core.isType(Struct.get(data, "mask"), Struct)
      ? new Rectangle(data.mask)
      : (Core.isType(sprite, Sprite)
        ? new Rectangle({ 
          x: 0, 
          y: 0, 
          width: sprite.getWidth(), 
          height: sprite.getHeight()
        })
        : null),

    ///@type {?NumberTransformer}
    angle: Core.isType(Struct.get(data, "angle"), Struct)
      ? new NumberTransformer({
        value: 0.0,
        factor: Struct.getDefault(data.angle, "factor", 1.0),
        target: Struct.getDefault(data.angle, "target", 1.0),
        increase: Struct.getDefault(data.angle, "increase", 0.0),
      })
      : null,

    ///@override
    ///@param {GridItem} item
    ///@param {VisuController} controller
    update: function(item, controller) {
      if (this.sprite != null) {
        if (this.angle != null) {
          this.sprite.setAngle(this.sprite.getAngle() 
            + this.angle.update().value)
        }
        item.setSprite(this.sprite)
      }

      if (this.mask != null) {
        item.setMask(this.mask)
      }
    },
  }))
}