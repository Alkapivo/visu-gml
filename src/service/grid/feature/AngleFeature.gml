///@package io.alkapivo.visu.service.grid.feature

///@param {Struct} [json]
///@return {GridItemFeature}
function AngleFeature(json = {}) {
  return new GridItemFeature(Struct.append(json, {

    ///@param {Callable}
    type: AngleFeature,

    ///@type {?NumberTransformer}
    transform: Struct.contains(json, "transform")
      ? new NumberTransformer(json.transform)
      : null,

    add: Struct.contains(json, "add")
    ? new NumberTransformer(json.add)
    : null,


    ///@override
    ///@param {GridItem} item
    ///@param {VisuController} controller
    update: function(item, controller) {
      if (Optional.is(this.transform)) {
        item.setAngle(this.transform.update().value)
      }

      if (Optional.is(this.add)) {
        item.setAngle(item.angle + this.add.update().value)
      }
    },
  }))
}