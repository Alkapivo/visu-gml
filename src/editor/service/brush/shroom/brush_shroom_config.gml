///@package io.alkapivo.visu.editor.service.brush.shroom

///@param {?Struct} [json]
///@return {Struct}
function brush_shroom_config(json = null) {
  return {
    name: "brush_shroom_config",
    store: new Map(String, Struct, {
      "shroom-config_use-render-shrooms": {
        type: Boolean,
        value: Struct.getDefault(json, "shroom-config_use-render-shrooms", false),
      },
      "shroom-config_render-shrooms": {
        type: Boolean,
        value: Struct.getDefault(json, "shroom-config_render-shrooms", false),
      },
      "shroom-config_use-transform-shroom-z": {
        type: Boolean,
        value: Struct.getDefault(json, "shroom-config_use-transform-shroom-z", true),
      },
      "shroom-config_transform-shroom-z": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getDefault(json, 
          "shroom-config_transform-shroom-z", 
          { value: 0, target: 100, factor: 1.0, increase: 0.2 }
        )),
      },
    }),
    components: new Array(Struct, [
      {
        name: "shroom-config_render-shrooms",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Render shrooms",
            enable: { key: "shroom-config_use-render-shrooms" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "shroom-config_use-render-shrooms" },
          },
          input: { 
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "shroom-config_render-shrooms" },
            enable: { key: "shroom-config_use-render-shrooms" },
          },
        },
      },
      {
        name: "shroom-config_transform-shroom-z",
        template: VEComponents.get("transform-numeric-property"),
        layout: VELayouts.get("transform-numeric-property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          title: {
            label: { 
              text: "Transform shroom z",
              enable: { key: "shroom-config_use-transform-shroom-z" },
            },  
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "shroom-config_use-transform-shroom-z" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "shroom-config_use-transform-shroom-z" },
            },
            field: {
              store: { key: "shroom-config_transform-shroom-z" },
              enable: { key: "shroom-config_use-transform-shroom-z" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "shroom-config_use-transform-shroom-z" },
            },
            field: {
              store: { key: "shroom-config_transform-shroom-z" },
              enable: { key: "shroom-config_use-transform-shroom-z" },
            },
          },
          increment: {
            label: {
              text: "Increment",
              enable: { key: "shroom-config_use-transform-shroom-z" },
            },
            field: {
              store: { key: "shroom-config_transform-shroom-z" },
              enable: { key: "shroom-config_use-transform-shroom-z" },
            },
          },
        },
      },
    ]),
  }
}