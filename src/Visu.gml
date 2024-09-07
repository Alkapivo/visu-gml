///@package io.alkapivo.visu

global.__MAGIC_NUMBER_TASK = 10
#macro MAGIC_NUMBER_TASK global.__MAGIC_NUMBER_TASK

function _Visu() constructor {

  ///@type {Settings}
  settings = new Settings($"{working_directory}visu-settings.json")

  ///@param {String} [layerName]
  ///@param {Number} [layerDefaultDepth]
  ///@return {Visu}
  static run = function(layerName = "layer_main", layerDefaultDepth = 100) {
    window_set_caption($"{game_display_name}")

    initGPU()
    initBeans()
    GMTFContext = new _GMTFContext()
    Assert.isType(layerName, String)
    Core.loadProperties(FileUtil.get($"{working_directory}core-properties.json"))
    Core.loadProperties(FileUtil.get($"{working_directory}visu-properties.json"))
    this.settings.set(new SettingEntry({ name: "visu.autosave", type: SettingTypes.BOOLEAN, defaultValue: false }))
      .set(new SettingEntry({ name: "visu.language", type: SettingTypes.STRING, defaultValue: LanguageType.en_US }))
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
    
    initLanguage(this.settings.getValue("visu.language", LanguageType.en_US))

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

    if (!Beans.exists(BeanFileService)) {
      Beans.add(BeanFileService, new Bean(FileService,
        GMObjectUtil.factoryGMObject(
          GMServiceInstance, 
          layerId, 0, 0, 
          new FileService()
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
    
    if (!Beans.exists(BeanVisuEditorController)) {
      Beans.add(BeanVisuEditorController, new Bean(VisuEditorController,
        GMObjectUtil.factoryGMObject(
          GMServiceInstance, 
          layerId, 0, 0, 
          new VisuEditorController()
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

    var parser = new CLIParamParser({
      cliParams: new Array(CLIParam, [
        new CLIParam({
          name: "-t",
          fullName: "--test",
          description: "Run tests from test suite",
          args: [
            {
              name: "file",
              type: "String",
              description: "Path to test suite JSON"
            }
          ],
          handler: function(args) {
            Logger.debug("CLIParamParser", $"Run --test {args.get(0)}")
            Beans.get(BeanVisuTestRunner).start(args.get(0))
            Core.setProperty("visu.manifest.load-on-start", false)
          },
        }),
        new CLIParam({
          name: "-l",
          fullName: "--load",
          description: "Load track from file",
          args: [
            {
              name: "file",
              type: "String",
              descritpion: "Path to manifest.visu"
            }
          ],
          handler: function(args) {
            Logger.debug("CLIParamParser", $"Run --load {args.get(0)}")
            Beans.get(BeanVisuController).send(new Event("load", {
              manifest: FileUtil.get(args.get(0)),
              autoplay: false,
            }))
          }
        })
      ])
    })
    parser.parse()
    
    return this
  }

  ///@private
  ///@type {Struct}
  shaderTemplates = {
    "shader-default": { 
      "shader": "shader_revert",
    },
  }

  ///@private
  ///@type {Struct}
  shroomTemplates = {
    "shroom-default": {
      "sprite": { "name": "texture_baron" },
      "gameModes":{
        "bulletHell":{ "features": [] },
        "platformer": { "features": [] },
        "racing":{ "features": [] },
      },
    },
  }

  _assets = null

  static assets = function() {
    if (this._assets == null) {
      this._assets = {
        shaderTemplates: Struct
          .toMap(this.shaderTemplates, String, ShaderTemplate, 
            function(json, name) {
              return new ShaderTemplate(name, json)
            }),
        shroomTemplates: Struct
          .toMap(this.shroomTemplates, String, ShroomTemplate, 
            function(json, name) {
              return new ShroomTemplate(name, json)
            }),
        
      }
    }

    return this._assets
  }
}
global.__Visu = new _Visu()
#macro Visu global.__Visu
