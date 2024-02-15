///@package io.alkapivo.visu.service.grid.feature

///@param {Struct} [json]
///@return {GridItemFeature}
function FollowPlayerFeature(json = {}) {
  return new GridItemFeature(Struct.append(json, {

    ///@param {Callable}
    type: FollowPlayerFeature,

    ///@type {NumberTransformer}
    value: new NumberTransformer(json.value),

    ///@type {?Timer}
    interval: Struct.contains(json, "interval")
      ? new Timer(json.interval)
      : null,

    ///@type {NumberTransformer}
    transformer: new NumberTransformer(),

    ///@override
    ///@param {GridItem} item
    ///@param {VisuController} controller
    update: function(item, controller) {
      var player = controller.playerService.player
      if (!Optional.is(player) 
        || (Optional.is(this.interval) 
        && !this.interval.update().finished)) {
        return
      }

      this.transformer.value = this.angle
      this.transformer.factor = this.value.update().value
      this.transformer.target = Math.fetchAngle(item.x, item.y, player.x, player.y)
      this.setAngle(this.transformer.update().value)
    },
  }))
}