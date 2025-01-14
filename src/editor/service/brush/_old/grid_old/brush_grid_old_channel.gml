///@package io.alkapivo.visu.editor.service.brush._old.grid_old

///@param {Struct} json
///@return {Struct}
function migrateGridOldChannelEvent(json) {
  return {
    "icon": Struct.getIfType(json, "icon", Struct, { name: "texture_baron" }),
    "gr-c_use-mode": Struct.getIfType(json, "grid-channel_use-mode", Boolean, false),
    "gr-c_mode": Struct.getIfType(json, "grid-channel_mode", String, "DUAL"),
    "gr-c_use-amount": false,
    "gr-c_amount": Struct.getIfType(json, "grid-channel_transform-amount", Struct),
    "gr-c_change-amount": Struct.getIfType(json, "grid-channel_use-transform-amount", Boolean, false),
    "gr-c_use-main-col": Struct.getIfType(json, "grid-channel_use-primary-color", Boolean, false),
    "gr-c_main-col": Struct.getIfType(json, "grid-channel_primary-color", String, "#ffffff"),
    "gr-c_main-col-spd": Struct.getIfType(json, "grid-channel_primary-color-speed", Number, 1.0),
    "gr-c_use-main-alpha": false,
    "gr-c_main-alpha": Struct.getIfType(json, "grid-channel_transform-primary-alpha", Struct),
    "gr-c_change-main-alpha": Struct.getIfType(json, "grid-channel_use-transform-primary-alpha", Boolean, false),
    "gr-c_use-main-size": false,
    "gr-c_main-size": Struct.getIfType(json, "grid-channel_transform-primary-size", Struct),
    "gr-c_change-main-size": Struct.getIfType(json, "grid-channel_use-transform-primary-size", Boolean, false),
    "gr-c_use-side-col": Struct.getIfType(json, "grid-channel_use-secondary-color", Boolean, false),
    "gr-c_side-col": Struct.getIfType(json, "grid-channel_secondary-color", String, "#ffffff"),
    "gr-c_side-col-spd": Struct.getIfType(json, "grid-channel_secondary-color-speed", Number, 1.0),
    "gr-c_use-side-alpha": false,
    "gr-c_side-alpha": Struct.getIfType(json, "grid-channel_transform-secondary-alpha", Struct),
    "gr-c_change-side-alpha": Struct.getIfType(json, "grid-channel_use-transform-secondary-alpha", Boolean, false),
    "gr-c_use-side-size": false,
    "gr-c_side-size": Struct.getIfType(json, "grid-channel_transform-secondary-size", Struct),
    "gr-c_change-side-size": Struct.getIfType(json, "grid-channel_use-transform-secondary-size", Boolean, false),
  }
}


