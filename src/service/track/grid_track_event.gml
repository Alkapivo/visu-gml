///@package io.alkapivo.visu.service.track

///@static
///@type {Struct}
global.__grid_track_event = {
  "brush_grid_area": function(data) {
    Core.print("Dispatch track event:", "brush_grid_area")
  },
  "brush_grid_column": function(data) {
    var controller = Beans.get(BeanVisuController)
    if (Struct.get(data, "grid-channel_use-mode")) {
      controller.gridService.properties.channelsMode = Struct.get(data, "grid-channel_mode")
    }

    if (Struct.get(data, "gr-c_use-amount") 
        && Core.isType(Struct.get(Struct.get(data, "gr-c_amount"), "value"), Number)) {
      controller.gridService.properties.channels = Struct.get(data, "gr-c_amount").value
    }

    if (Struct.get(data, "gr-c_change-amount")) {
      var transformer = Struct.get(data, "gr-c_amount")
      controller.gridService.send(new Event("transform-property", {
        key: "channels",
        container: controller.gridService.properties,
        executor: controller.gridService.executor,
        transformer: new NumberTransformer({
          value: controller.gridService.properties.channels,
          target: transformer.target,
          factor: transformer.factor,
          increase: transformer.increase,
        })
      }))
    }

    if (Struct.get(data, "gr-c_use-main-col")) {
      Core.print("color time!", Struct.get(data, "gr-c_main-col"))
      controller.gridService.send(new Event("transform-property", {
        key: "channelsPrimaryColor",
        container: controller.gridService.properties,
        executor: controller.gridService.executor,
        transformer: new ColorTransformer({
          value: controller.gridService.properties.gridClearColor.toHex(true),
          target: Struct.getIfType(data, "gr-c_main-col", String, controller.gridService.properties.gridClearColor.toHex(true)),
          factor: (Struct.get(data, "gr-c_use-main-col-spd")
            ? Struct.getIfType(data, "gr-c_main-col-spd", Number, 0.01)
            : 1.0),
        })
      }))
    }

    if (Struct.get(data, "gr-c_use-main-alpha") 
        && Core.isType(Struct.get(Struct.get(data, "gr-c_main-alpha"), "value"), Number)) {
      controller.gridService.properties.channelsPrimaryAlpha = Struct.get(data, "gr-c_main-alpha").value
    }

    if (Struct.get(data, "gr-c_change-main-alpha")) {
      var transformer = Struct.get(data, "gr-c_main-alpha")
      controller.gridService.send(new Event("transform-property", {
        key: "channelsPrimaryAlpha",
        container: controller.gridService.properties,
        executor: controller.gridService.executor,
        transformer: new NumberTransformer({
          value: controller.gridService.properties.channelsPrimaryAlpha,
          target: transformer.target,
          factor: transformer.factor,
          increase: transformer.increase,
        })
      }))
    }

    if (Struct.get(data, "gr-c_use-main-size") 
        && Core.isType(Struct.get(Struct.get(data, "gr-c_main-size"), "value"), Number)) {
      controller.gridService.properties.channelsPrimaryThickness = Struct.get(data, "gr-c_main-size").value
    }

    if (Struct.get(data, "gr-c_change-main-size")) {
      var transformer = Struct.get(data, "gr-c_main-size")
      controller.gridService.send(new Event("transform-property", {
        key: "channelsPrimaryThickness",
        container: controller.gridService.properties,
        executor: controller.gridService.executor,
        transformer: new NumberTransformer({
          value: controller.gridService.properties.channelsPrimaryThickness,
          target: transformer.target,
          factor: transformer.factor,
          increase: transformer.increase,
        })
      }))
    }
    
    if (Struct.get(data, "gr-c_use-side-col")) {
      controller.gridService.send(new Event("transform-property", {
        key: "channelsSecondaryColor",
        container: controller.gridService.properties,
        executor: controller.gridService.executor,
        transformer: new ColorTransformer({
          value: controller.gridService.properties.gridClearColor.toHex(true),
          target: Struct.getIfType(data, "gr-c_side-col", String, controller.gridService.properties.gridClearColor.toHex(true)),
          factor: (Struct.get(data, "gr-c_use-side-col-spd")
            ? Struct.getIfType(data, "gr-c_side-col-spd", Number, 0.01)
            : 1.0),
        })
      }))
    }

    if (Struct.get(data, "gr-c_use-side-alpha") 
        && Core.isType(Struct.get(Struct.get(data, "gr-c_side-alpha"), "value"), Number)) {
      controller.gridService.properties.channelsSecondaryAlpha = Struct.get(data, "gr-c_side-alpha").value
    }

    if (Struct.get(data, "gr-c_change-side-alpha")) {
      var transformer = Struct.get(data, "gr-c_side-alpha")
      controller.gridService.send(new Event("transform-property", {
        key: "channelsSecondaryAlpha",
        container: controller.gridService.properties,
        executor: controller.gridService.executor,
        transformer: new NumberTransformer({
          value: controller.gridService.properties.channelsSecondaryAlpha,
          target: transformer.target,
          factor: transformer.factor,
          increase: transformer.increase,
        })
      }))
    }

    if (Struct.get(data, "gr-c_use-side-size") 
        && Core.isType(Struct.get(Struct.get(data, "gr-c_side-size"), "value"), Number)) {
      controller.gridService.properties.channelsSecondaryThickness = Struct.get(data, "gr-c_side-size").value
    }

    if (Struct.get(data, "gr-c_change-side-size")) {
      var transformer = Struct.get(data, "gr-c_side-size")
      controller.gridService.send(new Event("transform-property", {
        key: "channelsSecondaryThickness",
        container: controller.gridService.properties,
        executor: controller.gridService.executor,
        transformer: new NumberTransformer({
          value: controller.gridService.properties.channelsSecondaryThickness,
          target: transformer.target,
          factor: transformer.factor,
          increase: transformer.increase,
        })
      }))
    }
  },
  "brush_grid_row": function(data) {
    var controller = Beans.get(BeanVisuController)
    if (Struct.get(data, "gr-r_use-mode")) {
      controller.gridService.properties.separatorsMode = Struct.get(data, "gr-r_mode")
    }

    if (Struct.get(data, "gr-r_use-amount") 
        && Core.isType(Struct.get(Struct.get(data, "gr-r_amount"), "value"), Number)) {
      controller.gridService.properties.separators = Struct.get(data, "gr-r_amount").value
    }

    if (Struct.get(data, "gr-r_change-amount")) {
      var transformer = Struct.get(data, "gr-r_amount")
      controller.gridService.send(new Event("transform-property", {
        key: "separators",
        container: controller.gridService.properties,
        executor: controller.gridService.executor,
        transformer: new NumberTransformer({
          value: controller.gridService.properties.separators,
          target: transformer.target,
          factor: transformer.factor,
          increase: transformer.increase,
        })
      }))
    }

    if (Struct.get(data, "gr-r_use-main-col")) {
      controller.gridService.send(new Event("transform-property", {
        key: "separatorsPrimaryColor",
        container: controller.gridService.properties,
        executor: controller.gridService.executor,
        transformer: new ColorTransformer({
          value: controller.gridService.properties.gridClearColor.toHex(true),
          target: Struct.getIfType(data, "gr-r_main-col", String, controller.gridService.properties.gridClearColor.toHex(true)),
          factor: (Struct.get(data, "gr-r_use-main-col-spd")
            ? Struct.getIfType(data, "gr-r_main-col-spd", Number, 0.01)
            : 1.0),
        })
      }))
    }

    if (Struct.get(data, "gr-r_use-main-alpha") 
        && Core.isType(Struct.get(Struct.get(data, "gr-r_main-alpha"), "value"), Number)) {
      controller.gridService.properties.separatorsPrimaryAlpha = Struct.get(data, "gr-r_main-alpha").value
    }

    if (Struct.get(data, "gr-r_change-main-alpha")) {
      var transformer = Struct.get(data, "gr-r_main-alpha")
      controller.gridService.send(new Event("transform-property", {
        key: "separatorsPrimaryAlpha",
        container: controller.gridService.properties,
        executor: controller.gridService.executor,
        transformer: new NumberTransformer({
          value: controller.gridService.properties.separatorsPrimaryAlpha,
          target: transformer.target,
          factor: transformer.factor,
          increase: transformer.increase,
        })
      }))
    }

    if (Struct.get(data, "gr-r_use-main-size") 
        && Core.isType(Struct.get(Struct.get(data, "gr-r_main-size"), "value"), Number)) {
      controller.gridService.properties.separatorsPrimaryThickness = Struct.get(data, "gr-r_main-size").value
    }

    if (Struct.get(data, "gr-r_change-main-size")) {
      var transformer = Struct.get(data, "gr-r_main-size")
      controller.gridService.send(new Event("transform-property", {
        key: "separatorsPrimaryThickness",
        container: controller.gridService.properties,
        executor: controller.gridService.executor,
        transformer: new NumberTransformer({
          value: controller.gridService.properties.separatorsPrimaryThickness,
          target: transformer.target,
          factor: transformer.factor,
          increase: transformer.increase,
        })
      }))
    }
    
    if (Struct.get(data, "gr-r_use-side-col")) {
      controller.gridService.send(new Event("transform-property", {
        key: "separatorsSecondaryColor",
        container: controller.gridService.properties,
        executor: controller.gridService.executor,
        transformer: new ColorTransformer({
          value: controller.gridService.properties.gridClearColor.toHex(true),
          target: Struct.getIfType(data, "gr-c_side-col", String, controller.gridService.properties.gridClearColor.toHex(true)),
          factor: (Struct.get(data, "gr-r_use-side-col-spd")
            ? Struct.getIfType(data, "gr-r_side-col-spd", Number, 0.01)
            : 1.0),
        })
      }))
    }

    if (Struct.get(data, "gr-r_use-side-alpha") 
        && Core.isType(Struct.get(Struct.get(data, "gr-r_side-alpha"), "value"), Number)) {
      controller.gridService.properties.separatorsSecondaryAlpha = Struct.get(data, "gr-r_side-alpha").value
    }

    if (Struct.get(data, "gr-r_change-side-alpha")) {
      var transformer = Struct.get(data, "gr-r_side-alpha")
      controller.gridService.send(new Event("transform-property", {
        key: "separatorsSecondaryAlpha",
        container: controller.gridService.properties,
        executor: controller.gridService.executor,
        transformer: new NumberTransformer({
          value: controller.gridService.properties.separatorsSecondaryAlpha,
          target: transformer.target,
          factor: transformer.factor,
          increase: transformer.increase,
        })
      }))
    }

    if (Struct.get(data, "gr-r_use-side-size") 
        && Core.isType(Struct.get(Struct.get(data, "gr-r_side-size"), "value"), Number)) {
      controller.gridService.properties.separatorsSecondaryThickness = Struct.get(data, "gr-r_side-size").value
    }

    if (Struct.get(data, "gr-r_change-side-size")) {
      var transformer = Struct.get(data, "gr-r_side-size")
      controller.gridService.send(new Event("transform-property", {
        key: "separatorsSecondaryThickness",
        container: controller.gridService.properties,
        executor: controller.gridService.executor,
        transformer: new NumberTransformer({
          value: controller.gridService.properties.separatorsSecondaryThickness,
          target: transformer.target,
          factor: transformer.factor,
          increase: transformer.increase,
        })
      }))
    }
  },
  "brush_grid_config": function(data) {
    Core.print("Dispatch track event:", "brush_grid_config")
  },
}
#macro grid_track_event global.__grid_track_event
