///@package io.alkapivo.visu.editor.api.template



///@param {Struct} json
///@return {Struct}
function template_shroom(json = null) {
  var template = {
    name: Assert.isType(json.name, String),
    store: new Map(String, Struct, {
      "shroom_use-lifespawn": {
        type: Boolean,
        value: Core.isType(Struct.get(json, "lifespawnMax"), Number),
      },
      "shroom_lifespawn": {
        type: Number,
        value: Core.isType(Struct.get(json, "lifespawnMax"), Number) ? json.lifespawnMax : 15.0,
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0, 99.9)
        },
      },
      "shroom_use-health-points": {
        type: Boolean,
        value: Core.isType(Struct.get(json, "healthPoints"), Number),
      },
      "shroom_health-points": {
        type: Number,
        value: Core.isType(Struct.get(json, "healthPoints"), Number) ? json.healthPoints : 1.0,
        passthrough: function(value) {
          return round(clamp(NumberUtil.parse(value, this.value), 0, 9999.9))
        },
      },
      "shroom_texture": {
        type: Sprite,
        value: SpriteUtil.parse(json.sprite, { name: "texture_missing" }),
      },
      "use_shroom_mask": {
        type: Boolean,
        value: Optional.is(Struct.getDefault(json, "mask", null)),
      },
      "shroom_mask": {
        type: Rectangle,
        value: new Rectangle(Struct.getDefault(json, "mask", null)),
      },
      "shroom_game-mode_bullet-hell_features": {
        type: String,
        value: JSON.stringify(Struct.getDefault(json.gameModes.bulletHell, "features", []), { pretty: true })
      },
      "shroom_game-mode_platformer_features": {
        type: String,
        value: JSON.stringify(Struct.getDefault(json.gameModes.platformer, "features", []), { pretty: true })
      },
      "shroom_game-mode_racing_features": {
        type: String,
        value: JSON.stringify(Struct.getDefault(json.gameModes.racing, "features", []), { pretty: true })
      },
    }),
    components: new Array(Struct, [
      {
        name: "shroom_lifespawn",
        template: VEComponents.get("text-field-checkbox"),
        layout: VELayouts.get("text-field-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Lifespawn",
            enable: { key: "shroom_use-lifespawn" },
          },  
          field: { 
            store: { key: "shroom_lifespawn" },
            enable: { key: "shroom_use-lifespawn" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "shroom_use-lifespawn" },
          },
          title: { 
            text: "Override",
            enable: { key: "shroom_use-lifespawn" },
          },
        },
      },
      {
        name: "shroom_health-points",
        template: VEComponents.get("text-field-checkbox"),
        layout: VELayouts.get("text-field-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "HP",
            enable: { key: "shroom_use-health-points" },
          },  
          field: { 
            store: { key: "shroom_health-points" },
            enable: { key: "shroom_use-health-points" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "shroom_use-health-points" },
          },
          title: { 
            text: "Override",
            enable: { key: "shroom_use-health-points" },
          },
        },
      },
      {
        name: "shroom_texture",
        template: VEComponents.get("texture-field-ext"),
        layout: VELayouts.get("texture-field-ext"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          title: {
            label: { text: "Set texture" },
          },
          texture: {
            label: { text: "Texture" }, 
            field: { store: { key: "shroom_texture" } },
          },
          preview: {
            image: { name: "texture_empty" },
            store: { key: "shroom_texture" },
          },
          resolution: {
            store: { key: "shroom_texture" },
          },
          alpha: {
            label: { text: "Alpha" },
            field: { store: { key: "shroom_texture" } },
            slider: { 
              minValue: 0.0,
              maxValue: 1.0,
              store: { key: "shroom_texture" },
            },
          },
          speed: {
            label: { text: "Speed" },
            field: { store: { key: "shroom_texture" } },
            checkbox: { 
              store: { key: "shroom_texture" },
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
            },
            title: { text: "Animate" }, 
          },
          frame: {
            label: { text: "Frame" },
            field: { store: { key: "shroom_texture" } },
            checkbox: { 
              store: { key: "shroom_texture" },
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
            },
            title: { text: "Rng" }, 
          },
          scaleX: {
            label: { text: "Scale X" },
            field: { store: { key: "shroom_texture" } },
          },
          scaleY: {
            label: { text: "Scale Y" },
            field: { store: { key: "shroom_texture" } },
          },
        },
      },
      {
        name: "shroom_mask-property",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Collision mask",
            enable: { key: "use_shroom_mask" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "use_shroom_mask" },
          },
        },
      },
      {
        name: "shroom_preview_mask",
        template: VEComponents.get("preview-image-mask"),
        layout: VELayouts.get("preview-image-mask"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          preview: {
            enable: { key: "use_shroom_mask" },
            image: { name: "texture_empty" },
            store: { key: "shroom_texture" },
            mask: "shroom_mask",
          },
        },
      },
      {
        name: "shroom_mask",
        template: VEComponents.get("vec4"),
        layout: VELayouts.get("vec4"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          x: {
            label: {
              text: "X",
              enable: { key: "use_shroom_mask" },
            },
            field: {
              store: { key: "shroom_mask" },
              enable: { key: "use_shroom_mask" },
            },
          },
          y: {
            label: {
              text: "Y",
              enable: { key: "use_shroom_mask" },
            },
            field: {
              store: { key: "shroom_mask" },
              enable: { key: "use_shroom_mask" },
            },
          },
          z: {
            label: {
              text: "Width",
              enable: { key: "use_shroom_mask" },
            },
            field: {
              store: { key: "shroom_mask" },
              enable: { key: "use_shroom_mask" },
            },
          },
          a: {
            label: {
              text: "Height",
              enable: { key: "use_shroom_mask" },
            },
            field: {
              store: { key: "shroom_mask" },
              enable: { key: "use_shroom_mask" },
            },
          },
        },
      },
      {
        name: "shroom_game-mode_bullet-hell",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "BulletHell" },
        },
      },
      {
        name: "shroom_game-mode_bullet-hell_features",
        template: VEComponents.get("text-area"),
        layout: VELayouts.get("text-area"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          field: { 
            v_grow: true,
            w_min: 570,
            store: { key: "shroom_game-mode_bullet-hell_features" },
          },
        },
      },
      {
        name: "shroom_game-mode_platformer",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Platformer" },
        },
      },
      {
        name: "shroom_game-mode_platformer_features",
        template: VEComponents.get("text-area"),
        layout: VELayouts.get("text-area"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          field: { 
            v_grow: true,
            w_min: 570,
            store: { key: "shroom_game-mode_platformer_features" },
          },
        },
      },
      {
        name: "shroom_game-mode_racing",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Racing" },
        },
      },
      {
        name: "shroom_game-mode_racing_features",
        template: VEComponents.get("text-area"),
        layout: VELayouts.get("text-area"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          field: { 
            v_grow: true,
            w_min: 570,
            store: { key: "shroom_game-mode_racing_features" },
          },
        },
      },
    ]),
  }

  return template
}