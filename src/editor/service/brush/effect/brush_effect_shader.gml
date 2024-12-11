///@package io.alkapivo.visu.editor.service.brush.effect

///@param {?Struct} [json]
///@return {Struct}
function brush_effect_shader(json = null) {
  return {
    name: "brush_effect_shader",
    store: new Map(String, Struct, {
      "ef-shd_template": {
        type: String,
        value: Struct.getDefault(json, "ef-shd_template", "shader-default"),
        passthrough: function(value) {
          var shaderPipeline = Beans.get(BeanVisuController).shaderPipeline
          return shaderPipeline.templates.contains(value) || Visu.assets().shaderTemplates.contains(value)
            ? value
            : (Core.isType(this.value, String) ? this.value : "shader-default")
        },
      },
      "ef-shd_duration": {
        type: Number,
        value: Struct.getDefault(json, "ef-shd_duration", 1.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 9999.9) 
        },
      },
      "ef-shd_fade-in": {
        type: Number,
        value: Struct.getDefault(json, "ef-shd_fade-in", 1.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 9999.9) 
        },
      },
      "ef-shd_fade-out": {
        type: Number,
        value: Struct.getDefault(json, "ef-shd_fade-out", 1.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 9999.9) 
        },
      },
      "ef-shd_alpha": {
        type: Number,
        value: Struct.getDefault(json, "ef-shd_alpha", 1.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 1.0) 
        },
      },
      "ef-shd_pipeline": {
        type: String,
        value: Struct.getDefault(json, "ef-shd_pipeline", "Background"),
        validate: function(value) {
          Assert.isTrue(this.data.contains(value))
        },
        data: new Array(String, [ "Background", "Grid", "All" ])
      },
      "ef-shd_use-merge-cfg": {
        type: Boolean,
        value: Struct.getIfType(json, "ef-shd_use-merge-cfg", Boolean, false),
      },
      "ef-shd_merge-cfg": {
        type: String,
        value: JSON.stringify(Struct.getIfType(json, "ef-shd_merge-cfg", Struct, {}), { pretty: true }),
        serialize: function() {
          return JSON.parse(this.get())
        },
        validate: function(value) {
          Assert.isType(JSON.parse(value), Struct)
        },
      },
    }),
    components: new Array(Struct, [
      {
        name: "ef-shd_template",  
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Template" },
          field: { store: { key: "ef-shd_template" } },
        },
      },
      {
        name: "ef-shd_duration-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "ef-shd_duration",  
        template: VEComponents.get("text-field-increase"),
        layout: VELayouts.get("text-field-increase"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Duration (s)" },
          field: { store: { key: "ef-shd_duration" } },
          decrease: {
            store: { key: "ef-shd_duration" },
            factor: -0.5,
          },
          increase: {
            store: { key: "ef-shd_duration" },
            factor: 0.5,
          },
        },
      },
      {
        name: "ef-shd_fade-in",  
        template: VEComponents.get("text-field-increase"),
        layout: VELayouts.get("text-field-increase"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Fade in (s)" },
          field: { store: { key: "ef-shd_fade-in" } },
          decrease: {
            store: { key: "ef-shd_fade-in" },
            factor: -0.25,
          },
          increase: {
            store: { key: "ef-shd_fade-in" },
            factor: 0.25,
          },
        },
      },
      {
        name: "ef-shd_fade-out",  
        template: VEComponents.get("text-field-increase"),
        layout: VELayouts.get("text-field-increase"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Fade out (s)" },
          field: { store: { key: "ef-shd_fade-out" } },
          decrease: {
            store: { key: "ef-shd_fade-out" },
            factor: -0.25,
          },
          increase: {
            store: { key: "ef-shd_fade-out" },
            factor: 0.25,
          },
        },
      },
      {
        name: "ef-shd_alpha-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "ef-shd_alpha",  
        template: VEComponents.get("numeric-slider-field"),
        layout: VELayouts.get("numeric-slider-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Alpha",
          },
          field: { 
            store: { key: "ef-shd_alpha" },
          },
          slider:{
            minValue: 0.0,
            maxValue: 1.0,
            snapValue: 0.01 / 1.0,
            store: { key: "ef-shd_alpha" },
          },
        },
      },
      {
        name: "ef-shd_pipeline",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Pipeline" },
          previous: { store: { key: "ef-shd_pipeline" } },
          preview: Struct.appendRecursive({ 
            store: { key: "ef-shd_pipeline" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: { store: { key: "ef-shd_pipeline" } },
        },
      },
      {
        name: "ef-shd_use-merge-cfg_line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "ef-shd_use-merge-cfg",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Shader config",
            enable: { key: "ef-shd_use-merge-cfg" },
            backgroundColor: VETheme.color.accentShadow,
          },
          input: { backgroundColor: VETheme.color.accentShadow },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "ef-shd_use-merge-cfg" },
            backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "ef-shd_merge-cfg",
        template: VEComponents.get("text-area"),
        layout: VELayouts.get("text-area"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          field: { 
            v_grow: true,
            w_min: 570,
            store: { key: "ef-shd_merge-cfg" },
            enable: { key: "ef-shd_use-merge-cfg" },
          },
        },
      }
    ]),
  }
}