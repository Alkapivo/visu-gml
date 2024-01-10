///@package io.alkapivo.visu.editor.service.brush.shader

///@param {?Struct} [json]
///@return {Struct}
function brush_shader_overlay(json = null) {
  return {
    name: "brush_shader_overlay",
    store: new Map(String, Struct, {
      "shader-overlay_use-render-support-grid": {
        type: Boolean,
        value: Struct.getDefault(json, "shader-overlay_use-render-support-grid", false),
      },
      "shader-overlay_render-support-grid": {
        type: Boolean,
        value: Struct.getDefault(json, "shader-overlay_render-support-grid", false),
      },
      "shader-overlay_use-transform-support-grid-treshold": {
        type: Boolean,
        value: Struct.getDefault(json, "shader-overlay_use-transform-support-grid-treshold", false),
      },
      "shader-overlay_transform-support-grid-treshold": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getDefault(json, 
          "shader-overlay_transform-support-grid-treshold", 
          { value: 0, target: 1, factor: 0.01, increase: 0 }
        )),
      },
      "shader-overlay_use-transform-support-grid-alpha": {
        type: Boolean,
        value: Struct.getDefault(json, "shader-overlay_use-transform-support-grid-alpha", false),
      },
      "shader-overlay_transform-support-grid-alpha": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getDefault(json, 
          "shader-overlay_transform-support-grid-alpha", 
          { value: 0, target: 4, factor: 0.02, increase: 1 }
        )),
      },
      "shader-overlay_use-clear-frame": {
        type: Boolean,
        value: Struct.getDefault(json, "shader-overlay_use-clear-frame", false),
      },
      "shader-overlay_clear-frame": {
        type: Boolean,
        value: Struct.getDefault(json, "shader-overlay_clear-frame", false),
      },
      "shader-overlay_use-clear-color": {
        type: Boolean,
        value: Struct.getDefault(json, "shader-overlay_use-clear-color", false),
      },
      "shader-overlay_clear-color": {
        type: Color,
        value: ColorUtil.fromHex(Struct.get(json, "shader-overlay_clear-color"), "#000000"),
      },
      "shader-overlay_use-transform-clear-frame-alpha": {
        type: Boolean,
        value: Struct.getDefault(json, "shader-overlay_use-transform-clear-frame-alpha", false),
      },
      "shader-overlay_transform-clear-frame-alpha": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getDefault(json, 
          "shader-overlay_transform-clear-frame-alpha", 
          { value: 0, target: 5, factor: 0.03, increase: 2 }
        )),
      },
    }),
    components: new Array(Struct, [
      {
        name: "shader-overlay_use-render-support-grid",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Render support grid",
            enable: { key: "shader-overlay_use-render-support-grid" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "shader-overlay_use-render-support-grid" },
          },
          input: { 
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "shader-overlay_render-support-grid" },
            enable: { key: "shader-overlay_use-render-support-grid" },
          },
        },
      },
      {
        name: "shader-overlay_transform-support-grid-treshold",
        template: VEComponents.get("transform-numeric-property"),
        layout: VELayouts.get("transform-numeric-property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          title: {
            label: { 
              text: "Transform treshold",
              enable: { key: "shader-overlay_use-transform-support-grid-treshold" },
            },  
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "shader-overlay_use-transform-support-grid-treshold" },
            },
          },
          target: {
            label: { 
              text: "Target",
              enable: { key: "shader-overlay_use-transform-support-grid-treshold" },
            },
            field: { 
              store: { key: "shader-overlay_transform-support-grid-treshold" },
              enable: { key: "shader-overlay_use-transform-support-grid-treshold" },
            },
          },
          factor: {
            label: { 
              text: "Factor",
              enable: { key: "shader-overlay_use-transform-support-grid-treshold" },
            },
            field: { 
              store: { key: "shader-overlay_transform-support-grid-treshold" },
              enable: { key: "shader-overlay_use-transform-support-grid-treshold" },
            },
          },
          increment: {
            label: { 
              text: "Increment",
              enable: { key: "shader-overlay_use-transform-support-grid-treshold" },
            },
            field: { 
              store: { key: "shader-overlay_transform-support-grid-treshold" },
              enable: { key: "shader-overlay_use-transform-support-grid-treshold" },
            },
          },
        },
      },
      {
        name: "shader-overlay_transform-support-grid-alpha",
        template: VEComponents.get("transform-numeric-property"),
        layout: VELayouts.get("transform-numeric-property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          title: {
            label: { 
              text: "Transform support alpha",
              enable: { key: "shader-overlay_use-transform-support-grid-alpha" },
            },  
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "shader-overlay_use-transform-support-grid-alpha" },
            },
          },
          target: {
            label: { 
              text: "Target",
              enable: { key: "shader-overlay_use-transform-support-grid-alpha" },
            },
            field: { 
              store: { key: "shader-overlay_transform-support-grid-alpha" },
              enable: { key: "shader-overlay_use-transform-support-grid-alpha" },
            },
          },
          factor: {
            label: { 
              text: "Factor",
              enable: { key: "shader-overlay_use-transform-support-grid-alpha" },
            },
            field: { 
              store: { key: "shader-overlay_transform-support-grid-alpha" },
              enable: { key: "shader-overlay_use-transform-support-grid-alpha" },
            },
          },
          increment: {
            label: { 
              text: "Increment",
              enable: { key: "shader-overlay_use-transform-support-grid-alpha" },
            },
            field: { 
              store: { key: "shader-overlay_transform-support-grid-alpha" },
              enable: { key: "shader-overlay_use-transform-support-grid-alpha" },
            },
          },
        },
      },
      {
        name: "shader-overlay_clear-frame",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Clear frame",
            enable: { key: "shader-overlay_use-clear-frame" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "shader-overlay_use-clear-frame" },
          },
          input: { 
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "shader-overlay_clear-frame"},
            enable: { key: "shader-overlay_use-clear-frame" },
          },
        },
      },
      {
        name: "shader-overlay_clear-color",
        template: VEComponents.get("color-picker"),
        layout: VELayouts.get("color-picker"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          title: {
            label: { 
              text: "Set clear color",
              enable: { key: "shader-overlay_use-clear-color" },
            },  
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "shader-overlay_use-clear-color" },
            },
            input: { 
              store: { key: "shader-overlay_clear-color" },
              enable: { key: "shader-overlay_use-clear-color" },
            }
          },
          red: {
            label: { 
              text: "Red",
              enable: { key: "shader-overlay_use-clear-color" },
            },
            field: { 
              store: { key: "shader-overlay_clear-color" },
              enable: { key: "shader-overlay_use-clear-color" },
            },
            slider: { 
              store: { key: "shader-overlay_clear-color" },
              enable: { key: "shader-overlay_use-clear-color" },
            },
          },
          green: {
            label: { 
              text: "Green",
              enable: { key: "shader-overlay_use-clear-color" },
            },
            field: { 
              store: { key: "shader-overlay_clear-color" },
              enable: { key: "shader-overlay_use-clear-color" },
            },
            slider: { 
              store: { key: "shader-overlay_clear-color" },
              enable: { key: "shader-overlay_use-clear-color" },
            },
          },
          blue: {
            label: { 
              text: "Blue",
              enable: { key: "shader-overlay_use-clear-color" },
            },
            field: { 
              store: { key: "shader-overlay_clear-color" },
              enable: { key: "shader-overlay_use-clear-color" },
            },
            slider: { 
              store: { key: "shader-overlay_clear-color" },
              enable: { key: "shader-overlay_use-clear-color" },
            },
          },
          hex: { 
            label: { 
              text: "Hex",
              enable: { key: "shader-overlay_use-clear-color" },
            },
            field: { 
              store: { key: "shader-overlay_clear-color" },
              enable: { key: "shader-overlay_use-clear-color" },
            },
          },
        },
      },
      {
        name: "shader-overlay_transform-clear-frame-alpha",
        template: VEComponents.get("transform-numeric-property"),
        layout: VELayouts.get("transform-numeric-property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          title: {
            label: { 
              text: "Transform clear frame alpha",
              enable: { key: "shader-overlay_use-transform-clear-frame-alpha" },
            },  
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "shader-overlay_use-transform-clear-frame-alpha" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "shader-overlay_use-transform-clear-frame-alpha" },
            },
            field: {
              store: { key: "shader-overlay_transform-clear-frame-alpha" },
              enable: { key: "shader-overlay_use-transform-clear-frame-alpha" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "shader-overlay_use-transform-clear-frame-alpha" },
            },
            field: {
              store: { key: "shader-overlay_transform-clear-frame-alpha" },
              enable: { key: "shader-overlay_use-transform-clear-frame-alpha" },
            },
          },
          increment: {
            label: {
              text: "Increment",
              enable: { key: "shader-overlay_use-transform-clear-frame-alpha" },
            },
            field: {
              store: { key: "shader-overlay_transform-clear-frame-alpha" },
              enable: { key: "shader-overlay_use-transform-clear-frame-alpha" },
            },
          },
        },
      },
    ]),
  }
}