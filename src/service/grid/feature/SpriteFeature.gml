///@package io.alkapivo.visu.service.grid.feature

///@param {Struct} [json]
///@return {GridItemFeature}
function SpriteFeature(json = {}) {

  return new GridItemFeature(Struct.append(json, {

    ///@param {Callable}
    type: SpriteFeature,

    ///@type {Struct}
    sprite: Assert.isType(json.sprite, Struct),

    ///@type {?Struct}
    mask: Optional.is(Struct.get(json, "mask"))
      ? Assert.isType(json.mask, Struct)
      : null,

    ///@override
    ///@param {GridItem} item
    ///@param {VisuController} controller
    update: function(item, controller) {
      var _sprite = SpriteUtil.parse(this.sprite)
      item.setSprite(_sprite)
      item.setMask(new Rectangle(Optional.is(this.mask)
        ? this.mask
        : { 
          x: 0, 
          y: 0, 
          width: _sprite.getWidth(), 
          height: _sprite.getHeight()
        }))
    },
  }))
}