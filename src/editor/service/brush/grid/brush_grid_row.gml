///@package io.alkapivo.visu.editor.service.brush.grid

///@param {?Struct} [json]
///@return {Struct}
function brush_grid_row(json = null) {
  return {
    name: "brush_grid_row",
    store: new Map(String, Struct, {
      "gr-r_use-mode": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-r_use-mode", Boolean, false),
      },
      "gr-r_mode": {
        type: String,
        value: Struct.getIfType(json, "gr-r_mode", String, "DUAL"),
        passthrough: function(value) {
          return this.data.contains(value) ? value : this.value
        },
        data: new Array(String, [ "SINGLE", "DUAL" ])
      },
      "gr-r_use-amount": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-r_use-amount", Boolean, false),
      },
      "gr-r_amount": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getIfType(json, "gr-r_amount", Struct, { 
          value: 0, 
          target: 1, 
          factor: 0.01, 
          increase: 0,
        })),
      },
      "gr-r_change-amount": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-r_change-amount", Boolean, false),
      },
      "gr-r_use-main-col": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-r_use-main-col", Boolean, false),
      },
      "gr-r_main-col": {
        type: Color,
        value: ColorUtil.fromHex(Struct.get(json, "gr-r_main-col"), ColorUtil.fromHex("#ffffff")),
      },
      "gr-r_use-main-col-spd": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-r_use-main-col-spd", Boolean, false),
      },
      "gr-r_main-col-spd": {
        type: Number,
        value: Struct.getIfType(json, "gr-r_main-col-spd", Number, 0.01),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.000001, 1.0) 
        },
      },
      "gr-r_use-main-alpha": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-r_use-main-alpha", Boolean, false),
      },
      "gr-r_main-alpha": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getIfType(json, "gr-r_main-alpha", Struct, { 
          value: 0, 
          target: 1, 
          factor: 0.01, 
          increase: 0,
        })),
      },
      "gr-r_change-main-alpha": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-r_change-main-alpha", Boolean, false),
      },
      "gr-r_use-main-size": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-r_use-main-size", Boolean, false),
      },
      "gr-r_main-size": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getIfType(json, "gr-r_main-size", Struct, { 
          value: 0, 
          target: 1, 
          factor: 0.01, 
          increase: 0,
        })),
      },
      "gr-r_change-main-size": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-r_change-main-size", Boolean, false),
      },
      "gr-r_use-side-col": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-r_use-side-col", Boolean, false),
      },
      "gr-r_side-col": {
        type: Color,
        value: ColorUtil.fromHex(Struct.get(json, "gr-r_side-col"), ColorUtil.fromHex("#ffffff")),
      },
      "gr-r_use-side-col-spd": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-r_use-side-col-spd", Boolean, false),
      },
      "gr-r_side-col-spd": {
        type: Number,
        value: Struct.getIfType(json, "gr-r_side-col-spd", Number, 0.01),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.000001, 1.0) 
        },
      },
      "gr-r_use-side-alpha": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-r_use-side-alpha", Boolean, false),
      },
      "gr-r_side-alpha": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getIfType(json, "gr-r_side-alpha", Struct, { 
          value: 0, 
          target: 1, 
          factor: 0.01, 
          increase: 0,
        })),
      },
      "gr-r_change-side-alpha": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-r_change-side-alpha", Boolean, false),
      },
      "gr-r_use-side-size": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-r_use-side-size", Boolean, false),
      },
      "gr-r_side-size": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getIfType(json, "gr-r_side-size", Struct, { 
          value: 0, 
          target: 1, 
          factor: 0.01, 
          increase: 0,
        })),
      },
      "gr-r_change-side-size": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-r_change-side-size", Boolean, false),
      },
    }),
    components: new Array(Struct, [
      {
        name: "gr-r_use-mode",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Render mode",
            enable: { key: "gr-r_use-mode" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "gr-r_use-mode" },
          },
        },
      },
      {
        name: "gr-r_mode",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Mode",
            enable: { key: "gr-r_use-mode" },
          },
          previous: { 
            enable: { key: "gr-r_use-mode" },
            store: { key: "gr-r_mode" },
          },
          preview: Struct.appendRecursive({ 
            enable: { key: "gr-r_use-mode" },
            store: { key: "gr-r_mode" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: { 
            enable: { key: "gr-r_use-mode" },
            store: { key: "gr-r_mode" },
          },
        },
      },
      {
        name: "gr-r_amount-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Amount" },
        },
      },
      {
        name: "gr-r_amount",
        template: VEComponents.get("vec4-value-checkbox"),
        layout: VELayouts.get("vec4-value-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Value",
              enable: { key: "gr-r_use-amount" },
            },
            field: {
              store: { key: "gr-r_amount" },
              enable: { key: "gr-r_use-amount" },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-r_use-amount" },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-r_use-amount" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-r_change-amount" },
            },
            field: {
              store: { key: "gr-r_amount" },
              enable: { key: "gr-r_change-amount" },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-r_change-amount" },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-r_change-amount" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-r_change-amount" },
            },
            field: {
              store: { key: "gr-r_amount" },
              enable: { key: "gr-r_change-amount" },
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-r_change-amount" },
            },
            field: {
              store: { key: "gr-r_amount" },
              enable: { key: "gr-r_change-amount" },
            },
          },
        },
      },
      {
        name: "gr-r_main-col",
        template: VEComponents.get("color-picker"),
        layout: VELayouts.get("color-picker"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          title: { 
            label: {
              text: "Main color",
              enable: { key: "gr-r_use-main-col" },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-r_use-main-col" },
            },
            input: { 
              store: { key: "gr-r_main-col" },
              enable: { key: "gr-r_use-main-col" },
            }
          },
          red: {
            label: {
              text: "Red",
              enable: { key: "gr-r_use-main-col" },
            },
            field: {
              store: { key: "gr-r_main-col" },
              enable: { key: "gr-r_use-main-col" },
            },
            slider: {
              store: { key: "gr-r_main-col" },
              enable: { key: "gr-r_use-main-col" },
            },
          },
          green: {
            label: {
              text: "Green",
              enable: { key: "gr-r_use-main-col" },
            },
            field: {
              store: { key: "gr-r_main-col" },
              enable: { key: "gr-r_use-main-col" },
            },
            slider: {
              store: { key: "gr-r_main-col" },
              enable: { key: "gr-r_use-main-col" },
            },
          },
          blue: {
            label: {
              text: "Blue",
              enable: { key: "gr-r_use-main-col" },
            },
            field: {
              store: { key: "gr-r_main-col" },
              enable: { key: "gr-r_use-main-col" },
            },
            slider: {
              store: { key: "gr-r_main-col" },
              enable: { key: "gr-r_use-main-col" },
            },
          },
          hex: { 
            label: {
              text: "Hex",
              enable: { key: "gr-r_use-main-col" },
            },
            field: {
              store: { key: "gr-r_main-col" },
              enable: { key: "gr-r_use-main-col" },
            },
          },
        },
      },
      {
        name: "gr-r_main-col-spd",
        template: VEComponents.get("text-field-checkbox"),
        layout: VELayouts.get("text-field-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Speed",
            enable: { key: "gr-r_use-main-col-spd" },
          },  
          field: { 
            store: { key: "gr-r_main-col-spd" },
            enable: { key: "gr-r_use-main-col-spd" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "gr-r_use-main-col-spd" },
          },
          title: { 
            text: "Enable",
            enable: { key: "gr-r_use-main-col-spd" },
          },
        },
      },
      {
        name: "gr-r_main-alpha-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Main alpha" },
        },
      },
      {
        name: "gr-r_main-alpha",
        template: VEComponents.get("vec4-value-checkbox"),
        layout: VELayouts.get("vec4-value-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Value",
              enable: { key: "gr-r_use-main-alpha" },
            },
            field: {
              store: { key: "gr-r_main-alpha" },
              enable: { key: "gr-r_use-main-alpha" },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-r_use-main-alpha" },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-r_use-main-alpha" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-r_change-main-alpha" },
            },
            field: {
              store: { key: "gr-r_main-alpha" },
              enable: { key: "gr-r_change-main-alpha" },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-r_change-main-alpha" },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-r_change-main-alpha" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-r_change-main-alpha" },
            },
            field: {
              store: { key: "gr-r_main-alpha" },
              enable: { key: "gr-r_change-main-alpha" },
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-r_change-main-alpha" },
            },
            field: {
              store: { key: "gr-r_main-alpha" },
              enable: { key: "gr-r_change-main-alpha" },
            },
          },
        },
      },
      {
        name: "gr-r_main-size-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Main size" },
        },
      },
      {
        name: "gr-r_main-size",
        template: VEComponents.get("vec4-value-checkbox"),
        layout: VELayouts.get("vec4-value-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Value",
              enable: { key: "gr-r_use-main-size" },
            },
            field: {
              store: { key: "gr-r_main-size" },
              enable: { key: "gr-r_use-main-size" },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-r_use-main-size" },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-r_use-main-size" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-r_change-main-size" },
            },
            field: {
              store: { key: "gr-r_main-size" },
              enable: { key: "gr-r_change-main-size" },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-r_change-main-size" },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-r_change-main-size" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-r_change-main-size" },
            },
            field: {
              store: { key: "gr-r_main-size" },
              enable: { key: "gr-r_change-main-size" },
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-r_change-main-size" },
            },
            field: {
              store: { key: "gr-r_main-size" },
              enable: { key: "gr-r_change-main-size" },
            },
          },
        },
      },
      {
        name: "gr-r_side-col",
        template: VEComponents.get("color-picker"),
        layout: VELayouts.get("color-picker"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          title: { 
            label: {
              text: "Side color",
              enable: { key: "gr-r_use-side-col" },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-r_use-side-col" },
            },
            input: {
              store: { key: "gr-r_side-col" },
              enable: { key: "gr-r_use-side-col" },
            }
          },
          red: {
            label: {
              text: "Red",
              enable: { key: "gr-r_use-side-col" },
            },
            field: {
              store: { key: "gr-r_side-col" },
              enable: { key: "gr-r_use-side-col" },
            },
            slider: {
              store: { key: "gr-r_side-col" },
              enable: { key: "gr-r_use-side-col" },
            },
          },
          green: {
            label: {
              text: "Green",
              enable: { key: "gr-r_use-side-col" },
            },
            field: {
              store: { key: "gr-r_side-col" },
              enable: { key: "gr-r_use-side-col" },
            },
            slider: {
              store: { key: "gr-r_side-col" },
              enable: { key: "gr-r_use-side-col" },
            },
          },
          blue: {
            label: {
              text: "Blue",
              enable: { key: "gr-r_use-side-col" },
            },
            field: {
              store: { key: "gr-r_side-col" },
              enable: { key: "gr-r_use-side-col" },
            },
            slider: {
              store: { key: "gr-r_side-col" },
              enable: { key: "gr-r_use-side-col" },
            },
          },
          hex: { 
            label: {
              text: "Hex",
              enable: { key: "gr-r_use-side-col" },
            },
            field: {
              store: { key: "gr-r_side-col" },
              enable: { key: "gr-r_use-side-col" },
            },
          },
        },
      },
      {
        name: "gr-r_side-col-spd",
        template: VEComponents.get("text-field-checkbox"),
        layout: VELayouts.get("text-field-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Speed",
            enable: { key: "gr-r_use-side-col-spd" },
          },  
          field: { 
            store: { key: "gr-r_side-col-spd" },
            enable: { key: "gr-r_use-side-col-spd" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "gr-r_use-side-col-spd" },
          },
          title: { 
            text: "Enable",
            enable: { key: "gr-r_use-side-col-spd" },
          },
        },
      },
      {
        name: "gr-r_side-alpha-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Side alpha" },
        },
      },
      {
        name: "gr-r_side-alpha",
        template: VEComponents.get("vec4-value-checkbox"),
        layout: VELayouts.get("vec4-value-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Value",
              enable: { key: "gr-r_use-side-alpha" },
            },
            field: {
              store: { key: "gr-r_side-alpha" },
              enable: { key: "gr-r_use-side-alpha" },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-r_use-side-alpha" },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-r_use-side-alpha" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-r_change-side-alpha" },
            },
            field: {
              store: { key: "gr-r_side-alpha" },
              enable: { key: "gr-r_change-side-alpha" },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-r_change-side-alpha" },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-r_change-side-alpha" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-r_change-side-alpha" },
            },
            field: {
              store: { key: "gr-r_side-alpha" },
              enable: { key: "gr-r_change-side-alpha" },
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-r_change-side-alpha" },
            },
            field: {
              store: { key: "gr-r_side-alpha" },
              enable: { key: "gr-r_change-side-alpha" },
            },
          },
        },
      },
      {
        name: "gr-r_side-size-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Side size" },
        },
      },
      {
        name: "gr-r_side-size",
        template: VEComponents.get("vec4-value-checkbox"),
        layout: VELayouts.get("vec4-value-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Value",
              enable: { key: "gr-r_use-side-size" },
            },
            field: {
              store: { key: "gr-r_side-size" },
              enable: { key: "gr-r_use-side-size" },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-r_use-side-size" },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-r_use-side-size" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-r_change-side-size" },
            },
            field: {
              store: { key: "gr-r_side-size" },
              enable: { key: "gr-r_change-side-size" },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-r_change-side-size" },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-r_change-side-size" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-r_change-side-size" },
            },
            field: {
              store: { key: "gr-r_side-size" },
              enable: { key: "gr-r_change-side-size" },
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-r_change-side-size" },
            },
            field: {
              store: { key: "gr-r_side-size" },
              enable: { key: "gr-r_change-side-size" },
            },
          },
        },
      },
    ]),
  }
}