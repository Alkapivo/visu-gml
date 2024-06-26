///@package io.alkapivo.visu

global.__MAGIC_NUMBER_TASK = 5
#macro MAGIC_NUMBER_TASK global.__MAGIC_NUMBER_TASK

function _Visu() constructor {

  ///@type {Settings}
  settings = new Settings($"{working_directory}visu-settings.json")

  ///@param {String} [layerName]
  ///@param {Number} [layerDefaultDepth]
  ///@return {Visu}
  static run = function(layerName = "layer_main", layerDefaultDepth = 100) {

    initGPU()
    initBeans()
    GMTFContext = new _GMTFContext()
    Assert.isType(layerName, String)
    Core.loadProperties(FileUtil.get($"{working_directory}core-properties.json"))
    Core.loadProperties(FileUtil.get($"{working_directory}visu-properties.json"))
    this.settings.set(new SettingEntry({ name: "visu.autosave", type: SettingTypes.BOOLEAN, defaultValue: false }))
      .set(new SettingEntry({ name: "visu.fullscreen", type: SettingTypes.BOOLEAN, defaultValue: false }))
      .set(new SettingEntry({ name: "visu.window.width", type: SettingTypes.NUMBER, defaultValue: 1400 }))
      .set(new SettingEntry({ name: "visu.window.height", type: SettingTypes.NUMBER, defaultValue: 900 }))
      .set(new SettingEntry({ name: "visu.editor.bpm", type: SettingTypes.NUMBER, defaultValue: 120 }))
      .set(new SettingEntry({ name: "visu.editor.bpm-sub", type: SettingTypes.NUMBER, defaultValue: 2 }))
      .set(new SettingEntry({ name: "visu.editor.snap", type: SettingTypes.BOOLEAN, defaultValue: true }))
      .set(new SettingEntry({ name: "visu.editor.render-event", type: SettingTypes.BOOLEAN, defaultValue: false }))
      .set(new SettingEntry({ name: "visu.editor.render-timeline", type: SettingTypes.BOOLEAN, defaultValue: false }))
      .set(new SettingEntry({ name: "visu.editor.render-track-control", type: SettingTypes.BOOLEAN, defaultValue: true }))
      .set(new SettingEntry({ name: "visu.editor.render-brush", type: SettingTypes.BOOLEAN, defaultValue: false }))
      .set(new SettingEntry({ name: "visu.editor.accordion.render-event-inspector", type: SettingTypes.BOOLEAN, defaultValue: false }))
      .set(new SettingEntry({ name: "visu.editor.accordion.render-template-toolbar", type: SettingTypes.BOOLEAN, defaultValue: true }))
      .set(new SettingEntry({ name: "visu.editor.timeline-zoom", type: SettingTypes.NUMBER, defaultValue: 10 }))
      .load()

    window_set_caption($"{game_display_name}")

    var layerId = layer_get_id(layerName)
    if (layerId == -1) {
      layerId = layer_create(Assert.isType(layerDefaultDepth, Number), layerName)
    }

    if (!Beans.exists(BeanDeltaTimeService)) {
      Beans.add(BeanDeltaTimeService, new Bean(DeltaTimeService,
        GMObjectUtil.factoryGMObject(
          GMServiceInstance, 
          layerId, 0, 0, 
          new DeltaTimeService()
        )
      ))
    }

    if (!Beans.exists(BeanTextureService)) {
      Beans.add(BeanTextureService, new Bean(TextureService,
        GMObjectUtil.factoryGMObject(
          GMServiceInstance, 
          layerId, 0, 0, 
          new TextureService()
        )
      ))
    }

    if (!Beans.exists(BeanSoundService)) {
      Beans.add(BeanSoundService, new Bean(SoundService,
        GMObjectUtil.factoryGMObject(
          GMServiceInstance, 
          layerId, 0, 0, 
          new SoundService()
        )
      ))
    }

    if (!Beans.exists(BeanVisuIO)) {
      Beans.add(BeanVisuIO, new Bean(VisuIO,
        GMObjectUtil.factoryGMObject(
          GMServiceInstance, 
          layerId, 0, 0, 
          new VisuIO()
        )
      ))
    }

    if (!Beans.exists(BeanVisuEditor)) {
      Beans.add(BeanVisuEditor, new Bean(VisuEditor,
        GMObjectUtil.factoryGMObject(
          GMServiceInstance, 
          layerId, 0, 0, 
          new VisuEditor()
        )
      ))
    }

    if (!Beans.exists(BeanVisuTestRunner)) {
      Beans.add(BeanVisuTestRunner, new Bean(VisuTestRunner,
        GMObjectUtil.factoryGMObject(
          GMServiceInstance, 
          layerId, 0, 0, 
          new VisuTestRunner()
        )
      ))
    }
    
    Beans.add(BeanVisuController, new Bean(VisuController,
      GMObjectUtil.factoryGMObject(
        GMControllerInstance, 
        layerId, 0, 0, 
        new VisuController(layerName)
      )
    ))
    
    return this
  }
}
global.__Visu = new _Visu()
#macro Visu global.__Visu


global.timer_counter = {
  time: 0,
  current: 0,
  amount: 0,
  get: function() {
    return this.time / this.amount
  },
  add: function(time) {
    this.time += time
    this.current = time
    this.amount += 1
    return this
  },
  reset: function() {
    this.time = 0
    this.amount = 0
    return this
  }
}