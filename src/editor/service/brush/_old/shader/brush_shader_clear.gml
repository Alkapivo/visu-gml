///@package io.alkapivo.visu.editor.service.brush._old.shader

///@param {Struct} json
///@return {Struct}
function migrateShaderClearEvent(json) {
  var pipeline = migrateShaderPipelineType(Struct.get(json, "shader-clear_pipeline"))
  var clear = Struct.getIfType(json, "shader-clear_use-clear-all-shaders", Boolean, false)
    || (Struct.getIfType(json, "shader-clear_use-clear-amount", Boolean, false)
      && Struct.getIfType(json, "shader-clear_clear-amount", Number, 0) > 0)

  return {
    "icon": Struct.getIfType(json, "icon", Struct, { name: "texture_baron" }),
    "ef-cfg_cls-shd-bkg": clear && pipeline == ShaderPipelineType.BACKGROUND,
    "ef-cfg_cls-shd-gr": clear && pipeline == ShaderPipelineType.GRID,
    "ef-cfg_cls-shd-all": clear && pipeline == ShaderPipelineType.COMBINED,
  }
}


///@param {?Struct} [json]
///@return {Struct}
function brush_shader_clear(json = null) {
  return {
    name: "brush_shader_clear",
    store: new Map(String, Struct, {
      "shader-clear_pipeline": {
        type: String,
        value: migrateShaderPipelineType(Struct.getDefault(json, "shader-clear_pipeline", ShaderPipelineType.BACKGROUND)),
        validate: function(value) {
          Assert.isTrue(this.data.contains(value))
        },
        data: ShaderPipelineType.keys(),
      },
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
      },
      "shader-clear_use-fade-out": {
        type: Boolean,
        value: Struct.getDefault(json, "shader-clear_use-fade-out", false),
      },
      "shader-clear_fade-out": {
        type: Number,
        value: Struct.getDefault(json, "shader-clear_fade-out", 0.0),
        passthrough: function(value) {
          return round(clamp(NumberUtil.parse(value, this.value), 0, 999))
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
            GMTF_DECIMAL: 0,
          },
        },
      },
      {
        name: "shader-clear_use-fade-out",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Fade out",
            enable: { key: "shader-clear_use-fade-out" },
          },  
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "shader-clear_use-fade-out" },
          },
        },
      },
      {
        name: "shader-clear_fade-out",
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Time",
            enable: { key: "shader-clear_use-fade-out" },
          },  
          field: { 
            store: { key: "shader-clear_fade-out" },
            enable: { key: "shader-clear_use-fade-out" },
          },
        },
      },
      {
        name: "shader-clear_pipeline",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Pipeline" },
          previous: { store: { key: "shader-clear_pipeline" } },
          preview: Struct.appendRecursive({ 
            store: { key: "shader-clear_pipeline" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: { store: { key: "shader-clear_pipeline" } },
        },
      },
    ]),
  }
}