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
      "vw-cfg_cls-bkg-texture": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_cls-bkg-texture"),
      },    
      "vw-cfg_cls-bkg-col": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_cls-bkg-col"),
      },
      "vw-cfg_cls-frg-texture": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_cls-frg-texture"),
      },    
      "vw-cfg_cls-frg-col": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_cls-frg-col"),
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
      "vw-cfg_video-use-blend": {
        type: Boolean,
        value: Struct.get(json, "vw-cfg_video-use-blend"),
      },
      "vw-cfg_video-blend-src": {
        type: String,
        value: Struct.get(json, "vw-cfg_video-blend-src"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: BlendModeExt.keys(),
      },
      "vw-cfg_video-blend-dest": {
        type: String,
        value: Struct.get(json, "vw-cfg_video-blend-dest"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: BlendModeExt.keys(),
      },
      "vw-cfg_video-blend-eq": {
        type: String,
        value: Struct.get(json, "vw-cfg_video-blend-eq"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: BlendEquation.keys(),
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
        name: "vw-cfg_cls-bkg-texture",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Background texture",
            enable: { key: "vw-cfg_cls-bkg-texture" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-cfg_cls-bkg-texture" },
          }
        },
      },
      {
        name: "vw-cfg_cls-bkg-col",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Background color",
            enable: { key: "vw-cfg_cls-bkg-col" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-cfg_cls-bkg-col" },
          }
        },
      },
      {
        name: "vw-cfg_cls-frg-texture",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Foreground texture",
            enable: { key: "vw-cfg_cls-frg-texture" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-cfg_cls-frg-texture" },
          }
        },
      },
      {
        name: "vw-cfg_cls-frg-col",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Foreground color",
            enable: { key: "vw-cfg_cls-frg-col" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-cfg_cls-frg-col" },
          }
        },
      },
      {
        name: "vw-cfg_cls-frg-col-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "vw-cfg_video-use-blend",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Video blend mode",
            backgroundColor: VETheme.color.accentShadow,
            enable: { key: "vw-cfg_video-use-blend" },
          },
          input: { backgroundColor: VETheme.color.accentShadow },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-cfg_video-use-blend" },
            backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "vw-cfg_video-blend-src",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Source",
            enable: { key: "vw-cfg_video-use-blend" },
          },
          previous: {
            store: { key: "vw-cfg_video-blend-src" },
            enable: { key: "vw-cfg_video-use-blend" },
          },
          preview: Struct.appendRecursive({ 
            store: { key: "vw-cfg_video-blend-src" },
            enable: { key: "vw-cfg_video-use-blend" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: { 
            store: { key: "vw-cfg_video-blend-src" },
            enable: { key: "vw-cfg_video-use-blend" },
          },
        },
      },
      {
        name: "vw-cfg_video-blend-dest",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Target",
            enable: { key: "vw-cfg_video-use-blend" },
          },
          previous: {
            store: { key: "vw-cfg_video-blend-dest" },
            enable: { key: "vw-cfg_video-use-blend" },
          },
          preview: Struct.appendRecursive({ 
            store: { key: "vw-cfg_video-blend-dest" },
            enable: { key: "vw-cfg_video-use-blend" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: { 
            store: { key: "vw-cfg_video-blend-dest" },
            enable: { key: "vw-cfg_video-use-blend" },
          },
        },
      },
      {
        name: "vw-cfg_video-blend-eq",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Equation",
            enable: { key: "vw-cfg_video-use-blend" },
          },
          previous: {
            store: { key: "vw-cfg_video-blend-eq" },
            enable: { key: "vw-cfg_video-use-blend" },
          },
          preview: Struct.appendRecursive({ 
            store: { key: "vw-cfg_video-blend-eq" },
            enable: { key: "vw-cfg_video-use-blend" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: {
            store: { key: "vw-cfg_video-blend-eq" },
            enable: { key: "vw-cfg_video-use-blend" },
          },
        },
      },
      {
        name: "vw-cfg_video-blend-line-h",
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
          layout: { 
            type: UILayoutType.VERTICAL,
            margin: { top: 4 },
          },
          value: {
            label: {
              text: "Alpha",
              font: "font_inter_10_bold",
              color: VETheme.color.textShadow,
              //enable: { key: "vw-cfg_use-video-alpha" },
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