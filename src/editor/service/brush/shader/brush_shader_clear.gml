///@package io.alkapivo.visu.editor.service.brush.shader

///@param {?Struct} [json]
///@return {Struct}
function brush_shader_clear(json = null) {
  return {
    name: "brush_shader_clear",
    store: new Map(String, Struct, {
      "shader-clear_use-clear-all-shaders": {
        type: Boolean,
        value: Struct.getDefault(json, "shader-clear_use-clear-all-shaders", false),
      },
      "shader-clear_use-clear-amount": {
        type: Boolean,
        value: Struct.getDefault(json, "shader-clear_use-clear-amount", false),
      },
      "shader-clear_clear-amount": {
        type: Number,
        value: Struct.getDefault(json, "shader-clear_clear-amount", 1),
        passthrough: function(value) {
          return round(clamp(NumberUtil.parse(value, this.value), 1, 999))
        },
      }
    }),
    components: new Array(Struct, [
      {
        name: "shader-clear_use-clear-all-shaders",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Clear all shaders",
            enable: { key: "shader-clear_use-clear-all-shaders" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "shader-clear_use-clear-all-shaders" },
          },
        },
      },
      {
        name: "shader-clear_use-clear-amount",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Clear amount",
            enable: { key: "shader-clear_use-clear-amount" },
          },  
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "shader-clear_use-clear-amount" },
          },
        },
      },
      {
        name: "shader-clear_clear-amount",
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Amount",
            enable: { key: "shader-clear_use-clear-amount" },
          },  
          field: { 
            store: { key: "shader-clear_clear-amount" },
            enable: { key: "shader-clear_use-clear-amount" },
          },
        },
      },
    ]),
  }
}