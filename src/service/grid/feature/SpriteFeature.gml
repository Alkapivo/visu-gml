///@package io.alkapivo.visu.service.grid.feature

///@param {Struct} json
///@return {GridItemFeature}
function SpriteFeature(json) {
  var data = Assert.isType(Struct.get(json, "data"), Struct)
  var sprite = Assert.isType(SpriteUtil.parse(data.sprite), Sprite)
  return new GridItemFeature(Struct.append(json, {

    ///@param {Callable}
    type: SpriteFeature,

    ///@type {Sprite}
    sprite: sprite,

    ///@type {Rectangle}
    mask: new Rectangle(Core.isType(Struct.get(data, "mask"), Struct) 
      ? data.mask
      : { 
        x: 0, 
        y: 0, 
        width: sprite.getWidth(), 
        height: sprite.getHeight()
      }),

    ///@override
    ///@param {GridItem} item
    ///@param {VisuController} controller
    update: function(item, controller) {
      item.setSprite(this.sprite)
      item.setMask(this.mask)
    },
  }))
}