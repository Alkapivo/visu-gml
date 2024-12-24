///@package io.alkapivo.visu.service.track

///@static
///@type {String[]}
global.__GRID_MODES = [
  "SINGLE",
  "DUAL"
]
#macro GRID_MODES global.__GRID_MODES


///@static
///@type {Struct}
global.__grid_track_event = {
  "brush_grid_area": {
    parse: function(data) {
      return {
        "icon": Struct.parse.sprite(data, "icon"),
        "gr-area_use-h": Struct.parse.boolean(data, "gr-area_use-h"),
        "gr-area_h": Struct.parse.numberTransformer(data, "gr-area_h", {
          clampValue: { from: 0.0, to: 10.0 },
          clampTarget: { from: 0.0, to: 10.0 },
        }),
        "gr-area_change-h": Struct.parse.boolean(data, "gr-area_change-h"),
        "gr-area_use-h-col": Struct.parse.boolean(data, "gr-area_use-h-col"),
        "gr-area_h-col": Struct.parse.color(data, "gr-area_h-col"),
        "gr-area_h-col-spd": Struct.parse.number(data, "gr-area_h-col-spd", 0.0, 0.000001, 1.0),
        "gr-area_use-h-alpha": Struct.parse.boolean(data, "gr-area_use-h-alpha"),
        "gr-area_h-alpha": Struct.parse.normalizedNumberTransformer(data, "gr-area_h-alpha"),
        "gr-area_change-h-alpha": Struct.parse.boolean(data, "gr-area_change-h-alpha"),
        "gr-area_use-h-size": Struct.parse.boolean(data, "gr-area_use-h-size"),
        "gr-area_h-size": Struct.parse.numberTransformer(data, "gr-area_h-size", {
          clampValue: { from: 0.0, to: 9999.9 },
          clampTarget: { from: 0.0, to: 9999.9 },
        }),
        "gr-area_change-h-size": Struct.parse.boolean(data, "gr-area_change-h-size"),
        "gr-area_use-v": Struct.parse.boolean(data, "gr-area_use-v"),
        "gr-area_v": Struct.parse.numberTransformer(data, "gr-area_v", {
          clampValue: { from: 0.0, to: 10.0 },
          clampTarget: { from: 0.0, to: 10.0 },
        }),
        "gr-area_change-v": Struct.parse.boolean(data, "gr-area_change-v"),
        "gr-area_use-v-col": Struct.parse.boolean(data, "gr-area_use-v-col"),
        "gr-area_v-col": Struct.parse.color(data, "gr-area_v-col"),
        "gr-area_v-col-spd": Struct.parse.number(data, "gr-area_v-col-spd", 1.0, 0.000001, 1.0),
        "gr-area_use-v-alpha": Struct.parse.boolean(data, "gr-area_use-v-alpha"),
        "gr-area_v-alpha": Struct.parse.normalizedNumberTransformer(data, "gr-area_v-alpha"),
        "gr-area_change-v-alpha": Struct.parse.boolean(data, "gr-area_change-v-alpha"),
        "gr-area_use-v-size": Struct.parse.boolean(data, "gr-area_use-v-size"),
        "gr-area_v-size": Struct.parse.numberTransformer(data, "gr-area_v-size", {
          clampValue: { from: 0.0, to: 9999.9 },
          clampTarget: { from: 0.0, to: 9999.9 },
        }),
        "gr-area_change-v-size": Struct.parse.boolean(data, "gr-area_change-v-size"),
      }
    },
    run: function(data) {
      Core.print("Dispatch track event:", "brush_grid_area")
    },
  },
  "brush_grid_column": {
    parse: function(data) {
      return {
        "icon": Struct.parse.sprite(data, "icon"),
        "gr-c_use-mode": Struct.parse.boolean(data, "gr-c_use-mode"),
        "gr-c_mode": Struct.parse.gmArrayValue(data, "gr-c_mode", GRID_MODES, GRID_MODES[0]),
        "gr-c_use-amount": Struct.parse.boolean(data, "gr-c_use-amount"),
        "gr-c_amount": Struct.parse.numberTransformer(data, "gr-c_amount", {
          clampValue: { from: 0.0, to: 999.9 },
          clampTarget: { from: 0.0, to: 999.9 },
        }),
        "gr-c_change-amount": Struct.parse.boolean(data, "gr-c_change-amount"),
        "gr-c_use-main-col": Struct.parse.boolean(data, "gr-c_use-main-col"),
        "gr-c_main-col": Struct.parse.color(data, "gr-c_main-col"),
        "gr-c_main-col-spd": Struct.parse.number(data, "gr-c_main-col-spd", 1.0, 0.000001, 1.0),
        "gr-c_use-main-alpha": Struct.parse.boolean(data, "gr-c_use-main-alpha"),
        "gr-c_main-alpha": Struct.parse.normalizedNumberTransformer(data, "gr-c_main-alpha"),
        "gr-c_change-main-alpha": Struct.parse.boolean(data, "gr-c_change-main-alpha"),
        "gr-c_use-main-size": Struct.parse.boolean(data, "gr-c_use-main-size"),
        "gr-c_main-size": Struct.parse.numberTransformer(data, "gr-c_main-size", {
          clampValue: { from: 0.0, to: 9999.9 },
          clampTarget: { from: 0.0, to: 9999.9 },
        }),
        "gr-c_change-main-size": Struct.parse.boolean(data, "gr-c_change-main-size"),
        "gr-c_use-side-col": Struct.parse.boolean(data, "gr-c_use-side-col"),
        "gr-c_side-col": Struct.parse.color(data, "gr-c_side-col"),
        "gr-c_side-col-spd": Struct.parse.number(data, "gr-c_side-col-spd", 1.0, 0.000001, 1.0),
        "gr-c_use-side-alpha": Struct.parse.boolean(data, "gr-c_use-side-alpha"),
        "gr-c_side-alpha": Struct.parse.normalizedNumberTransformer(data, "gr-c_side-alpha"),
        "gr-c_change-side-alpha": Struct.parse.boolean(data, "gr-c_change-side-alpha"),
        "gr-c_use-side-size": Struct.parse.boolean(data, "gr-c_use-side-size"),
        "gr-c_side-size": Struct.parse.numberTransformer(data, "gr-c_side-size", {
          clampValue: { from: 0.0, to: 9999.9 },
          clampTarget: { from: 0.0, to: 9999.9 },
        }),
        "gr-c_change-side-size": Struct.parse.boolean(data, "gr-c_change-side-size"),
      }
    },
    run: function(data) {
      Core.print("Dispatch track event:", "brush_grid_column")
      var controller = Beans.get(BeanVisuController)
      if (Struct.get(data, "grid-channel_use-mode")) {
        controller.gridService.properties.channelsMode = Struct.get(data, "grid-channel_mode")
      }

      if (Struct.get(data, "gr-c_use-amount")) {
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
        controller.gridService.send(new Event("transform-property", {
          key: "channelsPrimaryColor",
          container: controller.gridService.properties,
          executor: controller.gridService.executor,
          transformer: new ColorTransformer({
            value: controller.gridService.properties.gridClearColor.toHex(true),
            target: Struct.get(data, "gr-c_main-col").toHex(true),
            factor: Struct.get(data, "gr-c_main-col-spd"),
          })
        }))
      }

      if (Struct.get(data, "gr-c_use-main-alpha")) {
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

      if (Struct.get(data, "gr-c_use-main-size")) {
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
            target: Struct.get(data, "gr-c_side-col").toHex(true),
            factor: Struct.get(data, "gr-c_side-col-spd"),
          })
        }))
      }

      if (Struct.get(data, "gr-c_use-side-alpha")) {
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

      if (Struct.get(data, "gr-c_use-side-size")) {
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
  },
  "brush_grid_row": {
    parse: function(data) {
      return {
        "icon": Struct.parse.sprite(data, "icon"),
        "gr-r_use-mode": Struct.parse.boolean(data, "gr-r_use-mode"),
        "gr-r_mode": Struct.parse.gmArrayValue(data, "gr-r_mode", GRID_MODES, GRID_MODES[0]),
        "gr-r_use-amount": Struct.parse.boolean(data, "gr-r_use-amount"),
        "gr-r_amount": Struct.parse.numberTransformer(data, "gr-r_amount", {
          clampValue: { from: 0.0, to: 999.9 },
          clampTarget: { from: 0.0, to: 999.9 },
        }),
        "gr-r_change-amount": Struct.parse.boolean(data, "gr-r_change-amount"),
        "gr-r_use-main-col": Struct.parse.boolean(data, "gr-r_use-main-col"),
        "gr-r_main-col": Struct.parse.color(data, "gr-r_main-col"),
        "gr-r_main-col-spd": Struct.parse.number(data, "gr-r_main-col-spd", 1.0, 0.000001, 1.0),
        "gr-r_use-main-alpha": Struct.parse.boolean(data, "gr-r_use-main-alpha"),
        "gr-r_main-alpha": Struct.parse.normalizedNumberTransformer(data, "gr-r_main-alpha"),
        "gr-r_change-main-alpha": Struct.parse.boolean(data, "gr-r_change-main-alpha"),
        "gr-r_use-main-size": Struct.parse.boolean(data, "gr-r_use-main-size"),
        "gr-r_main-size": Struct.parse.numberTransformer(data, "gr-r_main-size", {
          clampValue: { from: 0.0, to: 9999.9 },
          clampTarget: { from: 0.0, to: 9999.9 },
        }),
        "gr-r_change-main-size": Struct.parse.boolean(data, "gr-r_change-main-size"),
        "gr-r_use-side-col": Struct.parse.boolean(data, "gr-r_use-side-col"),
        "gr-r_side-col": Struct.parse.color(data, "gr-r_side-col"),
        "gr-r_side-col-spd": Struct.parse.number(data, "gr-r_side-col-spd", 1.0, 0.000001, 1.0),
        "gr-r_use-side-alpha": Struct.parse.boolean(data, "gr-r_use-side-alpha"),
        "gr-r_side-alpha": Struct.parse.normalizedNumberTransformer(data, "gr-r_side-alpha"),
        "gr-r_change-side-alpha": Struct.parse.boolean(data, "gr-r_change-side-alpha"),
        "gr-r_use-side-size": Struct.parse.boolean(data, "gr-r_use-side-size"),
        "gr-r_side-size": Struct.parse.numberTransformer(data, "gr-r_side-size", {
          clampValue: { from: 0.0, to: 9999.9 },
          clampTarget: { from: 0.0, to: 9999.9 },
        }),
        "gr-r_change-side-size": Struct.parse.boolean(data, "gr-r_change-side-size"),
      }
    },
    run: function(data, channel) {
      //Core.print("Dispatch track event:", "brush_grid_row")
      var controller = Beans.get(BeanVisuController)
      if (Struct.get(data, "gr-r_use-mode")) {
        controller.gridService.properties.separatorsMode = Struct.get(data, "gr-r_mode")
      }

      if (Struct.get(data, "gr-r_use-amount")) {
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
            target: Struct.get(data, "gr-r_main-col").toHex(true),
            factor: Struct.get(data, "gr-r_main-col-spd"),
          })
        }))
      }

      if (Struct.get(data, "gr-r_use-main-alpha")) {
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

      if (Struct.get(data, "gr-r_use-main-size")) {
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
            target: Struct.get(data, "gr-r_side-col").toHex(true),
            factor: Struct.get(data, "gr-r_side-col-spd"),
          })
        }))
      }

      if (Struct.get(data, "gr-r_use-side-alpha")) {
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

      if (Struct.get(data, "gr-r_use-side-size")) {
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
  },
  "brush_grid_config": {
    parse: function(data) {
      return {
        "icon": Struct.parse.sprite(data, "icon"),
        "gr-cfg_use-render": Struct.parse.boolean(data, "gr-cfg_use-render"),
        "gr-cfg_render": Struct.parse.boolean(data, "gr-cfg_render"),
        "gr-cfg_use-spd": Struct.parse.boolean(data, "gr-cfg_use-spd"),
        "gr-cfg_spd": Struct.parse.numberTransformer(data, "gr-cfg_spd", {
          clampValue: { from: 0.0, to: 999.9 },
          clampTarget: { from: 0.0, to: 999.9 },
        }),
        "gr-cfg_change-spd": Struct.parse.boolean(data, "gr-cfg_change-spd"),
        "gr-cfg_use-z": Struct.parse.boolean(data, "gr-cfg_use-z"),
        "gr-cfg_z": Struct.parse.numberTransformer(data, "gr-cfg_z", {
          clampValue: { from: 0.0, to: 99999.9 },
          clampTarget: { from: 0.0, to: 99999.9 },
        }),
        "gr-cfg_change-z": Struct.parse.boolean(data, "gr-cfg_change-z"),
        "gr-cfg_use-cls-frame": Struct.parse.boolean(data, "gr-cfg_use-cls-frame"),
        "gr-cfg_cls-frame": Struct.parse.boolean(data, "gr-cfg_cls-frame"),
        "gr-cfg_use-cls-frame-col": Struct.parse.boolean(data, "gr-cfg_use-cls-frame-col"),
        "gr-cfg_cls-frame-col": Struct.parse.color(data, "gr-cfg_cls-frame-col"),
        "gr-cfg_cls-frame-col-spd": Struct.parse.number(data, "gr-cfg_cls-frame-col-spd", 1.0, 0.000001, 1.0),
        "gr-cfg_use-cls-frame-alpha": Struct.parse.boolean(data, "gr-cfg_use-cls-frame-alpha"),
        "gr-cfg_cls-frame-alpha":  Struct.parse.normalizedNumberTransformer(data, "gr-cfg_cls-frame-alpha"),
        "gr-cfg_change-cls-frame-alpha": Struct.parse.boolean(data, "gr-cfg_change-cls-frame-alpha"),
        "gr-cfg_use-render-focus-grid": Struct.parse.boolean(data, "gr-cfg_use-render-focus-grid"),
        "gr-cfg_render-focus-grid": Struct.parse.boolean(data, "gr-cfg_render-focus-grid"),
        "gr-cfg_use-focus-grid-alpha": Struct.parse.boolean(data, "gr-cfg_use-focus-grid-alpha"),
        "gr-cfg_focus-grid-alpha": Struct.parse.normalizedNumberTransformer(data, "gr-cfg_focus-grid-alpha"),
        "gr-cfg_change-focus-grid-alpha": Struct.parse.boolean(data, "gr-cfg_change-focus-grid-alpha"),
        "gr-cfg_use-focus-grid-treshold": Struct.parse.boolean(data, "gr-cfg_use-focus-grid-treshold"),
        "gr-cfg_focus-grid-treshold": Struct.parse.numberTransformer(data, "gr-cfg_focus-grid-treshold", {
          clampValue: { from: 0.0, to: 32.0 },
          clampTarget: { from: 0.0, to: 32.0 },
        }),
        "gr-cfg_change-focus-grid-treshold": Struct.parse.boolean(data, "gr-cfg_change-focus-grid-treshold"),
        "gr-cfg_grid-use-blend": Struct.parse.boolean(data, "gr-cfg_grid-use-blend"),
        "gr-cfg_grid-blend-src": Struct.parse.gmArrayValue(data, "gr-cfg_grid-blend-src", BLEND_MODES_EXT, BLEND_MODES_EXT[0]),
        "gr-cfg_grid-blend-dest": Struct.parse.gmArrayValue(data, "gr-cfg_grid-blend-dest", BLEND_MODES_EXT, BLEND_MODES_EXT[0]),
        "gr-cfg_grid-blend-eq": Struct.parse.gmArrayValue(data, "gr-cfg_grid-blend-eq", BLEND_EQUATIONS, BLEND_EQUATIONS[0]),
        "gr-cfg_focus-grid-use-blend": Struct.parse.boolean(data, "gr-cfg_focus-grid-use-blend"),
        "gr-cfg_focus-grid-blend-src": Struct.parse.gmArrayValue(data, "gr-cfg_focus-grid-blend-src", BLEND_MODES_EXT, BLEND_MODES_EXT[0]),
        "gr-cfg_focus-grid-blend-dest": Struct.parse.gmArrayValue(data, "gr-cfg_focus-grid-blend-dest", BLEND_MODES_EXT, BLEND_MODES_EXT[0]),
        "gr-cfg_focus-grid-blend-eq": Struct.parse.gmArrayValue(data, "gr-cfg_focus-grid-blend-eq", BLEND_EQUATIONS, BLEND_EQUATIONS[0]),
      }
    },
    run: function(data) {
      Core.print("Dispatch track event:", "brush_grid_config")
    },
  },
}
#macro grid_track_event global.__grid_track_event