///@param {?Struct} [json]
///@return {Struct}
function brush_grid_old_channel(json = null) {
  return {
    name: "brush_grid_old_channel",
    store: new Map(String, Struct, {
      "grid-channel_use-mode": {
        type: Boolean,
        value: Struct.getDefault(json, "grid-channel_use-mode", false),
      },
      "grid-channel_mode": {
        type: String,
        value: Struct.getIfType(json, "grid-channel_mode", String, GridMode.DUAL),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: GridMode.keys(),
      },
      "grid-channel_use-transform-amount": {
        type: Boolean,
        value: Struct.getDefault(json, "grid-channel_use-transform-amount", false),
      },
      "grid-channel_transform-amount": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getDefault(json, 
          "grid-channel_transform-amount", 
          { value: 0, target: 1, factor: 0.01, increase: 0 }
        )),
      },
      "grid-channel_use-transform-z": {
        type: Boolean,
        value: Struct.getDefault(json, "grid-channel_use-transform-z", false),
      },
      "grid-channel_transform-z": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getDefault(json, 
          "grid-channel_transform-z",
          { value: 0, target: 1, factor: 0.01, increase: 0 }
        )),
      },
      "grid-channel_use-primary-color": {
        type: Boolean,
        value: Struct.getDefault(json, "grid-channel_use-primary-color", false),
      },
      "grid-channel_primary-color": {
        type: Color,
        value: ColorUtil.fromHex(Struct.get(json, "grid-channel_primary-color"), "#ffffff"),
      },
      "grid-channel_primary-color-speed": {
        type: Number,
        value: Struct.getDefault(json, "grid-channel_primary-color-speed", 0.01),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.000001, 1.0) 
        },
      },
      "grid-channel_use-transform-primary-alpha": {
        type: Boolean,
        value: Struct.getDefault(json, "grid-channel_use-transform-primary-alpha", false),
      },
      "grid-channel_transform-primary-alpha": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getDefault(json, 
          "grid-channel_transform-primary-alpha",
          { value: 0, target: 1, factor: 0.01, increase: 0 }
        )),
      },
      "grid-channel_use-transform-primary-size": {
        type: Boolean,
        value: Struct.getDefault(json, "grid-channel_use-transform-primary-size", false),
      },
      "grid-channel_transform-primary-size": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getDefault(json, 
          "grid-channel_transform-primary-size",
          { value: 0, target: 1, factor: 0.01, increase: 0 }
        )),
      },
      "grid-channel_use-secondary-color": {
        type: Boolean,
        value: Struct.getDefault(json, "grid-channel_use-secondary-color", false),
      },
      "grid-channel_secondary-color": {
        type: Color,
        value: ColorUtil.fromHex(Struct.get(json, "grid-channel_secondary-color"), "#ffffff"),
      },
      "grid-channel_secondary-color-speed": {
        type: Number,
        value: Struct.getDefault(json, "grid-channel_secondary-color-speed", 0.01),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.000001, 1.0) 
        },
      },
      "grid-channel_use-transform-secondary-alpha": {
        type: Boolean,
        value: Struct.getDefault(json, "grid-channel_use-transform-secondary-alpha", false),
      },
      "grid-channel_transform-secondary-alpha": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getDefault(json, 
          "grid-channel_transform-secondary-alpha",
          { value: 0, target: 1, factor: 0.01, increase: 0 }
        )),
      },
      "grid-channel_use-transform-secondary-size": {
        type: Boolean,
        value: Struct.getDefault(json, "grid-channel_use-transform-secondary-size", false),
      },
      "grid-channel_transform-secondary-size": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getDefault(json, 
          "grid-channel_transform-secondary-size",
          { value: 0, target: 1, factor: 0.01, increase: 0 }
        )),
      },
    }),
    components: new Array(Struct, [
      {
        name: "grid-channel_transform-amount",
        template: VEComponents.get("transform-numeric-property"),
        layout: VELayouts.get("transform-numeric-property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          title: {
            label: {
              text: "Transform amount",
              enable: { key: "grid-channel_use-transform-amount" },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "grid-channel_use-transform-amount" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "grid-channel_use-transform-amount" },
            },
            field: {
              store: { key: "grid-channel_transform-amount" },
              enable: { key: "grid-channel_use-transform-amount" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "grid-channel_use-transform-amount" },
            },
            field: {
              store: { key: "grid-channel_transform-amount" },
              enable: { key: "grid-channel_use-transform-amount" },
            },
          },
          increment: {
            label: {
              text: "Increase",
              enable: { key: "grid-channel_use-transform-amount" },
            },
            field: {
              store: { key: "grid-channel_transform-amount" },
              enable: { key: "grid-channel_use-transform-amount" },
            },
          },
        },
      },
      {
        name: "grid-channel_use-mode",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Render mode",
            enable: { key: "grid-channel_use-mode" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "grid-channel_use-mode" },
          },
        },
      },
      {
        name: "grid-channel_mode",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Mode",
            enable: { key: "grid-channel_use-mode" },
          },
          previous: { 
            enable: { key: "grid-channel_use-mode" },
            store: { key: "grid-channel_mode" },
          },
          preview: Struct.appendRecursive({ 
            enable: { key: "grid-channel_use-mode" },
            store: { key: "grid-channel_mode" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: { 
            enable: { key: "grid-channel_use-mode" },
            store: { key: "grid-channel_mode" },
          },
        },
      },
      {
        name: "grid-channel_transform-z",
        template: VEComponents.get("transform-numeric-property"),
        layout: VELayouts.get("transform-numeric-property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          title: {
            label: {
              text: "Transform z",
              enable: { key: "grid-channel_use-transform-z" },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "grid-channel_use-transform-z" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "grid-channel_use-transform-z" },
            },
            field: {
              store: { key: "grid-channel_transform-z" },
              enable: { key: "grid-channel_use-transform-z" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "grid-channel_use-transform-z" },
            },
            field: {
              store: { key: "grid-channel_transform-z" },
              enable: { key: "grid-channel_use-transform-z" },
            },
          },
          increment: {
            label: {
              text: "Increase",
              enable: { key: "grid-channel_use-transform-z" },
            },
            field: {
              store: { key: "grid-channel_transform-z" },
              enable: { key: "grid-channel_use-transform-z" },
            },
          },
        },
      },
      {
        name: "grid-channel_primary-color",
        template: VEComponents.get("color-picker"),
        layout: VELayouts.get("color-picker"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          title: { 
            label: {
              text: "Primary color",
              enable: { key: "grid-channel_use-primary-color" },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "grid-channel_use-primary-color" },
            },
            input: { 
              store: { key: "grid-channel_primary-color" },
              enable: { key: "grid-channel_use-primary-color" },
            }
          },
          red: {
            label: {
              text: "Red",
              enable: { key: "grid-channel_use-primary-color" },
            },
            field: {
              store: { key: "grid-channel_primary-color" },
              enable: { key: "grid-channel_use-primary-color" },
            },
            slider: {
              store: { key: "grid-channel_primary-color" },
              enable: { key: "grid-channel_use-primary-color" },
            },
          },
          green: {
            label: {
              text: "Green",
              enable: { key: "grid-channel_use-primary-color" },
            },
            field: {
              store: { key: "grid-channel_primary-color" },
              enable: { key: "grid-channel_use-primary-color" },
            },
            slider: {
              store: { key: "grid-channel_primary-color" },
              enable: { key: "grid-channel_use-primary-color" },
            },
          },
          blue: {
            label: {
              text: "Blue",
              enable: { key: "grid-channel_use-primary-color" },
            },
            field: {
              store: { key: "grid-channel_primary-color" },
              enable: { key: "grid-channel_use-primary-color" },
            },
            slider: {
              store: { key: "grid-channel_primary-color" },
              enable: { key: "grid-channel_use-primary-color" },
            },
          },
          hex: { 
            label: {
              text: "Hex",
              enable: { key: "grid-channel_use-primary-color" },
            },
            field: {
              store: { key: "grid-channel_primary-color" },
              enable: { key: "grid-channel_use-primary-color" },
            },
          },
        },
      },
      {
        name: "grid-channel_primary-color-speed",  
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Speed",
            enable: { key: "grid-channel_use-primary-color" },
          },
          field: { 
            enable: { key: "grid-channel_use-primary-color" },
            store: { key: "grid-channel_primary-color-speed" },
          },
        },
      },
      {
        name: "grid-channel_transform-primary-alpha",
        template: VEComponents.get("transform-numeric-property"),
        layout: VELayouts.get("transform-numeric-property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          title: {
            label: {
              text: "Transform primary alpha",
              enable: { key: "grid-channel_use-transform-primary-alpha" },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "grid-channel_use-transform-primary-alpha" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "grid-channel_use-transform-primary-alpha" },
            },
            field: {
              store: { key: "grid-channel_transform-primary-alpha" },
              enable: { key: "grid-channel_use-transform-primary-alpha" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "grid-channel_use-transform-primary-alpha" },
            },
            field: {
              store: { key: "grid-channel_transform-primary-alpha" },
              enable: { key: "grid-channel_use-transform-primary-alpha" },
            },
          },
          increment: {
            label: {
              text: "Increase",
              enable: { key: "grid-channel_use-transform-primary-alpha" },
            },
            field: {
              store: { key: "grid-channel_transform-primary-alpha" },
              enable: { key: "grid-channel_use-transform-primary-alpha" },
            },
          },
        },
      },
      {
        name: "grid-channel_transform-primary-size",
        template: VEComponents.get("transform-numeric-property"),
        layout: VELayouts.get("transform-numeric-property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          title: {
            label: {
              text: "Transform primary size",
              enable: { key: "grid-channel_use-transform-primary-size" },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "grid-channel_use-transform-primary-size" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "grid-channel_use-transform-primary-size" },
            },
            field: {
              store: { key: "grid-channel_transform-primary-size" },
              enable: { key: "grid-channel_use-transform-primary-size" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "grid-channel_use-transform-primary-size" },
            },
            field: {
              store: { key: "grid-channel_transform-primary-size" },
              enable: { key: "grid-channel_use-transform-primary-size" },
            },
          },
          increment: {
            label: {
              text: "Increase",
              enable: { key: "grid-channel_use-transform-primary-size" },
            },
            field: {
              store: { key: "grid-channel_transform-primary-size" },
              enable: { key: "grid-channel_use-transform-primary-size" },
            },
          },
        },
      },
      {
        name: "grid-channel_secondary-color",
        template: VEComponents.get("color-picker"),
        layout: VELayouts.get("color-picker"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          title: { 
            label: {
              text: "Secondary color",
              enable: { key: "grid-channel_use-secondary-color" },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "grid-channel_use-secondary-color" },
            },
            input: {
              store: { key: "grid-channel_secondary-color" },
              enable: { key: "grid-channel_use-secondary-color" },
            }
          },
          red: {
            label: {
              text: "Red",
              enable: { key: "grid-channel_use-secondary-color" },
            },
            field: {
              store: { key: "grid-channel_secondary-color" },
              enable: { key: "grid-channel_use-secondary-color" },
            },
            slider: {
              store: { key: "grid-channel_secondary-color" },
              enable: { key: "grid-channel_use-secondary-color" },
            },
          },
          green: {
            label: {
              text: "Green",
              enable: { key: "grid-channel_use-secondary-color" },
            },
            field: {
              store: { key: "grid-channel_secondary-color" },
              enable: { key: "grid-channel_use-secondary-color" },
            },
            slider: {
              store: { key: "grid-channel_secondary-color" },
              enable: { key: "grid-channel_use-secondary-color" },
            },
          },
          blue: {
            label: {
              text: "Blue",
              enable: { key: "grid-channel_use-secondary-color" },
            },
            field: {
              store: { key: "grid-channel_secondary-color" },
              enable: { key: "grid-channel_use-secondary-color" },
            },
            slider: {
              store: { key: "grid-channel_secondary-color" },
              enable: { key: "grid-channel_use-secondary-color" },
            },
          },
          hex: { 
            label: {
              text: "Hex",
              enable: { key: "grid-channel_use-secondary-color" },
            },
            field: {
              store: { key: "grid-channel_secondary-color" },
              enable: { key: "grid-channel_use-secondary-color" },
            },
          },
        },
      },
      {
        name: "grid-channel_secondary-color-speed",  
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Speed",
            enable: { key: "grid-channel_use-secondary-color" },
          },
          field: { 
            enable: { key: "grid-channel_use-secondary-color" },
            store: { key: "grid-channel_secondary-color-speed" }
          },
        },
      },
      {
        name: "grid-channel_transform-secondary-alpha",
        template: VEComponents.get("transform-numeric-property"),
        layout: VELayouts.get("transform-numeric-property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          title: {
            label: {
              text: "Transform secondary alpha",
              enable: { key: "grid-channel_use-transform-secondary-alpha" },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "grid-channel_use-transform-secondary-alpha" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "grid-channel_use-transform-secondary-alpha" },
            },
            field: {
              store: { key: "grid-channel_transform-secondary-alpha" },
              enable: { key: "grid-channel_use-transform-secondary-alpha" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "grid-channel_use-transform-secondary-alpha" },
            },
            field: {
              store: { key: "grid-channel_transform-secondary-alpha" },
              enable: { key: "grid-channel_use-transform-secondary-alpha" },
            },
          },
          increment: {
            label: {
              text: "Increase",
              enable: { key: "grid-channel_use-transform-secondary-alpha" },
            },
            field: {
              store: { key: "grid-channel_transform-secondary-alpha" },
              enable: { key: "grid-channel_use-transform-secondary-alpha" },
            },
          },
        },
      },
      {
        name: "grid-channel_transform-secondary-size",
        template: VEComponents.get("transform-numeric-property"),
        layout: VELayouts.get("transform-numeric-property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          title: {
            label: {
              text: "Transform secondary size",
              enable: { key: "grid-channel_use-transform-secondary-size" },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "grid-channel_use-transform-secondary-size" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "grid-channel_use-transform-secondary-size" },
            },
            field: {
              store: { key: "grid-channel_transform-secondary-size" },
              enable: { key: "grid-channel_use-transform-secondary-size" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "grid-channel_use-transform-secondary-size" },
            },
            field: {
              store: { key: "grid-channel_transform-secondary-size" },
              enable: { key: "grid-channel_use-transform-secondary-size" },
            },
          },
          increment: {
            label: {
              text: "Increase",
              enable: { key: "grid-channel_use-transform-secondary-size" },
            },
            field: {
              store: { key: "grid-channel_transform-secondary-size" },
              enable: { key: "grid-channel_use-transform-secondary-size" },
            },
          },
        },
      },
    ]),
  }
}