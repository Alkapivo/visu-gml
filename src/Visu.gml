///@package io.alkapivo.visu

global.__MAGIC_NUMBER_TASK = 2
#macro MAGIC_NUMBER_TASK global.__MAGIC_NUMBER_TASK

function _Visu() constructor {

  ///@param {String} layerName
  ///@return {Visu}
  run = method(this, function(layerName) {
    if (!Beans.exists(BeanTextureService)) {
      Beans.add(BeanTextureService, new Bean(TextureService,
        GMObjectUtil.factoryGMObject(
          GMServiceInstance, 
          layer_get_id(layerName), 0, 0, 
          new TextureService()
        )
      ))
    }
    
    Beans.add(BeanVisuController, new Bean(VisuController,
      GMObjectUtil.factoryGMObject(
        GMControllerInstance, 
        layer_get_id(layerName), 0, 0, 
        new VisuController(layerName)
      )
    ))
    return this
  })
}
global.__Visu = new _Visu()
#macro Visu global.__Visu
