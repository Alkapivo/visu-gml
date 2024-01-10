///@package io.alkapivo.visu.editor.service.brush.shader

///@param {?Struct} [json]
///@return {Struct}
function brush_shader_config(json = null) {
  return {
    name: "brush_shader_config",
    store: new Map(String, Struct, {
      "shader-config_use-render-shaders": {
        type: Boolean,
        value: Struct.getDefault(json, "shader-config_use-render-shaders", false),
      },
      "shader-config_render-shaders": {
        type: Boolean,
        value: Struct.getDefault(json, "shader-config_render-shaders", false),
      },
      "shader-config_use-transform-shader-alpha": {
        type: Boolean,
        value: Struct.getDefault(json, "shader-config_use-transform-shader-alpha", false),
      },
      "shader-config_transform-shader-alpha": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getDefault(json, 
          "shader-config_transform-shader-alpha", 
          { value: 0, target: 1, factor: 0.01, increase: 0 }
        )),
      },
      "shader-config_use-clear-frame": {
        type: Boolean,
        value: Struct.getDefault(json, "shader-config_use-clear-frame", false),
      },
      "shader-config_clear-frame": {
        type: Boolean,
        value: Struct.getDefault(json, "shader-config_clear-frame", false),
      },
      "shader-config_use-transform-clear-frame-alpha": {
        type: Boolean,
        value: Struct.getDefault(json, "shader-config_use-transform-clear-frame-alpha", false),
      },
      "shader-config_transform-clear-frame-alpha": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getDefault(json, 
          "shader-config_transform-clear-frame-alpha", 
          { value: 0, target: 5, factor: 0.03, increase: 2 }
        )),
      },
    }),
    components: new Array(Struct, [
      {
        name: "shader-config_render-shaders",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Render shaders",
            enable: { key: "shader-config_use-render-shaders" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "shader-config_use-render-shaders" },
          },
          input: { 
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "shader-config_render-shaders" },
            enable: { key: "shader-config_use-render-shaders" },
          },
        },
      },
      {
        name: "shader-config_transform-shader-alpha",
        template: VEComponents.get("transform-numeric-property"),
        layout: VELayouts.get("transform-numeric-property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          title: {
            label: { 
              text: "Transform shader alpha",
              enable: { key: "shader-config_use-transform-shader-alpha" },
            },  
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "shader-config_use-transform-shader-alpha" },
            },
          },
          target: {
            label: { 
              text: "Target",
              enable: { key: "shader-config_use-transform-shader-alpha" },
            },
            field: { 
              store: { key: "shader-config_transform-shader-alpha" },
              enable: { key: "shader-config_use-transform-shader-alpha" },
            },
          },
          factor: {
            label: { 
              text: "Factor",
              enable: { key: "shader-config_use-transform-shader-alpha" },
            },
            field: { 
              store: { key: "shader-config_transform-shader-alpha" },
              enable: { key: "shader-config_use-transform-shader-alpha" },
            },
          },
          increment: {
            label: { 
              text: "Increment",
              enable: { key: "shader-config_use-transform-shader-alpha" },
            },
            field: { 
              store: { key: "shader-config_transform-shader-alpha" },
              enable: { key: "shader-config_use-transform-shader-alpha" },
            },
          },
        },
      },
      {
        name: "shader-config_clear-frame",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Clear frame",
            enable: { key: "shader-config_use-clear-frame" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "shader-config_use-clear-frame" },
          },
          input: { 
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "shader-config_clear-frame" },
            enable: { key: "shader-config_use-clear-frame" },
          },
        },
      },
      {
        name: "shader-config_transform-clear-frame-alpha",
        template: VEComponents.get("transform-numeric-property"),
        layout: VELayouts.get("transform-numeric-property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          title: {
            label: { 
              text: "Transform clear frame alpha",
              enable: { key: "shader-config_use-transform-clear-frame-alpha" },
            },  
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "shader-config_use-transform-clear-frame-alpha" },
            },
          },
          target: {
            label: { 
              text: "Target",
              enable: { key: "shader-config_use-transform-clear-frame-alpha" },
            },
            field: { 
              store: { key: "shader-config_transform-clear-frame-alpha" },
              enable: { key: "shader-config_use-transform-clear-frame-alpha" },
            },
          },
          factor: {
            label: { 
              text: "Factor",
              enable: { key: "shader-config_use-transform-clear-frame-alpha" },
            },
            field: { 
              store: { key: "shader-config_transform-clear-frame-alpha" },
              enable: { key: "shader-config_use-transform-clear-frame-alpha" },
            },
          },
          increment: {
            label: { 
              text: "Increment",
              enable: { key: "shader-config_use-transform-clear-frame-alpha" },
            },
            field: { 
              store: { key: "shader-config_transform-clear-frame-alpha" },
              enable: { key: "shader-config_use-transform-clear-frame-alpha" },
            },
          },
        },
      },
    ]),
  }
}