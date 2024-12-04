///@package io.alkapivo.visu.editor.service.brush.entity

///@param {?Struct} [json]
///@return {Struct}
function brush_entity_shroom(json = null) {
  return {
    name: "brush_entity_shroom",
    store: new Map(String, Struct, {
      "en-shr_preview": {
        type: Boolean,
        value: Struct.getIfType(json, "en-shr_preview", Boolean, true),
      },
      "en-shr_template": {
        type: String,
        value: Struct.getIfType(json, "en-shr_template", String, "shroom-default"),
        passthrough: function(value) {
          var shroomService = Beans.get(BeanVisuController).shroomService
          return shroomService.templates.contains(value) || Visu.assets().shroomTemplates.contains(value)
            ? value
            : (Core.isType(this.value, String) ? this.value : "shroom-default")
        },
      },
      "en-shr_spd": {
        type: Number,
        value: Struct.getIfType(json, "en-shr_spd", Number, 10.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 99.9) 
        },
      },
      "en-shr_use-spd-rng": {
        type: Boolean,
        value: Struct.getIfType(json, "en-shr_use-spd-rng", Boolean, false),
      },
      "en-shr_spd-rng"
    : {
        type: Number,
        value: Struct.getIfType(json, "en-shr_spd-rng"
      , Number, 0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 99.9) 
        },
      },
      "en-shr_dir": {
        type: Number,
        value: Struct.getIfType(json, "en-shr_dir", Number, 270.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0, 360.0) 
        },
      },
      "en-shr_use-dir-rng": {
        type: Boolean,
        value: Struct.getIfType(json, "en-shr_use-dir-rng", Boolean, false),
      },
      "en-shr_dir-rng": {
        type: Number,
        value: Struct.getIfType(json, "en-shr_dir-rng", Number, 0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 360.0) 
        },
      },
      "en-shr_x": {
        type: Number,
        value: Struct.getIfType(json, "en-shr_x", Number, 0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), -1.0 * (SHROOM_SPAWN_CHANNEL_AMOUNT / 2.0), SHROOM_SPAWN_CHANNEL_AMOUNT / 2.0)
        },
      },
      "en-shr_snap-x": {
        type: Boolean,
        value: Struct.getIfType(json, "en-shr_snap-x", Boolean, true),
      },
      "en-shr_use-rng-x": {
        type: Boolean,
        value: Struct.getIfType(json, "en-shr_use-rng-x", Boolean, false),
      },
      "en-shr_rng-x": {
        type: Number,
        value: Struct.getIfType(json, "en-shr_rng-x", Number, 0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0, SHROOM_SPAWN_CHANNEL_AMOUNT)
        },
      },
      "en-shr_y": {
        type: Number,
        value: Struct.getIfType(json, "en-shr_y", Number, 0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), -1.0 * (SHROOM_SPAWN_ROW_AMOUNT / 2.0), SHROOM_SPAWN_ROW_AMOUNT / 2.0)
        },
      },
      "en-shr_snap-y": {
        type: Boolean,
        value: Struct.getIfType(json, "en-shr_snap-y", Boolean, true),
      },
      "en-shr_use-rng-y": {
        type: Boolean,
        value: Struct.getIfType(json, "en-shr_use-rng-y", Boolean, false),
      },
      "en-shr_rng-y": {
        type: Number,
        value: Struct.getIfType(json, "en-shr_rng-y", Number, 0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0, SHROOM_SPAWN_ROW_AMOUNT)
        },
      },
    }),
    components: new Array(Struct, [
      {
        name: "en-shr_preview",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Preview spawn position",
            enable: { key: "en-shr_preview" },
            backgroundColor: VETheme.color.accentShadow,
            updateCustom: function() {
              this.preRender()
              if (Core.isType(this.context.updateTimer, Timer)) {
                var inspectorType = this.context.state.get("inspectorType")
                switch (inspectorType) {
                  case VEEventInspector:
                    var shroomService = Beans.get(BeanVisuController).shroomService
                    if (shroomService.spawnerEvent != null) {
                      shroomService.spawnerEvent.timeout = ceil(this.context.updateTimer.duration * 60)
                    }
                    break
                  case VEBrushToolbar:
                    var shroomService = Beans.get(BeanVisuController).shroomService
                    if (shroomService.spawner != null) {
                      shroomService.spawner.timeout = ceil(this.context.updateTimer.duration * 60)
                    }
                    break
                }
              }
            },
            preRender: function() {
              var store = null
              if (Core.isType(this.context.state.get("brush"), VEBrush)) {
                store = this.context.state.get("brush").store
              }
              
              if (Core.isType(this.context.state.get("event"), VEEvent)) {
                store = this.context.state.get("event").store
              }

              if (!Optional.is(store) || !store.getValue("en-shr_preview")) {
                return
              }

              var view = Beans.get(BeanVisuController).gridService.view
  
              if (!Struct.contains(this, "spawnerXTimer")) {
                Struct.set(this, "spawnerXTimer", new Timer(pi * 2, { 
                  loop: Infinity,
                  amount: FRAME_MS * 4,
                  shuffle: true
                }))
              }

              var _x = store.getValue("en-shr_x") * (SHROOM_SPAWN_CHANNEL_SIZE / SHROOM_SPAWN_CHANNEL_AMOUNT) + 0.5
              if (store.getValue("en-shr_use-rng-x")) {
                _x += sin(this.spawnerXTimer.update().time) * (store.getValue("en-shr_rng-x") * (SHROOM_SPAWN_CHANNEL_SIZE / SHROOM_SPAWN_CHANNEL_AMOUNT) / 2.0)
              }

              if (store.getValue("en-shr_snap-x")) {
                _x = _x - (view.x - floor(view.x / view.width) * view.width)
              }

              if (!Struct.contains(this, "spawnerYTimer")) {
                Struct.set(this, "spawnerYTimer", new Timer(pi * 2, { 
                  loop: Infinity,
                  amount: FRAME_MS * 4,
                  shuffle: true
                }))
              }

              var _y = store.getValue("en-shr_y") * (SHROOM_SPAWN_ROW_SIZE / SHROOM_SPAWN_ROW_AMOUNT) - 0.5
              if (store.getValue("en-shr_use-rng-y")) {
                _y += sin(this.spawnerYTimer.update().time) * (store.getValue("en-shr_rng-y") * (SHROOM_SPAWN_ROW_SIZE / SHROOM_SPAWN_ROW_AMOUNT) / 2.0)
              }

              if (store.getValue("en-shr_snap-y")) {
                _y = _y - (view.y - floor(view.y / view.height) * view.height)
              }

              var inspectorType = this.context.state.get("inspectorType")
              switch (inspectorType) {
                case VEEventInspector:
                  var shroomService = Beans.get(BeanVisuController).shroomService
                  shroomService.spawnerEvent = shroomService.factorySpawner({ 
                    x: _x, 
                    y: _y, 
                    sprite: SpriteUtil.parse({ name: "texture_bazyl" })
                  })
                  break
                case VEBrushToolbar:
                  var shroomService = Beans.get(BeanVisuController).shroomService
                  shroomService.spawner = shroomService.factorySpawner({ 
                    x: _x, 
                    y: _y, 
                    sprite: SpriteUtil.parse({ name: "texture_baron" })
                  })
                  break
              }
            },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-shr_preview" },
            backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            backgroundColor: VETheme.color.accentShadow,
          }
        },
      },
      {
        name: "en-shr_template",  
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Template" },
          field: { store: { key: "en-shr_template" } },
        },
      },
      {
        name: "en-shr_spd",  
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Speed" },
          field: { store: { key: "en-shr_spd" } },
        },
      },
      {
        name: "en-shr_spd-rng"
      ,
        template: VEComponents.get("text-field-checkbox"),
        layout: VELayouts.get("text-field-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Rng",
            enable: { key: "en-shr_use-spd-rng" },
          },  
          field: { 
            store: { key: "en-shr_spd-rng"
         },
            enable: { key: "en-shr_use-spd-rng" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-shr_use-spd-rng" },
          },
          title: { 
            text: "Enable",
            enable: { key: "en-shr_use-spd-rng" },
          },
        },
      },
      {
        name: "en-shr_dir",
        template: VEComponents.get("text-field-checkbox"),
        layout: VELayouts.get("text-field-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Angle" },  
          field: { store: { key: "en-shr_dir" } },
          checkbox: { 
            store: { 
              key: "en-shr_dir",
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
          },
          title: { text: "" },
        },
      },
      {
        name: "en-shr_dir-slider",  
        template: VEComponents.get("numeric-slider-button"),
        layout: VELayouts.get("numeric-slider-button"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "" },
          decrease: {
            factor: -1.0,
            minValue: 0.0,
            maxValue: 360.0,
            store: { key: "en-shr_dir" },
            label: { text: "-" },
            backgroundColor: VETheme.color.primary,
            backgroundColorSelected: VETheme.color.accent,
            backgroundColorOut: VETheme.color.primary,
            onMouseHoverOver: function(event) {
              if (Optional.is(this.enable) && !this.enable.value) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
                return
              }
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
            },
            onMouseHoverOut: function(event) {
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
            },
            callback: function() {
              this.store.set(clamp(this.store.getValue() + this.factor, this.minValue, this.maxValue))
            },
          },
          slider: {
            minValue: 0.0,
            maxValue: 360.0,
            snapValue: 1.0 / 360.0,
            store: { key: "en-shr_dir" },
          },
          increase: {
            factor: 1.0,
            minValue: 0.0,
            maxValue: 360.0,
            store: { key: "en-shr_dir" },
            label: { text: "+" },
            backgroundColor: VETheme.color.primary,
            backgroundColorSelected: VETheme.color.accent,
            backgroundColorOut: VETheme.color.primary,
            onMouseHoverOver: function(event) {
              if (Optional.is(this.enable) && !this.enable.value) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
                return
              }
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
            },
            onMouseHoverOut: function(event) {
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
            },
            callback: function() {
              this.store.set(clamp(this.store.getValue() + this.factor, this.minValue, this.maxValue))
            },
          },
        },
      },
      {
        name: "en-shr_dir-rng",
        template: VEComponents.get("text-field-checkbox"),
        layout: VELayouts.get("text-field-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Rng",
            enable: { key: "en-shr_use-dir-rng" },
          },  
          field: { 
            store: { key: "en-shr_dir-rng" },
            enable: { key: "en-shr_use-dir-rng" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-shr_use-dir-rng" },
          },
          title: { 
            text: "Enable",
            enable: { key: "en-shr_use-dir-rng" },
          },
        },
      },
      {
        name: "en-shr_dir-rng-slider",  
        template: VEComponents.get("numeric-slider-button"),
        layout: VELayouts.get("numeric-slider-button"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "" },
          decrease: {
            factor: -1.0,
            minValue: 0.0,
            maxValue: 360.0,
            store: { key: "en-shr_dir-rng" },
            enable: { key: "en-shr_use-dir-rng" },
            label: { text: "-" },
            backgroundColor: VETheme.color.primary,
            backgroundColorSelected: VETheme.color.accent,
            backgroundColorOut: VETheme.color.primary,
            onMouseHoverOver: function(event) {
              if (Optional.is(this.enable) && !this.enable.value) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
                return
              }
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
            },
            onMouseHoverOut: function(event) {
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
            },
            callback: function() {
              this.store.set(clamp(this.store.getValue() + this.factor, this.minValue, this.maxValue))
            },
          },
          slider: {
            minValue: 0.0,
            maxValue: 360.0,
            snapValue: 1.0 / 360.0,
            store: { key: "en-shr_dir-rng" },
            enable: { key: "en-shr_use-dir-rng" },
          },
          increase: {
            factor: 1.0,
            minValue: 0.0,
            maxValue: 360.0,
            store: { key: "en-shr_dir-rng" },
            enable: { key: "en-shr_use-dir-rng" },
            label: { text: "+" },
            backgroundColor: VETheme.color.primary,
            backgroundColorSelected: VETheme.color.accent,
            backgroundColorOut: VETheme.color.primary,
            onMouseHoverOver: function(event) {
              if (Optional.is(this.enable) && !this.enable.value) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
                return
              }
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
            },
            onMouseHoverOut: function(event) {
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
            },
            callback: function() {
              this.store.set(clamp(this.store.getValue() + this.factor, this.minValue, this.maxValue))
            },
          },
        },
      },
      {
        name: "en-shr_x",
        template: VEComponents.get("text-field-checkbox"),
        layout: VELayouts.get("text-field-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "X" },  
          field: { store: { key: "en-shr_x" } },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-shr_snap-x" },
          },
          title: { 
            text: "Snap",
            enable: { key: "en-shr_snap-x" },
          },
        },
      },
      {
        name: "en-shr_rng-x",
        template: VEComponents.get("text-field-checkbox"),
        layout: VELayouts.get("text-field-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Rng",
            enable: { key: "en-shr_use-rng-x" },
          },  
          field: { 
            store: { key: "en-shr_rng-x" },
            enable: { key: "en-shr_use-rng-x" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-shr_use-rng-x" },
          },
          title: { 
            text: "Enable",
            enable: { key: "en-shr_use-rng-x" },
          },
        },
      },
      {
        name: "shroom-spawn_channel-slider",  
        template: VEComponents.get("numeric-slider-button"),
        layout: VELayouts.get("numeric-slider-button"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "" },
          decrease: {
            factor: -1.0,
            minValue: -1.0 * (SHROOM_SPAWN_CHANNEL_AMOUNT / 2),
            maxValue: SHROOM_SPAWN_CHANNEL_AMOUNT / 2,
            store: { key: "en-shr_x" },
            label: { text: "-" },
            backgroundColor: VETheme.color.primary,
            backgroundColorSelected: VETheme.color.accent,
            backgroundColorOut: VETheme.color.primary,
            onMouseHoverOver: function(event) {
              if (Optional.is(this.enable) && !this.enable.value) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
                return
              }
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
            },
            onMouseHoverOut: function(event) {
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
            },
            callback: function() {
              this.store.set(clamp(this.store.getValue() + this.factor, this.minValue, this.maxValue))
            },
          },
          slider: {
            minValue: -1.0 * (SHROOM_SPAWN_CHANNEL_AMOUNT / 2.0),
            maxValue: SHROOM_SPAWN_CHANNEL_AMOUNT / 2.0,
            snapValue: 1.0 / SHROOM_SPAWN_CHANNEL_AMOUNT,
            store: { key: "en-shr_x" },
          },
          increase: {
            factor: 1.0,
            minValue: -1.0 * (SHROOM_SPAWN_CHANNEL_AMOUNT / 2),
            maxValue: SHROOM_SPAWN_CHANNEL_AMOUNT / 2,
            store: { key: "en-shr_x" },
            label: { text: "+" },
            backgroundColor: VETheme.color.primary,
            backgroundColorSelected: VETheme.color.accent,
            backgroundColorOut: VETheme.color.primary,
            onMouseHoverOver: function(event) {
              if (Optional.is(this.enable) && !this.enable.value) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
                return
              }
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
            },
            onMouseHoverOut: function(event) {
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
            },
            callback: function() {
              this.store.set(clamp(this.store.getValue() + this.factor, this.minValue, this.maxValue))
            },
          },
        },
      },
      {
        name: "en-shr_y",
        template: VEComponents.get("text-field-checkbox"),
        layout: VELayouts.get("text-field-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Y" },  
          field: { store: { key: "en-shr_y" } },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-shr_snap-y" },
          },
          title: { 
            text: "Snap",
            enable: { key: "en-shr_snap-y" },
          },
        },
      },
      {
        name: "en-shr_rng-y",
        template: VEComponents.get("text-field-checkbox"),
        layout: VELayouts.get("text-field-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Rng",
            enable: { key: "en-shr_use-rng-y" },
          },  
          field: { 
            store: { key: "en-shr_rng-y" },
            enable: { key: "en-shr_use-rng-y" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-shr_use-rng-y" },
          },
          title: { 
            text: "Enable",
            enable: { key: "en-shr_use-rng-y" },
          },
        },
      },
      {
        name: "shroom-spawn_row-slider",  
        template: VEComponents.get("numeric-slider-button"),
        layout: VELayouts.get("numeric-slider-button"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "" },
          decrease: {
            factor: -1.0,
            minValue: -1.0 * (SHROOM_SPAWN_ROW_AMOUNT / 2),
            maxValue: SHROOM_SPAWN_ROW_AMOUNT / 2,
            store: { key: "en-shr_y" },
            label: { text: "-" },
            backgroundColor: VETheme.color.primary,
            backgroundColorSelected: VETheme.color.accent,
            backgroundColorOut: VETheme.color.primary,
            onMouseHoverOver: function(event) {
              if (Optional.is(this.enable) && !this.enable.value) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
                return
              }
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
            },
            onMouseHoverOut: function(event) {
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
            },
            callback: function() {
              this.store.set(clamp(this.store.getValue() + this.factor, this.minValue, this.maxValue))
            },
          },
          slider: {
            minValue: -1.0 * (SHROOM_SPAWN_ROW_AMOUNT / 2.0),
            maxValue: SHROOM_SPAWN_ROW_AMOUNT / 2.0,
            snapValue: 1.0 / SHROOM_SPAWN_ROW_AMOUNT,
            store: { key: "en-shr_y" },
          },
          increase: {
            factor: 1.0,
            minValue: -1.0 * (SHROOM_SPAWN_ROW_AMOUNT / 2),
            maxValue: SHROOM_SPAWN_ROW_AMOUNT / 2,
            store: { key: "en-shr_y" },
            label: { text: "+" },
            backgroundColor: VETheme.color.primary,
            backgroundColorSelected: VETheme.color.accent,
            backgroundColorOut: VETheme.color.primary,
            onMouseHoverOver: function(event) {
              if (Optional.is(this.enable) && !this.enable.value) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
                return
              }
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
            },
            onMouseHoverOut: function(event) {
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
            },
            callback: function() {
              this.store.set(clamp(this.store.getValue() + this.factor, this.minValue, this.maxValue))
            },
          },
        },
      },
    ]),
  }
}