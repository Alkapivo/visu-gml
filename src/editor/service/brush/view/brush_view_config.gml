///@package io.alkapivo.visu.editor.service.brush.view

///@param {?Struct} [json]
///@return {Struct}
function brush_view_config(json = null) {
  return {
    name: "brush_view_config",
    store: new Map(String, Struct, {
      "vw-cfg_use-render-hud": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_use-render-hud"),
      },
      "vw-cfg_render-hud": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_render-hud"),
      },
      "vw-cfg_use-render-subtitle": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_use-render-subtitle"),
      },
      "vw-cfg_render-subtitle": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_render-subtitle"),
      },
      "vw-cfg_use-render-video": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_use-render-video"),
      },
      "vw-cfg_render-video": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_render-video"),
      },
      "vw-cfg_cls-subtitle": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_cls-subtitle"),
      },    
      "vw-cfg_cls-background": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_cls-background"),
      },    
      "vw-cfg_cls-foreground": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_cls-foreground"),
      },
      "vw-cfg_use-video-alpha": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_use-video-alpha"),
      },
      "vw-cfg_video-alpha": {
        type: NumberTransformer,
        value: Struct.get(json, "vw-cfg_video-alpha"),
        passthrough: UIUtil.passthrough.getNormalizedNumberTransformer(),
      },
      "vw-cfg_change-video-alpha": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_change-video-alpha"),
      },
    }),
    components: new Array(Struct, [
      {
        name: "vw-cfg_render",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Render",
            backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: { backgroundColor: VETheme.color.accentShadow },
          input: { backgroundColor: VETheme.color.accentShadow },
        },
      },
      {
        name: "vw-cfg_use-render-hud",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "HUD",
            enable: { key: "vw-cfg_use-render-hud" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-cfg_use-render-hud" },
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "vw-cfg_render-hud" },
            enable: { key: "vw-cfg_use-render-hud" },
          }
        },
      },
      {
        name: "vw-cfg_use-render-subtitle",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Subtitle",
            enable: { key: "vw-cfg_use-render-subtitle" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-cfg_use-render-subtitle" },
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "vw-cfg_render-subtitle" },
            enable: { key: "vw-cfg_use-render-subtitle" },
          }
        },
      },
      {
        name: "vw-cfg_use-render-video",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Video",
            enable: { key: "vw-cfg_use-render-video" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-cfg_use-render-video" },
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "vw-cfg_render-video" },
            enable: { key: "vw-cfg_use-render-video" },
          }
        },
      },
      {
        name: "vw-cfg_use-render-video-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "vw-cfg_cls",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Clear",
            backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: { backgroundColor: VETheme.color.accentShadow },
          input: { backgroundColor: VETheme.color.accentShadow },
        },
      },
      {
        name: "vw-cfg_cls-subtitle",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Subtitle",
            enable: { key: "vw-cfg_cls-subtitle" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-cfg_cls-subtitle" },
          }
        },
      },
      {
        name: "vw-cfg_cls-background",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Background",
            enable: { key: "vw-cfg_cls-background" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-cfg_cls-background" },
          }
        },
      },
      {
        name: "vw-cfg_cls-foreground",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Foreground",
            enable: { key: "vw-cfg_cls-foreground" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-cfg_cls-foreground" },
          }
        },
      },
      {
        name: "vw-cfg_cls-foreground-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "vw-cfg_video-alpha-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Video alpha",
            backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: { backgroundColor: VETheme.color.accentShadow },
          input: { backgroundColor: VETheme.color.accentShadow },
        },
      },
      {
        name: "vw-cfg_video-alpha",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Value",
              enable: { key: "vw-cfg_use-video-alpha" },
            },
            field: {
              store: { key: "vw-cfg_video-alpha" },
              enable: { key: "vw-cfg_use-video-alpha" },
            },
            decrease: { 
              store: { key: "vw-cfg_video-alpha" },
              enable: { key: "vw-cfg_use-video-alpha" },
              factor: -0.01,
            },
            increase: { 
              store: { key: "vw-cfg_video-alpha" },
              enable: { key: "vw-cfg_use-video-alpha" },
              factor: 0.01,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-cfg_use-video-alpha" },
            },
            title: { 
              text: "Override",
              enable: { key: "vw-cfg_use-video-alpha" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "vw-cfg_change-video-alpha" },
            },
            field: {
              store: { key: "vw-cfg_video-alpha" },
              enable: { key: "vw-cfg_change-video-alpha" },
            },
            decrease: { 
              store: { key: "vw-cfg_video-alpha" },
              enable: { key: "vw-cfg_change-video-alpha" },
              factor: -0.01,
            },
            increase: { 
              store: { key: "vw-cfg_video-alpha" },
              enable: { key: "vw-cfg_change-video-alpha" },
              factor: 0.01,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-cfg_change-video-alpha" },
            },
            title: { 
              text: "Change",
              enable: { key: "vw-cfg_change-video-alpha" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "vw-cfg_change-video-alpha" },
            },
            field: {
              store: { key: "vw-cfg_video-alpha" },
              enable: { key: "vw-cfg_change-video-alpha" },
            },
            decrease: { 
              store: { key: "vw-cfg_video-alpha" },
              enable: { key: "vw-cfg_change-video-alpha" },
              factor: -0.001,
            },
            increase: { 
              store: { key: "vw-cfg_video-alpha" },
              enable: { key: "vw-cfg_change-video-alpha" },
              factor: 0.001,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "vw-cfg_change-video-alpha" },
            },
            field: {
              store: { key: "vw-cfg_video-alpha" },
              enable: { key: "vw-cfg_change-video-alpha" },
            },
            decrease: { 
              store: { key: "vw-cfg_video-alpha" },
              enable: { key: "vw-cfg_change-video-alpha" },
              factor: -0.0001,
            },
            increase: { 
              store: { key: "vw-cfg_video-alpha" },
              enable: { key: "vw-cfg_change-video-alpha" },
              factor: 0.0001,
            },
          },
        },
      },
    ]),
  }
}