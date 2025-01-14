///@package io.alkapivo.visu.editor.service.brush._old.view_old

///@param {Struct} json
///@return {Struct}
function migrateViewOldConfigEvent(json) {
  return {
    "icon": Struct.getIfType(json, "icon", Struct, { name: "texture_baron" }),
    "vw-cfg_use-render-hud": Struct.getIfType(json, "view-config_use-render-HUD", Boolean, false),
    "vw-cfg_render-hud": Struct.getIfType(json, "view-config_render-HUD", Boolean, false),
    "vw-cfg_use-render-video": Struct.getIfType(json, "view-config_use-render-video", Boolean, false),
    "vw-cfg_render-video": Struct.getIfType(json, "view-config_render-video", Boolean, false),
    "vw-cfg_cls-subtitle": Struct.getIfType(json, "view-config_clear-lyrics", Boolean, false),
  }
}


///@param {Struct} json
///@return {Struct}
function migrateViewOldConfigToGridConfigEvent(json) {
  return {
    "icon": Struct.getIfType(json, "icon", Struct, { name: "texture_baron" }),
    "gr-cfg_use-render": Struct.getIfType(json, "view-config_use-render-grid", Boolean, false),
    "gr-cfg_render": Struct.getIfType(json, "view-config_render-grid", Boolean, false),
  }
}


///@param {Struct} json
///@return {Struct}
function migrateViewOldConfigToEffectConfigEvent(json) {
  return {
    "icon": Struct.getIfType(json, "icon", Struct, { name: "texture_baron" }),
    "ef-cfg_use-render-part": Struct.getIfType(json, "view-config_use-render-particles", Boolean, false),
    "ef-cfg_render-part": Struct.getIfType(json, "view-config_render-particles", Boolean, false),
  }
}


///@param {?Struct} [json]
///@return {Struct}
function brush_view_old_config(json = null) {
  return {
    name: "brush_view_old_config",
    store: new Map(String, Struct, {
      "view-config_use-render-grid": {
        type: Boolean,
        value: Struct.getDefault(json, "view-config_use-render-grid", false),
      },
      "view-config_render-grid": {
        type: Boolean,
        value: Struct.getDefault(json, "view-config_render-grid", false),
      },
      "view-config_use-render-particles": {
        type: Boolean,
        value: Struct.getDefault(json, "view-config_use-render-particles", false),
      },
      "view-config_render-particles": {
        type: Boolean,
        value: Struct.getDefault(json, "view-config_render-particles", false),
      },
      "view-config_use-transform-particles-z": {
        type: Boolean,
        value: Struct.getDefault(json, "view-config_use-transform-particles-z", false),
      },
      "view-config_transform-particles-z": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getDefault(json, 
          "view-config_transform-particles-z",
          { value: 0, target: 1, factor: 0.01, increase: 0 }
        )),
      },
      "view-config_use-render-video": {
        type: Boolean,
        value: Struct.getDefault(json, "view-config_use-render-video", false),
      },
      "view-config_render-video": {
        type: Boolean,
        value: Struct.getDefault(json, "view-config_render-video", false),
      },
      "view-config_use-render-HUD": {
        type: Boolean,
        value: Struct.getDefault(json, "view-config_use-render-HUD", false),
      },
      "view-config_render-HUD": {
        type: Boolean,
        value: Struct.getDefault(json, "view-config_render-HUD", false),
      },
      "view-config_clear-lyrics": {
        type: Boolean,
        value: Struct.getDefault(json, "view-config_clear-lyrics", false),
      },
    }),
    components: new Array(Struct, [
      {
        name: "view-config_use-render-grid",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Render grid",
            enable: { key: "view-config_use-render-grid" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "view-config_use-render-grid" },
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "grid-config_render-grid" },
            enable: { key: "view-config_use-render-grid" },
          }
        },
      },
      {
        name: "view-config_use-render-HUD",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Render HUD",
            enable: { key: "view-config_use-render-HUD" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "view-config_use-render-HUD" },
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "view-config_render-HUD" },
            enable: { key: "view-config_use-render-HUD" },
          }
        },
      },
      {
        name: "view-config_use-render-videos",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Render video",
            enable: { key: "view-config_use-render-video" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "view-config_use-render-video" },
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "view-config_render-video" },
            enable: { key: "view-config_use-render-video" },
          }
        },
      },
      {
        name: "view-config_use-render-particles",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Render particles",
            enable: { key: "view-config_use-render-particles" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "view-config_use-render-particles" },
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "view-config_render-particles" },
            enable: { key: "view-config_use-render-particles" },
          }
        },
      },
      {
        name: "view-config_transform-particles-z",
        template: VEComponents.get("transform-numeric-property"),
        layout: VELayouts.get("transform-numeric-property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          title: {
            label: { 
              text: "Transform particle z",
              enable: { key: "view-config_use-transform-particles-z" },
            },  
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "view-config_use-transform-particles-z" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "view-config_use-transform-particles-z" },
            },
            field: {
              store: { key: "view-config_transform-particles-z" },
              enable: { key: "view-config_use-transform-particles-z" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "view-config_use-transform-particles-z" },
            },
            field: {
              store: { key: "view-config_transform-particles-z" },
              enable: { key: "view-config_use-transform-particles-z" },
            },
          },
          increment: {
            label: {
              text: "Increase",
              enable: { key: "view-config_use-transform-particles-z" },
            },
            field: {
              store: { key: "view-config_transform-particles-z" },
              enable: { key: "view-config_use-transform-particles-z" },
            },
          },
        },
      },
      {
        name: "view-config_clear-lyrics",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Clear subtitle",
            enable: { key: "view-config_clear-lyrics" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "view-config_clear-lyrics" },
          }
        },
      },
    ]),
  }
}