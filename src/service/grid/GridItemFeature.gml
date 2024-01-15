///@package io.alkapivo.visu.service.grid

///@enum
function _GridItemFeatureType(): Enum() constructor {
  SPEED = "speed"
  FINISH = "finish"
}
global.__GridItemFeatureType = new _GridItemFeatureType()
#macro GridItemFeatureType global.__GridItemFeatureType



function _GRID_ITEM_FEATURES() constructor {

  ///@param {Struct} json
  ///@type {GridItemFeature}
  speed = method(this, function(json) {
    return new GridItemFeatureSpeed(json)
  })

  ///@param {Struct} json
  ///@type {GridItemFeature}
  finish = method(this, function(json) {
    return new GridItemFeatureFinish(json)
  })
  
  ///@param {String} name]
  ///@return {?GridItemFeature}
  get = method(this, function(name) {
    return Struct.get(this, name)
  })
}
global.__GRID_ITEM_FEATURES = new _GRID_ITEM_FEATURES()
#macro GRID_ITEM_FEATURES global.__GRID_ITEM_FEATURES 


///@interface
function GridItemFeature() constructor {

  ///@param {GridItem} gridItem
  ///@param {VisuController} controller
  update = function(gridItem, controller) { }

  ///@return {Struct}
  serialize = function() {
    return {}
  }
}


///@param {Struct} json
function GridItemFeatureSpeed(json): GridItemFeature() constructor {

  ///@type {NumberTransformer}
  transformer = new NumberTransformer(json)

  ///@override
  ///@param {GridItem} gridItem
  ///@param {VisuController} controller
  update = function(gridItem, controller) {
    gridItem.speed = this.transformer.update().value
  }

  ///@override
  ///@return {Struct}
  serialize = function() {
    var feature = this
    return {
      "value": feature.transformer.value,
      "target": feature.transformer.target,
      "factor": feature.transformer.factor,
      "increase": feature.transformer.increase,
    }
  }
}


///@param {Struct} json
function GridItemFeatureFinish(json): GridItemFeature() constructor {

  ///@type {?String}
  particle = Struct.getDefault(json, "particle", null)
  if (particle != null) {
    Assert.isType(particle, String, "particle")
  }

  ///@override
  ///@param {GridItem} gridItem
  ///@param {VisuController} controller
  update = method(this, function(gridItem, controller) {
    ///@todo spawn particle this.particle
  })

  ///@override
  ///@return {Struct}
  serialize = function() {
    var json = {}
    if (Optional.is(this.particle)) {
      Struct.set(json, "particle", this.particle)
    }

    return json
  }
}
