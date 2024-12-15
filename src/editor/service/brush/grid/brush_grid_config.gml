///@package io.alkapivo.visu.editor.service.brush.grid

///@param {Struct} json
///@return {Struct}
function brush_grid_config(json) {
  return {
    name: "brush_grid_config",
    store: new Map(String, Struct, {
      "en-cfg_use-render-shr": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_use-render-shr"),
      },
      "en-cfg_render-shr": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_render-shr"),
      },
      "en-cfg_use-render-player": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_use-render-player"),
      },
      "en-cfg_render-player": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_render-player"),
      },
      "en-cfg_use-render-coin": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_use-render-coin"),
      },
      "en-cfg_render-coin": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_render-coin"),
      },
      "en-cfg_use-render-bullet": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_use-render-bullet"),
      },
      "en-cfg_render-bullet": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_render-bullet"),
      },
      "en-cfg_cls-shr": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_cls-shr"),
      },
      "en-cfg_cls-player": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_cls-player"),
      },
      "en-cfg_cls-coin": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_cls-coin"),
      },
      "en-cfg_cls-bullet": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_cls-bullet"),
      },
      "en-cfg_use-z-shr": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_use-z-shr"),
      },
      "en-cfg_z-shr": {
        type: NumberTransformer,
        value: Struct.get(json, "en-cfg_z-shr"),
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 99999.9),
      },
      "en-cfg_change-z-shr": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_change-z-shr"),
      },
      "en-cfg_use-z-player": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_use-z-player"),
      },
      "en-cfg_z-player": {
        type: NumberTransformer,
        value: Struct.get(json, "en-cfg_z-player"),
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 99999.9),
      },
      "en-cfg_change-z-player": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_change-z-player"),
      },
      "en-cfg_use-z-coin": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_use-z-coin"),
      },
      "en-cfg_z-coin": {
        type: NumberTransformer,
        value: Struct.get(json, "en-cfg_z-coin"),
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 99999.9),
      },
      "en-cfg_change-z-coin": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_change-z-coin"),
      },
      "en-cfg_use-z-bullet": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_use-z-bullet"),
      },
      "en-cfg_z-bullet": {
        type: NumberTransformer,
        value: Struct.get(json, "en-cfg_z-bullet"),
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 99999.9),
      },
      "en-cfg_change-z-bullet": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_use-render-shr"),
      },
    }),
    components: new Array(Struct, [
      {
        name: "gr-cfg_render",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Render grid",
            enable: { key: "gr-cfg_use-render" },
            backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "gr-cfg_use-render" },
            backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "gr-cfg_render" },
            enable: { key: "gr-cfg_use-render" },
            backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "gr-cfg_render-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "gr-cfg_spd",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Speed",
              font: "font_inter_10_bold",
              color: VETheme.color.textFocus,
              enable: { key: "gr-cfg_use-spd" },
            },
            field: {
              store: { key: "gr-cfg_spd" },
              enable: { key: "gr-cfg_use-spd" },
            },
            decrease: { 
              store: { key: "gr-cfg_spd" },
              enable: { key: "gr-cfg_use-spd" },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_spd" },
              enable: { key: "gr-cfg_use-spd" },
              factor: 1.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-cfg_use-spd" },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-cfg_use-spd" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-cfg_change-spd" },
            },
            field: {
              store: { key: "gr-cfg_spd" },
              enable: { key: "gr-cfg_change-spd" },
            },
            decrease: { 
              store: { key: "gr-cfg_spd" },
              enable: { key: "gr-cfg_change-spd" },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_spd" },
              enable: { key: "gr-cfg_change-spd" },
              factor: 1.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-cfg_change-spd" },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-cfg_change-spd" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-cfg_change-spd" },
            },
            field: {
              store: { key: "gr-cfg_spd" },
              enable: { key: "gr-cfg_change-spd" },
            },
            decrease: { 
              store: { key: "gr-cfg_spd" },
              enable: { key: "gr-cfg_change-spd" },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_spd" },
              enable: { key: "gr-cfg_change-spd" },
              factor: 1.0,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-cfg_change-spd" },
            },
            field: {
              store: { key: "gr-cfg_spd" },
              enable: { key: "gr-cfg_change-spd" },
            },
            decrease: { 
              store: { key: "gr-cfg_spd" },
              enable: { key: "gr-cfg_change-spd" },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_spd" },
              enable: { key: "gr-cfg_change-spd" },
              factor: 1.0,
            },
          },
        },
      },
      {
        name: "gr-cfg_spd-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "gr-cfg_z",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Z",
              font: "font_inter_10_bold",
              color: VETheme.color.textFocus,
              enable: { key: "gr-cfg_use-z" },
            },
            field: {
              store: { key: "gr-cfg_z" },
              enable: { key: "gr-cfg_use-z" },
            },
            decrease: { 
              store: { key: "gr-cfg_z" },
              enable: { key: "gr-cfg_use-z" },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_z" },
              enable: { key: "gr-cfg_use-z" },
              factor: 1.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-cfg_use-z" },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-cfg_use-z" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-cfg_change-z" },
            },
            field: {
              store: { key: "gr-cfg_z" },
              enable: { key: "gr-cfg_change-z" },
            },
            decrease: { 
              store: { key: "gr-cfg_z" },
              enable: { key: "gr-cfg_change-z" },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_z" },
              enable: { key: "gr-cfg_change-z" },
              factor: 1.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-cfg_change-z" },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-cfg_change-z" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-cfg_change-z" },
            },
            field: {
              store: { key: "gr-cfg_z" },
              enable: { key: "gr-cfg_change-z" },
            },
            decrease: { 
              store: { key: "gr-cfg_z" },
              enable: { key: "gr-cfg_change-z" },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_z" },
              enable: { key: "gr-cfg_change-z" },
              factor: 1.0,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-cfg_change-z" },
            },
            field: {
              store: { key: "gr-cfg_z" },
              enable: { key: "gr-cfg_change-z" },
            },
            decrease: { 
              store: { key: "gr-cfg_z" },
              enable: { key: "gr-cfg_change-z" },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_z" },
              enable: { key: "gr-cfg_change-z" },
              factor: 1.0,
            },
          },
        },
      },
      {
        name: "gr-cfg_z-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "gr-cfg_grid-use-blend",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Grid blend mode",
            backgroundColor: VETheme.color.accentShadow,
            enable: { key: "gr-cfg_grid-use-blend" },
          },
          input: {
            backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "gr-cfg_grid-use-blend" },
            backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "gr-cfg_grid-blend-src",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Source",
            enable: { key: "gr-cfg_grid-use-blend" },
          },
          previous: {
            store: { key: "gr-cfg_grid-blend-src" },
            enable: { key: "gr-cfg_grid-use-blend" },
          },
          preview: Struct.appendRecursive({ 
            store: { key: "gr-cfg_grid-blend-src" },
            enable: { key: "gr-cfg_grid-use-blend" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: { 
            store: { key: "gr-cfg_grid-blend-src" },
            enable: { key: "gr-cfg_grid-use-blend" },
          },
        },
      },
      {
        name: "gr-cfg_grid-blend-dest",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Target",
            enable: { key: "gr-cfg_grid-use-blend" },
          },
          previous: {
            store: { key: "gr-cfg_grid-blend-dest" },
            enable: { key: "gr-cfg_grid-use-blend" },
          },
          preview: Struct.appendRecursive({ 
            store: { key: "gr-cfg_grid-blend-dest" },
            enable: { key: "gr-cfg_grid-use-blend" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: { 
            store: { key: "gr-cfg_grid-blend-dest" },
            enable: { key: "gr-cfg_grid-use-blend" },
          },
        },
      },
      {
        name: "gr-cfg_grid-blend-eq",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Equation",
            enable: { key: "gr-cfg_grid-use-blend" },
          },
          previous: {
            store: { key: "gr-cfg_grid-blend-eq" },
            enable: { key: "gr-cfg_grid-use-blend" },
          },
          preview: Struct.appendRecursive({ 
            store: { key: "gr-cfg_grid-blend-eq" },
            enable: { key: "gr-cfg_grid-use-blend" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: {
            store: { key: "gr-cfg_grid-blend-eq" },
            enable: { key: "gr-cfg_grid-use-blend" },
          },
        },
      },
      {
        name: "gr-cfg_grid-blend-eq-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "en-cfg_cls-frame-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Clear grid frame",
            backgroundColor: VETheme.color.accentShadow,
            enable: { key: "gr-cfg_use-cls-frame" },
          },
          checkbox: {
            backgroundColor: VETheme.color.accentShadow,
            store: { key: "gr-cfg_use-cls-frame" },
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
          },
          input: {
            backgroundColor: VETheme.color.accentShadow,
            store: { key: "gr-cfg_cls-frame" },
            enable: { key: "gr-cfg_use-cls-frame" },
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
          },
        },
      },
      {
        name: "gr-cfg_cls-frame-alpha",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Alpha",
              font: "font_inter_10_bold",
              color: VETheme.color.textFocus,
              enable: { key: "gr-cfg_use-cls-frame-alpha" },
            },
            field: {
              store: { key: "gr-cfg_cls-frame-alpha" },
              enable: { key: "gr-cfg_use-cls-frame-alpha" },
            },
            decrease: { 
              store: { key: "gr-cfg_cls-frame-alpha" },
              enable: { key: "gr-cfg_use-cls-frame-alpha" },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_cls-frame-alpha" },
              enable: { key: "gr-cfg_use-cls-frame-alpha" },
              factor: 1.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-cfg_use-cls-frame-alpha" },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-cfg_use-cls-frame-alpha" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-cfg_change-cls-frame-alpha" },
            },
            field: {
              store: { key: "gr-cfg_cls-frame-alpha" },
              enable: { key: "gr-cfg_change-cls-frame-alpha" },
            },
            decrease: { 
              store: { key: "gr-cfg_cls-frame-alpha" },
              enable: { key: "gr-cfg_change-cls-frame-alpha"},
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_cls-frame-alpha" },
              enable: { key: "gr-cfg_change-cls-frame-alpha" },
              factor: 1.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-cfg_change-cls-frame-alpha" },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-cfg_change-cls-frame-alpha" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-cfg_change-cls-frame-alpha" },
            },
            field: {
              store: { key: "gr-cfg_cls-frame-alpha" },
              enable: { key: "gr-cfg_change-cls-frame-alpha" },
            },
            decrease: { 
              store: { key: "gr-cfg_cls-frame-alpha" },
              enable: { key: "gr-cfg_change-cls-frame-alpha" },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_cls-frame-alpha" },
              enable: { key: "gr-cfg_change-cls-frame-alpha" },
              factor: 1.0,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-cfg_change-cls-frame-alpha" },
            },
            field: {
              store: { key: "gr-cfg_cls-frame-alpha" },
              enable: { key: "gr-cfg_change-cls-frame-alpha" },
            },
            decrease: { 
              store: { key: "gr-cfg_cls-frame-alpha" },
              enable: { key: "gr-cfg_change-cls-frame-alpha" },
              factor: 0.001,
            },
            increase: { 
              store: { key: "gr-cfg_cls-frame-alpha" },
              enable: { key: "gr-cfg_change-cls-frame-alpha"} ,
              factor: 0.001,
            },
          },
        },
      },
      {
        name: "gr-cfg_cls-frame-col",
        template: VEComponents.get("color-picker"),
        layout: VELayouts.get("color-picker"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          title: { 
            label: {
              text: "Color",
              enable: { key: "gr-cfg_use-cls-frame-col" },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-cfg_use-cls-frame-col" },
            },
            input: { 
              store: { key: "gr-cfg_cls-frame-col" },
              enable: { key: "gr-cfg_use-cls-frame-col" },
            }
          },
          red: {
            label: {
              text: "Red",
              enable: { key: "gr-cfg_use-cls-frame-col" },
            },
            field: {
              store: { key: "gr-cfg_cls-frame-col" },
              enable: { key: "gr-cfg_use-cls-frame-col" },
            },
            slider: {
              store: { key: "gr-cfg_cls-frame-col" },
              enable: { key: "gr-cfg_use-cls-frame-col" },
            },
          },
          green: {
            label: {
              text: "Green",
              enable: { key: "gr-cfg_use-cls-frame-col" },
            },
            field: {
              store: { key: "gr-cfg_cls-frame-col" },
              enable: { key: "gr-cfg_use-cls-frame-col" },
            },
            slider: {
              store: { key: "gr-cfg_cls-frame-col" },
              enable: { key: "gr-cfg_use-cls-frame-col" },
            },
          },
          blue: {
            label: {
              text: "Blue",
              enable: { key: "gr-cfg_use-cls-frame-col" },
            },
            field: {
              store: { key: "gr-cfg_cls-frame-col" },
              enable: { key: "gr-cfg_use-cls-frame-col" },
            },
            slider: {
              store: { key: "gr-cfg_cls-frame-col" },
              enable: { key: "gr-cfg_use-cls-frame-col" },
            },
          },
          hex: { 
            label: {
              text: "Hex",
              enable: { key: "gr-cfg_use-cls-frame-col" },
            },
            field: {
              store: { key: "gr-cfg_cls-frame-col" },
              enable: { key: "gr-cfg_use-cls-frame-col" },
            },
          },
        },
      },
      {
        name: "gr-cfg_cls-frame-col-spd",
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Speed",
            enable: { key: "gr-cfg_use-cls-frame-col" },
          },  
          field: { 
            store: { key: "gr-cfg_cls-frame-col-spd" },
            enable: { key: "gr-cfg_use-cls-frame-col" },
          },
          slider: {
            store: { key: "gr-cfg_cls-frame-col-spd" },
            enable: { key: "gr-cfg_use-cls-frame-col" },
            minValue: 0.0,
            maxValue: 1.0,
            snapValue: 0.01 / 1.0,
          },
          decrease: {
            store: { key: "gr-cfg_cls-frame-col-spd" },
            enable: { key: "gr-cfg_use-cls-frame-col" },
            factor: -0.001,
          },
          increase: {
            store: { key: "gr-cfg_cls-frame-col-spd" },
            enable: { key: "gr-cfg_use-cls-frame-col" },
            factor: 0.001,
          },
        },
      },
      {
        name: "gr-cfg_cls-frame-col-spd-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "gr-cfg_render-focus-grid",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Render focus grid",
            enable: { key: "gr-cfg_use-render-focus-grid" },
            backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "gr-cfg_use-render-focus-grid" },
            backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "gr-cfg_render-focus-grid" },
            enable: { key: "gr-cfg_use-render-focus-grid" },
            backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "gr-cfg_render-focus-grid-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "gr-cfg_focus-grid-treshold",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Treshold",
              font: "font_inter_10_bold",
              color: VETheme.color.textFocus,
              enable: { key: "gr-cfg_use-focus-grid-treshold" },
            },
            field: {
              store: { key: "gr-cfg_focus-grid-treshold" },
              enable: { key: "gr-cfg_use-focus-grid-treshold" },
            },
            decrease: { 
              store: { key: "gr-cfg_focus-grid-treshold" },
              enable: { key: "gr-cfg_use-focus-grid-treshold" },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_focus-grid-treshold" },
              enable: { key: "gr-cfg_use-focus-grid-treshold" },
              factor: 1.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-cfg_use-focus-grid-treshold" },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-cfg_use-focus-grid-treshold" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-cfg_change-focus-grid-treshold" },
            },
            field: {
              store: { key: "gr-cfg_focus-grid-treshold" },
              enable: { key: "gr-cfg_change-focus-grid-treshold" },
            },
            decrease: { 
              store: { key: "gr-cfg_focus-grid-treshold" },
              enable: { key: "gr-cfg_change-focus-grid-treshold" },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_focus-grid-treshold" },
              enable: { key: "gr-cfg_change-focus-grid-treshold" },
              factor: 1.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-cfg_change-focus-grid-treshold" },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-cfg_change-focus-grid-treshold" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-cfg_change-focus-grid-treshold" },
            },
            field: {
              store: { key: "gr-cfg_focus-grid-treshold" },
              enable: { key: "gr-cfg_change-focus-grid-treshold" },
            },
            decrease: { 
              store: { key: "gr-cfg_focus-grid-treshold" },
              enable: { key: "gr-cfg_change-focus-grid-treshold" },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_focus-grid-treshold" },
              enable: { key: "gr-cfg_change-focus-grid-treshold" },
              factor: 1.0,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-cfg_change-focus-grid-treshold" },
            },
            field: {
              store: { key: "gr-cfg_focus-grid-treshold" },
              enable: { key: "gr-cfg_change-focus-grid-treshold" },
            },
            decrease: { 
              store: { key: "gr-cfg_focus-grid-treshold" },
              enable: { key: "gr-cfg_change-focus-grid-treshold" },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_focus-grid-treshold" },
              enable: { key: "gr-cfg_change-focus-grid-treshold" },
              factor: 1.0,
            },
          },
        },
      },
      {
        name: "gr-cfg_focus-grid-treshold-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "gr-cfg_focus-grid-alpha",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Alpha",
              font: "font_inter_10_bold",
              color: VETheme.color.textFocus,
              enable: { key: "gr-cfg_use-focus-grid-alpha" },
            },
            field: {
              store: { key: "gr-cfg_focus-grid-alpha" },
              enable: { key: "gr-cfg_use-focus-grid-alpha" },
            },
            decrease: { 
              store: { key: "gr-cfg_focus-grid-alpha" },
              enable: { key: "gr-cfg_use-focus-grid-alpha" },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_focus-grid-alpha" },
              enable: { key: "gr-cfg_use-focus-grid-alpha" },
              factor: 1.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-cfg_use-focus-grid-alpha" },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-cfg_use-focus-grid-alpha" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-cfg_change-focus-grid-alpha" },
            },
            field: {
              store: { key: "gr-cfg_focus-grid-alpha" },
              enable: { key: "gr-cfg_change-focus-grid-alpha" },
            },
            decrease: { 
              store: { key: "gr-cfg_focus-grid-alpha" },
              enable: { key: "gr-cfg_change-focus-grid-alpha" },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_focus-grid-alpha" },
              enable: { key: "gr-cfg_change-focus-grid-alpha" },
              factor: 1.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-cfg_change-focus-grid-alpha" },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-cfg_change-focus-grid-alpha" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-cfg_change-focus-grid-alpha" },
            },
            field: {
              store: { key: "gr-cfg_focus-grid-alpha" },
              enable: { key: "gr-cfg_change-focus-grid-alpha" },
            },
            decrease: { 
              store: { key: "gr-cfg_focus-grid-alpha" },
              enable: { key: "gr-cfg_change-focus-grid-alpha" },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_focus-grid-alpha" },
              enable: { key: "gr-cfg_change-focus-grid-alpha" },
              factor: 1.0,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-cfg_change-focus-grid-alpha" },
            },
            field: {
              store: { key: "gr-cfg_focus-grid-alpha" },
              enable: { key: "gr-cfg_change-focus-grid-alpha" },
            },
            decrease: { 
              store: { key: "gr-cfg_focus-grid-alpha" },
              enable: { key: "gr-cfg_change-focus-grid-alpha" },
              factor: -1.0,
            },
            increase: { 
              store: { key: "gr-cfg_focus-grid-alpha" },
              enable: { key: "gr-cfg_change-focus-grid-alpha" },
              factor: 1.0,
            },
          },
        },
      },
      {
        name: "gr-cfg_focus-grid-alpha-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "gr-cfg_focus-grid-use-blend",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Focus grid blend mode",
            backgroundColor: VETheme.color.accentShadow,
            enable: { key: "gr-cfg_focus-grid-use-blend" },
          },
          input: { backgroundColor: VETheme.color.accentShadow },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "gr-cfg_focus-grid-use-blend" },
            backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "gr-cfg_focus-grid-blend-src",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Source",
            enable: { key: "gr-cfg_focus-grid-use-blend" },
          },
          previous: {
            store: { key: "gr-cfg_focus-grid-blend-src" },
            enable: { key: "gr-cfg_focus-grid-use-blend" },
          },
          preview: Struct.appendRecursive({ 
            store: { key: "gr-cfg_focus-grid-blend-src" },
            enable: { key: "gr-cfg_focus-grid-use-blend" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: { 
            store: { key: "gr-cfg_focus-grid-blend-src" },
            enable: { key: "gr-cfg_focus-grid-use-blend" },
          },
        },
      },
      {
        name: "gr-cfg_focus-grid-blend-dest",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Target",
            enable: { key: "gr-cfg_focus-grid-use-blend" },
          },
          previous: {
            store: { key: "gr-cfg_focus-grid-blend-dest" },
            enable: { key: "gr-cfg_focus-grid-use-blend" },
          },
          preview: Struct.appendRecursive({ 
            store: { key: "gr-cfg_focus-grid-blend-dest" },
            enable: { key: "gr-cfg_focus-grid-use-blend" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: { 
            store: { key: "gr-cfg_focus-grid-blend-dest" },
            enable: { key: "gr-cfg_focus-grid-use-blend" },
          },
        },
      },
      {
        name: "gr-cfg_focus-grid-blend-eq",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Equation",
            enable: { key: "gr-cfg_focus-grid-use-blend" },
          },
          previous: {
            store: { key: "gr-cfg_focus-grid-blend-eq" },
            enable: { key: "gr-cfg_focus-grid-use-blend" },
          },
          preview: Struct.appendRecursive({ 
            store: { key: "gr-cfg_focus-grid-blend-eq" },
            enable: { key: "gr-cfg_focus-grid-use-blend" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: {
            store: { key: "gr-cfg_focus-grid-blend-eq" },
            enable: { key: "gr-cfg_focus-grid-use-blend" },
          },
        },
      }
    ]),
  }
    
}