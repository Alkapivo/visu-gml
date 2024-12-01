///@package io.alkapivo.visu.editor.service.brush.effect

///@param {?Struct} [json]
///@return {Struct}
function brush_effect_glitch(json = null) {
  return {
    name: "brush_effect_glitch",
    store: new Map(String, Struct, {
      "ef-glt_use-fade-out": {
        type: Boolean,
        value: Struct.getDefault(json, "ef-glt_use-fade-out", false),
      },
      "ef-glt_fade-out": {
        type: Number,
        value: Struct.getDefault(json, "ef-glt_fade-out", 0.01),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 1.0) 
        },
      },
      "ef-glt_use-config": {
        type: Boolean,
        value: Struct.getDefault(json, "ef-glt_use-config", true),
      },
      "ef-glt_line-spd": {
        type: Number,
        value: Struct.getDefault(json, "ef-glt_line-spd", 0.01),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 0.5) 
        },
      },
      "ef-glt_line-shift": {
        type: Number,
        value: Struct.getDefault(json, "ef-glt_line-shift", 0.004),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 0.05)
        },
      },
      "ef-glt_line-res": {
        type: Number,
        value: Struct.getDefault(json, "ef-glt_line-res", 1.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 3.0)
        },
      },
      "ef-glt_line-v-shift": {
        type: Number,
        value: Struct.getDefault(json, "ef-glt_line-v-shift", 0.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 1.0)
        },
      },
      "ef-glt_line-drift": {
        type: Number,
        value: Struct.getDefault(json, "ef-glt_line-drift", 0.1),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 1.0)
        },
      },
      "ef-glt_jumb-spd": {
        type: Number,
        value: Struct.getDefault(json, "ef-glt_jumb-spd", 1.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 25.0)
        },
      },
      "ef-glt_jumb-shift": {
        type: Number,
        value: Struct.getDefault(json, "ef-glt_jumb-shift", 0.15),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 1.0)
        },
      },
      "ef-glt_jumb-res": {
        type: Number,
        value: Struct.getDefault(json, "ef-glt_jumb-res", 0.2),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 1.0)
        },
      },
      "ef-glt_jumb-chaos": {
        type: Number,
        value: Struct.getDefault(json, "ef-glt_jumb-chaos", 0.2),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 1.0)
        },
      },
      "ef-glt_shd-dispersion": {
        type: Number,
        value: Struct.getDefault(json, "ef-glt_shd-dispersion", 0.0025),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 0.5)
        },
      },
      "ef-glt_shd-ch-shift": {
        type: Number,
        value: Struct.getDefault(json, "ef-glt_shd-ch-shift", 0.004),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 0.05)
        },
      },
      "ef-glt_shd-noise": {
        type: Number,
        value: Struct.getDefault(json, "ef-glt_shd-noise", 0.5),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 1.0)
        },
      },
      "ef-glt_shd-shakiness": {
        type: Number,
        value: Struct.getDefault(json, "ef-glt_shd-shakiness", 0.5),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 10.0)
        },
      },
      "ef-glt_shd-rng-seed": {
        type: Number,
        value: Struct.getDefault(json, "ef-glt_shd-rng-seed", 0.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 1.0)
        },
      },
      "ef-glt_shd-intensity": {
        type: Number,
        value: Struct.getDefault(json, "ef-glt_shd-intensity", 1.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 5.0)
        },
      },  
    }),
    components: new Array(Struct, [
      {
        name: "ef-glt_use-fade-out",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Fade out",
            enable: { key: "ef-glt_use-fade-out" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "ef-glt_use-fade-out" },
          },
        },
      },
      {
        name: "ef-glt_fade-out",  
        template: VEComponents.get("numeric-slider-field"),
        layout: VELayouts.get("numeric-slider-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Factor",
            enable: { key: "ef-glt_use-fade-out" },
          },
          field: { store: { key: "ef-glt_fade-out" } },
          slider: { 
            minValue: 0.0,
            maxValue: 1.0,
            store: { key: "ef-glt_fade-out" },
          },
        },
      },
      {
        name: "ef-glt_use-config",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Use config",
            enable: { key: "ef-glt_use-config" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "ef-glt_use-config" },
          },
        },
      },
      {
        name: "view-glitch_line",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Line",
            enable: { key: "ef-glt_use-config" },
          },
        },
      },
      {
        name: "ef-glt_line-spd",  
        template: VEComponents.get("numeric-slider-field"),
        layout: VELayouts.get("numeric-slider-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Speed",
            enable: { key: "ef-glt_use-config" }
          },
          field: { store: { key: "ef-glt_line-spd" } },
          slider: { 
            minValue: 0.0,
            maxValue: 0.5,
            store: { key: "ef-glt_line-spd" },
            enable: { key: "ef-glt_use-config" },
          },
        },
      },
      {
        name: "ef-glt_line-shift",
        template: VEComponents.get("numeric-slider-field"),
        layout: VELayouts.get("numeric-slider-field"),
        config: {
          layout: { type: UILayoutType.VERTICAL},
          label: { 
            text: "Shift",
            enable: { key: "ef-glt_use-config" },
          },
          field: { store: { key: "ef-glt_line-shift" }},
          slider: {
            minValue: 0.0,
            maxValue: 0.05,
            store: { key: "ef-glt_line-shift" },
            enable: { key: "ef-glt_use-config" },
          },
        }
      },
      {
        name: "ef-glt_line-res",
        template: VEComponents.get("numeric-slider-field"),
        layout: VELayouts.get("numeric-slider-field"),
        config: {
          layout: { type: UILayoutType.VERTICAL},
          label: { 
            text: "Resolution",
            enable: { key: "ef-glt_use-config" },
          },
          field: { store: { key: "ef-glt_line-res" }},
          slider: {
            minValue: 0.0,
            maxValue: 3.0,
            store: { key: "ef-glt_line-res" },
            enable: { key: "ef-glt_use-config" },
          },
        }
      },
      {
        name: "ef-glt_line-v-shift",
        template: VEComponents.get("numeric-slider-field"),
        layout: VELayouts.get("numeric-slider-field"),
        config: {
          layout: { type: UILayoutType.VERTICAL},
          label: {
            text: "V shift",
            enable: { key: "ef-glt_use-config" },
          },
          field: { store: { key: "ef-glt_line-v-shift" }},
          slider: {
            minValue: 0.0,
            maxValue: 1.0,
            store: { key: "ef-glt_line-v-shift" },
            enable: { key: "ef-glt_use-config" },
          },
        }
      },
      {
        name: "ef-glt_line-drift",
        template: VEComponents.get("numeric-slider-field"),
        layout: VELayouts.get("numeric-slider-field"),
        config: {
          layout: { type: UILayoutType.VERTICAL},
          label: {
            text: "Drift",
            enable: { key: "ef-glt_use-config" },
          },
          field: { store: { key: "ef-glt_line-drift" }},
          slider: {
            minValue: 0.0,
            maxValue: 1.0,
            store: { key: "ef-glt_line-drift" },
            enable: { key: "ef-glt_use-config" },
          },
        }
      },
      {
        name: "view-glitch_jumble",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Jumble",
            enable: { key: "ef-glt_use-config" }
          },
        },
      },
      {
        name: "ef-glt_jumb-spd",
        template: VEComponents.get("numeric-slider-field"),
        layout: VELayouts.get("numeric-slider-field"),
        config: {
          layout: { type: UILayoutType.VERTICAL},
          label: {
            text: "Speed",
            enable: { key: "ef-glt_use-config" },
          },
          field: { store: { key: "ef-glt_jumb-spd" }},
          slider: {
            minValue: 0.0,
            maxValue: 25.0,
            store: { key: "ef-glt_jumb-spd" },
            enable: { key: "ef-glt_use-config" },
          },
        }
      },
      {
        name: "ef-glt_jumb-shift",
        template: VEComponents.get("numeric-slider-field"),
        layout: VELayouts.get("numeric-slider-field"),
        config: {
          layout: { type: UILayoutType.VERTICAL},
          label: {
            text: "Shift",
            enable: { key: "ef-glt_use-config" },
          },
          field: { store: { key: "ef-glt_jumb-shift" }},
          slider: {
            minValue: 0.0,
            maxValue: 1.0,
            store: { key: "ef-glt_jumb-shift" },
            enable: { key: "ef-glt_use-config" },
          },
        }
      },
      {
        name: "ef-glt_jumb-res",
        template: VEComponents.get("numeric-slider-field"),
        layout: VELayouts.get("numeric-slider-field"),
        config: {
          layout: { type: UILayoutType.VERTICAL},
          label: { 
            text: "Resolution",
            enable: { key: "ef-glt_use-config" },
          },
          field: { store: { key: "ef-glt_jumb-res" }},
          slider: {
            minValue: 0.0,
            maxValue: 1.0,
            store: { key: "ef-glt_jumb-res" },
            enable: { key: "ef-glt_use-config" },
          },
        }
      },
      {
        name: "ef-glt_jumb-chaos",
        template: VEComponents.get("numeric-slider-field"),
        layout: VELayouts.get("numeric-slider-field"),
        config: {
          layout: { type: UILayoutType.VERTICAL},
          label: {
            text: "Chaos",
            enable: { key: "ef-glt_use-config" },
          },
          field: { store: { key: "ef-glt_jumb-chaos" }},
          slider: {
            minValue: 0.0,
            maxValue: 1.0,
            store: { key: "ef-glt_jumb-chaos" },
            enable: { key: "ef-glt_use-config" },
          },
        }
      },
      {
        name: "view-glitch_shader",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Shader",
            enable: { key: "ef-glt_use-config" },
          },
        },
      },
      {
        name: "ef-glt_shd-dispersion",
        template: VEComponents.get("numeric-slider-field"),
        layout: VELayouts.get("numeric-slider-field"),
        config: {
          layout: { type: UILayoutType.VERTICAL},
          label: {
            text: "Dispersion",
            enable: { key: "ef-glt_use-config" },
          },
          field: { store: { key: "ef-glt_shd-dispersion" }},
          slider: {
            minValue: 0.0,
            maxValue: 0.5,
            store: { key: "ef-glt_shd-dispersion" },
            enable: { key: "ef-glt_use-config" },
          },
        }
      },
      {
        name: "ef-glt_shd-ch-shift",
        template: VEComponents.get("numeric-slider-field"),
        layout: VELayouts.get("numeric-slider-field"),
        config: {
          layout: { type: UILayoutType.VERTICAL},
          label: {
            text: "Ch. shift",
            enable: { key: "ef-glt_use-config" },
          },
          field: { store: { key: "ef-glt_shd-ch-shift" }},
          slider: {
            minValue: 0.0,
            maxValue: 0.05,
            store: { key: "ef-glt_shd-ch-shift" },
            enable: { key: "ef-glt_use-config" },
          },
        }
      },
      {
        name: "ef-glt_shd-noise",
        template: VEComponents.get("numeric-slider-field"),
        layout: VELayouts.get("numeric-slider-field"),
        config: {
          layout: { type: UILayoutType.VERTICAL},
          label: {
            text: "Noise level",
            enable: { key: "ef-glt_use-config" },
          },
          field: { store: { key: "ef-glt_shd-noise" }},
          slider: {
            minValue: 0.0,
            maxValue: 1.0,
            store: { key: "ef-glt_shd-noise" },
            enable: { key: "ef-glt_use-config" },
          },
        }
      },
      {
        name: "ef-glt_shd-shakiness",
        template: VEComponents.get("numeric-slider-field"),
        layout: VELayouts.get("numeric-slider-field"),
        config: {
          layout: { type: UILayoutType.VERTICAL},
          label: {
            text: "Shakiness",
            enable: { key: "ef-glt_use-config" },
          },
          field: { store: { key: "ef-glt_shd-shakiness" }},
          slider: {
            minValue: 0.0,
            maxValue: 10.0,
            store: { key: "ef-glt_shd-shakiness" },
            enable: { key: "ef-glt_use-config" },
          },
        }
      },
      {
        name: "ef-glt_shd-rng-seed",
        template: VEComponents.get("numeric-slider-field"),
        layout: VELayouts.get("numeric-slider-field"),
        config: {
          layout: { type: UILayoutType.VERTICAL},
          label: {
            text: "RNG seed",
            enable: { key: "ef-glt_use-config" },
          },
          field: { store: { key: "ef-glt_shd-rng-seed" }},
          slider: {
            minValue: 0.0,
            maxValue: 1.0,
            store: { key: "ef-glt_shd-rng-seed" },
            enable: { key: "ef-glt_use-config" },
          },
        }
      },
      {
        name: "ef-glt_shd-intensity",
        template: VEComponents.get("numeric-slider-field"),
        layout: VELayouts.get("numeric-slider-field"),
        config: {
          layout: { type: UILayoutType.VERTICAL},
          label: {
            text: "Intensity",
            enable: { key: "ef-glt_use-config" },
          },
          field: { store: { key: "ef-glt_shd-intensity" }},
          slider: {
            minValue: 0.0,
            maxValue: 5.0,
            store: { key: "ef-glt_shd-intensity" },
            enable: { key: "ef-glt_use-config" },
          },
        }
      },
    ]),
  }
}