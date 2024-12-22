///@package io.alkapivo.visu.service.track

///@static
///@type {String[]}
global.__SHADER_PIPELINE_TYPES = [ 
  "Background", 
  "Grid", 
  "All"
]
#macro SHADER_PIPELINE_TYPES global.__SHADER_PIPELINE_TYPES


///@static
///@type {Struct}
global.__effect_track_event = {
  "brush_effect_shader": {
    parse: function(data) {
      return {
        "icon": Struct.getIfType(data, "icon", Struct, { name: "texture_baron" }),
        "ef-shd_template": Struct.parse.text(data, "ef-shd_template", "shader-default"),
        "ef-shd_duration": Struct.parse.number(data, "ef-shd_duration", 0.0, 0.0, 9999.9),
        "ef-shd_fade-in": Struct.parse.number(data, "ef-shd_fade-in", 0.0, 0.0, 9999.9),
        "ef-shd_fade-out": Struct.parse.number(data, "ef-shd_fade-out", 0.0, 0.0, 9999.9),
        "ef-shd_alpha": Struct.parse.normalizedNumber(data, "ef-shd_alpha", 1.0),
        "ef-shd_pipeline": Struct.parse.gmArrayValue(data, "ef-shd_pipeline", SHADER_PIPELINE_TYPES, SHADER_PIPELINE_TYPES[0]),
        "ef-shd_use-merge-cfg": Struct.parse.boolean(data, "ef-shd_use-merge-cfg"),
        "ef-shd_merge-cfg": Struct.getIfType(data, "ef-shd_merge-cfg", Struct, { }),
      }
    },
    run: function(data) {
      var eventData = {
        template: Struct.get(data, "ef-shd_template"),
        duration: Struct.get(data, "ef-shd_duration"),
      }

      if (Struct.get(data, "ef-shd_fade-in")) {
        Struct.set(eventData, "fadeIn", Struct.get(data, "ef-shd_fade-in"))
      }

      if (Struct.get(data, "ef-shd_fade-out")) {
        Struct.set(eventData, "fadeOut", Struct.get(data, "ef-shd_fade-out"))
      }

      if (Struct.get(data, "ef-shd_alpha")) {
        Struct.set(eventData, "alphaMax", Struct.get(data, "ef-shd_alpha"))
      }

      if (Struct.get(data, "ef-shd_use-merge-cfg")) {
        Struct.set(eventData, "mergeProperties", Struct.get(data, "ef-shd_merge-cfg"))
      }

      if (Core.getRuntimeType() == RuntimeType.GXGAMES
          && Struct.contains(SHADERS_WASM, eventData.template)) {
        var wasmTemplate = Struct.get(SHADERS_WASM, eventData.template)
        Logger.debug("TrackService", $"Override shader '{eventData.template}' with '{wasmTemplate}'")
        Struct.set(eventData, "template", wasmTemplate)
      }

      var event = new Event("spawn-shader", JSON.clone(eventData))
      var controller = Beans.get(BeanVisuController)
      var pipeline = Struct.get(data, "ef-shd_pipeline")
      switch (pipeline) {
        case "Background": 
          controller.shaderBackgroundPipeline.send(event)
          break
        case "Grid":
          controller.shaderPipeline.send(event)
          break
        case "All":
          controller.shaderCombinedPipeline.send(event)
          break
        default: 
          Logger.warn("Track", $"Found unsupported pipeline: {pipeline}")
          break
      }
    },
  },
  "brush_effect_glitch": {
    parse: function(data) {
      return {
        "icon": Struct.getIfType(data, "icon", Struct, { name: "texture_baron" }),
        "ef-glt_use-fade-out": Struct.parse.boolean(data, "ef-glt_use-fade-out"),
        "ef-glt_fade-out": Struct.parse.number(data, "ef-glt_fade-out", 0.01, 0.0, 1.0),
        "ef-glt_use-config": Struct.parse.boolean(data, "ef-glt_use-config"),
        "ef-glt_line-spd": Struct.parse.number(data, "ef-glt_line-spd", 0.01, 0.0, 0.5),
        "ef-glt_line-shift": Struct.parse.number(data, "ef-glt_line-shift", 0.004, 0.0, 0.05),
        "ef-glt_line-res": Struct.parse.number(data, "ef-glt_line-res", 1.0, 0.0, 3.0),
        "ef-glt_line-v-shift": Struct.parse.number(data, "ef-glt_line-v-shift", 0.0, 0.0, 1.0),
        "ef-glt_line-drift": Struct.parse.number(data, "ef-glt_line-drift", 0.1, 0.0, 1.0),
        "ef-glt_jumb-spd": Struct.parse.number(data, "ef-glt_jumb-spd", 1.0, 0.0, 25.0),
        "ef-glt_jumb-shift": Struct.parse.number(data, "ef-glt_jumb-shift", 0.15, 0.0, 1.0),
        "ef-glt_jumb-res": Struct.parse.number(data, "ef-glt_jumb-res", 0.2, 0.0, 1.0),
        "ef-glt_jumb-chaos": Struct.parse.number(data, "ef-glt_jumb-chaos", 0.2, 0.0, 1.0),
        "ef-glt_shd-dispersion": Struct.parse.number(data, "ef-glt_shd-dispersion", 0.0025, 0.0, 0.5),
        "ef-glt_shd-ch-shift": Struct.parse.number(data, "ef-glt_shd-ch-shift", 0.004, 0.0, 0.05),
        "ef-glt_shd-noise": Struct.parse.number(data, "ef-glt_shd-noise", 0.5, 0.0, 1.0),
        "ef-glt_shd-shakiness": Struct.parse.number(data, "ef-glt_shd-shakiness", 0.5, 0.0, 10.0),
        "ef-glt_shd-rng-seed": Struct.parse.number(data, "ef-glt_shd-rng-seed", 0.0, 0.0, 1.0),
        "ef-glt_shd-intensity": Struct.parse.number(data, "ef-glt_shd-intensity", 1.0, 0.0, 5.0),
      }
    },
    run: function(data) {
      var bktGlitchService = Beans.get(BeanVisuController).visuRenderer.gridRenderer.glitchService
      var config = {
        lineSpeed: {
          defValue: Struct.get(data, "ef-glt_line-spd"),
          minValue: 0.0,
          maxValue: 0.5,
        },
        lineShift: {
          defValue: Struct.get(data, "ef-glt_line-shift"),
          minValue: 0.0,
          maxValue: 0.05,
        },
        lineResolution: {
          defValue: Struct.get(data, "ef-glt_line-res"),
          minValue: 0.0,
          maxValue: 3.0,
        },
        lineVertShift: {
          defValue: Struct.get(data, "ef-glt_line-v-shift"),
          minValue: 0.0,
          maxValue: 1.0,
        },
        lineDrift: {
          defValue: Struct.get(data, "ef-glt_line-drift"),
          minValue: 0.0,
          maxValue: 1.0,
        },
        jumbleSpeed: {
          defValue: Struct.get(data, "ef-glt_jumb-spd"),
          minValue: 0.0,
          maxValue: 25.0,
        },
        jumbleShift: {
          defValue: Struct.get(data, "ef-glt_jumb-shift"),
          minValue: 0.0,
          maxValue: 1.0,
        },
        jumbleResolution: {
          defValue: Struct.get(data, "ef-glt_jumb-res"),
          minValue: 0.0,
          maxValue: 1.0,
        },
        jumbleness: {
          defValue: Struct.get(data, "ef-glt_jumb-chaos"),
          minValue: 0.0,
          maxValue: 1.0,
        },
        dispersion: {
          defValue: Struct.get(data, "ef-glt_shd-dispersion"),
          minValue: 0.0,
          maxValue: 0.5,
        },
        channelShift: {
          defValue: Struct.get(data, "ef-glt_shd-ch-shift"),
          minValue: 0.0,
          maxValue: 0.05,
        },
        noiseLevel: {
          defValue: Struct.get(data, "ef-glt_shd-noise"),
          minValue: 0.0,
          maxValue: 1.0,
        },
        shakiness: {
          defValue: Struct.get(data, "ef-glt_shd-shakiness"),
          minValue: 0.0,
          maxValue: 10.0,
        },
        rngSeed: {
          defValue: Struct.get(data, "ef-glt_shd-rng-seed"),
          minValue: 0.0,
          maxValue: 1.0,
        },
        intensity: {
          defValue: Struct.get(data, "ef-glt_shd-intensity"),
          minValue: 0.0,
          maxValue: 5.0,
        },
      }
      var useConfig = Struct.get(data, "ef-glt_use-config")
      if (useConfig) {
        bktGlitchService.dispatcher.execute(new Event("load-config", config))
      }

      bktGlitchService.dispatcher.execute(new Event("spawn", { 
        factor: (Struct.get(data, "ef-glt_use-fade-out") 
          ? Struct.get(data, "ef-glt_fade-out") / 100.0 
          : 0.0),
        rng: !useConfig,
      }))
    },
  },
  "brush_effect_particle": {
    parse: function(data) {
      return {
        "icon": Struct.getIfType(data, "icon", Struct, { name: "texture_baron" }),
        "ef-part_preview": Struct.parse.boolean(data, "ef-part_preview"),
        "ef-part_template": Struct.parse.text(data, "ef-part_template", "particle-default"),
        "ef-part_area": Struct.parse.rectangle(data, "ef-part_area", { width: 1.0, height: 1.0 }),
        "ef-part_amount": round(Struct.parse.number(data, "ef-part_amount", 1, 1, 999)),
        "ef-part_duration": Struct.parse.number(data, "ef-part_duration", 0.0, 0, 999.9),
        "ef-part_interval": Struct.parse.number(data, "ef-part_interval", 0.0, 0, 999.9),
        "ef-part_shape": Struct.parse.arrayValue(data, "ef-part_shape", ParticleEmitterShape.keys(), ParticleEmitterShape.keys().getFirst()),
        "ef-part_distribution": Struct.parse.arrayValue(data, "ef-part_distribution", ParticleEmitterDistribution.keys(), ParticleEmitterDistribution.keys().getFirst()),
      }
    },
    run: function(data) {
      var particleService = Beans.get(BeanVisuController).particleService
      var area = Struct.get(data, "ef-part_area")
      particleService.send(particleService
        .factoryEventSpawnParticleEmitter(
          {
            particleName: Struct.get(data, "ef-part_template"),
            beginX: (area.getX() + 0.5) * GRID_SERVICE_PIXEL_WIDTH,
            beginY: (area.getY() + 0.5) * GRID_SERVICE_PIXEL_HEIGHT,
            endX: (area.getX() + area.getWidth() + 0.5) * GRID_SERVICE_PIXEL_WIDTH,
            endY: (area.getY() + area.getHeight() + 0.5) * GRID_SERVICE_PIXEL_HEIGHT,
            amount: Struct.get(data, "ef-part_amount"),
            interval: Struct.get(data, "ef-part_interval"),
            duration: Struct.get(data, "ef-part_duration"),
            shape: ParticleEmitterShape.get(Struct.get(data, "ef-part_shape")),
            distribution: ParticleEmitterDistribution.get(Struct.get(data, "ef-part_distribution")),
          }, 
        ))
    },
  },
  "brush_effect_config": {
    parse: function(data) {
      return {
        "icon": Struct.getIfType(data, "icon", Struct, { name: "texture_baron" }),
        "ef-cfg_use-render-shd-bkg": Struct.parse.boolean(data, "ef-cfg_use-render-shd-bkg"),
        "ef-cfg_render-shd-bkg": Struct.parse.boolean(data, "ef-cfg_render-shd-bkg"),
        "ef-cfg_cls-shd-bkg": Struct.parse.boolean(data, "ef-cfg_cls-shd-bkg"),
        "ef-cfg_use-render-shd-gr": Struct.parse.boolean(data, "ef-cfg_use-render-shd-gr"),
        "ef-cfg_render-shd-gr": Struct.parse.boolean(data, "ef-cfg_render-shd-gr"),
        "ef-cfg_cls-shd-gr": Struct.parse.boolean(data, "ef-cfg_cls-shd-gr"),
        "ef-cfg_use-render-shd-all": Struct.parse.boolean(data, "ef-cfg_use-render-shd-all"),
        "ef-cfg_render-shd-all": Struct.parse.boolean(data, "ef-cfg_render-shd-all"),
        "ef-cfg_cls-shd-all": Struct.parse.boolean(data, "ef-cfg_cls-shd-all"),
        "ef-cfg_use-render-glt": Struct.parse.boolean(data, "ef-cfg_use-render-glt"),
        "ef-cfg_render-glt": Struct.parse.boolean(data, "ef-cfg_render-glt"),
        "ef-cfg_cls-glt": Struct.parse.boolean(data, "ef-cfg_cls-glt"),
        "ef-cfg_use-render-part": Struct.parse.boolean(data, "ef-cfg_use-render-part"),
        "ef-cfg_render-part": Struct.parse.boolean(data, "ef-cfg_render-part"),
        "ef-cfg_cls-part": Struct.parse.boolean(data, "ef-cfg_cls-part"),
        "ef-cfg_use-cls-frame": Struct.parse.boolean(data, "ef-cfg_use-cls-frame"),
        "ef-cfg_cls-frame": Struct.parse.boolean(data, "ef-cfg_cls-frame"),
        "ef-cfg_use-cls-frame-col": Struct.parse.boolean(data, "ef-cfg_use-cls-frame-col"),
        "ef-cfg_cls-frame-col": Struct.parse.color(data, "ef-cfg_cls-frame-col"),
        "ef-cfg_cls-frame-col-spd": Struct.parse.number(data, "ef-cfg_cls-frame-col-spd", 1.0, 0.000001, 1.0),
        "ef-cfg_cls-frame-alpha": Struct.parse.normalizedNumberTransformer(data, "ef-cfg_cls-frame-alpha"),
        "ef-cfg_use-cls-frame-alpha": Struct.parse.boolean(data, "ef-cfg_use-cls-frame-alpha"),
        "ef-cfg_change-cls-frame-alpha": Struct.parse.boolean(data, "ef-cfg_change-cls-frame-alpha"),
      }
    },
    run: function(data) {
      var controller = Beans.get(BeanVisuController)
      var properties = controller.gridService.properties
      
      if (Struct.get(data, "ef-cfg_use-render-shd-bkg")) {
        properties.renderBackgroundShaders = Struct.get(data, "ef-cfg_render-shd-bkg")
      }

      if (Struct.get(data, "ef-cfg_use-render-shd-gr")) {
        properties.renderGridShaders = Struct.get(data, "ef-cfg_render-shd-gr")
      }

      if (Struct.get(data, "ef-cfg_use-render-shd-all")) {
        properties.renderCombinedShaders = Struct.get(data, "ef-cfg_render-shd-all")
      }

      if (Struct.get(data, "ef-cfg_use-cls-frame")) {
        properties.shaderClearFrame = Struct.get(data, "ef-cfg_cls-frame")
      }

      if (Struct.get(data, "ef-cfg_use-cls-frame-col")) {
        controller.gridService.send(new Event("transform-property", {
          key: "shaderClearColor",
          container: controller.gridService.properties,
          executor: controller.gridService.executor,
          transformer: new ColorTransformer({
            value: controller.gridService.properties.shaderClearColor.toHex(true),
            target: Struct.get(data, "ef-cfg_cls-frame-col"),
            factor: Struct.get(data, "ef-cfg_cls-frame-col-spd"),
            increase: 0.0,
          })
        }))
      }
      
      if (Struct.get(data, "ef-cfg_use-cls-frame-alpha")) {
        controller.gridService.properties.shaderClearFrameAlpha = Struct.get(data, "ef-cfg_cls-frame-alpha").value
      }

      if (Struct.get(data, "ef-cfg_change-cls-frame-alpha")) {
        var transformer = Struct.get(data, "ef-cfg_cls-frame-alpha")
        controller.gridService.send(new Event("transform-property", {
          key: "shaderClearFrameAlpha",
          container: controller.gridService.properties,
          executor: controller.gridService.executor,
          transformer: new NumberTransformer({
            value: controller.gridService.properties.shaderClearFrameAlpha,
            target: transformer.target,
            factor: transformer.factor,
            increase: transformer.increase,
          })
        }))
      }

      if (Struct.get(data, "ef-cfg_cls-shd-gr")) {
        controller.shaderPipeline.send(new Event("clear-shaders"))
      }

      if (Struct.get(data, "ef-cfg_cls-shd-bkg")) {
        controller.shaderBackgroundPipeline.send(new Event("clear-shaders"))
      }

      if (Struct.get(data, "ef-cfg_cls-shd-all")) {
        controller.shaderCombinedPipeline.send(new Event("clear-shaders"))
      }
    },
  },
}
#macro effect_track_event global.__effect_track_event