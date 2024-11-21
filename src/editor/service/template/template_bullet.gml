///@package io.alkapivo.visu.editor.api.template

///@param {Struct} json
///@return {Struct}
function template_bullet(json = null) {
  var template = {
    name: Assert.isType(json.name, String),
    store: new Map(String, Struct, {
      "bullet_use-lifespawn": {
        type: Boolean,
        value: Core.isType(Struct.get(json, "lifespawnMax"), Number),
      },
      "bullet_lifespawn": {
        type: Number,
        value: Core.isType(Struct.get(json, "lifespawnMax"), Number) ? json.lifespawnMax : 15.0,
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0, 99.9)
        },
      },
      "bullet_use-damage": {
        type: Boolean,
        value: Core.isType(Struct.get(json, "damage"), Number),
      },
      "bullet_damage": {
        type: Number,
        value: Core.isType(Struct.get(json, "damage"), Number) ? json.damage : 1.0,
        passthrough: function(value) {
          return round(clamp(NumberUtil.parse(value, this.value), 0, 999.9))
        },
      },
      "bullet_texture": {
        type: Sprite,
        value: SpriteUtil.parse(json.sprite, { name: "texture_bullet" }),
      },
      "use_bullet_mask": {
        type: Boolean,
        value: Optional.is(Struct.getDefault(json, "mask", null)),
      },
      "bullet_mask": {
        type: Rectangle,
        value: new Rectangle(Struct.getDefault(json, "mask", null)),
      },
      "bullet_use-wiggle": {
        type: Boolean,
        value: Struct.getIfType(json, "wiggle", Boolean, false),
      },
      "bullet_wiggle-time": {
        type: Number,
        value: Struct.getIfType(json, "wiggleTime", Number, 8.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 99.9)
        },
      },
      "bullet_use-wiggle-time-rng": {
        type: Boolean,
        value: Struct.getIfType(json, "wiggleTimeRng", Boolean, false),
      },
      "bullet_wiggle-frequency": {
        type: Number,
        value: Struct.getIfType(json, "wiggleFrequency", Number, 8.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), -99.9, 99.9)
        },
      },
      "bullet_use-wiggle-dir-rng": {
        type: Boolean,
        value: Struct.getIfType(json, "wiggleDirRng", Boolean, false),
      },
      "bullet_wiggle-amplitude": {
        type: Number,
        value: Struct.getIfType(json, "wiggleAmplitude", Number, 5.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), -99.9, 99.9)
        },
      },
      "bullet_use-angle-offset": {
        type: Boolean,
        value: Core.isType(Struct.get(json, "angleOffset"), Struct),
      },
      "bullet_angle-offset": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getDefault(json, 
          "angleOffset",
          { value: 0.0, target: 0.0, factor: 0.0, increase: 0.0 },
        )),
      },
      "bullet_use-angle-offset-rng": {
        type: Boolean,
        value: Struct.getIfType(json, "angleOffsetRng", Boolean, false),
      },
      "bullet_use-speed-offset": {
        type: Boolean,
        value: Core.isType(Struct.get(json, "speedOffset"), Struct),
      },
      "bullet_speed-offset": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getDefault(json, 
          "speedOffset",
          { value: 0.0, target: 0.0, factor: 0.0, increase: 0.0 },
        )),
      },
      "bullet_use-on-death": {
        type: Boolean,
        value: Core.isType(Struct.get(json, "onDeath"), String),
      },
      "bullet_on-death": {
        type: String,
        value: Struct.getIfType(json, "onDeath", String, "bullet-default"),
        passthrough: function(value) {
          var bulletService = Beans.get(BeanVisuController).bulletService
          return !bulletService.templates.contains(value) &&
              !Visu.assets().bulletTemplates.contains(value)
                ? Struct.getIfType(this, "value", String, "bullet-default")
                : value
        },
      },
      "bullet_on-death-amount": {
        type: Number,
        value: Struct.getIfType(json, "onDeathAmount", Number, 1),
        passthrough: function(value) {
          return round(clamp(NumberUtil.parse(value, this.value), 1, 16))
        },
      },
      "bullet_on-death-angle": {
        type: Number,
        value: Struct.getIfType(json, "onDeathAngle", Number, 0.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), -360.0, 360.0)
        },
      },
      "bullet_on-death-angle-rng": {
        type: Boolean,
        value: Struct.getIfType(json, "onDeathAngleRng", Boolean, false),
      },
      "bullet_on-death-angle-step": {
        type: Number,
        value: Struct.getIfType(json, "onDeathAngleStep", Number, 0.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), -360.0, 360.0)
        },
      },
      "bullet_on-death-rng-step": {
        type: Number,
        value: Struct.getIfType(json, "onDeathRngStep", Number, 0.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 360.0)
        },
      },
      "bullet_on-death-speed": {
        type: Number,
        value: Struct.getIfType(json, "onDeathSpeed", Number, 0.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), -99.9, 99.9)
        },
      },
      "bullet_on-death-speed-merge": {
        type: Boolean,
        value: Struct.getIfType(json, "onDeathSpeedMerge", Boolean, true),
      },
      "bullet_on-death-rng-speed": {
        type: Number,
        value: Struct.getIfType(json, "onDeathRngSpeed", Number, 0.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 99.9)
        },
      },
    }),
    components: new Array(Struct, [
      {
        name: "bullet_lifespawn",
        template: VEComponents.get("text-field-checkbox"),
        layout: VELayouts.get("text-field-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Lifespawn",
            enable: { key: "bullet_use-lifespawn" },
          },  
          field: { 
            store: { key: "bullet_lifespawn" },
            enable: { key: "bullet_use-lifespawn" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "bullet_use-lifespawn" },
          },
          title: { 
            text: "Override",
            enable: { key: "bullet_use-lifespawn" },
          },
        },
      },
      {
        name: "bullet_damage",
        template: VEComponents.get("text-field-checkbox"),
        layout: VELayouts.get("text-field-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Damage",
            enable: { key: "bullet_use-damage" },
          },  
          field: { 
            store: { key: "bullet_damage" },
            enable: { key: "bullet_use-damage" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "bullet_use-damage" },
          },
          title: { 
            text: "Override",
            enable: { key: "bullet_use-damage" },
          },
        },
      },
      {
        name: "bullet_texture",
        template: VEComponents.get("texture-field-ext"),
        layout: VELayouts.get("texture-field-ext"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          title: {
            label: { text: "Set texture" },
          },
          texture: {
            label: { text: "Texture" }, 
            field: { store: { key: "bullet_texture" } },
          },
          preview: {
            image: { name: "texture_empty" },
            store: { key: "bullet_texture" },
          },
          resolution: {
            store: { key: "bullet_texture" },
          },
          alpha: {
            label: { text: "Alpha" },
            field: { store: { key: "bullet_texture" } },
            slider: { 
              minValue: 0.0,
              maxValue: 1.0,
              store: { key: "bullet_texture" },
            },
          },
          speed: {
            label: { text: "Speed" },
            field: { store: { key: "bullet_texture" } },
            checkbox: { 
              store: { key: "bullet_texture" },
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
            },
            title: { text: "Animate" }, 
          },
          frame: {
            label: { text: "Frame" },
            field: { store: { key: "bullet_texture" } },
            checkbox: { 
              store: { key: "bullet_texture" },
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
            },
            title: { text: "Rng" }, 
          },
          scaleX: {
            label: { text: "Scale X" },
            field: { store: { key: "bullet_texture" } },
          },
          scaleY: {
            label: { text: "Scale Y" },
            field: { store: { key: "bullet_texture" } },
          },
        },
      },
      {
        name: "bullet_mask-property",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Collision mask",
            enable: { key: "use_bullet_mask" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "use_bullet_mask" },
          },
        },
      },
      {
        name: "bullet_preview_mask",
        template: VEComponents.get("preview-image-mask"),
        layout: VELayouts.get("preview-image-mask"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          preview: {
            enable: { key: "use_bullet_mask" },
            image: { name: "texture_empty" },
            store: { key: "bullet_texture" },
            mask: "bullet_mask",
          },
        },
      },
      {
        name: "bullet_mask",
        template: VEComponents.get("vec4"),
        layout: VELayouts.get("vec4"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          x: {
            label: {
              text: "X",
              enable: { key: "use_bullet_mask" },
            },
            field: {
              store: { key: "bullet_mask" },
              enable: { key: "use_bullet_mask" },
            },
          },
          y: {
            label: {
              text: "Y",
              enable: { key: "use_bullet_mask" },
            },
            field: {
              store: { key: "bullet_mask" },
              enable: { key: "use_bullet_mask" },
            },
          },
          z: {
            label: {
              text: "Width",
              enable: { key: "use_bullet_mask" },
            },
            field: {
              store: { key: "bullet_mask" },
              enable: { key: "use_bullet_mask" },
            },
          },
          a: {
            label: {
              text: "Height",
              enable: { key: "use_bullet_mask" },
            },
            field: {
              store: { key: "bullet_mask" },
              enable: { key: "use_bullet_mask" },
            },
          },
        },
      },
      {
        name: "bullet_angle-wiggle-property",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Wiggle" },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "bullet_use-wiggle" },
          },
        },
      },
      {
        name: "bullet_angle-wiggle",
        template: VEComponents.get("text-field-checkbox"),
        layout: VELayouts.get("text-field-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Time",
            enable: { key: "bullet_use-wiggle" },
          },  
          field: { 
            store: { key: "bullet_wiggle-time" },
            enable: { key: "bullet_use-wiggle" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "bullet_use-wiggle-time-rng" },
            enable: { key: "bullet_use-wiggle" },
          },
          title: { 
            text: "Rng time",
            enable: { key: "bullet_use-wiggle" },
          },
        },
      },
      {
        name: "bullet_wiggle-frequency",
        template: VEComponents.get("text-field-checkbox"),
        layout: VELayouts.get("text-field-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Frequency",
            enable: { key: "bullet_use-wiggle" },
          },  
          field: { 
            store: { key: "bullet_wiggle-frequency" },
            enable: { key: "bullet_use-wiggle" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "bullet_use-wiggle-dir-rng" },
            enable: { key: "bullet_use-wiggle" },
          },
          title: { 
            text: "Rng dir.",
            enable: { key: "bullet_use-wiggle" },
          },
        },
      },
      {
        name: "bullet_wiggle-amplitude",
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Size",
            enable: { key: "bullet_use-wiggle" },
          },  
          field: { 
            store: { key: "bullet_wiggle-amplitude" },
            enable: { key: "bullet_use-wiggle" },
          },
        },
      },
      {
        name: "bullet_angle-offset",
        template: VEComponents.get("transform-numeric-uniform"),
        layout: VELayouts.get("transform-numeric-uniform"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          title: { 
            label: { 
              text: "Angle offset",
              enable: { key: "bullet_use-angle-offset" },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "bullet_use-angle-offset" },
            },
          },
          value: {
            label: { 
              text: "Value",
              enable: { key: "bullet_use-angle-offset" },
            },
            field: { 
              store: { key: "bullet_angle-offset" },
              enable: { key: "bullet_use-angle-offset" },
            },
          },
          target: {
            label: { 
              text: "Target",
              enable: { key: "bullet_use-angle-offset" },
            },
            field: { 
              store: { key: "bullet_angle-offset" },
              enable: { key: "bullet_use-angle-offset" },
            },
          },
          factor: {
            label: { 
              text: "Factor",
              enable: { key: "bullet_use-angle-offset" },
            },
            field: { 
              store: { key: "bullet_angle-offset" },
              enable: { key: "bullet_use-angle-offset" },
            },
          },
          increase: {
            label: { 
              text: "Increase",
              enable: { key: "bullet_use-angle-offset" },
            },
            field: { 
              store: { key: "bullet_angle-offset" },
              enable: { key: "bullet_use-angle-offset" },
            },
          },
        },
      },
      {
        name: "bullet_use-angle-offset-rng",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Random direction",
            enable: { key: "bullet_use-angle-offset" },
          },
          enable: { key: "bullet_use-angle-offset" },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "bullet_use-angle-offset-rng" },
            enable: { key: "bullet_use-angle-offset" },
          },
        },
      },
      {
        name: "bullet_speed-offset",
        template: VEComponents.get("transform-numeric-uniform"),
        layout: VELayouts.get("transform-numeric-uniform"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          title: { 
            label: { 
              text: "Speed offset",
              enable: { key: "bullet_use-speed-offset" },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "bullet_use-speed-offset" },
            },
          },
          value: {
            label: { 
              text: "Value",
              enable: { key: "bullet_use-speed-offset" },
            },
            field: { 
              store: { key: "bullet_speed-offset" },
              enable: { key: "bullet_use-speed-offset" },
            },
          },
          target: {
            label: { 
              text: "Target",
              enable: { key: "bullet_use-speed-offset" },
            },
            field: { 
              store: { key: "bullet_speed-offset" },
              enable: { key: "bullet_use-speed-offset" },
            },
          },
          factor: {
            label: { 
              text: "Factor",
              enable: { key: "bullet_use-speed-offset" },
            },
            field: { 
              store: { key: "bullet_speed-offset" },
              enable: { key: "bullet_use-speed-offset" },
            },
          },
          increase: {
            label: { 
              text: "Increase",
              enable: { key: "bullet_use-speed-offset" },
            },
            field: { 
              store: { key: "bullet_speed-offset" },
              enable: { key: "bullet_use-speed-offset" },
            },
          },
        },
      },
      {
        name: "bullet_use-on-death",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Spawn on death",
            enable: { key: "bullet_use-on-death" },
          },  
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "bullet_use-on-death" },
          },
        },
      },
      {
        name: "bullet_on-death",
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Name",
            enable: { key: "bullet_use-on-death" },
          },  
          field: { 
            store: { key: "bullet_on-death" },
            enable: { key: "bullet_use-on-death" },
          },
        },
      },
      {
        name: "bullet_on-death-amount",
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Amount",
            enable: { key: "bullet_use-on-death" },
          },  
          field: { 
            store: { key: "bullet_on-death-amount" },
            enable: { key: "bullet_use-on-death" },
          },
        },
      },
      {
        name: "bullet_on-death-angle",
        template: VEComponents.get("text-field-checkbox"),
        layout: VELayouts.get("text-field-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Angle",
            enable: { key: "bullet_use-on-death" },
          },  
          field: { 
            store: { key: "bullet_on-death-angle" },
            enable: { key: "bullet_use-on-death" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "bullet_on-death-angle-rng" },
            enable: { key: "bullet_use-on-death" },
          },
          title: { 
            text: "Rng dir.",
            enable: { key: "bullet_use-on-death" },
          },  
        },
      },
      {
        name: "bullet_on-death-angle-step",
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Angle step",
            enable: { key: "bullet_use-on-death" },
          },  
          field: { 
            store: { key: "bullet_on-death-angle-step" },
            enable: { key: "bullet_use-on-death" },
          },
        },
      },
      {
        name: "bullet_on-death-rng-step",
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Rng step",
            enable: { key: "bullet_use-on-death" },
          },  
          field: { 
            store: { key: "bullet_on-death-rng-step" },
            enable: { key: "bullet_use-on-death" },
          },
        },
      },
      {
        name: "bullet_on-death-speed",
        template: VEComponents.get("text-field-checkbox"),
        layout: VELayouts.get("text-field-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Speed",
            enable: { key: "bullet_use-on-death" },
          },  
          field: { 
            store: { key: "bullet_on-death-speed" },
            enable: { key: "bullet_use-on-death" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "bullet_on-death-speed-merge" },
            enable: { key: "bullet_use-on-death" },
          },
          title: { 
            text: "Merge",
            enable: { key: "bullet_use-on-death" },
          },  
        },
      },
      {
        name: "bullet_on-death-rng-speed",
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Rng speed",
            enable: { key: "bullet_use-on-death" },
          },  
          field: { 
            store: { key: "bullet_on-death-rng-speed" },
            enable: { key: "bullet_use-on-death" },
          },
        },
      },
    ]),
  }

  return template
}
