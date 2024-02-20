///@package io.alkapivo.visu.service.track

///@static
///@type {Map<String, Callable>}
global.__shader_track_event = new Map(String, Callable, {
  "brush_shader_spawn": function(data) {
    var controller = Beans.get(BeanVisuController)
    var pipeline = Struct.getDefault(data, "shader-spawn_pipeline", "Grid")
    var event = new Event("spawn-shader", {
      template: Struct.get(data, "shader-spawn_template"),
      duration: Struct.get(data, "shader-spawn_duration"),
    })
    
    switch (pipeline) {
      case "Grid": 
        controller.shaderPipeline.send(event)
        break
      case "Background":
        controller.shaderBackgroundPipeline.send(event)
        break
      case "All": 
        controller.shaderPipeline.send(event)
        controller.shaderBackgroundPipeline.send(new Event("spawn-shader", {
          template: Struct.get(data, "shader-spawn_template"),
          duration: Struct.get(data, "shader-spawn_duration"),
        }))
        break
      default: throw new Exception($"Found unsupported pipeline: {pipeline}")
    }
  },
  "brush_shader_overlay": function(data) {
    var controller = Beans.get(BeanVisuController)
    if (Struct.get(data, "shader-overlay_use-render-support-grid") == true) {
      controller.gridService.properties.renderSupportGrid = Struct.get(data, "shader-overlay_render-support-grid")
    }

    if (Struct.get(data, "shader-overlay_use-transform-support-grid-treshold") == true) {
      var transformer = Struct.get(data, "shader-overlay_transform-support-grid-treshold")
      controller.gridService.send(new Event("transform-property", {
        key: "renderSupportGridTreshold",
        container: controller.gridService.properties,
        executor: controller.gridService.executor,
        transformer: new NumberTransformer({
          value: controller.gridService.properties.renderSupportGridTreshold,
          target: transformer.target,
          factor: transformer.factor,
          increase: transformer.increase,
        })
      }))
    }

    if (Struct.get(data, "shader-overlay_use-transform-support-grid-alpha") == true) {
      var transformer = Struct.get(data, "shader-overlay_transform-support-grid-alpha")
      controller.gridService.send(new Event("transform-property", {
        key: "renderSupportGridAlpha",
        container: controller.gridService.properties,
        executor: controller.gridService.executor,
        transformer: new NumberTransformer({
          value: controller.gridService.properties.renderSupportGridAlpha,
          target: transformer.target,
          factor: transformer.factor,
          increase: transformer.increase,
        })
      }))
    }

    if (Struct.get(data, "shader-overlay_use-clear-frame") == true) {
      controller.gridService.properties.shaderClearFrame = Struct.get(data, "shader-overlay_clear-frame")
    }

    if (Struct.get(data, "shader-overlay_use-clear-color") == true) {
      controller.gridService.send(new Event("transform-property", {
        key: "shaderClearColor",
        container: controller.gridService.properties,
        executor: controller.gridService.executor,
        transformer: new ColorTransformer({
          value: controller.gridService.properties.shaderClearColor.toHex(true),
          target: Struct.get(data, "shader-overlay_clear-color"),
          factor: 0.01,
        })
      }))
    }

    if (Struct.get(data, "shader-overlay_use-transform-clear-frame-alpha") == true) {
      var transformer = Struct.get(data, "shader-overlay_transform-clear-frame-alpha")
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
  },
  "brush_shader_clear": function(data) {
    static fadeOutTask = function(task) {
      var fadeOut = task.state.getDefault("fadeOut", 0.0)
      if (task.timeout.time < task.timeout.duration - fadeOut) {
        task.timeout.time = task.timeout.duration - fadeOut
      }
    }

    static amountTask = function(task, iterator, acc) {
      if (acc.amount <= 0) {
        return BREAK_LOOP
      }

      if (task.timeout.time < task.timeout.duration 
         - task.state.getDefault("fadeOut", 0.0)) {
        acc.handler(task)
        acc.amount = acc.amount - 1
      }
    }

    var controller = Beans.get(BeanVisuController)
    var pipeline = Struct.getDefault(data, "shader-spawn_pipeline", "All")    
    if (Struct.get(data, "shader-clear_use-clear-all-shaders") == true) {
      switch (pipeline) {
        case "Grid":
          controller.shaderPipeline.executor.tasks.forEach(fadeOutTask)
          break
        case "Background":
          controller.shaderBackgroundPipeline.executor.tasks.forEach(fadeOutTask)
          break
        case "All":
          controller.shaderPipeline.executor.tasks.forEach(fadeOutTask)
          controller.shaderBackgroundPipeline.executor.tasks.forEach(fadeOutTask)
          break
      }
    }

    if (Struct.get(data, "shader-clear_use-clear-amount") == true) {
      var amount = Struct.getDefault(data, "shader-clear_clear-amount", 1)
      switch (pipeline) {
        case "Grid":
          controller.shaderPipeline.executor.tasks.forEach(amountTask, {
            amount: amount,
            handler: fadeOutTask,
          })
          break
        case "Background":
          controller.shaderBackgroundPipeline.executor.tasks.forEach(amountTask, {
            amount: amount,
            handler: fadeOutTask,
          })
          break
        case "All":
          controller.shaderPipeline.executor.tasks.forEach(amountTask, {
            amount: amount,
            handler: fadeOutTask,
          })
          controller.shaderBackgroundPipeline.executor.tasks.forEach(amountTask, {
            amount: amount,
            handler: fadeOutTask,
          })
          break
      }
    }
  },
  "brush_shader_config": function(data) {
    if (Struct.get(data, "shader-config_use-render-grid-shaders") == true) {
      controller.gridService.properties.renderGridShaders = Struct.get(data, "shader-config_render-grid-shaders")
    }

    if (Struct.get(data, "shader-config_use-render-background-shaders") == true) {
      controller.gridService.properties.renderBackgroundShaders = Struct.get(data, "shader-config_render-background-shaders")
    }

    /* 
    if (Struct.get(data, "grid-config_use-clear-frame") == true) {
      controller.gridService.properties.gridClearFrame = Struct.get(data, "grid-config_clear-frame")
    }

    if (Struct.get(data, "shader-config_use-transform-shader-alpha") == true) {
      var transformer = Struct.get(data, "shader-config_transform-shader-alpha")
      controller.gridService.send(new Event("transform-property", {
        key: "renderSupportGridAlpha",
        container: controller.gridService.properties,
        executor: controller.gridService.executor,
        transformer: new NumberTransformer({
          value: controller.gridService.properties.renderSupportGridAlpha,
          target: transformer.target,
          factor: transformer.factor,
          increase: transformer.increase,
        })
      }))
    }
    */
  },
})
#macro shader_track_event global.__shader_track_event
