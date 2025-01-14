///@package io.alkapivo.visu.service.track._old

///@static
///@type {Struct}
global.__view_old_track_event = {
  "brush_view_old_wallpaper": {
    parse: function(data) {
      return Struct.appendUnique({ 
        "icon": Struct.parse.sprite(data, "icon"),
        "view-wallpaper_type": migrateShaderPipelineType(Struct.get(data, "view-wallpaper_type")),
      }, data, false)
    },
    run: function(data) {
      var controller = Beans.get(BeanVisuController)
      if (Struct.get(data, "view-wallpaper_clear-color") == true) {
        controller.gridService.executor.tasks.forEach(function(task, iterator, type) {
          if (task.name == "fade-color" && task.state.get("type") == type) {
            task.state.set("stage", "fade-out")
          }
        }, Struct.get(data, "view-wallpaper_type"))
      }

      if (Struct.get(data, "view-wallpaper_use-color") == true) {
        controller.gridService.send(new Event("fade-color", {
          color: ColorUtil.fromHex(Struct.get(data, "view-wallpaper_color")),
          collection: Struct.get(data, "view-wallpaper_type") == WallpaperType.BACKGROUND
            ? controller.visuRenderer.gridRenderer.overlayRenderer.backgroundColors
            : controller.visuRenderer.gridRenderer.overlayRenderer.foregroundColors,
          type: Struct.get(data, "view-wallpaper_type"),
          fadeInDuration: Struct.get(data, "view-wallpaper_fade-in-duration"),
          fadeOutDuration: Struct.get(data, "view-wallpaper_fade-out-duration"),
          executor: controller.gridService.executor,
          blendModeSource: BlendModeExt.get(Struct.getDefault(data, "view-wallpaper_blend-mode-source", "SRC_ALPHA")),
          blendModeTarget: BlendModeExt.get(Struct.getDefault(data, "view-wallpaper_blend-mode-target", Struct.get(data, "view-wallpaper_type") == WallpaperType.BACKGROUND ? "INV_SRC_ALPHA" : "ONE")),
          blendEquation: BlendEquation.get(Struct.getDefault(data, "view-wallpaper_blend-equation", "ADD")),
        }))
      }

      if (Struct.get(data, "view-wallpaper_clear-texture") == true) {
        controller.gridService.executor.tasks.forEach(function(task, iterator, type) {
          if (task.name == "fade-sprite" && task.state.get("type") == type) {
            task.state.set("stage", "fade-out")
          }
        }, Struct.get(data, "view-wallpaper_type"))
      }

      if (Struct.get(data, "view-wallpaper_use-texture") == true) {
        var sprite = Struct.get(data, "view-wallpaper_texture")

        if (Struct.get(data, "view-wallpaper_use-texture-blend")) {
          Struct.set(sprite, "blend", Struct.get(data, "view-wallpaper_texture-blend"))
        } else {
          Struct.remove(sprite, "blend")
        }

        controller.gridService.send(new Event("fade-sprite", {
          sprite: SpriteUtil.parse(sprite),
          collection: Struct.get(data, "view-wallpaper_type") == WallpaperType.BACKGROUND
            ? controller.visuRenderer.gridRenderer.overlayRenderer.backgrounds
            : controller.visuRenderer.gridRenderer.overlayRenderer.foregrounds,
          type: Struct.get(data, "view-wallpaper_type"),
          blendModeSource: BlendModeExt.get(Struct.getDefault(data, "view-wallpaper_blend-mode-source", "SRC_ALPHA")),
          blendModeTarget: BlendModeExt.get(Struct.getDefault(data, "view-wallpaper_blend-mode-target", Struct.get(data, "view-wallpaper_type") == WallpaperType.BACKGROUND ? "INV_SRC_ALPHA" : "ONE")),
          blendEquation: BlendEquation.get(Struct.getDefault(data, "view-wallpaper_blend-equation", "ADD")),
          fadeInDuration: Struct.get(data, "view-wallpaper_fade-in-duration"),
          fadeOutDuration: Struct.get(data, "view-wallpaper_fade-out-duration"),
          angle: Struct.get(data, "view-wallpaper_angle"),
          angleTransformer: Struct.get(data, "view-wallpaper_use-angle-transform") 
            ? Struct.get(data, "view-wallpaper_angle-transform") 
            : null,
          speed: Struct.get(data, "view-wallpaper_speed"),
          speedTransformer: Struct.get(data, "view-wallpaper_use-speed-transform") 
            ? Struct.get(data, "view-wallpaper_speed-transform") 
            : null,
          xScale: Struct.get(data, "view-wallpaper_xScale"),
          xScaleTransformer: Struct.get(data, "view-wallpaper_use-xScale-transform") 
            ? Struct.get(data, "view-wallpaper_xScale-transform") 
            : null,
          yScale: Struct.get(data, "view-wallpaper_yScale"),
          yScaleTransformer: Struct.get(data, "view-wallpaper_use-yScale-transform") 
            ? Struct.get(data, "view-wallpaper_yScale-transform") 
            : null,
          executor: controller.gridService.executor,
        }))
      }
    },
  },
  "brush_view_old_camera": {
    parse: function(data) {
      return Struct.appendUnique({ "icon": Struct.parse.sprite(data, "icon") }, data, false)
    },
    run: function(data) {
      var controller = Beans.get(BeanVisuController)

      if (Struct.get(data, "view-config_use-movement")) {
        controller.gridService.movement.enable = Struct
          .get(data, "view-config_movement-enable")

        var movementAngle = Struct.get(data, "view-config_movement-angle")
        var angleDifference = Math.fetchPointsAngleDiff(movementAngle.target, controller.gridService.movement.angle.get())
        controller.gridService.movement.angle = new NumberTransformer({
          value: controller.gridService.movement.angle.get(),
          target: controller.gridService.movement.angle.get() + angleDifference,
          factor: movementAngle.factor,
          increase: movementAngle.increase,
        })

        var movementSpeed = Struct.get(data, "view-config_movement-speed")
        controller.gridService.movement.speed = new NumberTransformer({
          value: controller.gridService.movement.speed.get(),
          target: movementSpeed.target,
          factor: movementSpeed.factor,
          increase: movementSpeed.increase,
        })
      }
      

      if (Struct.get(data, "view-config_use-lock-target-x")) {
        controller.gridService.targetLocked.isLockedX = Struct.get(data, "view-config_lock-target-x")
      }
      
      if (Struct.get(data, "view-config_use-lock-target-y")) {
        controller.gridService.targetLocked.isLockedY = Struct.get(data, "view-config_lock-target-y")
      }

      if (Struct.get(data, "view-config_use-follow-properties")) {
        var follow = controller.gridService.view.follow
        follow.xMargin = Struct.get(data, "view-config_follow-margin-x")
        follow.yMargin = Struct.get(data, "view-config_follow-margin-y")
        follow.smooth = Struct.get(data, "view-config_follow-smooth")
      }

      if (Struct.get(data, "view-config_use-transform-x")) {
        var transformer = Struct.get(data, "view-config_transform-x")
        controller.gridService.send(new Event("transform-property", {
          key: "x",
          container: controller.visuRenderer.gridRenderer.camera,
          executor: controller.gridService.executor, // controller.visuRenderer.gridRenderer.camera.executor,
          transformer: new NumberTransformer({
            value: controller.visuRenderer.gridRenderer.camera.x,
            target: transformer.target,
            factor: transformer.factor,
            increase: transformer.increase,
          })
        }))
      }
      
      if (Struct.get(data, "view-config_use-transform-y")) {
        var transformer = Struct.get(data, "view-config_transform-y")
        controller.gridService.send(new Event("transform-property", {
          key: "y",
          container: controller.visuRenderer.gridRenderer.camera,
          executor: controller.gridService.executor, // controller.visuRenderer.gridRenderer.camera.executor,
          transformer: new NumberTransformer({
            value: controller.visuRenderer.gridRenderer.camera.y,
            target: transformer.target,
            factor: transformer.factor,
            increase: transformer.increase,
          })
        }))
      }
      
      if (Struct.get(data, "view-config_use-transform-z")) {
        var transformer = Struct.get(data, "view-config_transform-z")
        controller.gridService.send(new Event("transform-property", {
          key: "z",
          container: controller.visuRenderer.gridRenderer.camera,
          executor: controller.gridService.executor, // controller.visuRenderer.gridRenderer.camera.executor,
          transformer: new NumberTransformer({
            value: controller.visuRenderer.gridRenderer.camera.z,
            target: transformer.target,
            factor: transformer.factor,
            increase: transformer.increase,
          })
        }))
      }
      
      if (Struct.get(data, "view-config_use-transform-zoom")) {
        var transformer = Struct.get(data, "view-config_transform-zoom")
        controller.gridService.send(new Event("transform-property", {
          key: "zoom",
          container: controller.visuRenderer.gridRenderer.camera,
          executor: controller.gridService.executor, // controller.visuRenderer.gridRenderer.camera.executor,
          transformer: new NumberTransformer({
            value: controller.visuRenderer.gridRenderer.camera.zoom,
            target: transformer.target,
            factor: transformer.factor,
            increase: transformer.increase,
          })
        }))
      }
      
      if (Struct.get(data, "view-config_use-transform-angle")) {
        var transformer = Struct.get(data, "view-config_transform-angle")
        var angleDifference = Math.fetchPointsAngleDiff(transformer.target, controller.visuRenderer.gridRenderer.camera.angle)
        controller.gridService.send(new Event("transform-property", {
          key: "angle",
          container: controller.visuRenderer.gridRenderer.camera,
          executor: controller.gridService.executor, // controller.visuRenderer.gridRenderer.camera.executor,
          transformer: new NumberTransformer({
            value: controller.visuRenderer.gridRenderer.camera.angle,
            target: controller.visuRenderer.gridRenderer.camera.angle + angleDifference,
            factor: transformer.factor,
            increase: transformer.increase,
          })
        }))
      }
      
      if (Struct.get(data, "view-config_use-transform-pitch")) {
        var transformer = Struct.get(data, "view-config_transform-pitch")
        controller.gridService.send(new Event("transform-property", {
          key: "pitch",
          container: controller.visuRenderer.gridRenderer.camera,
          executor: controller.gridService.executor, // controller.visuRenderer.gridRenderer.camera.executor,
          transformer: new NumberTransformer({
            value: controller.visuRenderer.gridRenderer.camera.pitch,
            target: transformer.target,
            factor: transformer.factor,
            increase: transformer.increase,
          })
        }))
      }
    },
  },
  "brush_view_old_lyrics": {
    parse: function(data) {
      return Struct.appendUnique({ "icon": Struct.parse.sprite(data, "icon") }, data, false)
    },
    run: function(data) {
      var controller = Beans.get(BeanVisuController)

      var align = { v: VAlign.TOP, h: HAlign.LEFT }
      var alignV = Struct.get(data, "view-lyrics_align-v")
      var alignH = Struct.get(data, "view-lyrics_align-h")
      if (alignV == "BOTTOM") {
        align.v = VAlign.BOTTOM
      }
      if (alignH == "CENTER") {
        align.h = HAlign.CENTER
      } else if (alignH == "RIGHT") {
        align.h = HAlign.RIGHT
      }

      controller.subtitleService.send(new Event("add")
        .setData({
          template: Struct.get(data, "view-lyrics_template"),
          font: FontUtil.fetch(Struct.get(data, "view-lyrics_font")),
          fontHeight: Struct.get(data, "view-lyrics_font-height"),
          charSpeed: Struct.get(data, "view-lyrics_char-speed"),
          color: ColorUtil.fromHex(Struct.get(data, "view-lyrics_color")).toGMColor(),
          outline: Struct.get(data, "view-lyrics_use-outline")
            ? ColorUtil.fromHex(Struct.get(data, "view-lyrics_outline")).toGMColor()
            : null,
          timeout: Struct.get(data, "view-lyrics_use-timeout")
            ? Struct.get(data, "view-lyrics_timeout")
            : null,
          align: align,
          area: new Rectangle({ 
            x: Struct.get(data, "view-lyrics_x"),
            y: Struct.get(data, "view-lyrics_y"),
            width: Struct.get(data, "view-lyrics_width"),
            height: Struct.get(data, "view-lyrics_height"),
          }),
          lineDelay: Struct.get(data, "view-lyrics_use-line-delay")
            ? new Timer(Struct.get(data, "view-lyrics_line-delay"))
            : null,
          finishDelay: Struct.get(data, "view-lyrics_use-finish-delay")
            ? new Timer(Struct.get(data, "view-lyrics_finish-delay"))
            : null,
          angleTransformer: Struct.get(data, "view-lyrics_use-transform-angle")
            ? new NumberTransformer(Struct.get(data, "view-lyrics_transform-angle"))
            : new NumberTransformer({ value: 0.0, target: 0.0, factor: 0.0, increase: 0.0 }),
          speedTransformer: Struct.get(data, "view-lyrics_use-transform-speed")
            ? new NumberTransformer(Struct.get(data, "view-lyrics_transform-speed"))
            : null,
          fadeIn: Struct.get(data, "view-lyrics_fade-in"),
          fadeOut: Struct.get(data, "view-lyrics_fade-out"),
        }))
    },
  },
  "brush_view_old_glitch": {
    parse: function(data) {
      return Struct.appendUnique({ "icon": Struct.parse.sprite(data, "icon") }, data, false)
    },
    run: function(data) {
      var bktGlitchService = Beans.get(BeanVisuController).visuRenderer.gridRenderer.glitchService
      var config = {
        lineSpeed: {
          defValue: Struct.getDefault(data, "view-glitch_line-speed", 0.0),
          minValue: 0.0,
          maxValue: 0.5,
        },
        lineShift: {
          defValue: Struct.getDefault(data, "view-glitch_line-shift", 0.0),
          minValue: 0.0,
          maxValue: 0.05,
        },
        lineResolution: {
          defValue: Struct.getDefault(data, "view-glitch_line-resolution", 0.0),
          minValue: 0.0,
          maxValue: 3.0,
        },
        lineVertShift: {
          defValue: Struct.getDefault(data, "view-glitch_line-vertical-shift", 0.0),
          minValue: 0.0,
          maxValue: 1.0,
        },
        lineDrift: {
          defValue: Struct.getDefault(data, "view-glitch_line-drift", 0.0),
          minValue: 0.0,
          maxValue: 1.0,
        },
        jumbleSpeed: {
          defValue: Struct.getDefault(data, "view-glitch_jumble-speed", 0.0),
          minValue: 0.0,
          maxValue: 25.0,
        },
        jumbleShift: {
          defValue: Struct.getDefault(data, "view-glitch_jumble-shift", 0.0),
          minValue: 0.0,
          maxValue: 1.0,
        },
        jumbleResolution: {
          defValue: Struct.getDefault(data, "view-glitch_jumble-resolution", 0.0),
          minValue: 0.0,
          maxValue: 1.0,
        },
        jumbleness: {
          defValue: Struct.getDefault(data, "view-glitch_jumble-jumbleness", 0.0),
          minValue: 0.0,
          maxValue: 1.0,
        },
        dispersion: {
          defValue: Struct.getDefault(data, "view-glitch_shader-dispersion", 0.0),
          minValue: 0.0,
          maxValue: 0.5,
        },
        channelShift: {
          defValue: Struct.getDefault(data, "view-glitch_shader-channel-shift", 0.0),
          minValue: 0.0,
          maxValue: 0.05,
        },
        noiseLevel: {
          defValue: Struct.getDefault(data, "view-glitch_shader-noise-level", 0.0),
          minValue: 0.0,
          maxValue: 1.0,
        },
        shakiness: {
          defValue: Struct.getDefault(data, "view-glitch_shader-shakiness", 0.0),
          minValue: 0.0,
          maxValue: 10.0,
        },
        rngSeed: {
          defValue: Struct.getDefault(data, "view-glitch_shader-rng-seed", 0.0),
          minValue: 0.0,
          maxValue: 1.0,
        },
        intensity: {
          defValue: Struct.getDefault(data, "view-glitch_shader-intensity", 0.0),
          minValue: 0.0,
          maxValue: 5.0,
        },
      }
      var useConfig = Struct.get(data, "view-glitch_use-config")
      if (useConfig) {
        bktGlitchService.dispatcher.execute(new Event("load-config", config))
      }

      bktGlitchService.dispatcher.execute(new Event("spawn", { 
        factor: (Struct.get(data, "view-glitch_use-factor") 
          ? Struct.get(data, "view-glitch_factor") / 100.0 
          : 0.0),
        rng: !useConfig,
      }))
    },
  },
  "brush_view_old_config": {
    parse: function(data) {
      return Struct.appendUnique({ "icon": Struct.parse.sprite(data, "icon") }, data, false)
    },
    run: function(data) {
      var controller = Beans.get(BeanVisuController)
      var gridService = controller.gridService
      if (Struct.get(data, "view-config_use-render-grid")) {
        controller.gridService.properties.renderGrid = Struct
          .get(data, "view-config_render-grid")
      }

      if (Struct.get(data, "view-config_use-render-particles")) {
        gridService.properties.renderParticles = Struct
          .get(data, "view-config_render-particles")
      }
      
      if (Struct.get(data, "view-config_use-transform-particles-z")) {
        var transformer = Struct.get(data, "view-config_transform-particles-z")
        gridService.send(new Event("transform-property", {
          key: "particleZ",
          container: gridService.properties.depths,
          executor: gridService.executor,
          transformer: new NumberTransformer({
            value: gridService.properties.depths.particleZ,
            target: transformer.target,
            factor: transformer.factor,
            increase: transformer.increase,
          })
        }))
      }
      
      if (Struct.get(data, "view-config_use-render-video")) {
        gridService.properties.renderVideo = Struct
          .get(data, "view-config_render-video")
      }

      if (Struct.get(data, "view-config_use-render-HUD")) {
        controller.visuRenderer.hudRenderer.enabled = Struct
          .get(data, "view-config_render-HUD")
      }

      if (Struct.get(data, "view-config_clear-lyrics")) {
        controller.subtitleService.send(new Event("clear-subtitle"))
      }
    },
  },
}
#macro view_old_track_event global.__view_old_track_event
