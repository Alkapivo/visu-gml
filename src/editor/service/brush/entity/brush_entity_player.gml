///@package io.alkapivo.visu.editor.service.brush.entity

///@param {?Struct} [json]
///@return {Struct}
function brush_entity_player(json = null) {
  return {
    name: "brush_entity_player",
    store: new Map(String, Struct, {
      "en-pl_texture": {
        type: Sprite,
        value: SpriteUtil.parse(Struct.get(json, "en-pl_texture"), { 
          name: "texture_player", 
          animate: true 
        }),
      },
      "en-pl_use-mask": {
        type: Boolean,
        value: Struct.getIfType(json, "en-pl_use-mask", Boolean, false),
      },
      "en-pl_mask": {
        type: Rectangle,
        value: new Rectangle(Struct.getIfType(json, "en-pl_mask", Struct, null)),
      },
      "en-pl_reset-pos": {
        type: Boolean,
        value: Struct.getIfType(json, "en-pl_reset-pos", Boolean, false),
      },
      "en-pl_use-stats": {
        type: Boolean,
        value: Struct.getIfType(json, "en-pl_use-stats", Boolean, false),
      },
      "en-pl_stats": {
        type: String,
        value: JSON.stringify(Struct.getDefault(json, "en-pl_stats", {
          "force": {
            "value": 0
          },
          "point": {
            "value": 0
          },
          "bomb": {
            "value": 5
          },
          "life": {
            "value": 4
          }
        }), { pretty: true }),
        serialize: function() {
          return JSON.parse(this.get())
        },
        validate: function(value) {
          Assert.isType(JSON.parse(value), Struct)
        },
      },
      "en-pl_use-bullethell": {
        type: Boolean,
        value: Struct.getIfType(json, "en-pl_use-bullethell", Boolean, true),
      },
      "en-pl_bullethell": {
        type: String,
        value: JSON.stringify(Struct.getDefault(json, "en-pl_bullethell", {
          "x":{
            "friction":9.3,
            "acceleration":1.92,
            "speedMax":2.1
          },
          "y":{
            "friction":9.3,
            "acceleration":1.92,
            "speedMax":2.1
          },
          "guns":[
            {
              "angle": 90,
              "bullet":"bullet_default",
              "cooldown":8.0,
              "offsetX": 0.0,
              "offsetY": 0.0,
              "speed": 10.0
            }
          ]
        }), { pretty: true }),
        serialize: function() {
          return JSON.parse(this.get())
        },
        validate: function(value) {
          Assert.isType(JSON.parse(value), Struct)
        },
      },
      "en-pl_use-platformer": {
        type: Boolean,
        value: Struct.getIfType(json, "en-pl_use-platformer", Boolean, true),
      },
      "en-pl_platformer": {
        type: String,
        value: JSON.stringify(Struct.getDefault(json, "en-pl_platformer", {
          "x":{
            "friction":9.3,
            "acceleration":1.92,
            "speedMax":2.1
          },
          "y":{
            "friction":0.0,
            "acceleration":1.92,
            "speedMax":25.0
          },
          "jump": {
            "size": 3.5
          }
        }), { pretty: true }),
        serialize: function() {
          return JSON.parse(this.get())
        },
        validate: function(value) {
          Assert.isType(JSON.parse(value), Struct)
        },
      },
      "en-pl_use-racing": {
        type: Boolean,
        value: Struct.getIfType(json, "en-pl_use-racing", Boolean, true),
      },
      "en-pl_racing": {
        type: String,
        value: JSON.stringify(Struct.getDefault(json, "en-pl_racing", {}), { pretty: true }),
        serialize: function() {
          return JSON.parse(this.get())
        },
        validate: function(value) {
          Assert.isType(JSON.parse(value), Struct)
        },
      },
    }),
    components: new Array(Struct, [
      {
        name: "en-pl_texture",
        template: VEComponents.get("texture-field-ext"),
        layout: VELayouts.get("texture-field-ext"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          title: {
            label: { text: "Set texture" },
          },
          texture: {
            label: { text: "Texture" }, 
            field: { store: { key: "en-pl_texture" } },
          },
          preview: {
            image: { name: "texture_empty" },
            store: { key: "en-pl_texture" },
          },
          resolution: {
            store: { key: "en-pl_texture" },
          },
          alpha: {
            label: { text: "Alpha" },
            field: { store: { key: "en-pl_texture" } },
            slider: { 
              minValue: 0.0,
              maxValue: 1.0,
              store: { key: "en-pl_texture" },
            },
          },
          frame: {
            label: { text: "Frame" },
            field: { store: { key: "en-pl_texture" } },
            checkbox: { 
              store: { key: "en-pl_texture" },
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
            },
            title: { text: "Rng" }, 
          },
          speed: {
            label: { text: "Speed" },
            field: { store: { key: "en-pl_texture" } },
            checkbox: { 
              store: { key: "en-pl_texture" },
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
            },
            title: { text: "Animate" }, 
          },
          scaleX: {
            label: { text: "Scale X" },
            field: { store: { key: "en-pl_texture" } },
          },
          scaleY: {
            label: { text: "Scale Y" },
            field: { store: { key: "en-pl_texture" } },
          },
        },
      },
      {
        name: "grid-player_mask-property",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Collision mask",
            enable: { key: "en-pl_use-mask" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-pl_use-mask" },
          },
        },
      },
      {
        name: "grid-player_preview_mask",
        template: VEComponents.get("preview-image-mask"),
        layout: VELayouts.get("preview-image-mask"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          preview: {
            enable: { key: "en-pl_use-mask" },
            image: { name: "texture_empty" },
            store: { key: "en-pl_texture" },
            mask: "en-pl_mask",
          },
        },
      },
      {
        name: "en-pl_mask",
        template: VEComponents.get("vec4"),
        layout: VELayouts.get("vec4"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          x: {
            label: {
              text: "X",
              enable: { key: "en-pl_use-mask" },
            },
            field: {
              store: { key: "en-pl_mask" },
              enable: { key: "en-pl_use-mask" },
            },
          },
          y: {
            label: {
              text: "Y",
              enable: { key: "en-pl_use-mask" },
            },
            field: {
              store: { key: "en-pl_mask" },
              enable: { key: "en-pl_use-mask" },
            },
          },
          z: {
            label: {
              text: "Width",
              enable: { key: "en-pl_use-mask" },
            },
            field: {
              store: { key: "en-pl_mask" },
              enable: { key: "en-pl_use-mask" },
            },
          },
          a: {
            label: {
              text: "Height",
              enable: { key: "en-pl_use-mask" },
            },
            field: {
              store: { key: "en-pl_mask" },
              enable: { key: "en-pl_use-mask" },
            },
          },
        },
      },
      {
        name: "en-pl_reset-pos",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Reset position",
            enable: { key: "en-pl_reset-pos" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-pl_reset-pos" },
          },
        },
      },
      {
        name: "en-pl_use-stats",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Use stats",
            enable: { key: "en-pl_use-stats" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-pl_use-stats" },
          },
        },
      },
      {
        name: "en-pl_stats",
        template: VEComponents.get("text-area"),
        layout: VELayouts.get("text-area"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          field: { 
            v_grow: true,
            w_min: 570,
            store: { key: "en-pl_stats" },
            enable: { key: "en-pl_use-stats" },
          },
        },
      },
      {
        name: "en-pl_bullethell",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "BulletHell",
            enable: { key: "en-pl_use-bullethell" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-pl_use-bullethell" },
          },
        },
      },
      {
        name: "en-pl_bullethell",
        template: VEComponents.get("text-area"),
        layout: VELayouts.get("text-area"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          field: { 
            v_grow: true,
            w_min: 570,
            store: { key: "en-pl_bullethell" },
            enable: { key: "en-pl_use-bullethell" },
          },
        },
      },
      {
        name: "grid-player_mode_platformer",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Platformer",
            enable: { key: "en-pl_use-platformer" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-pl_use-platformer" },
          },
        },
      },
      {
        name: "en-pl_platformer",
        template: VEComponents.get("text-area"),
        layout: VELayouts.get("text-area"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          field: { 
            v_grow: true,
            w_min: 570,
            store: { key: "en-pl_platformer" },
            enable: { key: "en-pl_use-platformer" },
          },
        },
      },
      {
        name: "en-pl_racing",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Racing",
            enable: { key: "en-pl_use-racing" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-pl_use-racing" },
          },
        },
      },
      {
        name: "en-pl_racing",
        template: VEComponents.get("text-area"),
        layout: VELayouts.get("text-area"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          field: { 
            v_grow: true,
            w_min: 570,
            store: { key: "en-pl_racing" },
            enable: { key: "en-pl_use-racing" },
          },
        },
      },
    ]),
  }
}