///@package io.alkapivo.visu.service.track

///@static
///@type {Struct}
global.__effect_track_event = {
  "brush_effect_shader": function(data) {
    var eventData = {
      template: Struct.get(data, "ef-shd_template"),
      duration: Struct.get(data, "ef-shd_duration"),
    }

    if (Core.isType(Struct.get(data, "ef-shd_fade-in"), Number)) {
      Struct.set(eventData, "fadeIn", Struct.get(data, "ef-shd_fade-in"))
    }

    if (Core.isType(Struct.get(data, "ef-shd_fade-out"), Number)) {
      Struct.set(eventData, "fadeOut", Struct.get(data, "ef-shd_fade-out"))
    }

    if (Core.isType(Struct.get(data, "ef-shd_alpha"), Number)) {
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
    var pipeline = Struct.getDefault(data, "ef-shd_pipeline", "Grid")
    switch (pipeline) {
      case "Background": 
        controller.shaderBackgroundPipeline.send(event)
        break
      case "Grid":
        controller.shaderPipeline.send(event)
        break
      case "All":
        controller.shaderCombinedPipeline.send(event)
        //controller.shaderPipeline.send(event)
        //controller.shaderBackgroundPipeline.send(new Event("spawn-shader", JSON.clone(eventData)))
        break
      default: throw new Exception($"Found unsupported pipeline: {pipeline}")
    }
  },
  "brush_effect_glitch": function(data) {
    var bktGlitchService = Beans.get(BeanVisuController).visuRenderer.gridRenderer.glitchService
    var config = {
      lineSpeed: {
        defValue: Struct.getDefault(data, "ef-glt_line-spd", 0.0),
        minValue: 0.0,
        maxValue: 0.5,
      },
      lineShift: {
        defValue: Struct.getDefault(data, "ef-glt_line-shift", 0.0),
        minValue: 0.0,
        maxValue: 0.05,
      },
      lineResolution: {
        defValue: Struct.getDefault(data, "ef-glt_line-res", 0.0),
        minValue: 0.0,
        maxValue: 3.0,
      },
      lineVertShift: {
        defValue: Struct.getDefault(data, "ef-glt_line-v-shift", 0.0),
        minValue: 0.0,
        maxValue: 1.0,
      },
      lineDrift: {
        defValue: Struct.getDefault(data, "ef-glt_line-drift", 0.0),
        minValue: 0.0,
        maxValue: 1.0,
      },
      jumbleSpeed: {
        defValue: Struct.getDefault(data, "ef-glt_jumb-spd", 0.0),
        minValue: 0.0,
        maxValue: 25.0,
      },
      jumbleShift: {
        defValue: Struct.getDefault(data, "ef-glt_jumb-shift", 0.0),
        minValue: 0.0,
        maxValue: 1.0,
      },
      jumbleResolution: {
        defValue: Struct.getDefault(data, "ef-glt_jumb-res", 0.0),
        minValue: 0.0,
        maxValue: 1.0,
      },
      jumbleness: {
        defValue: Struct.getDefault(data, "ef-glt_jumb-chaos", 0.0),
        minValue: 0.0,
        maxValue: 1.0,
      },
      dispersion: {
        defValue: Struct.getDefault(data, "ef-glt_shd-dispersion", 0.0),
        minValue: 0.0,
        maxValue: 0.5,
      },
      channelShift: {
        defValue: Struct.getDefault(data, "ef-glt_shd-ch-shift", 0.0),
        minValue: 0.0,
        maxValue: 0.05,
      },
      noiseLevel: {
        defValue: Struct.getDefault(data, "ef-glt_shd-noise", 0.0),
        minValue: 0.0,
        maxValue: 1.0,
      },
      shakiness: {
        defValue: Struct.getDefault(data, "ef-glt_shd-shakiness", 0.0),
        minValue: 0.0,
        maxValue: 10.0,
      },
      rngSeed: {
        defValue: Struct.getDefault(data, "ef-glt_shd-rng-seed", 0.0),
        minValue: 0.0,
        maxValue: 1.0,
      },
      intensity: {
        defValue: Struct.getDefault(data, "ef-glt_shd-intensity", 0.0),
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
  "brush_effect_particle": function(data) {
    var particleService = Beans.get(BeanVisuController).particleService
    var area = new Rectangle(Struct.get(data, "ef-part_area"))
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
  "brush_effect_config": function(data) {
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
          factor: Struct.getIfType(data, "ef-cfg_cls-frame-col-spd", Number, 0.01),
        })
      }))
    }
    
    if (Struct.get(data, "ef-cfg_use-cls-frame-alpha") 
        && Core.isType(Struct.get(Struct.get(data, "ef-cfg_cls-frame-alpha"), "value"), Number)) {
      controller.gridService.properties.shaderClearFrameAlpha = Struct.get(data, "ef-cfg_cls-frame-alpha").value
    }

    if (Struct.get(data, "ef-cfg_change-cls-frame-alpha") == true) {
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
}
#macro effect_track_event global.__effect_track_event