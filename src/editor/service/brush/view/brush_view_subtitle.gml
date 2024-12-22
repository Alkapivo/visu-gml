///@package io.alkapivo.visu.editor.service.brush.view

///@type {String[]}
global.__VISU_FONT = [
  "font_kodeo_mono_10_regular",
  "font_kodeo_mono_12_regular",
  "font_kodeo_mono_18_regular",
  "font_kodeo_mono_28_regular",
  "font_kodeo_mono_48_regular",

  "font_kodeo_mono_10_bold",
  "font_kodeo_mono_12_bold",
  "font_kodeo_mono_18_bold",
  "font_kodeo_mono_28_bold",
  "font_kodeo_mono_48_bold",

  "font_inter_8_regular",
  "font_inter_10_regular",
  "font_inter_12_regular",
  "font_inter_18_regular",
  "font_inter_24_regular",
  "font_inter_28_regular",

  "font_inter_8_bold",
  "font_inter_10_bold",
  "font_inter_12_bold",
  "font_inter_18_bold",
  "font_inter_24_bold",
  "font_inter_28_bold",

  "font_consolas_10_regular",
  "font_consolas_12_regular",
  "font_consolas_18_regular",
  "font_consolas_28_regular",

  "font_consolas_10_bold",
  "font_consolas_12_bold",
  "font_consolas_18_bold",
  "font_consolas_28_bold"
]
#macro VISU_FONT global.__VISU_FONT


