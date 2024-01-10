///@package io.alkapivo.visu.editor.service.brush.shroom

///@param {?Struct} [json]
///@return {Struct}
function brush_shroom_spawn(json = null) {

  generateSpawnerMethods = function() {
    return {
      onMouseHoverOver: function(event) { },
      onMouseHoverOut: function(event) { },
      preRender: function() {
        if (!this.isHoverOver) {
          return
        }

        var store = null
        if (Core.isType(this.context.state.get("brush"), VEBrush)) {
          store = this.context.state.get("brush").store
        } else if (Core.isType(this.context.state.get("event"), VEEvent)) {
          store = this.context.state.get("event").store
        } else {
          return
        }

        var shroomService = Beans.get(BeanVisuController).shroomService
        shroomService.spawner = shroomService.factorySpawner({ 
          x: store.getValue("shroom-spawn_use-spawn-x") 
            ? store.getValue("shroom-spawn_spawn-x") 
            : 0.5, 
          y: store.getValue("shroom-spawn_use-spawn-y") 
            ? store.getValue("shroom-spawn_spawn-y") 
            : 0.5,
        })
      },
    }
  }

  return {
    name: "brush_shroom_spawn",
    store: new Map(String, Struct, {
      "shroom-spawn_template": {
        type: String,
        value: Struct.getDefault(json, "shroom-spawn_template", "shroom-01"),
        validate: function(value) {
          Assert.areEqual(true, Beans.get(BeanVisuController)
            .shroomService.templates.contains(value))
        },
      },
      "shroom-spawn_speed": {
        type: Number,
        value: Struct.getDefault(json, "shroom-spawn_speed", 3.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.01, 99.0) 
        },
      },
      "shroom-spawn_use-spawn-x": {
        type: Boolean,
        value: Struct.getDefault(json, "shroom-spawn_use-spawn-x", true),
      },
      "shroom-spawn_spawn-x": {
        type: Number,
        value: Struct.getDefault(json, "shroom-spawn_spawn-x", 0.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), -3.0, 3.0) 
        },
      },
      "shroom-spawn_use-spawn-y": {
        type: Boolean,
        value: Struct.getDefault(json, "shroom-spawn_use-spawn-y", true),
      },
      "shroom-spawn_spawn-y": {
        type: Number,
        value: Struct.getDefault(json, "shroom-spawn_spawn-y", 0.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), -3.0, 3.0) 
        },
      },
      "shroom-spawn_use-angle": {
        type: Boolean,
        value: Struct.getDefault(json, "shroom-spawn_use-angle", true),
      },
      "shroom-spawn_angle": {
        type: Number,
        value: Struct.getDefault(json, "shroom-spawn_angle", 0.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0, 360.0) 
        },
      },
    }),
    components: new Array(Struct, [
      {
        name: "shroom-spawn_template",  
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Template" },
          field: { store: { key: "shroom-spawn_template" } },
        },
        
      },
      {
        name: "shroom-spawn_speed",  
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Speed" },
          field: { store: { key: "shroom-spawn_speed" } },
        },
      },
      {
        name: "shroom-spawn_use-spawn-x",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: Struct.appendUnique(
            { 
              text: "Spawn x",
              enable: { key: "shroom-spawn_use-spawn-x" },
            },
            generateSpawnerMethods(),
            false
          ),
          checkbox: Struct.appendUnique(
            { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "shroom-spawn_use-spawn-x"}
            },
            generateSpawnerMethods(),
            false
          ),
        },
      },
      {
        name: "shroom-spawn_spawn-x",  
        template: VEComponents.get("numeric-slider-field"),
        layout: VELayouts.get("numeric-slider-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: Struct.appendUnique(
            { 
              text: "X",
              enable: { key: "shroom-spawn_use-spawn-x" },
            },
            generateSpawnerMethods(),
            false
          ),
          field: Struct.appendUnique(
            { 
              store: { key: "shroom-spawn_spawn-x" },
              enable: { key: "shroom-spawn_use-spawn-x" },
            },
            generateSpawnerMethods(),
            false
          ),
          slider: Struct.appendUnique(
            { 
              minValue: -3.0,
              maxValue: 3.0,
              store: { key: "shroom-spawn_spawn-x" },
              enable: { key: "shroom-spawn_use-spawn-x" },
            },
            generateSpawnerMethods(),
            false
          ),
        },
      },
      {
        name: "shroom-spawn_use-spawn-y",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: Struct.appendUnique(
            { 
              text: "Spawn y",
              enable: { key: "shroom-spawn_use-spawn-y" },
            },
            generateSpawnerMethods(),
            false
          ),
          checkbox: Struct.appendUnique(
            { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "shroom-spawn_use-spawn-y"}
            },
            generateSpawnerMethods(),
            false
          ),
        },
      },
      {
        name: "shroom-spawn_spawn-y",  
        template: VEComponents.get("numeric-slider-field"),
        layout: VELayouts.get("numeric-slider-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: Struct.appendUnique(
            { 
              text: "Y",
              enable: { key: "shroom-spawn_use-spawn-y" },
            },
            generateSpawnerMethods(),
            false
          ),
          field: Struct.appendUnique(
            { 
              store: { key: "shroom-spawn_spawn-y" },
              enable: { key: "shroom-spawn_use-spawn-y" },
            },
            generateSpawnerMethods(),
            false
          ),
          slider: Struct.appendUnique(
            { 
              minValue: -3.0,
              maxValue: 3.0,
              store: { key: "shroom-spawn_spawn-y" },
              enable: { key: "shroom-spawn_use-spawn-y" },
            },
            generateSpawnerMethods(),
            false
          ),
        },
      },
      {
        name: "shroom-spawn_use-angle",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Angle",
            enable: { key: "shroom-spawn_use-angle" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "shroom-spawn_use-angle" },
          },
          input: {
            store: { 
              key: "shroom-spawn_angle",
              callback: function(value, data) { 
                var sprite = Struct.get(data, "sprite")
                if (!Core.isType(sprite, Sprite)) {
                  sprite = SpriteUtil.parse({ name: "visu_texture_ui_spawn_arrow" })
                  Struct.set(data, "sprite", sprite)
                }
                sprite.setAngle(value)
              },
              set: function(value) { return },
            },
            enable: { key: "shroom-spawn_use-angle" },
            render: function() {
              if (this.backgroundColor != null) {
                var _x = this.context.area.getX() + this.area.getX()
                var _y = this.context.area.getY() + this.area.getY()
                var color = this.backgroundColor
                draw_rectangle_color(
                  _x, _y, 
                  _x + this.area.getWidth(), _y + this.area.getHeight(),
                  color, color, color, color,
                  false
                )
              }

              var sprite = Struct.get(this, "sprite")
              if (!Core.isType(sprite, Sprite)) {
                sprite = SpriteUtil.parse({ name: "visu_texture_ui_spawn_arrow" })
                Struct.set(this, "sprite", sprite)
              }
              sprite.scaleToFit(this.area.getWidth(), this.area.getHeight())
                .render(
                  this.context.area.getX() + this.area.getX() + sprite.texture.offsetX * sprite.getScaleX(),
                  this.context.area.getY() + this.area.getY() + sprite.texture.offsetY * sprite.getScaleY()
                )
              
              return this
            },
          }
        },
      },
      {
        name: "shroom-spawn_angle",  
        template: VEComponents.get("numeric-slider-field"),
        layout: VELayouts.get("numeric-slider-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Angle",
            enable: { key: "shroom-spawn_use-angle" },
          },
          field: { 
            store: { key: "shroom-spawn_angle" },
            enable: { key: "shroom-spawn_use-angle" },
          },
          slider: { 
            minValue: 0.0,
            maxValue: 360.0,
            store: { key: "shroom-spawn_angle" },
            enable: { key: "shroom-spawn_use-angle" },
          },
        },
      },
    ]),
  }
}