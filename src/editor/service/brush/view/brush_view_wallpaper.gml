///@package io.alkapivo.visu.editor.service.brush.view

///@static
///@type {Array<String>}
global.__WALLPAPER_TYPES = [
  "Background",
  "Foreground",
]
#macro WALLPAPER_TYPES global.__WALLPAPER_TYPES


///@static
///@type {GMArray<String>}
global.__BLEND_MODES_EXT = [
  "ONE",
  "ZERO",
  "SRC_ALPHA",
  "INV_SRC_ALPHA",
  "SRC_COLOUR",
  "INV_SRC_COLOUR",
  "SRC_ALPHA_SAT",
  "DEST_ALPHA",
  "INV_DEST_ALPHA",
  "DEST_COLOUR",
  "INV_DEST_COLOUR"
]
#macro BLEND_MODES_EXT global.__BLEND_MODES_EXT


///@static
///@type {GMArray<String>}
global.__BLEND_EQUATIONS = [
  "ADD",
  "SUBTRACT",
  "REVERSE_SUBTRACT",
  "MIN",
  "MAX"
]
#macro BLEND_EQUATIONS global.__BLEND_EQUATIONS


///@param {?Struct} [json]
///@return {Struct}
function brush_view_wallpaper(json = null) {
  return {
    name: "brush_view_wallpaper",
    store: new Map(String, Struct, {
      "vw-layer_type": {
        type: String,
        value: Struct.getDefault(json, "vw-layer_type", WALLPAPER_TYPES[0]),
        validate: function(value) {
          Assert.areEqual(true, this.data.contains(value))
        },
        data: new Array(String, WALLPAPER_TYPES),
      },
      "vw-layer_fade-in": {
        type: Number,
        value: Struct.getIfType(json, "vw-layer_fade-in", Number, 0.0),
        passthrough: function(value) {
          return NumberUtil.parse(value, this.value)
        },
      },
      "vw-layer_fade-out": {
        type: Number,
        value: Struct.getIfType(json, "vw-layer_fade-out", Number, 0.0),
        passthrough: function(value) {
          return NumberUtil.parse(value, this.value)
        },
      },
      "vw-layer_use-texture": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-layer_use-texture", Boolean, true),
      },
      "vw-layer_texture": {
        type: Sprite,
        value: SpriteUtil.parse(Struct.getIfType(json, "vw-layer_texture", Struct), { 
          name: "texture_missing"
        }),
      },
      "vw-layer_use-texture-blend": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-layer_use-texture-blend", Boolean, true),
      },
      "vw-layer_texture-blend": {
        type: Color,
        value: ColorUtil.fromHex(Struct.getIfType(json, "vw-layer_texture-blend", String), ColorUtil.fromHex("#ffffff")),
      },
      "vw-layer_use-col": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-layer_use-col", Boolean, false),
      },
      "vw-layer_col": {
        type: Color,
        value: ColorUtil.fromHex(Struct.getIfType(json, "vw-layer_col", String), ColorUtil.fromHex("#ffffffff")),
      },
      "vw-layer_cls-texture": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-layer_cls-texture", Boolean, false),
      },
      "vw-layer_cls-color": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-layer_cls-color", Boolean, false),
      },
      "vw-layer_use-blend": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-layer_use-blend", Boolean, false),
      },
      "vw-layer_blend-src": {
        type: String,
        value: Struct.getDefault(json, "vw-layer_blend-src", "SRC_ALPHA"),
        validate: function(value) {
          Assert.areEqual(true, this.data.contains(value))
        },
        data: new Array(String, BLEND_MODES_EXT),
      },
      "vw-layer_blend-dest": {
        type: String,
        value: Struct.getDefault(json, "vw-layer_blend-dest", Struct.get(json, "vw-layer_type") == "Background" ? "INV_SRC_ALPHA" : "ONE"),
        validate: function(value) {
          Assert.areEqual(true, this.data.contains(value))
        },
        data: new Array(String, BLEND_MODES_EXT),
      },
      "vw-layer_blend-eq": {
        type: String,
        value: Struct.getDefault(json, "vw-layer_blend-eq", "ADD"),
        validate: function(value) {
          Assert.areEqual(true, this.data.contains(value))
        },
        data: new Array(String, BLEND_EQUATIONS),
      },
      "vw-layer_use-spd": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-layer_use-spd", Boolean, false),
      },
      "vw-layer_spd": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getIfType(json, "vw-layer_spd", Struct, {
          value: 0.0,
          target: 0.0,
          factor: 0.0,
          increase: 0.0,
        })),
        passthrough: function(value) {
          if (!Core.isType(value, NumberTransformer)) {
            return this.value
          }
  
          value.value = clamp(value.value, 0.0, 99.9)
          value.target = clamp(value.target, 0.0, 99.9)
          return value
        },
      },
      "vw-layer_change-spd": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-layer_change-spd", Boolean, false),
      },
      "vw-layer_use-dir": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-layer_use-dir", Boolean, false),
      },
      "vw-layer_dir": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getIfType(json, "vw-layer_dir", Struct, {
          value: 0.0,
          target: 0.0,
          factor: 0.0,
          increase: 0.0,
        })),
        passthrough: function(value) {
          if (!Core.isType(value, NumberTransformer)) {
            return this.value
          }

          value.value = clamp(value.value, -999.9, 999.9)
          value.target = clamp(value.target, -999.9, 999.9)
          return value
        },
      },
      "vw-layer_change-dir": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-layer_change-dir", Boolean, false),
      },
      "vw-layer_use-scale-x": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-layer_use-scale-x", Boolean, false),
      },
      "vw-layer_scale-x": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getIfType(json, "vw-layer_scale-x", Struct, {
          value: 0.0,
          target: 0.0,
          factor: 0.0,
          increase: 0.0,
        })),
        passthrough: function(value) {
          if (!Core.isType(value, NumberTransformer)) {
            return this.value
          }

          value.value = clamp(value.value, -99.9, 99.9)
          value.target = clamp(value.target, -99.9, 99.9)
          return value
        },
      },
      "vw-layer_change-scale-x": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-layer_change-scale-x", Boolean, false),
      },
      "vw-layer_use-scale-y": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-layer_use-scale-y", Boolean, false),
      },
      "vw-layer_scale-y": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getIfType(json, "vw-layer_scale-y", Struct, {
          value: 0.0,
          target: 0.0,
          factor: 0.0,
          increase: 0.0,
        })),
        passthrough: function(value) {
          if (!Core.isType(value, NumberTransformer)) {
            return this.value
          }

          value.value = clamp(value.value, -99.9, 99.9)
          value.target = clamp(value.target, -99.9, 99.9)
          return value
        },
      },
      "vw-layer_change-scale-y": {
        type: Boolean,
        value: Struct.getIfType(json, "vw-layer_change-scale-y", Boolean, false),
      },
    }),
    components: new Array(Struct, [
      {
        name: "vw-layer_type",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Type" },
          previous: { store: { key: "vw-layer_type" } },
          preview: Struct.appendRecursive({ 
            store: { key: "vw-layer_type" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: { store: { key: "vw-layer_type" } },
        },
      },
      {
        name: "vw-layer_fade-in",  
        template: VEComponents.get("text-field-increase"),
        layout: VELayouts.get("text-field-increase"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Fade in" },
          field: { store: { key: "vw-layer_fade-in" } },
          decrease: {
            store: { key: "vw-layer_fade-in" },
            factor: -0.25,
          },
          increase: {
            store: { key: "vw-layer_fade-in" },
            factor: 0.25,
          },
        },
      },
      {
        name: "vw-layer_fade-out",  
        template: VEComponents.get("text-field-increase"),
        layout: VELayouts.get("text-field-increase"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Fade out" },
          field: { store: { key: "vw-layer_fade-out" } },
          decrease: {
            store: { key: "vw-layer_fade-out" },
            factor: -0.25,
          },
          increase: {
            store: { key: "vw-layer_fade-out" },
            factor: 0.25,
          },
        },
      },
      {
        name: "vw-layer_fade-out-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "vw-layer_texture",
        template: VEComponents.get("texture-field"),
        layout: VELayouts.get("texture-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          title: {
            label: { 
              text: "Wallpaper texture",
              enable: { key: "vw-layer_use-texture" },
              backgroundColor: VETheme.color.accentShadow,
            },
            input: { backgroundColor: VETheme.color.accentShadow },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-layer_use-texture" },
              backgroundColor: VETheme.color.accentShadow,
            },
          },
          texture: {
            label: { enable: { key: "vw-layer_use-texture" } }, 
            field: {
              store: { key: "vw-layer_texture" },
              enable: { key: "vw-layer_use-texture" },
            },
          },
          preview: {
            image: { name: "texture_empty" },
            store: { key: "vw-layer_texture" },
            enable: { key: "vw-layer_use-texture" },
            imageBlendStoreKey: "vw-layer_texture-blend",
            useImageBlendStoreKey: "vw-layer_use-texture-blend",
            updateCustom: function() {
              var key = Struct.get(this, "imageBlendStoreKey")
              var use = Struct.get(this, "useImageBlendStoreKey")
              if (!Core.isType(this.store, UIStore) ||
                  !Core.isType(key, String) ||
                  !Core.isType(use, String) ||
                  !Core.isType(this.image, Sprite)) {
                return
              }

              var store = this.store.getStore()
              if (!Core.isType(store, Store)) {
                return
              }

              var color = store.getValue(key)
              if (!Core.isType(color, Color)) {
                return
              }

              this.image.setBlend(store.getValue(use) ? color.toGMColor() : c_white)
            },
          },
          resolution: {
            store: { key: "vw-layer_texture" },
            enable: { key: "vw-layer_use-texture" },
          },
          frame: {
            label: { enable: { key: "vw-layer_use-texture" } },
            field: { 
              store: { key: "vw-layer_texture" },
              enable: { key: "vw-layer_use-texture" },
            },
            decrease: { 
              store: { key: "vw-layer_texture" },
              enable: { key: "vw-layer_use-texture" },
            },
            increase: { 
              store: { key: "vw-layer_texture" },
              enable: { key: "vw-layer_use-texture" },
            },
            checkbox: { 
              store: { key: "vw-layer_texture" },
              enable: { key: "vw-layer_use-texture" },
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
            },
            title: { enable: { key: "vw-layer_use-texture" } },
          },
          speed: {
            label: { enable: { key: "vw-layer_use-texture" } },
            field: { 
              enable: { key: "vw-layer_use-texture" },
              store: { key: "vw-layer_texture" },
            },
            decrease: { 
              store: { key: "vw-layer_texture" },
              enable: { key: "vw-layer_use-texture" },
            },
            increase: { 
              store: { key: "vw-layer_texture" },
              enable: { key: "vw-layer_use-texture" },
            },
            checkbox: { 
              store: { key: "vw-layer_texture" },
              enable: { key: "vw-layer_use-texture" },
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
            },
            title: { enable: { key: "vw-layer_use-texture" } },
          },
          alpha: {
            label: { enable: { key: "vw-layer_use-texture" } },
            field: { 
              enable: { key: "vw-layer_use-texture" },
              store: { key: "vw-layer_texture" },
            },
            decrease: { 
              store: { key: "vw-layer_texture" },
              enable: { key: "vw-layer_use-texture" },
            },
            increase: { 
              store: { key: "vw-layer_texture" },
              enable: { key: "vw-layer_use-texture" },
            },
            slider: { 
              store: { key: "vw-layer_texture" },
            },
          },
        },
      },
      {
        name: "vw-layer_texture-blend",
        template: VEComponents.get("color-picker"),
        layout: VELayouts.get("color-picker"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          title: { 
            label: { 
              text: "Texture blend",
              enable: { key: "vw-layer_use-texture-blend" },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              enable: { key: "vw-layer_use-texture" },
              store: { key: "vw-layer_use-texture-blend" },
            },
            input: { 
              store: { key: "vw-layer_texture-blend" },
              enable: { key: "vw-layer_use-texture-blend" },
            }
          },
          red: {
            label: {
              text: "Red",
              enable: { key: "vw-layer_use-texture-blend" },
            },
            field: {
              store: { key: "vw-layer_texture-blend" },
              enable: { key: "vw-layer_use-texture-blend" },
            },
            slider: {
              store: { key: "vw-layer_texture-blend" },
              enable: { key: "vw-layer_use-texture-blend" },
            },
          },
          green: {
            label: {
              text: "Green",
              enable: { key: "vw-layer_use-texture-blend" },
            },
            field: {
              store: { key: "vw-layer_texture-blend" },
              enable: { key: "vw-layer_use-texture-blend" },
            },
            slider: {
              store: { key: "vw-layer_texture-blend" },
              enable: { key: "vw-layer_use-texture-blend" },
            },
          },
          blue: {
            label: {
              text: "Blue",
              enable: { key: "vw-layer_use-texture-blend" },
            },
            field: {
              store: { key: "vw-layer_texture-blend" },
              enable: { key: "vw-layer_use-texture-blend" },
            },
            slider: {
              store: { key: "vw-layer_texture-blend" },
              enable: { key: "vw-layer_use-texture-blend" },
            },
          },
          hex: { 
            label: {
              text: "Hex",
              enable: { key: "vw-layer_use-texture-blend" },
            },
            field: {
              store: { key: "vw-layer_texture-blend" },
              enable: { key: "vw-layer_use-texture-blend" },
            },
          },
        },
      },
      {
        name: "vw-layer_cls-texture",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Remove texture",
            enable: { key: "vw-layer_cls-texture" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-layer_cls-texture" },
          },
        },
      },
      {
        name: "vw-layer_cls-texture-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "vw-layer_col",
        template: VEComponents.get("color-picker"),
        layout: VELayouts.get("color-picker-alpha"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          title: {
            label: { 
              text: "Wallpaper color",
              enable: { key: "vw-layer_use-col" },
              backgroundColor: VETheme.color.accentShadow,
            },  
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-layer_use-col" },
              backgroundColor: VETheme.color.accentShadow,
            },
            input: { 
              store: { key: "vw-layer_col" },
              enable: { key: "vw-layer_use-col" },
              backgroundColor: VETheme.color.accentShadow,
            }
          },
          red: {
            label: { 
              text: "Red",
              enable: { key: "vw-layer_use-col" },
            },
            field: { 
              store: { key: "vw-layer_col" },
              enable: { key: "vw-layer_use-col" },
            },
            slider: { 
              store: { key: "vw-layer_col" },
              enable: { key: "vw-layer_use-col" },
            },
          },
          green: {
            label: { 
              text: "Green",
              enable: { key: "vw-layer_use-col" },
            },
            field: { 
              store: { key: "vw-layer_col" },
              enable: { key: "vw-layer_use-col" },
            },
            slider: { 
              store: { key: "vw-layer_col" },
              enable: { key: "vw-layer_use-col" },
            },
          },
          blue: {
            label: { 
              text: "Blue",
              enable: { key: "vw-layer_use-col" },
            },
            field: { 
              store: { key: "vw-layer_col" },
              enable: { key: "vw-layer_use-col" },
            },
            slider: { 
              store: { key: "vw-layer_col" },
              enable: { key: "vw-layer_use-col" },
            },
          },
          alpha: {
            label: { 
              text: "Alpha",
              enable: { key: "vw-layer_use-col" },
            },
            field: { 
              store: { key: "vw-layer_col" },
              enable: { key: "vw-layer_use-col" },
            },
            slider: { 
              store: { key: "vw-layer_col" },
              enable: { key: "vw-layer_use-col" },
            },
          },
          hex: { 
            label: { 
              text: "Hex",
              enable: { key: "vw-layer_use-col" },
            },
            field: { 
              store: { key: "vw-layer_col" },
              enable: { key: "vw-layer_use-col" },
            },
          },
        },
      },
      {
        name: "vw-layer_cls-color",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Remove color",
            enable: { key: "vw-layer_cls-color" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-layer_cls-color" },
          },
        },
      },
      {
        name: "vw-layer_cls-color-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "vw-layer_use-blend",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Wallpaper blend mode",
            backgroundColor: VETheme.color.accentShadow,
            enable: { key: "vw-layer_use-blend" },
          },
          input: { backgroundColor: VETheme.color.accentShadow },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "vw-layer_use-blend" },
            backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "vw-layer_blend-src",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Source",
            enable: { key: "vw-layer_use-blend" },
          },
          previous: {
            store: { key: "vw-layer_blend-src" },
            enable: { key: "vw-layer_use-blend" },
          },
          preview: Struct.appendRecursive({ 
            store: { key: "vw-layer_blend-src" },
            enable: { key: "vw-layer_use-blend" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: { 
            store: { key: "vw-layer_blend-src" },
            enable: { key: "vw-layer_use-blend" },
          },
        },
      },
      {
        name: "vw-layer_blend-dest",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Destination",
            enable: { key: "vw-layer_use-blend" },
          },
          previous: {
            store: { key: "vw-layer_blend-dest" },
            enable: { key: "vw-layer_use-blend" },
          },
          preview: Struct.appendRecursive({ 
            store: { key: "vw-layer_blend-dest" },
            enable: { key: "vw-layer_use-blend" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: { 
            store: { key: "vw-layer_blend-dest" },
            enable: { key: "vw-layer_use-blend" },
          },
        },
      },
      {
        name: "vw-layer_blend-eq",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Equation",
            enable: { key: "vw-layer_use-blend" },
          },
          previous: {
            store: { key: "vw-layer_blend-eq" },
            enable: { key: "vw-layer_use-blend" },
          },
          preview: Struct.appendRecursive({ 
            store: { key: "vw-layer_blend-eq" },
            enable: { key: "vw-layer_use-blend" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: {
            store: { key: "vw-layer_blend-eq" },
            enable: { key: "vw-layer_use-blend" },
          },
        },
      },
      {
        name: "vw-layer_blend-eq-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "vw-layer_position-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Wallpaper position",
            backgroundColor: VETheme.color.accentShadow,
          },
          input: { backgroundColor: VETheme.color.accentShadow },
          checkbox: { backgroundColor: VETheme.color.accentShadow },
        },
      },
      {
        name: "vw-layer_spd",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Speed",
              font: "font_inter_10_bold",
              color: VETheme.color.textFocus,
              enable: { key: "vw-layer_use-spd" },
            },
            field: {
              store: { key: "vw-layer_spd" },
              enable: { key: "vw-layer_use-spd" },
            },
            decrease: {
              store: { key: "vw-layer_spd" },
              enable: { key: "vw-layer_use-spd" },
              factor: -0.25,
            },
            increase: {
              store: { key: "vw-layer_spd" },
              enable: { key: "vw-layer_use-spd" },
              factor: 0.25,        
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-layer_use-spd" },
            },
            title: { 
              text: "Override",
              enable: { key: "vw-layer_use-spd" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "vw-layer_change-spd" },
            },
            field: {
              store: { key: "vw-layer_spd" },
              enable: { key: "vw-layer_change-spd" },
            },
            decrease: {
              store: { key: "vw-layer_spd" },
              enable: { key: "vw-layer_change-spd" },
              factor: -0.25,
            },
            increase: {
              store: { key: "vw-layer_spd" },
              enable: { key: "vw-layer_change-spd" },
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-layer_change-spd" },
            },
            title: { 
              text: "Change",
              enable: { key: "vw-layer_change-spd" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "vw-layer_change-spd" },
            },
            field: {
              store: { key: "vw-layer_spd" },
              enable: { key: "vw-layer_change-spd" },
            },
            decrease: {
              store: { key: "vw-layer_spd" },
              enable: { key: "vw-layer_change-spd" },
              factor: -0.01,
            },
            increase: {
              store: { key: "vw-layer_spd" },
              enable: { key: "vw-layer_change-spd" },
              factor: 0.01,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "vw-layer_change-spd" },
            },
            field: {
              store: { key: "vw-layer_spd" },
              enable: { key: "vw-layer_change-spd" },
            },
            decrease: {
              store: { key: "vw-layer_spd" },
              enable: { key: "vw-layer_change-spd" },
              factor: -0.001,
            },
            increase: {
              store: { key: "vw-layer_spd" },
              enable: { key: "vw-layer_change-spd" },
              factor: 0.001,      
            },
          },
        },
      },
      {
        name: "vw-layer_spd-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "vw-layer_dir",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Angle",
              font: "font_inter_10_bold",
              color: VETheme.color.textFocus,
              enable: { key: "vw-layer_use-dir" },
            },
            field: {
              store: { key: "vw-layer_dir" },
              enable: { key: "vw-layer_use-dir" },
            },
            decrease: {
              store: { key: "vw-layer_dir" },
              enable: { key: "vw-layer_use-dir" },
              factor: -0.25,
            },
            increase: {
              store: { key: "vw-layer_dir" },
              enable: { key: "vw-layer_use-dir" },
              factor: 0.25,        
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-layer_use-dir" },
            },
            title: { 
              text: "Override",
              enable: { key: "vw-layer_use-dir" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "vw-layer_change-dir" },
            },
            field: {
              store: { key: "vw-layer_dir" },
              enable: { key: "vw-layer_change-dir" },
            },
            decrease: {
              store: { key: "vw-layer_dir" },
              enable: { key: "vw-layer_change-dir" },
              factor: -0.25,
            },
            increase: {
              store: { key: "vw-layer_dir" },
              enable: { key: "vw-layer_change-dir" },
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-layer_change-dir" },
            },
            title: { 
              text: "Change",
              enable: { key: "vw-layer_change-dir" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "vw-layer_change-dir" },
            },
            field: {
              store: { key: "vw-layer_dir" },
              enable: { key: "vw-layer_change-dir" },
            },
            decrease: {
              store: { key: "vw-layer_dir" },
              enable: { key: "vw-layer_change-dir" },
              factor: -0.01,
            },
            increase: {
              store: { key: "vw-layer_dir" },
              enable: { key: "vw-layer_change-dir" },
              factor: 0.01,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "vw-layer_change-dir" },
            },
            field: {
              store: { key: "vw-layer_dir" },
              enable: { key: "vw-layer_change-dir" },
            },
            decrease: {
              store: { key: "vw-layer_dir" },
              enable: { key: "vw-layer_change-dir" },
              factor: -0.001,
            },
            increase: {
              store: { key: "vw-layer_dir" },
              enable: { key: "vw-layer_change-dir" },
              factor: 0.001,      
            },
          },
        },
      },
      {
        name: "vw-layer_dir-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "vw-layer_scale-x",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Scale Y",
              font: "font_inter_10_bold",
              color: VETheme.color.textFocus,
              enable: { key: "vw-layer_use-scale-x" },
            },
            field: {
              store: { key: "vw-layer_scale-x" },
              enable: { key: "vw-layer_use-scale-x" },
            },
            decrease: {
              store: { key: "vw-layer_scale-x" },
              enable: { key: "vw-layer_use-scale-x" },
              factor: -0.25,
            },
            increase: {
              store: { key: "vw-layer_scale-x" },
              enable: { key: "vw-layer_use-scale-x" },
              factor: 0.25,        
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-layer_use-scale-x" },
            },
            title: { 
              text: "Override",
              enable: { key: "vw-layer_use-scale-x" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "vw-layer_change-scale-x" },
            },
            field: {
              store: { key: "vw-layer_scale-x" },
              enable: { key: "vw-layer_change-scale-x" },
            },
            decrease: {
              store: { key: "vw-layer_scale-x" },
              enable: { key: "vw-layer_change-scale-x" },
              factor: -0.25,
            },
            increase: {
              store: { key: "vw-layer_scale-x" },
              enable: { key: "vw-layer_change-scale-x" },
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-layer_change-scale-x" },
            },
            title: { 
              text: "Change",
              enable: { key: "vw-layer_change-scale-x" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "vw-layer_change-scale-x" },
            },
            field: {
              store: { key: "vw-layer_scale-x" },
              enable: { key: "vw-layer_change-scale-x" },
            },
            decrease: {
              store: { key: "vw-layer_scale-x" },
              enable: { key: "vw-layer_change-scale-x" },
              factor: -0.01,
            },
            increase: {
              store: { key: "vw-layer_scale-x" },
              enable: { key: "vw-layer_change-scale-x" },
              factor: 0.01,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "vw-layer_change-scale-x" },
            },
            field: {
              store: { key: "vw-layer_scale-x" },
              enable: { key: "vw-layer_change-scale-x" },
            },
            decrease: {
              store: { key: "vw-layer_scale-x" },
              enable: { key: "vw-layer_change-scale-x" },
              factor: -0.001,
            },
            increase: {
              store: { key: "vw-layer_scale-x" },
              enable: { key: "vw-layer_change-scale-x" },
              factor: 0.001,      
            },
          },
        },
      },
      {
        name: "vw-layer_scale-x-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "vw-layer_scale-y",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Scale Y",
              font: "font_inter_10_bold",
              color: VETheme.color.textFocus,
              enable: { key: "vw-layer_use-scale-y" },
            },
            field: {
              store: { key: "vw-layer_scale-y" },
              enable: { key: "vw-layer_use-scale-y" },
            },
            decrease: {
              store: { key: "vw-layer_scale-y" },
              enable: { key: "vw-layer_use-scale-y" },
              factor: -0.25,
            },
            increase: {
              store: { key: "vw-layer_scale-y" },
              enable: { key: "vw-layer_use-scale-y" },
              factor: 0.25,        
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-layer_use-scale-y" },
            },
            title: { 
              text: "Override",
              enable: { key: "vw-layer_use-scale-y" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "vw-layer_change-scale-y" },
            },
            field: {
              store: { key: "vw-layer_scale-y" },
              enable: { key: "vw-layer_change-scale-y" },
            },
            decrease: {
              store: { key: "vw-layer_scale-y" },
              enable: { key: "vw-layer_change-scale-y" },
              factor: -0.25,
            },
            increase: {
              store: { key: "vw-layer_scale-y" },
              enable: { key: "vw-layer_change-scale-y" },
              factor: 0.25,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "vw-layer_change-scale-y" },
            },
            title: { 
              text: "Change",
              enable: { key: "vw-layer_change-scale-y" },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "vw-layer_change-scale-y" },
            },
            field: {
              store: { key: "vw-layer_scale-y" },
              enable: { key: "vw-layer_change-scale-y" },
            },
            decrease: {
              store: { key: "vw-layer_scale-y" },
              enable: { key: "vw-layer_change-scale-y" },
              factor: -0.01,
            },
            increase: {
              store: { key: "vw-layer_scale-y" },
              enable: { key: "vw-layer_change-scale-y" },
              factor: 0.01,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "vw-layer_change-scale-y" },
            },
            field: {
              store: { key: "vw-layer_scale-y" },
              enable: { key: "vw-layer_change-scale-y" },
            },
            decrease: {
              store: { key: "vw-layer_scale-y" },
              enable: { key: "vw-layer_change-scale-y" },
              factor: -0.001,
            },
            increase: {
              store: { key: "vw-layer_scale-y" },
              enable: { key: "vw-layer_change-scale-y" },
              factor: 0.001,      
            },
          },
        },
      },
    ]),
  }
}