///@param {?Struct} [json]
///@return {Struct}
function brush_view_subtitle(json = null) {
  return {
    name: "brush_view_subtitle",
    store: new Map(String, Struct, {
      "vw-sub_template": {
        type: String,
        value: Struct.get(json, "vw-sub_template"),
        passthrough: UIUtil.passthrough.getCallbackValue(),
        data: {
          callback: Beans.get(BeanVisuController).subtitleTemplateExists,
          defaultValue: "subtitle-default",
        },
      },
      "vw-sub_font": {
        type: String,
        value: Struct.get(json, "vw-sub_font"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: new Array(String, VISU_FONT),
      },
      "vw-sub-fh": {
        type: Number,
        value: Struct.get(json, "vw-sub-fh"),
        passthrough: UIUtil.passthrough.getClampedStringInteger(),
        data: new Vector2(0, 999),
      },
      "vw-sub_use-timeout": {
        type: Boolean,
        value: Struct.get(json, "vw-sub_use-timeout"),
      },
      "vw-sub_timeout": {
        type: Number,
        value: Struct.get(json, "vw-sub_timeout"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 999.9),
      },
      "vw-sub_col": {
        type: Color,
        value: Struct.get(json, "vw-sub_col"),
      },
      "vw-sub_use-outline": {
        type: Boolean,
        value: Struct.get(json, "vw-sub_use-outline"),
      },
      "vw-sub_outline": {
        type: Color,
        value: Struct.get(json, "vw-sub_outline"),
      },
      "vw-sub_align-v": {
        type: String,
        value: Struct.get(json, "vw-sub_align-v"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: new Array("String", [ "TOP", "BOTTOM" ]),
      },
      "vw-sub_align-h": {
        type: String,
        value: Struct.get(json, "vw-sub_align-h"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: new Array("String", [ "LEFT", "CENTER", "RIGHT" ]),
      },
      "vw-sub_x": {
        type: Number,
        value: Struct.get(json, "vw-sub_x"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(-5.0, 5.0),
      },
      "vw-sub_y": {
        type: Number,
        value: Struct.get(json, "vw-sub_y"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(-5.0, 5.0),
      },
      "vw-sub_w": {
        type: Number,
        value: Struct.get(json, "vw-sub_w"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 10.0),
      },
      "vw-sub_h": {
        type: Number,
        value: Struct.get(json, "vw-sub_h"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 10.0),
      },
      "vw-sub-char-spd": {
        type: Number,
        value: Struct.get(json, "vw-sub-char-spd"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.00001, 999.9),
      },
      "vw-sub_use-nl-delay": {
        type: Boolean,
        value: Struct.get(json, "vw-sub_use-nl-delay"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 999.9),
      },
      "vw-sub_nl-delay": {
        type: Number,
        value: Struct.get(json, "vw-sub_nl-delay"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 999.9),
      },
      "vw-sub_use-end-delay": {
        type: Boolean,
        value: Struct.get(json, "vw-sub_use-end-delay"),
      },
      "vw-sub_end-delay": {
        type: Number,
        value: Struct.get(json, "vw-sub_end-delay"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 999.9),
      },
      "vw-sub_use-dir": {
        type: Boolean,
        value: Struct.get(json, "vw-sub_use-dir"),
      },
      "vw-sub_dir": {
        type: NumberTransformer,
        value: Struct.get(json, "vw-sub_dir"),
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(-9999.9, 9999.9),
      },
      "vw-sub_change-dir": {
        type: Boolean,
        value: Struct.get(json, "vw-sub_change-dir"),
      },
      "vw-sub_use-spd": {
        type: Boolean,
        value: Struct.get(json, "vw-sub_use-spd"),
      },
      "vw-sub_spd": {
        type: NumberTransformer,
        value: Struct.get(json, "vw-sub_spd"),
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 999.9),
      },
      "vw-sub_change-spd": {
        type: Boolean,
        value: Struct.get(json, "vw-sub_change-spd"),
      },
      "vw-sub-fade-in": {
        type: Number,
        value: Struct.get(json, "vw-sub-fade-in"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 999.9),
      },
      "vw-sub-fade-out": {
        type: Number,
        value: Struct.get(json, "vw-sub-fade-out"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 999.9),
      },
    }),
    components: new Array(Struct, [
      {
        name: "vw-sub_template",  
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Template" },
          field: { store: { key: "vw-sub_template" } },
        },
      },
      {
        name: "vw-sub-char-spd",  
        template: VEComponents.get("text-field-increase"),
        layout: VELayouts.get("text-field-increase"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Speed",
            font: "font_inter_10_regular",
          },
          field: { store: { key: "vw-sub-char-spd" } },
          decrease: { 
            store: { key: "vw-sub-char-spd" },
            factor: -0.1,
          },
          increase: { 
            store: { key: "vw-sub-char-spd" },
            factor: 0.1,
          },
        },
      },
      {
        name: "vw-sub_char-spd-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },

      {
        name: "vw-sub-fade-in",  
        template: VEComponents.get("text-field-increase"),
        layout: VELayouts.get("text-field-increase"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Fade in (s)",
            font: "font_inter_10_regular",
          },
          field: { store: { key: "vw-sub-fade-in" } },
          decrease: { 
            store: { key: "vw-sub-fade-in" },
            factor: -0.25,
          },
          increase: { 
            store: { key: "vw-sub-fade-in" },
            factor: 0.25,
          },
        },
      },
      {
        name: "vw-sub-fade-out",  
        template: VEComponents.get("text-field-increase"),
        layout: VELayouts.get("text-field-increase"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Fade out (s)",
            font: "font_inter_10_regular",
          },
          field: { store: { key: "vw-sub-fade-out" } },
          decrease: { 
            store: { key: "vw-sub-fade-out" },
            factor: -0.25,
          },
          increase: { 
            store: { key: "vw-sub-fade-out" },
            factor: 0.25,
          },
        },
      },
      {
        name: "vw-sub_fade-out-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "vw-sub_nl-delay",
        template: VEComponents.get("text-field-increase-checkbox"),
        layout: VELayouts.get("text-field-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Line (s)",
            enable: { key: "vw-sub_use-nl-delay" },
          },  
          field: { 
            store: { key: "vw-sub_nl-delay" },
            enable: { key: "vw-sub_use-nl-delay" },
          },
          decrease: {
            store: { key: "vw-sub_nl-delay" },
            enable: { key: "vw-sub_use-nl-delay" },
            factor: -0.25,
          },
          increase: {
            store: { key: "vw-sub_nl-delay" },
            enable: { key: "vw-sub_use-nl-delay" },
            factor: 0.25,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-sub_use-nl-delay" },
          },
          title: { 
            text: "Enable",
            enable: { key: "vw-sub_use-nl-delay" },
          },
        },
      },
      {
        name: "vw-sub_end-delay",
        template: VEComponents.get("text-field-increase-checkbox"),
        layout: VELayouts.get("text-field-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "End (s)",
            enable: { key: "vw-sub_use-end-delay" },
          },  
          field: { 
            store: { key: "vw-sub_end-delay" },
            enable: { key: "vw-sub_use-end-delay" },
          },
          decrease: {
            store: { key: "vw-sub_end-delay" },
            enable: { key: "vw-sub_use-end-delay" },
            factor: -0.25,
          },
          increase: {
            store: { key: "vw-sub_end-delay" },
            enable: { key: "vw-sub_use-end-delay" },
            factor: 0.25,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-sub_use-end-delay" },
          },
          title: { 
            text: "Enable",
            enable: { key: "vw-sub_use-end-delay" },
          },
        },
      },
      {
        name: "vw-sub_timeout",
        template: VEComponents.get("text-field-increase-checkbox"),
        layout: VELayouts.get("text-field-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Timeout (s)",
            enable: { key: "vw-sub_use-timeout" },
          },  
          field: { 
            store: { key: "vw-sub_timeout" },
            enable: { key: "vw-sub_use-timeout" },
          },
          decrease: {
            store: { key: "vw-sub_timeout" },
            enable: { key: "vw-sub_use-timeout" },
            factor: -0.25,
          },
          increase: {
            store: { key: "vw-sub_timeout" },
            enable: { key: "vw-sub_use-timeout" },
            factor: 0.25,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-sub_use-timeout" },
          },
          title: { 
            text: "Enable",
            enable: { key: "vw-sub_use-timeout" },
          },
        },
      },
      {
        name: "vw-sub_timeout-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "vw-sub_area-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Subtitle area",
            backgroundColor: VETheme.color.accentShadow,
          },
          input: { backgroundColor: VETheme.color.accentShadow },
          checkbox: { backgroundColor: VETheme.color.accentShadow },
        },
      },
      {
        name: "vw-sub_x",  
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "X (%)" },
          field: { store: { key: "vw-sub_x" } },
          slider: { 
            minValue: -1.0,
            maxValue: 2.0,
            snapValue: 0.1 / 3.0,
            store: { key: "vw-sub_x" },
          },
          decrease: {
            store: { key: "vw-sub_x" },
            factor: -0.01,
          },
          increase: {
            store: { key: "vw-sub_x" },
            factor: 0.01,
          },
        },
      },
      {
        name: "vw-sub_y",  
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Y (%)" },
          field: { store: { key: "vw-sub_y" } },
          slider: { 
            minValue: -1.0,
            maxValue: 2.0,
            snapValue: 0.1 / 3.0,
            store: { key: "vw-sub_y" },
          },
          decrease: {
            store: { key: "vw-sub_y" },
            factor: -0.01,
          },
          increase: {
            store: { key: "vw-sub_y" },
            factor: 0.01,
          },
        },
      },
      {
        name: "vw-sub_w",  
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Width (%)" },
          field: { store: { key: "vw-sub_y" } },
          slider: { 
            minValue: -1.0,
            maxValue: 2.0,
            snapValue: 0.1 / 3.0,
            store: { key: "vw-sub_w" },
          },
          decrease: {
            store: { key: "vw-sub_w" },
            factor: -0.01,
          },
          increase: {
            store: { key: "vw-sub_w" },
            factor: 0.01,
          },
        },
      },
      {
        name: "vw-sub_h",  
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Height (%)" },
          field: { store: { key: "vw-sub_y" } },
          slider: { 
            minValue: -1.0,
            maxValue: 2.0,
            snapValue: 0.1 / 3.0,
            store: { key: "vw-sub_h" },
          },
          decrease: {
            store: { key: "vw-sub_h" },
            factor: -0.01,
          },
          increase: {
            store: { key: "vw-sub_h" },
            factor: 0.01,
          },
        },
      },
      {
        name: "vw-sub_h-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "vw-sub_typography-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Typography",
            backgroundColor: VETheme.color.accentShadow,
          },
          input: { backgroundColor: VETheme.color.accentShadow },
          checkbox: { backgroundColor: VETheme.color.accentShadow },
        },
      },
      {
        name: "vw-sub_font",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Font family" },
          previous: { store: { key: "vw-sub_font" } },
          preview: Struct.appendRecursive({ 
            store: { key: "vw-sub_font" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: { store: { key: "vw-sub_font" } },
        },
      },
      {
        name: "vw-sub-fh",  
        template: VEComponents.get("text-field-increase"),
        layout: VELayouts.get("text-field-increase"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Leading",
            font: "font_inter_10_regular",
          },
          field: { store: { key: "vw-sub-fh" } },
          decrease: { 
            store: { key: "vw-sub-fh" },
            factor: -1.0,
          },
          increase: { 
            store: { key: "vw-sub-fh" },
            factor: 1.0,
          },
        },
      },
      {
        name: "vw-sub_fh-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "vw-sub_align-v",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Align X" },
          previous: { store: { key: "vw-sub_align-v" } },
          preview: Struct.appendRecursive({ 
            store: { key: "vw-sub_align-v" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: { store: { key: "vw-sub_align-v" } },
        },
      },
      {
        name: "vw-sub_align-h",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Align Y" },
          previous: { store: { key: "vw-sub_align-h" } },
          preview: Struct.appendRecursive({ 
            store: { key: "vw-sub_align-h" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: { store: { key: "vw-sub_align-h" } },
        },
      },
      {
        name: "vw-sub_align-h-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "vw-sub_col",
        template: VEComponents.get("color-picker"),
        layout: VELayouts.get("color-picker"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          title: {
            label: { text: "Color" },  
            input: { store: { key: "vw-sub_col" } }
          },
          red: {
            label: { text: "Red" },
            field: { store: { key: "vw-sub_col" } },
            slider: { store: { key: "vw-sub_col" } },
          },
          green: {
            label: { text: "Green", },
            field: { store: { key: "vw-sub_col" } },
            slider: { store: { key: "vw-sub_col" } },
          },
          blue: {
            label: { text: "Blue" },
            field: { store: { key: "vw-sub_col" } },
            slider: { store: { key: "vw-sub_col" } },
          },
          hex: { 
            label: { text: "Hex" },
            field: { store: { key: "vw-sub_col" } },
          },
        },
      },
      {
        name: "vw-sub_outline",
        template: VEComponents.get("color-picker"),
        layout: VELayouts.get("color-picker"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          title: {
            label: { 
              text: "Outline color",
              enable: { key: "vw-sub_use-outline" },
            },  
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-sub_use-outline" },
            },
            input: { 
              store: { key: "vw-sub_outline" },
              enable: { key: "vw-sub_use-outline" },
            }
          },
          red: {
            label: { 
              text: "Red",
              enable: { key: "vw-sub_use-outline" },
            },
            field: { 
              store: { key: "vw-sub_outline" },
              enable: { key: "vw-sub_use-outline" },
            },
            slider: { 
              store: { key: "vw-sub_outline" },
              enable: { key: "vw-sub_use-outline" },
            },
          },
          green: {
            label: { 
              text: "Green",
              enable: { key: "vw-sub_use-outline" },
            },
            field: { 
              store: { key: "vw-sub_outline" },
              enable: { key: "vw-sub_use-outline" },
            },
            slider: { 
              store: { key: "vw-sub_outline" },
              enable: { key: "vw-sub_use-outline" },
            },
          },
          blue: {
            label: { 
              text: "Blue",
              enable: { key: "vw-sub_use-outline" },
            },
            field: { 
              store: { key: "vw-sub_outline" },
              enable: { key: "vw-sub_use-outline" },
            },
            slider: { 
              store: { key: "vw-sub_outline" },
              enable: { key: "vw-sub_use-outline" },
            },
          },
          hex: { 
            label: { 
              text: "Hex",
              enable: { key: "vw-sub_use-outline" },
            },
            field: { 
              store: { key: "vw-sub_outline" },
              enable: { key: "vw-sub_use-outline" },
            },
          },
        },
      },
      {
        name: "vw-sub_movement-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Subtitle movement",
            backgroundColor: VETheme.color.accentShadow,
          },
          input: { backgroundColor: VETheme.color.accentShadow },
          checkbox: { backgroundColor: VETheme.color.accentShadow },
        },
      },
      {
        name: "vw-sub_spd",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Speed",
              font: "font_inter_10_bold",
              color: VETheme.color.textFocus,
            },
            field: {
              store: { key: "vw-sub_spd" },
            },
            decrease: { 
              store: { key: "vw-sub_spd" },
              factor: -1.0,
            },
            increase: { 
              store: { key: "vw-sub_spd" },
              factor: 1.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-sub_use-spd" },
            },
            title: { 
              text: "Enable",
              enable: { key: "vw-sub_use-spd" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "vw-sub_change-spd" },
            },
            field: {
              store: { key: "vw-sub_spd" },
              enable: { key: "vw-sub_change-spd" },
            },
            decrease: { 
              store: { key: "vw-sub_spd" },
              enable: { key: "vw-sub_change-spd" },
              factor: -1.0,
            },
            increase: { 
              store: { key: "vw-sub_spd" },
              enable: { key: "vw-sub_change-spd" },
              factor: 1.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-sub_change-spd" },
            },
            title: { 
              text: "Change",
              enable: { key: "vw-sub_change-spd" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "vw-sub_change-spd" },
            },
            field: {
              store: { key: "vw-sub_spd" },
              enable: { key: "vw-sub_change-spd" },
            },
            decrease: { 
              store: { key: "vw-sub_spd" },
              enable: { key: "vw-sub_change-spd" },
              factor: -1.0,
            },
            increase: { 
              store: { key: "vw-sub_spd" },
              enable: { key: "vw-sub_change-spd" },
              factor: 1.0,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "vw-sub_change-spd" },
            },
            field: {
              store: { key: "vw-sub_spd" },
              enable: { key: "vw-sub_change-spd" },
            },
            decrease: { 
              store: { key: "vw-sub_spd" },
              enable: { key: "vw-sub_change-spd" },
              factor: -1.0,
            },
            increase: { 
              store: { key: "vw-sub_spd" },
              enable: { key: "vw-sub_change-spd" },
              factor: 1.0,
            },
          },
        },
      },
      {
        name: "vw-sub_spd-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "vw-sub_dir",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Angle",
              font: "font_inter_10_bold",
              color: VETheme.color.textFocus,
            },
            field: {
              store: { key: "vw-sub_dir" },
            },
            decrease: { 
              store: { key: "vw-sub_dir" },
              factor: -1.0,
            },
            increase: { 
              store: { key: "vw-sub_dir" },
              factor: 1.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-sub_use-dir" },
            },
            title: { 
              text: "Enable",
              enable: { key: "vw-sub_use-dir" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "en-cfg_change-z-bullet" },
            },
            field: {
              store: { key: "vw-sub_dir" },
              enable: { key: "en-cfg_change-z-bullet" },
            },
            decrease: { 
              store: { key: "vw-sub_dir" },
              enable: { key: "en-cfg_change-z-bullet" },
              factor: -1.0,
            },
            increase: { 
              store: { key: "vw-sub_dir" },
              enable: { key: "en-cfg_change-z-bullet" },
              factor: 1.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "en-cfg_change-z-bullet" },
            },
            title: { 
              text: "Change",
              enable: { key: "en-cfg_change-z-bullet" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "en-cfg_change-z-bullet" },
            },
            field: {
              store: { key: "vw-sub_dir" },
              enable: { key: "en-cfg_change-z-bullet" },
            },
            decrease: { 
              store: { key: "vw-sub_dir" },
              enable: { key: "en-cfg_change-z-bullet" },
              factor: -1.0,
            },
            increase: { 
              store: { key: "vw-sub_dir" },
              enable: { key: "en-cfg_change-z-bullet" },
              factor: 1.0,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "en-cfg_change-z-bullet" },
            },
            field: {
              store: { key: "vw-sub_dir" },
              enable: { key: "en-cfg_change-z-bullet" },
            },
            decrease: { 
              store: { key: "vw-sub_dir" },
              enable: { key: "en-cfg_change-z-bullet" },
              factor: -1.0,
            },
            increase: { 
              store: { key: "vw-sub_dir" },
              enable: { key: "en-cfg_change-z-bullet" },
              factor: 1.0,
            },
          },
        },
      },
    ]),
  }
}


