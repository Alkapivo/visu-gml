///@package io.alkapivo.visu

///@type {Number}
global.__MAGIC_NUMBER_TASK = 10
#macro MAGIC_NUMBER_TASK global.__MAGIC_NUMBER_TASK


///@enum
function _GameMode(): Enum() constructor {
  RACING = "racing"
  BULLETHELL = "bulletHell"
  PLATFORMER = "platformer"
}
global.__GameMode = new _GameMode()
#macro GameMode global.__GameMode


///@static
function _Visu() constructor {

  ///@type {Settings}
  settings = new Settings($"{working_directory}visu-settings.json")

  ///@private
  ///@type {?Struct}
  _assets = null

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

  ///@private
  ///@type {Struct}
  bulletTemplates = {
    "bullet-default": {
      "gameModes":{
        "bulletHell": { "features": [] },
        "platformer": { "features": [] },
        "racing": { "features": [] },
      },
      "sprite":{
        "name":"texture_bullet"
      },
      "mask":{
        "width":128.0,
        "height":128.0
      },
    },
  }

  ///@private
  ///@type {Struct}
  coinTemplates = {
    "coin-default": {
      "sprite": { 
        "name": "texture_baron"
      },
      "category": CoinCategory.POINT,
    },
  }

  ///@private
  ///@type {Struct}
  lyricsTemplates = {
    "lyrics-default": {
      "lines": [ "Lorem ipsum" ]
    },
  }

  ///@private
  ///@type {Struct}
  particleTemplates = {
    "particle-default": {
      "color":{
        "start":"#ffffff",
        "halfway":"#ffffff",
        "finish":"#ffffff"
      },
      "alpha":{
        "start":1.0,
        "halfway":0.0,
        "finish":0.0
      },
      "speed":{
        "wiggle":0.0,
        "increase":0.001,
        "minValue":0.01,
        "maxValue":5.0
      },
      "shape":"CIRCLE",
      "gravity":{
        "angle":0.0,
        "amount":0.0
      },
      "orientation":{
        "wiggle":0.0,
        "relative":0.0,
        "increase":0.001,
        "minValue":0.0,
        "maxValue":360.0
      },
      "angle":{
        "wiggle":0.0,
        "increase":0.01,
        "minValue":0.0,
        "maxValue":360.0
      },
      "life":{
        "minValue":80.0,
        "maxValue":120.0
      },
      "sprite":{
        "name":"texture_particle",
        "stretch":0.0,
        "randomValue":0.0,
        "animate":0.0
      },
      "scale":{
        "x":1.0,
        "y":1.0
      },
      "blend":0.0,
      "size":{
        "wiggle":0.0,
        "increase":0.0,
        "minValue":1.0,
        "maxValue":32.0
      }
    },
  }

  ///@private
  ///@type {Struct}
  textures = {
    "texture_baron": {
      "asset": texture_baron,
      "file": ""
    },
    "texture_baron_wallpaper_1": {
      "asset": texture_baron_wallpaper_1,
      "file": ""
    },
    "texture_baron_wallpaper_2": {
      "asset": texture_baron_wallpaper_2,
      "file": ""
    },
    "texture_bazyl": {
      "asset": texture_bazyl,
      "file": ""
    },
    "texture_bazyl_cursor": {
      "asset": texture_bazyl_cursor,
      "file": ""
    },
    "texture_bullet": {
      "asset": texture_bullet,
      "file": ""
    },
    "texture_coin_bomb": {
      "asset": texture_coin_bomb,
      "file": ""
    },
    "texture_coin_force": {
      "asset": texture_coin_force,
      "file": ""
    },
    "texture_coin_life": {
      "asset": texture_coin_life,
      "file": ""
    },
    "texture_coin_point": {
      "asset": texture_coin_point,
      "file": ""
    },
    "texture_empty": {
      "asset": texture_empty,
      "file": ""
    },
    "texture_missing": {
      "asset": texture_missing,
      "file": ""
    },
    "texture_particle": {
      "asset": texture_particle,
      "file": ""
    },
    "texture_player": {
      "asset": texture_player,
      "file": ""
    },
    "texture_white": {
      "asset": texture_white,
      "file": ""
    },
  }

  ///@return {Struct}
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
        bulletTemplates: Struct
          .toMap(this.bulletTemplates, String, BulletTemplate, 
            function(json, name) {
              return new BulletTemplate(name, json)
            }),
        coinTemplates: Struct
          .toMap(this.coinTemplates, String, CoinTemplate, 
            function(json, name) {
              return new CoinTemplate(name, json)
            }),
        lyricsTemplates: Struct
          .toMap(this.lyricsTemplates, String, LyricsTemplate, 
            function(json, name) {
              return new LyricsTemplate(name, json)
            }),
        particleTemplates: Struct
          .toMap(this.particleTemplates, String, ParticleTemplate, 
            function(json, name) {
              return new ParticleTemplate(name, json)
            }),
        textures: Struct
          .toMap(this.textures, String, TextureTemplate, 
            function(json, name) {
              return new TextureTemplate(name, json)
            }),
      }
    }

    return this._assets
  }

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
          new TextureService({
            getStaticTemplates: function() {
              return Visu.assets().textures
            },
          })
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

    if (!Beans.exists(BeanVisuEditorIO)) {
      Beans.add(BeanVisuEditorIO, new Bean(VisuEditorIO,
        GMObjectUtil.factoryGMObject(
          GMServiceInstance, 
          layerId, 0, 0, 
          new VisuEditorIO()
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
}
global.__Visu = new _Visu()
#macro Visu global.__Visu
