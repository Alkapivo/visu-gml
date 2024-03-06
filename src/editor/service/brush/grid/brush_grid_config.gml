///@package io.alkapivo.visu.editor.service.brush.grid

///@param {?Struct} [json]
///@return {Struct}
function brush_grid_config(json = null) {
  return {
    name: "brush_grid_config",
    store: new Map(String, Struct, {
      "grid-config_use-render-grid": {
        type: Boolean,
        value: Struct.getDefault(json, "grid-config_use-render-grid", false),
      },
      "grid-config_render-grid": {
        type: Boolean,
        value: Struct.getDefault(json, "grid-config_render-grid", false),
      },
      "grid-config_use-render-grid-elements": {
        type: Boolean,
        value: Struct.getDefault(json, "grid-config_use-render-grid-elements", false),
      },
      "grid-config_render-grid-elements": {
        type: Boolean,
        value: Struct.getDefault(json, "grid-config_render-grid-elements", false),
      },
      "grid-config_use-transform-speed": {
        type: Boolean,
        value: Struct.getDefault(json, "grid-config_use-transform-speed", false),
      },
      "grid-config_transform-speed": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getDefault(json, 
          "grid-config_transform-speed", 
          { value: (FRAME_MS / 4) * 1000, target: 1, factor: 0.01, increase: 0 }
        )),
      },
      "grid-config_use-clear-frame": {
        type: Boolean,
        value: Struct.getDefault(json, "grid-config_use-clear-frame", false),
      },
      "grid-config_clear-frame": {
        type: Boolean,
        value: Struct.getDefault(json, "grid-config_clear-frame", false),
      },
      "grid-config_use-clear-color": {
        type: Boolean,
        value: Struct.getDefault(json, "grid-config_use-clear-color", false),
      },
      "grid-config_clear-color": {
        type: Color,
        value: ColorUtil.fromHex(Struct.get(json, "grid-config_clear-color"), "#000000"),
      },
      "grid-config_use-transform-clear-frame-alpha": {
        type: Boolean,
        value: Struct.getDefault(json, "grid-config_use-transform-clear-frame-alpha", false),
      },
      "grid-config_transform-clear-frame-alpha": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getDefault(json, 
          "grid-config_transform-clear-frame-alpha", 
          { value: 0, target: 5, factor: 0.03, increase: 2 }
        )),
      },
      "grid-config_use-gamemode": {
        type: Boolean,
        value: Struct.getDefault(json, "grid-config_use-gamemode", false),
      },
      "grid-config_gamemode": {
        type: String,
        value: Struct.getDefault(json, "grid-config_gamemode", GameMode.keys().get(0)),
        validate: function(value) {
          Assert.isEnumKey(value, GameMode)
        },
        data: GameMode.keys(),
      },
    }),
    components: new Array(Struct, [
      {
        name: "grid-config_use-render-grid",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Render grid",
            enable: { key: "grid-config_use-render-grid" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "grid-config_use-render-grid" },
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "grid-config_render-grid" },
            enable: { key: "grid-config_use-render-grid" },
          }
        },
      },
      {
        name: "grid-config_use-render-grid-elements",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Render elements",
            enable: { key: "grid-config_use-render-grid-elements" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "grid-config_use-render-grid-elements" },
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "grid-config_render-grid-elements" },
            enable: { key: "grid-config_use-render-grid-elements" },
          }
        },
      },
      {
        name: "grid-config_transform-speed",
        template: VEComponents.get("transform-numeric-property"),
        layout: VELayouts.get("transform-numeric-property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          title: {
            label: {
              text: "Transform speed",
              enable: { key: "grid-config_use-transform-speed" },
            },  
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "grid-config_use-transform-speed" },
            },
          },
          target: {
            label: { 
              text: "Target",
              enable: { key: "grid-config_use-transform-speed" },
            },
            field: { 
              store: { key: "grid-config_transform-speed" },
              enable: { key: "grid-config_use-transform-speed" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "grid-config_use-transform-speed" },
            },
            field: { 
              store: { key: "grid-config_transform-speed" },
              enable: { key: "grid-config_use-transform-speed" },
            },
          },
          increment: {
            label: {
              text: "Increment",
              enable: { key: "grid-config_use-transform-speed" },
            },
            field: { 
              store: { key: "grid-config_transform-speed" },
              enable: { key: "grid-config_use-transform-speed" },
            },
          },
        },
      },
      {
        name: "grid-config_clear-frame",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Clear frame",
            enable: { key: "grid-config_use-clear-frame" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "grid-config_use-clear-frame"}
          },
          input: { 
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "grid-config_clear-frame" },
            enable: { key: "grid-config_use-clear-frame" },
          },
        },
      },
      {
        name: "grid-config_clear-color",
        template: VEComponents.get("color-picker"),
        layout: VELayouts.get("color-picker"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          title: {
            label: { 
              text: "Set clear color",
              enable: { key: "grid-config_use-clear-color" },
            },  
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "grid-config_use-clear-color" },
            },
            input: { 
              store: { key: "grid-config_clear-color" },
              enable: { key: "grid-config_use-clear-color" },
            }
          },
          red: {
            label: { 
              text: "Red",
              enable: { key: "grid-config_use-clear-color" },
            },
            field: { 
              store: { key: "grid-config_clear-color" },
              enable: { key: "grid-config_use-clear-color" },
            },
            slider: { 
              store: { key: "grid-config_clear-color" },
              enable: { key: "grid-config_use-clear-color" },
            },
          },
          green: {
            label: { 
              text: "Green",
              enable: { key: "grid-config_use-clear-color" },
            },
            field: { 
              store: { key: "grid-config_clear-color" },
              enable: { key: "grid-config_use-clear-color" },
            },
            slider: { 
              store: { key: "grid-config_clear-color" },
              enable: { key: "grid-config_use-clear-color" },
            },
          },
          blue: {
            label: { 
              text: "Blue",
              enable: { key: "grid-config_use-clear-color" },
            },
            field: { 
              store: { key: "grid-config_clear-color" },
              enable: { key: "grid-config_use-clear-color" },
            },
            slider: { 
              store: { key: "grid-config_clear-color" },
              enable: { key: "grid-config_use-clear-color" },
            },
          },
          hex: { 
            label: { 
              text: "Hex",
              enable: { key: "grid-config_use-clear-color" },
            },
            field: { 
              store: { key: "grid-config_clear-color" },
              enable: { key: "grid-config_use-clear-color" },
            },
          },
        },
      },
      {
        name: "grid-config_transform-clear-frame-alpha",
        template: VEComponents.get("transform-numeric-property"),
        layout: VELayouts.get("transform-numeric-property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          title: {
            label: { 
              text: "Transform clear frame alpha",
              enable: { key: "grid-config_use-transform-clear-frame-alpha" },
            },  
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "grid-config_use-transform-clear-frame-alpha"}
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "grid-config_use-transform-clear-frame-alpha" },
            },
            field: {
              store: { key: "grid-config_transform-clear-frame-alpha" },
              enable: { key: "grid-config_use-transform-clear-frame-alpha" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "grid-config_use-transform-clear-frame-alpha" },
            },
            field: {
              store: { key: "grid-config_transform-clear-frame-alpha" },
              enable: { key: "grid-config_use-transform-clear-frame-alpha" },
            },
          },
          increment: {
            label: { 
              text: "Increment",
              enable: { key: "grid-config_use-transform-clear-frame-alpha" },
            },
            field: { 
              store: { key: "grid-config_transform-clear-frame-alpha" },
              enable: { key: "grid-config_use-transform-clear-frame-alpha" },
            },
          },
        },
      },
      {
        name: "grid-config_use-gamemode",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Set gamemode",
            enable: { key: "grid-config_use-render-grid" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "grid-config_use-gamemode" },
          },
        },
      },
      {
        name: "grid-config_gamemode",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Mode",
            enable: { key: "grid-config_use-gamemode" },
          },
          previous: { 
            enable: { key: "grid-config_use-gamemode" },
            store: { key: "grid-config_gamemode" },
          },
          preview: Struct.appendRecursive({ 
            enable: { key: "grid-config_use-gamemode" },
            store: { key: "grid-config_gamemode" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: { 
            enable: { key: "grid-config_use-gamemode" },
            store: { key: "grid-config_gamemode" },
          },
        },
      },
    ]),
  }
}