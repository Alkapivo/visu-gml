///@package io.alkapivo.visu.editor.service.brush.shader

///@param {?Struct} [json]
///@return {Struct}
function brush_shader_spawn(json = null) {
  return {
    name: "brush_shader_spawn",
    store: new Map(String, Struct, {
      "shader-spawn_template": {
        type: String,
        value: Struct.getDefault(json, "shader-spawn_template", "Wave"),
        passthrough: function(value) {
          return Beans.get(BeanVisuController).shaderPipeline.templates
            .contains(value) ? value : this.value
        },
      },
      "shader-spawn_duration": {
        type: Number,
        value: Struct.getDefault(json, "shader-spawn_duration", 1.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 3600.0) 
        },
      },
    }),
    components: new Array(Struct, [
      {
        name: "shader-spawn_template",  
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Template" },
          field: { store: { key: "shader-spawn_template" } },
        },
      },
      {
        name: "shader-spawn_duration",  
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Duration" },
          field: { store: { key: "shader-spawn_duration" } },
        },
      },
    ]),
  }
}