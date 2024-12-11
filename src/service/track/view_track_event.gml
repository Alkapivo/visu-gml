///@package io.alkapivo.visu.service.track

///@static
///@type {Struct}
global.__view_track_event = {
  "brush_view_camera": function(data) {
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
  "brush_view_wallpaper": function(data) {
    Core.print("Dispatch track event:", "brush_view_wallpaper")
    return null;
    var controller = Beans.get(BeanVisuController)
    if (Struct.get(data, "vw-layer_cls-color") == true) {
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
  "brush_view_subtitle": function(data) {
    Core.print("Dispatch track event:", "brush_view_subtitle")
  },
  "brush_view_config": function(data) {
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
}
#macro view_track_event global.__view_track_event
