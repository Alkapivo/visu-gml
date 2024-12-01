///@package io.alkapivo.visu.editor.service.brush.effect

///@param {?Struct} [json]
///@return {Struct}
function brush_effect_config(json = null) {
  return {
    name: "brush_effect_config",
    store: new Map(String, Struct, {
      "ef-cfg_use-render-shd-bkg": {
        type: Boolean,
        value: Struct.getIfType(json, "ef-cfg_use-render-shd-bkg", Boolean, false),
      },
      "ef-cfg_render-shd-bkg": {
        type: Boolean,
        value: Struct.getIfType(json, "ef-cfg_render-shd-bkg", Boolean, false),
      },
      "ef-cfg_cls-shd-bkg": {
        type: Boolean,
        value: Struct.getIfType(json, "ef-cfg_cls-shd-bkg", Boolean, false),
      },
      "ef-cfg_cls-shd-bkg-smooth": {
        type: Boolean,
        value: Struct.getIfType(json, "ef-cfg_cls-shd-bkg-smooth", Boolean, false),
      },
      "ef-cfg_use-render-shd-gr": {
        type: Boolean,
        value: Struct.getIfType(json, "ef-cfg_use-render-shd-gr", Boolean, false),
      },
      "ef-cfg_render-shd-gr": {
        type: Boolean,
        value: Struct.getIfType(json, "ef-cfg_render-shd-gr", Boolean, false),
      },
      "ef-cfg_cls-shd-gr": {
        type: Boolean,
        value: Struct.getIfType(json, "ef-cfg_cls-shd-gr", Boolean, false),
      },
      "ef-cfg_cls-shd-gr-smooth": {
        type: Boolean,
        value: Struct.getIfType(json, "ef-cfg_cls-shd-gr-smooth", Boolean, false),
      },
      "ef-cfg_use-render-shd-all": {
        type: Boolean,
        value: Struct.getIfType(json, "ef-cfg_use-render-shd-all", Boolean, false),
      },
      "ef-cfg_render-shd-all": {
        type: Boolean,
        value: Struct.getIfType(json, "ef-cfg_render-shd-all", Boolean, false),
      },
      "ef-cfg_cls-shd-all": {
        type: Boolean,
        value: Struct.getIfType(json, "ef-cfg_cls-shd-all", Boolean, false),
      },
      "ef-cfg_cls-shd-all-smooth": {
        type: Boolean,
        value: Struct.getIfType(json, "ef-cfg_cls-shd-all-smooth", Boolean, false),
      },
      "ef-cfg_use-render-glt": {
        type: Boolean,
        value: Struct.getIfType(json, "ef-cfg_use-render-glt", Boolean, false),
      },
      "ef-cfg_render-glt": {
        type: Boolean,
        value: Struct.getIfType(json, "ef-cfg_render-glt", Boolean, false),
      },
      "ef-cfg_cls-glt": {
        type: Boolean,
        value: Struct.getIfType(json, "ef-cfg_cls-glt", Boolean, false),
      },
      "ef-cfg_cls-glt-smooth": {
        type: Boolean,
        value: Struct.getIfType(json, "ef-cfg_cls-glt-smooth", Boolean, false),
      },
      "ef-cfg_use-render-part": {
        type: Boolean,
        value: Struct.getIfType(json, "ef-cfg_use-render-part", Boolean, false),
      },
      "ef-cfg_render-part": {
        type: Boolean,
        value: Struct.getIfType(json, "ef-cfg_render-part", Boolean, false),
      },
      "ef-cfg_cls-part": {
        type: Boolean,
        value: Struct.getIfType(json, "ef-cfg_cls-part", Boolean, false),
      },
      "ef-cfg_cls-part-smooth": {
        type: Boolean,
        value: Struct.getIfType(json, "ef-cfg_cls-part-smooth", Boolean, false),
      },
      "ef-cfg_use-cls-frame": {
        type: Boolean,
        value: Struct.getIfType(json, "ef-cfg_use-cls-frame", Boolean, false),
      },
      "ef-cfg_cls-frame": {
        type: Boolean,
        value: Struct.getIfType(json, "ef-cfg_cls-frame", Boolean, false),
      },
      "ef-cfg_use-cls-frame-col": {
        type: Boolean,
        value: Struct.getIfType(json, "ef-cfg_use-cls-frame-col", Boolean, false),
      },
      "ef-cfg_cls-frame-col": {
        type: Color,
        value: ColorUtil.fromHex(Struct.get(json, "ef-cfg_cls-frame-col"), ColorUtil.fromHex("#000000")),
      },
      "ef-cfg_cls-frame-col-spd": {
        type: Number,
        value: Struct.getIfType(json, "ef-cfg_cls-frame-col-spd", Number, 0.01),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.000001, 1.0) 
        },
      },
      "ef-cfg_cls-frame-alpha": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getIfType(json, "ef-cfg_cls-frame-alpha", Struct, {})),
      },
      "ef-cfg_use-cls-frame-alpha": {
        type: Boolean,
        value: Struct.getIfType(json, "ef-cfg_use-cls-frame-alpha", Boolean, false),
      },
      "ef-cfg_change-cls-frame-alpha": {
        type: Boolean,
        value: Struct.getIfType(json, "ef-cfg_change-cls-frame-alpha", Boolean, false),

      },
    }),
    components: new Array(Struct, [
      {
        name: "ef-cfg_render",
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
        name: "ef-cfg_render-shd-bkg",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Background shaders",
            enable: { key: "ef-cfg_use-render-shd-bkg" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "ef-cfg_use-render-shd-bkg" },
          },
          input: { 
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "ef-cfg_render-shd-bkg" },
            enable: { key: "ef-cfg_use-render-shd-bkg" },
          },
        },
      },
      {
        name: "ef-cfg_render-shd-gr",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Grid shaders",
            enable: { key: "ef-cfg_use-render-shd-gr" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "ef-cfg_use-render-shd-gr" },
          },
          input: { 
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "ef-cfg_render-shd-gr" },
            enable: { key: "ef-cfg_use-render-shd-gr" },
          },
        },
      },
      {
        name: "ef-cfg_render-shd-all",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Combined shaders",
            enable: { key: "ef-cfg_use-render-shd-all" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "ef-cfg_use-render-shd-all" },
          },
          input: { 
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "ef-cfg_render-shd-all" },
            enable: { key: "ef-cfg_use-render-shd-all" },
          },
        },
      },
      {
        name: "ef-cfg_render-glt",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Glitches",
            enable: { key: "ef-cfg_use-render-glt" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "ef-cfg_use-render-glt" },
          },
          input: { 
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "ef-cfg_render-glt" },
            enable: { key: "ef-cfg_use-render-glt" },
          },
        },
      },
      {
        name: "ef-cfg_render-part",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Particles",
            enable: { key: "ef-cfg_use-render-part" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "ef-cfg_use-render-part" },
          },
          input: { 
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "ef-cfg_render-part" },
            enable: { key: "ef-cfg_use-render-part" },
          },
        },
      },
      {
        name: "ef-cfg_clear",
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
        name: "ef-cfg_cls-shd-bkg",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Background shaders (smooth)",
            enable: { key: "ef-cfg_cls-shd-bkg" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "ef-cfg_cls-shd-bkg" },
          },
          input: { 
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "ef-cfg_cls-shd-bkg-smooth" },
            enable: { key: "ef-cfg_cls-shd-bkg" },
          },
        },
      },
      {
        name: "ef-cfg_cls-shd-gr",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Grid shaders (smooth)",
            enable: { key: "ef-cfg_cls-shd-gr" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "ef-cfg_cls-shd-gr" },
          },
          input: { 
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "ef-cfg_cls-shd-gr-smooth" },
            enable: { key: "ef-cfg_cls-shd-gr" },
          },
        },
      },
      {
        name: "ef-cfg_cls-shd-all",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Combined shaders (smooth)",
            enable: { key: "ef-cfg_cls-shd-all" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "ef-cfg_cls-shd-all" },
          },
          input: { 
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "ef-cfg_cls-shd-all-smooth" },
            enable: { key: "ef-cfg_cls-shd-all" },
          },
        },
      },
      {
        name: "ef-cfg_cls-glt",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Glitches (smooth)",
            enable: { key: "ef-cfg_cls-glt" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "ef-cfg_cls-glt" },
          },
          input: { 
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "ef-cfg_cls-glt-smooth" },
            enable: { key: "ef-cfg_cls-glt" },
          },
        },
      },
      {
        name: "ef-cfg_cls-part",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Particles (smooth)",
            enable: { key: "ef-cfg_cls-part" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "ef-cfg_cls-part" },
          },
          input: { 
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "ef-cfg_cls-part-smooth" },
            enable: { key: "ef-cfg_cls-part" },
          },
        },
      },
      {
        name: "ef-cfg_cls-frame",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Clear frame",
            enable: { key: "ef-cfg_use-cls-frame" },
            backgroundColor: VETheme.color.accentShadow 
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "ef-cfg_use-cls-frame" },
            backgroundColor: VETheme.color.accentShadow 
          },
          input: { 
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "ef-cfg_cls-frame" },
            enable: { key: "ef-cfg_use-cls-frame" },
            backgroundColor: VETheme.color.accentShadow 
          },
        },
      },
      {
        name: "ef-cfg_cls-frame-alpha",
        template: VEComponents.get("vec4-value-checkbox"),
        layout: VELayouts.get("vec4-value-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Alpha",
              enable: { key: "ef-cfg_use-cls-frame-alpha" },
            },
            field: {
              store: { key: "ef-cfg_cls-frame-alpha" },
              enable: { key: "ef-cfg_use-cls-frame-alpha" },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "ef-cfg_use-cls-frame-alpha" },
            },
            title: { 
              text: "Override",
              enable: { key: "ef-cfg_use-cls-frame-alpha" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "ef-cfg_change-cls-frame-alpha" },
            },
            field: {
              store: { key: "ef-cfg_cls-frame-alpha" },
              enable: { key: "ef-cfg_change-cls-frame-alpha" },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "ef-cfg_change-cls-frame-alpha" },
            },
            title: { 
              text: "Change",
              enable: { key: "ef-cfg_change-cls-frame-alpha" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "ef-cfg_change-cls-frame-alpha" },
            },
            field: {
              store: { key: "ef-cfg_cls-frame-alpha" },
              enable: { key: "ef-cfg_change-cls-frame-alpha" },
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "ef-cfg_change-cls-frame-alpha" },
            },
            field: {
              store: { key: "ef-cfg_cls-frame-alpha" },
              enable: { key: "ef-cfg_change-cls-frame-alpha" },
            },
          },
        },
      },
      {
        name: "ef-cfg_cls-frame-col",
        template: VEComponents.get("color-picker"),
        layout: VELayouts.get("color-picker"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          title: {
            label: { 
              text: "Clear frame color",
              enable: { key: "ef-cfg_use-cls-frame-col" },
            },  
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "ef-cfg_use-cls-frame-col" },
            },
            input: { 
              store: { key: "ef-cfg_cls-frame-col" },
              enable: { key: "ef-cfg_use-cls-frame-col" },
            }
          },
          red: {
            label: { 
              text: "Red",
              enable: { key: "ef-cfg_use-cls-frame-col" },
            },
            field: { 
              store: { key: "ef-cfg_cls-frame-col" },
              enable: { key: "ef-cfg_use-cls-frame-col" },
            },
            slider: { 
              store: { key: "ef-cfg_cls-frame-col" },
              enable: { key: "ef-cfg_use-cls-frame-col" },
            },
          },
          green: {
            label: { 
              text: "Green",
              enable: { key: "ef-cfg_use-cls-frame-col" },
            },
            field: { 
              store: { key: "ef-cfg_cls-frame-col" },
              enable: { key: "ef-cfg_use-cls-frame-col" },
            },
            slider: { 
              store: { key: "ef-cfg_cls-frame-col" },
              enable: { key: "ef-cfg_use-cls-frame-col" },
            },
          },
          blue: {
            label: { 
              text: "Blue",
              enable: { key: "ef-cfg_use-cls-frame-col" },
            },
            field: { 
              store: { key: "ef-cfg_cls-frame-col" },
              enable: { key: "ef-cfg_use-cls-frame-col" },
            },
            slider: { 
              store: { key: "ef-cfg_cls-frame-col" },
              enable: { key: "ef-cfg_use-cls-frame-col" },
            },
          },
          hex: { 
            label: { 
              text: "Hex",
              enable: { key: "ef-cfg_use-cls-frame-col" },
            },
            field: { 
              store: { key: "ef-cfg_cls-frame-col" },
              enable: { key: "ef-cfg_use-cls-frame-col" },
            },
          },
        },
      },
      {
        name: "ef-cfg_cls-frame-col-spd",  
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Speed",
            enable: { key: "ef-cfg_use-cls-frame-col" },
          },
          field: { 
            store: { key: "ef-cfg_cls-frame-col-spd" },
            enable: { key: "ef-cfg_use-cls-frame-col" },
          },
        },
      },
    ]),
  }
}