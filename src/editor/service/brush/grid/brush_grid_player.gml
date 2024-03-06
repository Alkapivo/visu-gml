///@package io.alkapivo.visu.editor.service.brush.grid

///@param {?Struct} [json]
///@return {Struct}
function brush_grid_player(json = null) {
  return {
    name: "brush_grid_player",
    store: new Map(String, Struct, {
      "grid-player_use-bullet-hell": {
        type: Boolean,
        value: Struct.getDefault(json, "grid-player_use-bullet-hell", true),
      },
      "grid-player_bullet-hell": {
        type: String,
        value: JSON.stringify(Struct.getDefault(json, "grid-player_bullet-hell", {
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
      "grid-player_use-platformer": {
        type: Boolean,
        value: Struct.getDefault(json, "grid-player_use-platformer", true),
      },
      "grid-player_platformer": {
        type: String,
        value: JSON.stringify(Struct.getDefault(json, "grid-player_platformer", {
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
      "grid-player_use-idle": {
        type: Boolean,
        value: Struct.getDefault(json, "grid-player_use-idle", true),
      },
      "grid-player_idle": {
        type: String,
        value: JSON.stringify(Struct.getDefault(json, "grid-player_idle", {}), { pretty: true }),
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
        name: "grid-player_bullet-hell",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "BulletHell",
            enable: { key: "grid-player_use-bullet-hell" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "grid-player_use-bullet-hell" },
          },
        },
      },
      {
        name: "grid-player_bullet-hell",
        template: VEComponents.get("text-area"),
        layout: VELayouts.get("text-area"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          field: { 
            v_grow: true,
            w_min: 570,
            store: { key: "grid-player_bullet-hell" },
            enable: { key: "grid-player_use-bullet-hell" },
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
            enable: { key: "grid-player_use-platformer" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "grid-player_use-platformer" },
          },
        },
      },
      {
        name: "grid-player_platformer",
        template: VEComponents.get("text-area"),
        layout: VELayouts.get("text-area"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          field: { 
            v_grow: true,
            w_min: 570,
            store: { key: "grid-player_platformer" },
            enable: { key: "grid-player_use-platformer" },
          },
        },
      },
      {
        name: "grid-player_idle",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Idle",
            enable: { key: "grid-player_use-idle" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "grid-player_use-idle" },
          },
        },
      },
      {
        name: "grid-player_idle",
        template: VEComponents.get("text-area"),
        layout: VELayouts.get("text-area"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          field: { 
            v_grow: true,
            w_min: 570,
            store: { key: "grid-player_idle" },
            enable: { key: "grid-player_use-idle" },
          },
        },
      },
    ]),
  }
}