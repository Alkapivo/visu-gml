///@package io.alkapivo.visu.service.grid.feature

///@param {Struct} json
///@return {GridItemFeature}
function AngleFeature(json) {
  var data = Struct.map(Assert.isType(Struct
    .getDefault(json, "data", {}), Struct), GMArray.resolveRandom)
  
  if (Struct.contains(data, "transform")) {
    data.transform = Struct.map(data.transform, GMArray.resolveRandom)
  }

  if (Struct.contains(data, "add")) {
    data.add = Struct.map(data.add, GMArray.resolveRandom)
  }

  return new GridItemFeature(Struct.append(json, {

    ///@param {Callable}
    type: AngleFeature,

    ///@type {Boolean}
    isAngleSet: false,

    ///@type {Boolean}
    isRelative: Struct.getIfType(data, "isRelative", Boolean, true),

    ///@type {?NumberTransformer}
    transform: Struct.contains(data, "transform")
      ? new NumberTransformer(data.transform)
      : null,

    ///@type {?NumberTransformer}
    add: Struct.contains(data, "add")
      ? new NumberTransformer({
        value: 0.0,
        factor: Struct.getDefault(data.add, "factor", 1.0),
        target: Struct.getDefault(data.add, "target", 1.0),
        increase: Struct.getDefault(data.add, "increase", 0.0),
      })
      : null,

    ///@override
    ///@param {GridItem} item
    ///@param {VisuController} controller
    update: function(item, controller) {
      if (this.transform != null) {
        if (!this.isAngleSet) {
          this.transform.value = item.angle
          this.transform.startValue = item.angle
          this.transform.target = item.angle + ((this.transform.factor >= 0 ? 1 : -1)
            * Math.fetchPointsAngleDiff(item.angle, (this.isRelative ? item.angle : 0.0) + this.transform.target))
          this.transform.factor = abs(this.transform.factor)
          this.isAngleSet = true
        }
        
        item.setAngle(this.transform.update().value)
      }

      if (this.add != null) {
        item.setAngle(item.angle + this.add.update().value)
      }
    },
  }))
}
