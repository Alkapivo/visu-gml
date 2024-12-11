///@package io.alkapivo.visu.editor.service.brush.grid

///@param {?Struct} [json]
///@return {Struct}
function brush_grid_column(json = null) {
  return {
    name: "brush_grid_column",
    store: new Map(String, Struct, {
      "gr-c_use-mode": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-c_use-mode", Boolean, false),
      },
      "gr-c_mode": {
        type: String,
        value: Struct.getIfType(json, "gr-c_mode", String, "DUAL"),
        passthrough: function(value) {
          return this.data.contains(value) ? value : this.value
        },
        data: new Array(String, [ "SINGLE", "DUAL" ])
      },
      "gr-c_use-amount": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-c_use-amount", Boolean, false),
      },
      "gr-c_amount": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getIfType(json, "gr-c_amount", Struct, { 
          value: 0.0, 
          target: 4.0, 
          factor: 0.01, 
          increase: 0.0,
        })),
        passthrough: function(value) {
          if (!Core.isType(value, NumberTransformer)) {
            return this.value
          }

          value.value = clamp(value.value, 0.0, 999.9)
          value.target = clamp(value.target, 0.0, 999.9)
          return value
        },
      },
      "gr-c_change-amount": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-c_change-amount", Boolean, false),
      },
      "gr-c_use-main-col": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-c_use-main-col", Boolean, false),
      },
      "gr-c_main-col": {
        type: Color,
        value: ColorUtil.fromHex(Struct.get(json, "gr-c_main-col"), ColorUtil.fromHex("#ffffff")),
      },
      "gr-c_use-main-col-spd": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-c_use-main-col-spd", Boolean, false),
      },
      "gr-c_main-col-spd": {
        type: Number,
        value: Struct.getIfType(json, "gr-c_main-col-spd", Number, 0.01),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.000001, 1.0) 
        },
      },
      "gr-c_use-main-alpha": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-c_use-main-alpha", Boolean, false),
      },
      "gr-c_main-alpha": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getIfType(json, "gr-c_main-alpha", Struct, { 
          value: 0.0, 
          target: 1.0, 
          factor: 0.001, 
          increase: 0.0,
        })),
        passthrough: function(value) {
          if (!Core.isType(value, NumberTransformer)) {
            return this.value
          }

          value.value = clamp(value.value, 0.0, 1.0)
          value.target = clamp(value.target, 0.0, 1.0)
          return value
        },
      },
      "gr-c_change-main-alpha": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-c_change-main-alpha", Boolean, false),
      },
      "gr-c_use-main-size": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-c_use-main-size", Boolean, false),
      },
      "gr-c_main-size": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getIfType(json, "gr-c_main-size", Struct, { 
          value: 0.0, 
          target: 5.0, 
          factor: 0.01, 
          increase: 0.0,
        })),
        passthrough: function(value) {
          if (!Core.isType(value, NumberTransformer)) {
            return this.value
          }

          value.value = clamp(value.value, 0.0, 9999.9)
          value.target = clamp(value.target, 0.0, 9999.9)
          return value
        },
      },
      "gr-c_change-main-size": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-c_change-main-size", Boolean, false),
      },
      "gr-c_use-side-col": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-c_use-side-col", Boolean, false),
      },
      "gr-c_side-col": {
        type: Color,
        value: ColorUtil.fromHex(Struct.get(json, "gr-c_side-col"), ColorUtil.fromHex("#ffffff")),
      },
      "gr-c_use-side-col-spd": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-c_use-side-col-spd", Boolean, false),
      },
      "gr-c_side-col-spd": {
        type: Number,
        value: Struct.getIfType(json, "gr-c_side-col-spd", Number, 0.01),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.000001, 1.0) 
        },
      },
      "gr-c_use-side-alpha": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-c_use-side-alpha", Boolean, false),
      },
      "gr-c_side-alpha": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getIfType(json, "gr-c_side-alpha", Struct, { 
          value: 0.0, 
          target: 1.0, 
          factor: 0.001, 
          increase: 0.0,
        })),
        passthrough: function(value) {
          if (!Core.isType(value, NumberTransformer)) {
            return this.value
          }

          value.value = clamp(value.value, 0.0, 1.0)
          value.target = clamp(value.target, 0.0, 1.0)
          return value
        },
      },
      "gr-c_change-side-alpha": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-c_change-side-alpha", Boolean, false),
      },
      "gr-c_use-side-size": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-c_use-side-size", Boolean, false),
      },
      "gr-c_side-size": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getIfType(json, "gr-c_side-size", Struct, { 
          value: 0.0, 
          target: 5.0, 
          factor: 0.01, 
          increase: 0.0,
        })),
        passthrough: function(value) {
          if (!Core.isType(value, NumberTransformer)) {
            return this.value
          }

          value.value = clamp(value.value, 0.0, 9999.9)
          value.target = clamp(value.target, 0.0, 9999.9)
          return value
        },
      },
      "gr-c_change-side-size": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-c_change-side-size", Boolean, false),
      },
    }),
    components: new Array(Struct, [
      {
        name: "gr-c_use-mode",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Column render mode",
            enable: { key: "gr-c_use-mode" },
            backgroundColor: VETheme.color.accentShadow,
          },
          input: { backgroundColor: VETheme.color.accentShadow },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "gr-c_use-mode" },
            backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "gr-c_mode",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Mode",
            enable: { key: "gr-c_use-mode" },
          },
          previous: { 
            enable: { key: "gr-c_use-mode" },
            store: { key: "gr-c_mode" },
          },
          preview: Struct.appendRecursive({ 
            enable: { key: "gr-c_use-mode" },
            store: { key: "gr-c_mode" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: { 
            enable: { key: "gr-c_use-mode" },
            store: { key: "gr-c_mode" },
          },
        },
      },
      {
        name: "gr-c_mode-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "gr-c_amount",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Amount",
              font: "font_inter_10_bold",
              color: VETheme.color.textFocus,
              enable: { key: "gr-c_use-amount" },
            },
            field: {
              store: { key: "gr-c_amount" },
              enable: { key: "gr-c_use-amount" },
            },
            decrease: {
              store: { key: "gr-c_amount" },
              enable: { key: "gr-c_use-amount" },
              factor: -0.25,
            },
            increase: {
              store: { key: "gr-c_amount" },
              enable: { key: "gr-c_use-amount" },
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-c_use-amount" },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-c_use-amount" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-c_change-amount" },
            },
            field: {
              store: { key: "gr-c_amount" },
              enable: { key: "gr-c_change-amount" },
            },
            decrease: {
              store: { key: "gr-c_amount" },
              enable: { key: "gr-c_change-amount" },
              factor: -0.25,
            },
            increase: {
              store: { key: "gr-c_amount" },
              enable: { key: "gr-c_change-amount" },
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-c_change-amount" },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-c_change-amount" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-c_change-amount" },
            },
            field: {
              store: { key: "gr-c_amount" },
              enable: { key: "gr-c_change-amount" },
            },
            decrease: {
              store: { key: "gr-c_amount" },
              enable: { key: "gr-c_change-amount" },
              factor: -0.01,
            },
            increase: {
              store: { key: "gr-c_amount" },
              enable: { key: "gr-c_change-amount" },            
              factor: 0.01,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-c_change-amount" },
            },
            field: {
              store: { key: "gr-c_amount" },
              enable: { key: "gr-c_change-amount" },
            },
            decrease: {
              store: { key: "gr-c_amount" },
              enable: { key: "gr-c_change-amount" },
              factor: -0.001,
            },
            increase: {
              store: { key: "gr-c_amount" },
              enable: { key: "gr-c_change-amount" },            
              factor: 0.001,
            },
          },
        },
      },
      {
        name: "gr-c_amount-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "gr-c_main-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Main columns",
            backgroundColor: VETheme.color.accentShadow,
          },
          input: { backgroundColor: VETheme.color.accentShadow },
          checkbox: { backgroundColor: VETheme.color.accentShadow },
        },
      },
      {
        name: "gr-c_main-size",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Thickness",
              font: "font_inter_10_bold",
              color: VETheme.color.textFocus,
              enable: { key: "gr-c_use-main-size" },
            },
            field: {
              store: { key: "gr-c_main-size" },
              enable: { key: "gr-c_use-main-size" },
            },
            decrease: {
              store: { key: "gr-c_main-size" },
              enable: { key: "gr-c_use-main-size" },
              value: -0.25,
            },
            increase: {
              store: { key: "gr-c_main-size" },
              enable: { key: "gr-c_use-main-size" },
              value: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-c_use-main-size" },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-c_use-main-size" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-c_change-main-size" },
            },
            field: {
              store: { key: "gr-c_main-size" },
              enable: { key: "gr-c_change-main-size" },
            },
            decrease: {
              store: { key: "gr-c_main-size" },
              enable: { key: "gr-c_change-main-size" },
              value: -0.25,
            },
            increase: {
              store: { key: "gr-c_main-size" },
              enable: { key: "gr-c_change-main-size" },
              value: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-c_change-main-size" },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-c_change-main-size" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-c_change-main-size" },
            },
            field: {
              store: { key: "gr-c_main-size" },
              enable: { key: "gr-c_change-main-size" },
            },
            decrease: {
              store: { key: "gr-c_main-size" },
              enable: { key: "gr-c_change-main-size" },
              value: -0.01,
            },
            increase: {
              store: { key: "gr-c_main-size" },
              enable: { key: "gr-c_change-main-size" },
              value: 0.01,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-c_change-main-size" },
            },
            field: {
              store: { key: "gr-c_main-size" },
              enable: { key: "gr-c_change-main-size" },
            },
            decrease: {
              store: { key: "gr-c_main-size" },
              enable: { key: "gr-c_change-main-size" },
              value: -0.001,
            },
            increase: {
              store: { key: "gr-c_main-size" },
              enable: { key: "gr-c_change-main-size" },
              value: 0.001,
            },
          },
        },
      },
      {
        name: "gr-c_main-size-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "gr-c_main-alpha",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Alpha",
              font: "font_inter_10_bold",
              color: VETheme.color.textFocus,
              enable: { key: "gr-c_use-main-alpha" },
            },
            field: {
              store: { key: "gr-c_main-alpha" },
              enable: { key: "gr-c_use-main-alpha" },
            },
            decrease: {
              store: { key: "gr-c_main-alpha" },
              enable: { key: "gr-c_use-main-alpha" },
              factor: -0.01,
            },
            increase: {
              store: { key: "gr-c_main-alpha" },
              enable: { key: "gr-c_use-main-alpha" },
              factor: 0.01,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-c_use-main-alpha" },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-c_use-main-alpha" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-c_change-main-alpha" },
            },
            field: {
              store: { key: "gr-c_main-alpha" },
              enable: { key: "gr-c_change-main-alpha" },
            },
            decrease: {
              store: { key: "gr-c_main-alpha" },
              enable: { key: "gr-c_change-main-alpha" },
              factor: -0.01,
            },
            increase: {
              store: { key: "gr-c_main-alpha" },
              enable: { key: "gr-c_change-main-alpha" },
              factor: 0.01,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-c_change-main-alpha" },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-c_change-main-alpha" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-c_change-main-alpha" },
            },
            field: {
              store: { key: "gr-c_main-alpha" },
              enable: { key: "gr-c_change-main-alpha" },
            },
            decrease: {
              store: { key: "gr-c_main-alpha" },
              enable: { key: "gr-c_change-main-alpha" },
              factor: -0.001,
            },
            increase: {
              store: { key: "gr-c_main-alpha" },
              enable: { key: "gr-c_change-main-alpha" },
              factor: 0.001,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-c_change-main-alpha" },
            },
            field: {
              store: { key: "gr-c_main-alpha" },
              enable: { key: "gr-c_change-main-alpha" },
            },
            decrease: {
              store: { key: "gr-c_main-alpha" },
              enable: { key: "gr-c_change-main-alpha" },
              factor: -0.0001,
            },
            increase: {
              store: { key: "gr-c_main-alpha" },
              enable: { key: "gr-c_change-main-alpha" },
              factor: 0.0001,
            },
          },
        },
      },
      {
        name: "gr-c_main-col",
        template: VEComponents.get("color-picker"),
        layout: VELayouts.get("color-picker"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          title: { 
            label: {
              text: "Color",
              enable: { key: "gr-c_use-main-col" },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-c_use-main-col" },
            },
            input: { 
              store: { key: "gr-c_main-col" },
              enable: { key: "gr-c_use-main-col" },
            }
          },
          red: {
            label: {
              text: "Red",
              enable: { key: "gr-c_use-main-col" },
            },
            field: {
              store: { key: "gr-c_main-col" },
              enable: { key: "gr-c_use-main-col" },
            },
            slider: {
              store: { key: "gr-c_main-col" },
              enable: { key: "gr-c_use-main-col" },
            },
          },
          green: {
            label: {
              text: "Green",
              enable: { key: "gr-c_use-main-col" },
            },
            field: {
              store: { key: "gr-c_main-col" },
              enable: { key: "gr-c_use-main-col" },
            },
            slider: {
              store: { key: "gr-c_main-col" },
              enable: { key: "gr-c_use-main-col" },
            },
          },
          blue: {
            label: {
              text: "Blue",
              enable: { key: "gr-c_use-main-col" },
            },
            field: {
              store: { key: "gr-c_main-col" },
              enable: { key: "gr-c_use-main-col" },
            },
            slider: {
              store: { key: "gr-c_main-col" },
              enable: { key: "gr-c_use-main-col" },
            },
          },
          hex: { 
            label: {
              text: "Hex",
              enable: { key: "gr-c_use-main-col" },
            },
            field: {
              store: { key: "gr-c_main-col" },
              enable: { key: "gr-c_use-main-col" },
            },
          },
        },
      },
      {
        name: "gr-c_main-col-spd",
        template: VEComponents.get("text-field-increase-checkbox"),
        layout: VELayouts.get("text-field-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Speed",
            enable: { key: "gr-c_use-main-col-spd" },
          },  
          field: { 
            store: { key: "gr-c_main-col-spd" },
            enable: { key: "gr-c_use-main-col-spd" },
          },
          decrease: {
            store: { key: "gr-c_main-col-spd" },
            enable: { key: "gr-c_use-main-col-spd" },
            factor: -0.001,
          },
          increase: {
            store: { key: "gr-c_main-col-spd" },
            enable: { key: "gr-c_use-main-col-spd" },
            factor: 0.001,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "gr-c_use-main-col-spd" },
          },
          title: { 
            text: "Enable",
            enable: { key: "gr-c_use-main-col-spd" },
          },
        },
      },
      {
        name: "gr-c_main-col-spd-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "gr-c_side-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Side columns",
            backgroundColor: VETheme.color.accentShadow,
          },
          input: { backgroundColor: VETheme.color.accentShadow },
          checkbox: { backgroundColor: VETheme.color.accentShadow },
        },
      },
      {
        name: "gr-c_side-size",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Thickness",
              font: "font_inter_10_bold",
              color: VETheme.color.textFocus,
              enable: { key: "gr-c_use-side-size" },
            },
            field: {
              store: { key: "gr-c_side-size" },
              enable: { key: "gr-c_use-side-size" },
            },
            decrease: {
              store: { key: "gr-c_side-size" },
              enable: { key: "gr-c_use-side-size" },
              factor: -0.25,
            },
            increase: {
              store: { key: "gr-c_side-size" },
              enable: { key: "gr-c_use-side-size" },
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-c_use-side-size" },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-c_use-side-size" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-c_change-side-size" },
            },
            field: {
              store: { key: "gr-c_side-size" },
              enable: { key: "gr-c_change-side-size" },
            },
            decrease: {
              store: { key: "gr-c_side-size" },
              enable: { key: "gr-c_change-side-size" },
              factor: -0.25,
            },
            increase: {
              store: { key: "gr-c_side-size" },
              enable: { key: "gr-c_change-side-size" },
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-c_change-side-size" },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-c_change-side-size" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-c_change-side-size" },
            },
            field: {
              store: { key: "gr-c_side-size" },
              enable: { key: "gr-c_change-side-size" },
            },
            decrease: {
              store: { key: "gr-c_side-size" },
              enable: { key: "gr-c_change-side-size" },
              factor: -0.01,
            },
            increase: {
              store: { key: "gr-c_side-size" },
              enable: { key: "gr-c_change-side-size" },
              factor: 0.01,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-c_change-side-size" },
            },
            field: {
              store: { key: "gr-c_side-size" },
              enable: { key: "gr-c_change-side-size" },
            },
            decrease: {
              store: { key: "gr-c_side-size" },
              enable: { key: "gr-c_change-side-size" },
              factor: -0.001,
            },
            increase: {
              store: { key: "gr-c_side-size" },
              enable: { key: "gr-c_change-side-size" },
              factor: 0.001,
            },
          },
        },
      },
      {
        name: "gr-c_side-size-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "gr-c_side-alpha",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Alpha",
              font: "font_inter_10_bold",
              color: VETheme.color.textFocus,
              enable: { key: "gr-c_use-side-alpha" },
            },
            field: {
              store: { key: "gr-c_side-alpha" },
              enable: { key: "gr-c_use-side-alpha" },
            },
            decrease: {
              store: { key: "gr-c_side-alpha" },
              enable: { key: "gr-c_use-side-alpha" },
              factor: -0.01,
            },
            increase: {
              store: { key: "gr-c_side-alpha" },
              enable: { key: "gr-c_use-side-alpha" },
              factor: 0.01,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-c_use-side-alpha" },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-c_use-side-alpha" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-c_change-side-alpha" },
            },
            field: {
              store: { key: "gr-c_side-alpha" },
              enable: { key: "gr-c_change-side-alpha" },
            },
            decrease: {
              store: { key: "gr-c_side-alpha" },
              enable: { key: "gr-c_change-side-alpha" },
              factor: -0.01,
            },
            increase: {
              store: { key: "gr-c_side-alpha" },
              enable: { key: "gr-c_change-side-alpha" }, 
              factor: 0.01,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-c_change-side-alpha" },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-c_change-side-alpha" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-c_change-side-alpha" },
            },
            field: {
              store: { key: "gr-c_side-alpha" },
              enable: { key: "gr-c_change-side-alpha" },
            },
            decrease: {
              store: { key: "gr-c_side-alpha" },
              enable: { key: "gr-c_change-side-alpha" },
              factor: -0.001,
            },
            increase: {
              store: { key: "gr-c_side-alpha" },
              enable: { key: "gr-c_change-side-alpha" }, 
              factor: 0.001,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-c_change-side-alpha" },
            },
            field: {
              store: { key: "gr-c_side-alpha" },
              enable: { key: "gr-c_change-side-alpha" },
            },
            decrease: {
              store: { key: "gr-c_side-alpha" },
              enable: { key: "gr-c_change-side-alpha" },
              factor: -0.0001,
            },
            increase: {
              store: { key: "gr-c_side-alpha" },
              enable: { key: "gr-c_change-side-alpha" }, 
              factor: 0.0001,
            },
          },
        },
      },
      {
        name: "gr-c_side-col",
        template: VEComponents.get("color-picker"),
        layout: VELayouts.get("color-picker"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          title: { 
            label: {
              text: "Color",
              enable: { key: "gr-c_use-side-col" },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-c_use-side-col" },
            },
            input: {
              store: { key: "gr-c_side-col" },
              enable: { key: "gr-c_use-side-col" },
            }
          },
          red: {
            label: {
              text: "Red",
              enable: { key: "gr-c_use-side-col" },
            },
            field: {
              store: { key: "gr-c_side-col" },
              enable: { key: "gr-c_use-side-col" },
            },
            slider: {
              store: { key: "gr-c_side-col" },
              enable: { key: "gr-c_use-side-col" },
            },
          },
          green: {
            label: {
              text: "Green",
              enable: { key: "gr-c_use-side-col" },
            },
            field: {
              store: { key: "gr-c_side-col" },
              enable: { key: "gr-c_use-side-col" },
            },
            slider: {
              store: { key: "gr-c_side-col" },
              enable: { key: "gr-c_use-side-col" },
            },
          },
          blue: {
            label: {
              text: "Blue",
              enable: { key: "gr-c_use-side-col" },
            },
            field: {
              store: { key: "gr-c_side-col" },
              enable: { key: "gr-c_use-side-col" },
            },
            slider: {
              store: { key: "gr-c_side-col" },
              enable: { key: "gr-c_use-side-col" },
            },
          },
          hex: { 
            label: {
              text: "Hex",
              enable: { key: "gr-c_use-side-col" },
            },
            field: {
              store: { key: "gr-c_side-col" },
              enable: { key: "gr-c_use-side-col" },
            },
          },
        },
      },
      {
        name: "gr-c_side-col-spd",
        template: VEComponents.get("text-field-increase-checkbox"),
        layout: VELayouts.get("text-field-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Speed",
            enable: { key: "gr-c_use-side-col-spd" },
          },  
          field: { 
            store: { key: "gr-c_side-col-spd" },
            enable: { key: "gr-c_use-side-col-spd" },
          },
          decrease: {
            store: { key: "gr-c_side-col-spd" },
            enable: { key: "gr-c_use-side-col-spd" },
            factor: -0.001,
          },
          increase: {
            store: { key: "gr-c_side-col-spd" },
            enable: { key: "gr-c_use-side-col-spd" },
            factor: 0.001,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "gr-c_use-side-col-spd" },
          },
          title: { 
            text: "Enable",
            enable: { key: "gr-c_use-side-col-spd" },
          },
        },
      },
    ]),
  }
}