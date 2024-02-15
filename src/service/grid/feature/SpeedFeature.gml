///@package io.alkapivo.visu.service.grid.feature

///@param {Struct} [json]
///@return {GridItemFeature}
function SpeedFeature(json = {}) {
  return new GridItemFeature(Struct.append(json, {

    ///@param {Callable}
    type: SpeedFeature,

    ///@type {NumberTransformer}
    value: new NumberTransformer(json.value),

    ///@override
    ///@param {GridItem} item
    ///@param {VisuController} controller
    update: function(item, controller) {
      item.setSpeed(this.value.update().value)
    },
  }))
}