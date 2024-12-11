///@package io.alkapivo.visu.editor.service.brush.grid

///@param {?Struct} [json]
///@return {Struct}
function brush_grid_area(json = null) {
  return {
    name: "brush_grid_area",
    store: new Map(String, Struct, {
      "gr-area_use-h": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-area_use-h", Boolean, false),
      },
      "gr-area_h": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getIfType(json, "gr-area_h", Struct, {
          value: 0.0,
          target: 1.0,
          factor: 0.01,
          increase: 0,
        })),
        passthrough: function(value) {
          if (!Core.isType(value, NumberTransformer)) {
            return this.value
          }

          value.value = clamp(value.value, 0.0, 10.0)
          value.target = clamp(value.target, 0.0, 10.0)
          return value
        },
      },
      "gr-area_change-h": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-area_change-h", Boolean, false),
      },
      "gr-area_use-h-col": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-area_use-h-col", Boolean, false),
      },
      "gr-area_h-col": {
        type: Color,
        value: ColorUtil.fromHex(Struct.getIfType(json, "gr-area_h-col", String), ColorUtil.fromHex("#ffffff")),
      },
      "gr-area_h-col-spd": {
        type: Number,
        value: Struct.getIfType(json, "gr-area_h-col-spd", Number, 0.01),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.000001, 1.0) 
        },
      },
      "gr-area_use-h-col-spd": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-area_use-h-col-spd", Boolean, false),
      },
      "gr-area_use-h-alpha": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-area_use-h-alpha", Boolean, false),
      },
      "gr-area_h-alpha": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getIfType(json, "gr-area_h-alpha", Struct, {
          value: 0.0,
          target: 1.0,
          factor: 0.01,
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
      "gr-area_change-h-alpha": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-area_change-h-alpha", Boolean, false),
      },
      "gr-area_use-h-size": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-area_use-h-size", Boolean, false),
      },
      "gr-area_h-size": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getIfType(json, "gr-area_h-size", Struct, {
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
      "gr-area_change-h-size": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-area_change-h-size", Boolean, false),
      },
      "gr-area_use-v": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-area_use-v", Boolean, false),
      },
      "gr-area_v": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getIfType(json, "gr-area_v", Struct, {
          value: 0.0,
          target: 1.0,
          factor: 0.01,
          increase: 0,
        })),
        passthrough: function(value) {
          if (!Core.isType(value, NumberTransformer)) {
            return this.value
          }

          value.value = clamp(value.value, 0.0, 10.0)
          value.target = clamp(value.target, 0.0, 10.0)
          return value
        },
      },
      "gr-area_change-v": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-area_use-v", Boolean, false),
      },
      "gr-area_use-v-col": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-area_use-v-col", Boolean, false),
      },
      "gr-area_v-col": {
        type: Color,
        value: ColorUtil.fromHex(Struct.get(json, "gr-area_v-col"), ColorUtil.fromHex("#ffffff")),
      },
      "gr-area_v-col-spd": {
        type: Number,
        value: Struct.getIfType(json, "gr-area_v-col-spd", Number, 0.01),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.000001, 1.0) 
        },
      },
      "gr-area_use-v-col-spd": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-area_use-v-col-spd", Boolean, false),
      },
      "gr-area_use-v-alpha": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-area_use-v-alpha", Boolean, false),
      },
      "gr-area_v-alpha": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getIfType(json, "gr-area_v-alpha", Struct, {
          value: 0.0,
          target: 1.0,
          factor: 0.01,
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
      "gr-area_change-v-alpha": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-area_change-v-alpha", Boolean, false),
      },
      "gr-area_use-v-size": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-area_use-v-size", Boolean, false),
      },
      "gr-area_v-size": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getIfType(json, "gr-area_v-size", Struct, {
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
      "gr-area_change-v-size": {
        type: Boolean,
        value: Struct.getIfType(json, "gr-area_change-v-size", Boolean, false),
      },
    }),
    components: new Array(Struct, [
      {
        name: "gr-area_h-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Horizontal",
            backgroundColor: VETheme.color.accentShadow,
          },
          input: { backgroundColor: VETheme.color.accentShadow },
          checkbox: { backgroundColor: VETheme.color.accentShadow },
        },
      },
      {
        name: "gr-area_h",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Width",
              font: "font_inter_10_bold",
              color: VETheme.color.textFocus,
              enable: { key: "gr-area_use-h" },
            },
            field: {
              store: { key: "gr-area_h" },
              enable: { key: "gr-area_use-h" },
            },
            decrease: {
              store: { key: "gr-area_h" },
              enable: { key: "gr-area_use-h" },
              factor: -0.25,
            },
            increase: {
              store: { key: "gr-area_h" },
              enable: { key: "gr-area_use-h" },
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-area_use-h" },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-area_use-h" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-area_change-h" },
            },
            field: {
              store: { key: "gr-area_h" },
              enable: { key: "gr-area_change-h" },
            },
            decrease: {
              store: { key: "gr-area_h" },
              enable: { key: "gr-area_change-h" },
              factor: -0.25,
            },
            increase: {
              store: { key: "gr-area_h" },
              enable: { key: "gr-area_change-h" },
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-area_change-h" },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-area_change-h" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-area_change-h" },
            },
            field: {
              store: { key: "gr-area_h" },
              enable: { key: "gr-area_change-h" },
            },
            decrease: {
              store: { key: "gr-area_h" },
              enable: { key: "gr-area_change-h" },
              factor: -0.01,
            },
            increase: {
              store: { key: "gr-area_h" },
              enable: { key: "gr-area_change-h" },
              factor: 0.01,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-area_change-h" },
            },
            field: {
              store: { key: "gr-area_h" },
              enable: { key: "gr-area_change-h" },
            },
            decrease: {
              store: { key: "gr-area_h" },
              enable: { key: "gr-area_change-h" },
              factor: -0.001,
            },
            increase: {
              store: { key: "gr-area_h" },
              enable: { key: "gr-area_change-h" },
              factor: 0.001,
            },
          },
        },
      },
      {
        name: "gr-area_h-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "gr-area_h-size",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Thickness",
              font: "font_inter_10_bold",
              color: VETheme.color.textFocus,
              enable: { key: "gr-area_use-h-size" },
            },
            field: {
              store: { key: "gr-area_h-size" },
              enable: { key: "gr-area_use-h-size" },
            },
            decrease: {
              store: { key: "gr-area_h-size" },
              enable: { key: "gr-area_use-h-size" },
              factor: -0.25,
            },
            increase: {
              store: { key: "gr-area_h-size" },
              enable: { key: "gr-area_use-h-size" },
              factor: 0.25,        
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-area_use-h-size" },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-area_use-h-size" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-area_change-h-size" },
            },
            field: {
              store: { key: "gr-area_h-size" },
              enable: { key: "gr-area_use-h-size" },
            },
            decrease: {
              store: { key: "gr-area_h-size" },
              enable: { key: "gr-area_use-h-size" },
              factor: -0.25,
            },
            increase: {
              store: { key: "gr-area_h-size" },
              enable: { key: "gr-area_use-h-size" },
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-area_change-h-size" },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-area_change-h-size" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-area_change-h-size" },
            },
            field: {
              store: { key: "gr-area_h-size" },
              enable: { key: "gr-area_change-h-size" },
            },
            decrease: {
              store: { key: "gr-area_h-size" },
              enable: { key: "gr-area_use-h-size" },
              factor: -0.01,
            },
            increase: {
              store: { key: "gr-area_h-size" },
              enable: { key: "gr-area_use-h-size" },
              factor: 0.01,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-area_change-h-size" },
            },
            field: {
              store: { key: "gr-area_h-size" },
              enable: { key: "gr-area_change-h-size" },
            },
            decrease: {
              store: { key: "gr-area_h-size" },
              enable: { key: "gr-area_use-h-size" },
              factor: -0.001,
            },
            increase: {
              store: { key: "gr-area_h-size" },
              enable: { key: "gr-area_use-h-size" },
              factor: 0.001,      
            },
          },
        },
      },
      {
        name: "gr-area_h-size-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "gr-area_h-alpha",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Alpha",
              font: "font_inter_10_bold",
              color: VETheme.color.textFocus,
              enable: { key: "gr-area_use-h-alpha" },
            },
            field: {
              store: { key: "gr-area_h-alpha" },
              enable: { key: "gr-area_use-h-alpha" },
            },
            decrease: {
              store: { key: "gr-area_h-alpha" },
              enable: { key: "gr-area_use-h-alpha" },
              factor: -0.01,
            },
            increase: {
              store: { key: "gr-area_h-alpha" },
              enable: { key: "gr-area_use-h-alpha" },
              factor: 0.01,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-area_use-h-alpha" },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-area_use-h-alpha" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-area_change-h-alpha" },
            },
            field: {
              store: { key: "gr-area_h-alpha" },
              enable: { key: "gr-area_change-h-alpha" },
            },
            decrease: {
              store: { key: "gr-area_h-alpha" },
              enable: { key: "gr-area_change-h-alpha" },
              factor: -0.01,
            },
            increase: {
              store: { key: "gr-area_h-alpha" },
              enable: { key: "gr-area_change-h-alpha" }, 
              factor: 0.01,     
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-area_change-h-alpha" },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-area_change-h-alpha" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-area_change-h-alpha" },
            },
            field: {
              store: { key: "gr-area_h-alpha" },
              enable: { key: "gr-area_change-h-alpha" },
            },
            decrease: {
              store: { key: "gr-area_h-alpha" },
              enable: { key: "gr-area_change-h-alpha" },
              factor: -0.001,
            },
            increase: {
              store: { key: "gr-area_h-alpha" },
              enable: { key: "gr-area_change-h-alpha" },      
              factor: 0.001,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-area_change-h-alpha" },
            },
            field: {
              store: { key: "gr-area_h-alpha" },
              enable: { key: "gr-area_change-h-alpha" },
            },
            decrease: {
              store: { key: "gr-area_h-alpha" },
              enable: { key: "gr-area_change-h-alpha" },
              factor: -0.0001,
            },
            increase: {
              store: { key: "gr-area_h-alpha" },
              enable: { key: "gr-area_change-h-alpha" },
              factor: 0.0001,
            },
          },
        },
      },
      {
        name: "gr-area_h-alpha-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "gr-area_h-col",
        template: VEComponents.get("color-picker"),
        layout: VELayouts.get("color-picker"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          title: { 
            label: {
              text: "Color",
              enable: { key: "gr-area_use-h-col" },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-area_use-h-col" },
            },
            input: { 
              store: { key: "gr-area_h-col" },
              enable: { key: "gr-area_use-h-col" },
            }
          },
          red: {
            label: {
              text: "Red",
              enable: { key: "gr-area_use-h-col" },
            },
            field: {
              store: { key: "gr-area_h-col" },
              enable: { key: "gr-area_use-h-col" },
            },
            slider: {
              store: { key: "gr-area_h-col" },
              enable: { key: "gr-area_use-h-col" },
            },
          },
          green: {
            label: {
              text: "Green",
              enable: { key: "gr-area_use-h-col" },
            },
            field: {
              store: { key: "gr-area_h-col" },
              enable: { key: "gr-area_use-h-col" },
            },
            slider: {
              store: { key: "gr-area_h-col" },
              enable: { key: "gr-area_use-h-col" },
            },
          },
          blue: {
            label: {
              text: "Blue",
              enable: { key: "gr-area_use-h-col" },
            },
            field: {
              store: { key: "gr-area_h-col" },
              enable: { key: "gr-area_use-h-col" },
            },
            slider: {
              store: { key: "gr-area_h-col" },
              enable: { key: "gr-area_use-h-col" },
            },
          },
          hex: { 
            label: {
              text: "Hex",
              enable: { key: "gr-area_use-h-col" },
            },
            field: {
              store: { key: "gr-area_h-col" },
              enable: { key: "gr-area_use-h-col" },
            },
          },
        },
      },
      {
        name: "gr-area_h-col-spd",
        template: VEComponents.get("text-field-increase-checkbox"),
        layout: VELayouts.get("text-field-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Speed",
            enable: { key: "gr-area_use-h-col-spd" },
          },  
          field: { 
            store: { key: "gr-area_h-col-spd" },
            enable: { key: "gr-area_use-h-col-spd" },
          },
          decrease: {
            store: { key: "gr-area_h-col-spd" },
            enable: { key: "gr-area_use-h-col-spd" },
            factor: -0.001,
          },
          increase: {
            store: { key: "gr-area_h-col-spd" },
            enable: { key: "gr-area_use-h-col-spd" },
            factor: 0.001,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "gr-area_use-h-col-spd" },
          },
          title: { 
            text: "Enable",
            enable: { key: "gr-area_use-h-col-spd" },
          },
        },
      },
      {
        name: "gr-area_h-col-spd-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "gr-area_v-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Vertical",
            backgroundColor: VETheme.color.accentShadow,
          },
          input: { backgroundColor: VETheme.color.accentShadow },
          checkbox: { backgroundColor: VETheme.color.accentShadow },
        },
      },
      {
        name: "gr-area_v",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Height",
              font: "font_inter_10_bold",
              color: VETheme.color.textFocus,
              enable: { key: "gr-area_use-v" },
            },
            field: {
              store: { key: "gr-area_v" },
              enable: { key: "gr-area_use-v" },
            },
            decrease: {
              store: { key: "gr-area_v" },
              enable: { key: "gr-area_use-v" },
              factor: -0.25,
            },
            increase: {
              store: { key: "gr-area_v" },
              enable: { key: "gr-area_use-v" },    
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-area_use-v" },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-area_use-v" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-area_change-v" },
            },
            field: {
              store: { key: "gr-area_v" },
              enable: { key: "gr-area_change-v" },
            },
            decrease: {
              store: { key: "gr-area_v" },
              enable: { key: "gr-area_change-v" },
              factor: -0.25,
            },
            increase: {
              store: { key: "gr-area_v" },
              enable: { key: "gr-area_change-v" },
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-area_change-v" },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-area_change-v" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-area_change-v" },
            },
            field: {
              store: { key: "gr-area_v" },
              enable: { key: "gr-area_change-v" },
            },
            decrease: {
              store: { key: "gr-area_v" },
              enable: { key: "gr-area_change-v" },
              factor: -0.01,
            },
            increase: {
              store: { key: "gr-area_v" },
              enable: { key: "gr-area_change-v" },
              factor: 0.01,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-area_change-v" },
            },
            field: {
              store: { key: "gr-area_v" },
              enable: { key: "gr-area_change-v" },
            },
            decrease: {
              store: { key: "gr-area_v" },
              enable: { key: "gr-area_change-v" },
              factor: -0.001,
            },
            increase: {
              store: { key: "gr-area_v" },
              enable: { key: "gr-area_change-v" },
              factor: 0.001,
            },
          },
        },
      },
      {
        name: "gr-area_v-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "gr-area_v-size",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Thickness",
              font: "font_inter_10_bold",
              color: VETheme.color.textFocus,
              enable: { key: "gr-area_use-v-size" },
            },
            field: {
              store: { key: "gr-area_v-size" },
              enable: { key: "gr-area_use-v-size" },
            },
            decrease: {
              store: { key: "gr-area_v-size" },
              enable: { key: "gr-area_use-v-size" },
              factor: -0.25,
            },
            increase: {
              store: { key: "gr-area_v-size" },
              enable: { key: "gr-area_use-v-size" },          
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-area_use-v-size" },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-area_use-v-size" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-area_change-v-size" },
            },
            field: {
              store: { key: "gr-area_v-size" },
              enable: { key: "gr-area_change-v-size" },
            },
            decrease: {
              store: { key: "gr-area_v-size" },
              enable: { key: "gr-area_change-v-size" },
              factor: -0.25,
            },
            increase: {
              store: { key: "gr-area_v-size" },
              enable: { key: "gr-area_change-v-size" },             
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-area_change-v-size" },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-area_change-v-size" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-area_change-v-size" },
            },
            field: {
              store: { key: "gr-area_v-size" },
              enable: { key: "gr-area_change-v-size" },
            },
            decrease: {
              store: { key: "gr-area_v-size" },
              enable: { key: "gr-area_change-v-size" },
              factor: -0.01,
            },
            increase: {
              store: { key: "gr-area_v-size" },
              enable: { key: "gr-area_change-v-size" },             
              factor: 0.01,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-area_change-v-size" },
            },
            field: {
              store: { key: "gr-area_v-size" },
              enable: { key: "gr-area_change-v-size" },
            },
            decrease: {
              store: { key: "gr-area_v-size" },
              enable: { key: "gr-area_change-v-size" },
              factor: -0.001,
            },
            increase: {
              store: { key: "gr-area_v-size" },
              enable: { key: "gr-area_change-v-size" },             
              factor: 0.001,
            },
          },
        },
      },
      {
        name: "gr-area_v-size-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "gr-area_v-alpha",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Alpha",
              font: "font_inter_10_bold",
              color: VETheme.color.textFocus,
              enable: { key: "gr-area_use-v-alpha" },
            },
            field: {
              store: { key: "gr-area_v-alpha" },
              enable: { key: "gr-area_use-v-alpha" },
            },
            decrease: {
              store: { key: "gr-area_v-alpha" },
              enable: { key: "gr-area_use-v-alpha" },
              factor: -0.01,
            },
            increase: {
              store: { key: "gr-area_v-alpha" },
              enable: { key: "gr-area_use-v-alpha" },
              factor: 0.01,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-area_use-v-alpha" },
            },
            title: { 
              text: "Override",
              enable: { key: "gr-area_use-v-alpha" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "gr-area_change-v-alpha" },
            },
            field: {
              store: { key: "gr-area_v-alpha" },
              enable: { key: "gr-area_change-v-alpha" },
            },
            decrease: {
              store: { key: "gr-area_v-alpha" },
              enable: { key: "gr-area_change-v-alpha" },
              factor: -0.01,
            },
            increase: {
              store: { key: "gr-area_v-alpha" },
              enable: { key: "gr-area_change-v-alpha" },  
              factor: 0.01,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-area_change-v-alpha" },
            },
            title: { 
              text: "Change",
              enable: { key: "gr-area_change-v-alpha" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "gr-area_change-v-alpha" },
            },
            field: {
              store: { key: "gr-area_v-alpha" },
              enable: { key: "gr-area_change-v-alpha" },
            },
            decrease: {
              store: { key: "gr-area_v-alpha" },
              enable: { key: "gr-area_change-v-alpha" },
              factor: -0.001,
            },
            increase: {
              store: { key: "gr-area_v-alpha" },
              enable: { key: "gr-area_change-v-alpha" },  
              factor: 0.001,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "gr-area_change-v-alpha" },
            },
            field: {
              store: { key: "gr-area_v-alpha" },
              enable: { key: "gr-area_change-v-alpha" },
            },
            decrease: {
              store: { key: "gr-area_v-alpha" },
              enable: { key: "gr-area_change-v-alpha" },
              factor: -0.0001,
            },
            increase: {
              store: { key: "gr-area_v-alpha" },
              enable: { key: "gr-area_change-v-alpha" },  
              factor: 0.0001,
            },
          },
        },
      },
      {
        name: "gr-area_v-alpha-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "gr-area_v-col",
        template: VEComponents.get("color-picker"),
        layout: VELayouts.get("color-picker"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          title: { 
            label: {
              text: "Color",
              enable: { key: "gr-area_use-v-col" },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "gr-area_use-v-col" },
            },
            input: { 
              store: { key: "gr-area_v-col" },
              enable: { key: "gr-area_use-v-col" },
            }
          },
          red: {
            label: {
              text: "Red",
              enable: { key: "gr-area_use-v-col" },
            },
            field: {
              store: { key: "gr-area_v-col" },
              enable: { key: "gr-area_use-v-col" },
            },
            slider: {
              store: { key: "gr-area_v-col" },
              enable: { key: "gr-area_use-v-col" },
            },
          },
          green: {
            label: {
              text: "Green",
              enable: { key: "gr-area_use-v-col" },
            },
            field: {
              store: { key: "gr-area_v-col" },
              enable: { key: "gr-area_use-v-col" },
            },
            slider: {
              store: { key: "gr-area_v-col" },
              enable: { key: "gr-area_use-v-col" },
            },
          },
          blue: {
            label: {
              text: "Blue",
              enable: { key: "gr-area_use-v-col" },
            },
            field: {
              store: { key: "gr-area_v-col" },
              enable: { key: "gr-area_use-v-col" },
            },
            slider: {
              store: { key: "gr-area_v-col" },
              enable: { key: "gr-area_use-v-col" },
            },
          },
          hex: { 
            label: {
              text: "Hex",
              enable: { key: "gr-area_use-v-col" },
            },
            field: {
              store: { key: "gr-area_v-col" },
              enable: { key: "gr-area_use-v-col" },
            },
          },
        },
      },
      {
        name: "gr-area_v-col-spd",
        template: VEComponents.get("text-field-increase-checkbox"),
        layout: VELayouts.get("text-field-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Speed",
            enable: { key: "gr-area_use-v-col-spd" },
          },  
          field: { 
            store: { key: "gr-area_v-col-spd" },
            enable: { key: "gr-area_use-v-col-spd" },
          },
          decrease: {
            store: { key: "gr-area_v-col-spd" },
            enable: { key: "gr-area_use-v-col-spd" },
            factor: -0.001,
          },
          increase: {
            store: { key: "gr-area_v-col-spd" },
            enable: { key: "gr-area_use-v-col-spd" },
            factor: 0.001,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "gr-area_use-v-col-spd" },
          },
          title: { 
            text: "Enable",
            enable: { key: "gr-area_use-v-col-spd" },
          },
        },
      },
    ]),
  }
}