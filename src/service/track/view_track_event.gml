///@package io.alkapivo.visu.service.track

///@static
///@type {Struct}
global.__view_track_event = {
  "brush_view_camera": {
    parse: function(data) {
      return {
        "icon": Struct.parse.sprite(data, "icon"),
        "vw-cam_use-lock-x": Struct.parse.boolean(data, "vw-cam_use-lock-x"),
        "vw-cam_lock-x": Struct.parse.boolean(data, "vw-cam_lock-x"),
        "vw-cam_use-lock-y": Struct.parse.boolean(data, "vw-cam_use-lock-y"),
        "vw-cam_lock-y": Struct.parse.boolean(data, "vw-cam_lock-y"),
        "vw-cam_follow": Struct.parse.boolean(data, "vw-cam_follow"),
        "vw-cam_use-follow-x": Struct.parse.boolean(data, "vw-cam_use-follow-x"),
        "vw-cam_follow-x": Struct.parse.number(data, "vw-cam_follow-x", 0.35, 0.0, 0.5),
        "vw-cam_use-follow-y": Struct.parse.boolean(data, "vw-cam_use-follow-y"),
        "vw-cam_follow-y": Struct.parse.number(data, "vw-cam_follow-y", 0.40, 0.0, 0.5),
        "vw-cam_follow-smooth": Struct.parse.number(data, "vw-cam_follow-smooth", 32.0, 1.0, 256.0),
        "vw-cam_use-follow-smooth": Struct.parse.boolean(data, "vw-cam_use-follow-smooth"),
        "vw-cam_use-x": Struct.parse.boolean(data, "vw-cam_use-x"),
        "vw-cam_x": Struct.parse.numberTransformer(data, "vm-cam_x", {
          value: 4096.0,
          clampValue: { from: 0.0, to: 99999.9 },
          clampTarget: { from: 0.0, to: 99999.9 },
        }),
        "vw-cam_change-x": Struct.parse.boolean(data, "vw-cam_change-x"),
        "vw-cam_use-y": Struct.parse.boolean(data, "vw-cam_use-y"),
        "vw-cam_y": Struct.parse.numberTransformer(data, "vw-cam_y", {
          value: 5356.0,
          clampValue: { from: 0.0, to: 99999.9 },
          clampTarget: { from: 0.0, to: 99999.9 },
        }),
        "vw-cam_change-y": Struct.parse.boolean(data, "vw-cam_change-y"),
        "vw-cam_use-z": Struct.parse.boolean(data, "vw-cam_use-z"),
        "vw-cam_z": Struct.parse.numberTransformer(data, "vw-cam_z", {
          value: 5000.0,
          clampValue: { from: 0.0, to: 99999.9 },
          clampTarget: { from: 0.0, to: 99999.9 },
        }),
        "vw-cam_change-z": Struct.parse.boolean(data, "vw-cam_change-z"),
        "vw-cam_use-dir": Struct.parse.boolean(data, "vw-cam_use-dir"),
        "vw-cam_dir": Struct.parse.numberTransformer(data, "vw-cam_dir", {
          clampValue: { from: -9999.9, to: 9999.9 },
          clampTarget: { from: -9999.9, to: 9999.9 },
        }),
        "vw-cam_change-dir": Struct.parse.boolean(data, "vw-cam_change-dir"),
        "vw-cam_use-pitch": Struct.parse.boolean(data, "vw-cam_use-pitch"),
        "vw-cam_pitch": Struct.parse.numberTransformer(data, "vw-cam_pitch", {
          value: -70.0,
          clampValue: { from: -9999.9, to: 9999.9 },
          clampTarget: { from: -9999.9, to: 9999.9 },
        }),
        "vw-cam_change-pitch": Struct.parse.boolean(data, "vw-cam_change-pitch"),
        "vw-cam_use-move-speed": Struct.parse.boolean(data, "vw-cam_use-move-speed"),
        "vw-cam_move-speed": Struct.parse.numberTransformer(data, "vw-cam_move-speed", {
          clampValue: { from: 0.0, to: 99.9 },
          clampTarget: { from: 0.0, to: 99.9 },
        }),
        "vw-cam_change-move-speed": Struct.parse.boolean(data, "vw-cam_change-move-speed"),
        "vw-cam_use-move-angle": Struct.parse.boolean(data, "vw-cam_use-move-angle"),
        "vw-cam_move-angle": Struct.parse.numberTransformer(data, "vw-cam_move-angle", {
          clampValue: { from: -9999.9, to: 9999.9 },
          clampTarget: { from: -9999.9, to: 9999.9 },
        }),
        "vw-cam_change-move-angle": Struct.parse.boolean(data, "vw-cam_change-move-angle"),
      }
    },
    run: function(data) {
      Core.print("Dispatch track event:", "brush_view_camera")
      return null;
      var controller = Beans.get(BeanVisuController)
      if (Struct.get(data, "vw-cam_use-lock-x")) {
        controller.gridService.targetLocked.isLockedX = Struct.get(data, "vw-cam_lock-x")
      }
      
      if (Struct.get(data, "vw-cam_use-lock-y")) {
        controller.gridService.targetLocked.isLockedY = Struct.get(data, "vw-cam_lock-y")
      }

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

      if (Struct.get(data, "vw-cam_follow")) {
        var follow = controller.gridService.view.follow
        follow.xMargin = Struct.get(data, "vw-cam_follow-x")
        follow.yMargin = Struct.get(data, "vw-cam_follow-y")
        follow.smooth = Struct.get(data, "vw-cam_follow-smooth")
      }

      if (Struct.get(data, "vw-cam_use-change-x")) {
        var transformer = Struct.get(data, "vw-cam_change-x")
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
      
      if (Struct.get(data, "vw-cam_use-change-y")) {
        var transformer = Struct.get(data, "vw-cam_change-y")
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
      
      if (Struct.get(data, "vw-cam_use-change-z")) {
        var transformer = Struct.get(data, "vw-cam_change-z")
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
      
      if (Struct.get(data, "vw-cam_use-change-zoom")) {
        var transformer = Struct.get(data, "vw-cam_change-zoom")
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
      
      if (Struct.get(data, "vw-cam_use-change-dir")) {
        var transformer = Struct.get(data, "vw-cam_change-dir")
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
      
      if (Struct.get(data, "vw-cam_use-change-pitch")) {
        var transformer = Struct.get(data, "vw-cam_change-pitch")
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
  "brush_view_wallpaper": {
    parse: function(data) {
      return {
        "icon": Struct.parse.sprite(data, "icon"),
        "vw-layer_type": Struct.parse.gmArrayValue(data, "vw-layer_type", WALLPAPER_TYPES, WALLPAPER_TYPES[0]),
        "vw-layer_fade-in": Struct.parse.number(data, "vw-layer_fade-in", 0.0, 0.0, 999.9),
        "vw-layer_fade-out": Struct.parse.number(data, "vw-layer_fade-out", 0.0, 0.0, 999.9),
        "vw-layer_use-texture": Struct.parse.boolean(data, "vw-layer_use-texture"),
        "vw-layer_texture": Struct.parse.sprite(data, "vw-layer_texture"),
        "vw-layer_use-texture-blend": Struct.parse.boolean(data, "vw-layer_use-texture-blend"),
        "vw-layer_texture-blend": Struct.parse.color(data, "vw-layer_texture-blend"),
        "vw-layer_use-col": Struct.parse.boolean(data, "vw-layer_use-col"),
        "vw-layer_col": Struct.parse.color(data, "vw-layer_col"),
        "vw-layer_cls-texture": Struct.parse.boolean(data, "vw-layer_cls-texture"),
        "vw-layer_cls-col": Struct.parse.boolean(data, "vw-layer_cls-col"),
        "vw-layer_use-blend": Struct.parse.boolean(data, "vw-layer_use-blend"),
        "vw-layer_blend-src": Struct.parse.gmArrayValue(data, "vw-layer_blend-src", BLEND_MODES_EXT, BLEND_MODES_EXT[0]),
        "vw-layer_blend-dest": Struct.parse.gmArrayValue(data, "vw-layer_blend-dest", BLEND_MODES_EXT, BLEND_MODES_EXT[0]),
        "vw-layer_blend-eq": Struct.parse.gmArrayValue(data, "vw-layer_blend-dest", BLEND_EQUATIONS, BLEND_EQUATIONS[0]),
        "vw-layer_use-spd": Struct.parse.boolean(data, "vw-layer_use-spd"),
        "vw-layer_spd": Struct.parse.numberTransformer(data, "vw-layer_spd", {
          clampValue: { from: 0.0, to: 99.9 },
          clampTarget: { from: 0.0, to: 99.9 },
        }),
        "vw-layer_change-spd": Struct.parse.boolean(data, "vw-layer_change-spd"),
        "vw-layer_use-dir": Struct.parse.boolean(data, "vw-layer_use-dir"),
        "vw-layer_dir": Struct.parse.numberTransformer(data, "vw-layer_dir", {
          clampValue: { from: -9999.9, to: 9999.9 },
          clampTarget: { from: -9999.9, to: 9999.9 },
        }),
        "vw-layer_change-dir": Struct.parse.boolean(data, "vw-layer_change-dir"),
        "vw-layer_use-scale-x": Struct.parse.boolean(data, "vw-layer_use-scale-x"),
        "vw-layer_scale-x": Struct.parse.numberTransformer(data, "vw-layer_scale-x", {
          clampValue: { from: -99.9, to: 99.9 },
          clampTarget: { from: 99.9, to: 99.9 },
        }),
        "vw-layer_change-scale-x": Struct.parse.boolean(data, "vw-layer_change-scale-x"),
        "vw-layer_use-scale-y": Struct.parse.boolean(data, "vw-layer_use-scale-y"),
        "vw-layer_scale-y": Struct.parse.numberTransformer(data, "vw-layer_scale-x", {
          clampValue: { from: -99.9, to: 99.9 },
          clampTarget: { from: 99.9, to: 99.9 },
        }),
        "vw-layer_change-scale-y": Struct.parse.boolean(data, "vw-layer_change-scale-y"),
      }
    },
    run: function(data) {
      Core.print("Dispatch track event:", "brush_view_wallpaper")
      return null;
      var controller = Beans.get(BeanVisuController)
      if (Struct.get(data, "vw-layer_cls-col") == true) {
        controller.gridService.executor.tasks.forEach(function(task, iterator, type) {
          if (task.name == "fade-color" && task.state.get("type") == type) {
            task.state.set("stage", "fade-out")
          }
        }, Struct.get(data, "vw-layer_type"))
      }

      if (Struct.get(data, "vw-layer_use-col") == true) {
        controller.gridService.send(new Event("fade-color", {
          color: ColorUtil.fromHex(Struct.get(data, "vw-layer_col")),
          collection: Struct.get(data, "vw-layer_type") == "Background" 
            ? controller.visuRenderer.gridRenderer.overlayRenderer.backgroundColors
            : controller.visuRenderer.gridRenderer.overlayRenderer.foregroundColors,
          type: Struct.get(data, "vw-layer_type"),
          fadeInDuration: Struct.get(data, "vw-layer_fade-in"),
          fadeOutDuration: Struct.get(data, "vw-layer_fade-out"),
          executor: controller.gridService.executor,
          blendModeSource: BlendModeExt.get(Struct.getDefault(data, "vw-layer_blend-src", "SRC_ALPHA")),
          blendModeTarget: BlendModeExt.get(Struct.getDefault(data, "vw-layer_blend-dest", Struct.get(data, "vw-layer_type") == "Background" ? "INV_SRC_ALPHA" : "ONE")),
          blendEquation: BlendEquation.get(Struct.getDefault(data, "vw-layer_blend-eq", "ADD")),
        }))
      }

      if (Struct.get(data, "vw-layer_cls-texture") == true) {
        controller.gridService.executor.tasks.forEach(function(task, iterator, type) {
          if (task.name == "fade-sprite" && task.state.get("type") == type) {
            task.state.set("stage", "fade-out")
          }
        }, Struct.get(data, "vw-layer_type"))
      }

      if (Struct.get(data, "vw-layer_use-texture") == true) {
        var sprite = Struct.get(data, "vw-layer_texture")

        if (Struct.get(data, "vw-layer_use-texture-blend")) {
          Struct.set(sprite, "blend", Struct.get(data, "vw-layer_texture-blend"))
        } else {
          Struct.remove(sprite, "blend")
        }

        controller.gridService.send(new Event("fade-sprite", {
          sprite: SpriteUtil.parse(sprite),
          collection: Struct.get(data, "vw-layer_type") == "Background" 
            ? controller.visuRenderer.gridRenderer.overlayRenderer.backgrounds
            : controller.visuRenderer.gridRenderer.overlayRenderer.foregrounds,
          type: Struct.get(data, "vw-layer_type"),
          blendModeSource: BlendModeExt.get(Struct.getDefault(data, "vw-layer_blend-src", "SRC_ALPHA")),
          blendModeTarget: BlendModeExt.get(Struct.getDefault(data, "vw-layer_blend-dest", Struct.get(data, "vw-layer_type") == "Background" ? "INV_SRC_ALPHA" : "ONE")),
          blendEquation: BlendEquation.get(Struct.getDefault(data, "vw-layer_blend-eq", "ADD")),
          fadeInDuration: Struct.get(data, "vw-layer_fade-in"),
          fadeOutDuration: Struct.get(data, "vw-layer_fade-out"),
          angle: Struct.get(data, "view-wallpaper_angle"),
          angleTransformer: Struct.get(data, "vw-layer_change-dir") 
            ? Struct.get(data, "vw-layer_dir") 
            : null,
          speed: Struct.get(data, "view-wallpaper_speed"),
          speedTransformer: Struct.get(data, "vw-layer_change-spd") 
            ? Struct.get(data, "vw-layer_spd") 
            : null,
          xScale: Struct.get(data, "view-wallpaper_xScale"),
          xScaleTransformer: Struct.get(data, "vw-layer_change-scale-x") 
            ? Struct.get(data, "vw-layer_scale-x") 
            : null,
          yScale: Struct.get(data, "view-wallpaper_yScale"),
          yScaleTransformer: Struct.get(data, "vw-layer_change-scale-y") 
            ? Struct.get(data, "vw-layer_scale-y") 
            : null,
          executor: controller.gridService.executor,
        }))
      }
    },
  },
  "brush_view_subtitle": {
    parse: function(data) {
      return {
        "icon": Struct.parse.sprite(data, "icon"),
        "vw-sub_template": Struct.parse.text(data, "vw-sub_template"),
        "vw-sub_font": Struct.parse.text(data, "vw-sub_font", VISU_FONT[0]),
        "vw-sub-fh": Struct.parse.number(data, "vw-sub-fh", 12, 0, 999),
        "vw-sub_use-timeout": Struct.parse.boolean(data, "vw-sub_use-timeout"),
        "vw-sub_timeout": Struct.parse.number(data, "vw-sub_timeout", 0.0, 0.0, 999.9),
        "vw-sub_col": Struct.parse.color(data, "vw-sub_col"),
        "vw-sub_use-outline": Struct.parse.boolean(data, "vw-sub_use-outline"),
        "vw-sub_outline": Struct.parse.color(data, "vw-sub_outline"),
        "vw-sub_align-v": Struct.parse.gmArrayValue(data, "vw-sub_align-v", [ "TOP", "BOTTOM" ], "TOP"),
        "vw-sub_align-h": Struct.parse.gmArrayValue(data, "vw-sub_align-h", [ "LEFT", "CENTER", "RIGHT" ], "LEFT"),
        "vw-sub_x": Struct.parse.normalizedNumber(data, "vw-sub_x", 0.0),
        "vw-sub_y": Struct.parse.normalizedNumber(data, "vw-sub_y", 0.0),
        "vw-sub_w": Struct.parse.number(data, "vw-sub_w", 1.0, 0.0, 10.0),
        "vw-sub_h": Struct.parse.number(data, "vw-sub_h", 1.0, 0.0, 10.0),
        "vw-sub-char-spd": Struct.parse.number(data, "vw-sub-char-spd", 1.0, 0.000001, 999.9),
        "vw-sub_use-nl-delay": Struct.parse.boolean(data, "vw-sub_use-nl-delay"),
        "vw-sub_nl-delay": Struct.parse.number(data, "vw-sub_nl-delay", 1.0, 0.0, 999.9),
        "vw-sub_use-end-delay": Struct.parse.boolean(data, "vw-sub_use-end-delay"),
        "vw-sub_end-delay": Struct.parse.number(data, "vw-sub_end-delay", 1.0, 0.0, 999.9),
        "vw-sub_use-dir": Struct.parse.boolean(data, "vw-sub_use-dir"),
        "vw-sub_dir": Struct.parse.numberTransformer(data, "vw-sub_dir", {
          clampValue: { from: -9999.9, to: 9999.9 },
          clampTarget: { from: -9999.9, to: 9999.9 },
        }),
        "vw-sub_change-dir": Struct.parse.boolean(data, "vw-sub_change-dir"),
        "vw-sub_use-spd": Struct.parse.boolean(data, "vw-sub_use-spd"),
        "vw-sub_spd": Struct.parse.numberTransformer(data, "vw-sub_spd", {
          clampValue: { from: 0.0, to: 999.9 },
          clampTarget: { from: 0.0, to: 999.9 },
        }),
        "vw-sub_change-spd": Struct.parse.boolean(data, "vw-sub_change-spd"),
        "vw-sub-fade-in": Struct.parse.number(data, "vw-sub_fade-in", 0.0, 999.9),
        "vw-sub-fade-out": Struct.parse.number(data, "vw-sub_fade-out", 0.0, 999.9),
      }
    },
    run: function(data) {
      Core.print("Dispatch track event:", "brush_view_subtitle")
    },
  },
  "brush_view_config": {
    parse: function(data) {
      return {
        "icon": Struct.parse.sprite(data, "icon"),
        "vw-cfg_use-render-hud": Struct.parse.boolean(data, "vw-cfg_use-render-hud"),
        "vw-cfg_render-hud": Struct.parse.boolean(data, "vw-cfg_render-hud"),
        "vw-cfg_use-render-subtitle": Struct.parse.boolean(data, "vw-cfg_use-render-subtitle"),
        "vw-cfg_render-subtitle": Struct.parse.boolean(data, "vw-cfg_render-subtitle"),
        "vw-cfg_use-render-video": Struct.parse.boolean(data, "vw-cfg_use-render-video"),
        "vw-cfg_render-video": Struct.parse.boolean(data, "vw-cfg_render-video"),
        "vw-cfg_cls-subtitle": Struct.parse.boolean(data, "vw-cfg_cls-subtitle"),    
        "vw-cfg_cls-background": Struct.parse.boolean(data, "vw-cfg_cls-background"),    
        "vw-cfg_cls-foreground": Struct.parse.boolean(data, "vw-cfg_cls-foreground"),
        "vw-cfg_use-video-alpha": Struct.parse.boolean(data, "vw-cfg_use-video-alpha"),
        "vw-cfg_video-alpha": Struct.parse.normalizedNumberTransformer(data, "vw-cfg_video-alpha"),
        "vw-cfg_change-video-alpha": Struct.parse.boolean(data, "vw-cfg_change-video-alpha"),
      }
    },
    run: function(data) {
      Core.print("Dispatch track event:", "brush_view_config")
      return null;
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
      
      if (Struct.get(data, "vw-cfg_use-render-video")) {
        gridService.properties.renderVideo = Struct
          .get(data, "vw-cfg_render-video")
      }

      if (Struct.get(data, "vw-cfg_use-render-hud")) {
        controller.visuRenderer.hudRenderer.enabled = Struct
          .get(data, "vw-cfg_render-hud")
      }

      if (Struct.get(data, "vw-cfg_cls-subtitle")) {
        controller.subtitleService.send(new Event("clear-subtitle"))
      }
    },
  },
}
#macro view_track_event global.__view_track_event