/*
"brush_view_old_lyrics": function(data) {
  var controller = Beans.get(BeanVisuController)

  var align = { v: VAlign.TOP, h: HAlign.LEFT }
  var alignV = Struct.get(data, "vw-sub_align-v")
  var alignH = Struct.get(data, "vw-sub_align-h")
  if (alignV == "BOTTOM") {
    align.v = VAlign.BOTTOM
  }
  if (alignH == "CENTER") {
    align.h = HAlign.CENTER
  } else if (alignH == "RIGHT") {
    align.h = HAlign.RIGHT
  }

  controller.subtitleService.send(new Event("add")
    .setData({
      template: Struct.get(data, "vw-sub_template"),
      font: FontUtil.fetch(Struct.get(data, "vw-sub_font")),
      fontHeight: Struct.get(data, "vw-sub-fh"),
      charSpeed: Struct.get(data, "vw-sub-char-spd"),
      color: ColorUtil.fromHex(Struct.get(data, "vw-sub_col")).toGMColor(),
      outline: Struct.get(data, "vw-sub_use-outline")
        ? ColorUtil.fromHex(Struct.get(data, "vw-sub_outline")).toGMColor()
        : null,
      timeout: Struct.get(data, "vw-sub_use-timeout")
        ? Struct.get(data, "vw-sub_timeout")
        : null,
      align: align,
      area: new Rectangle({ 
        x: Struct.get(data, "vw-sub_x"),
        y: Struct.get(data, "vw-sub_y"),
        width: Struct.get(data, "vw-sub_w"),
        height: Struct.get(data, "vw-sub_h"),
      }),
      lineDelay: Struct.get(data, "vw-sub_use-nl-delay")
        ? new Timer(Struct.get(data, "vw-sub_nl-delay"))
        : null,
      finishDelay: Struct.get(data, "vw-sub_use-end-delay")
        ? new Timer(Struct.get(data, "vw-sub_end-delay"))
        : null,
      angleTransformer: Struct.get(data, "vw-sub_use-dir")
        ? new NumberTransformer(Struct.get(data, "vw-sub_dir"))
        : new NumberTransformer({ value: 0.0, target: 0.0, factor: 0.0, increase: 0.0 }),
      speedTransformer: Struct.get(data, "vw-sub_use-spd")
        ? new NumberTransformer(Struct.get(data, "vw-sub_spd"))
        : null,
      fadeIn: Struct.get(data, "vw-sub-fade-in"),
      fadeOut: Struct.get(data, "vw-sub-fade-out"),
    }))
},
*/