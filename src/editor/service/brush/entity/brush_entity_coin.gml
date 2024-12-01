///@package io.alkapivo.visu.editor.service.brush.entity

///@param {?Struct} [json]
///@return {Struct}
function brush_entity_coin(json = null) {
  return {
    name: "brush_entity_coin",
    store: new Map(String, Struct, {
      "en-coin_preview": {
        type: Boolean,
        value: Struct.getIfType(json, "en-coin_preview", Boolean, true),
      },
      "en-coin_template": {
        type: String,
        value: Struct.getDefault(json, "en-coin_template", "coin-default"),
        passthrough: function(value) {
          var coinService = Beans.get(BeanVisuController).coinService
          return coinService.templates.contains(value) || Visu.assets().coinTemplates.contains(value)
            ? value
            : (Core.isType(this.value, String) ? this.value : "coin-default")
        },
      },
      "en-coin_x": {
        type: Number,
        value: Struct.getDefault(json, "en-coin_x", 0.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), -1.0 * (SHROOM_SPAWN_CHANNEL_AMOUNT / 2.0), SHROOM_SPAWN_CHANNEL_AMOUNT / 2.0)
        },        
      },
      "en-coin_snap-x": {
        type: Boolean,
        value: Struct.getDefault(json, "en-coin_snap-x", true),
      },
      "en-coin_use-rng-x": {
        type: Boolean,
        value: Struct.getDefault(json, "en-coin_use-rng-x", true),
      },
      "en-coin_rng-x": {
        type: Number,
        value: Struct.getIfType(json, "en-coin_rng-x", Number, 0.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0, SHROOM_SPAWN_CHANNEL_AMOUNT)
        },
      },
      "en-coin_y": {
        type: Number,
        value: Struct.getDefault(json, "en-coin_y", 0.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), -1.0 * (SHROOM_SPAWN_ROW_AMOUNT / 2.0), SHROOM_SPAWN_ROW_AMOUNT / 2.0)
        },
      },
      "en-coin_snap-y": {
        type: Boolean,
        value: Struct.getDefault(json, "en-coin_snap-y", true),
      },
      "en-coin_use-rng-y": {
        type: Boolean,
        value: Struct.getDefault(json, "en-coin_use-rng-y", true),
      },
      "en-coin_rng-y": {
        type: Number,
        value: Struct.getIfType(json, "en-coin_rng-y", Number, 0.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0, SHROOM_SPAWN_ROW_AMOUNT)
        },
      },
    }),
    components: new Array(Struct, [
      {
        name: "en-coin_preview",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Spawner preview",
            enable: { key: "en-coin_preview" },
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

              if (!Optional.is(store) || !store.getValue("en-coin_preview")) {
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

              var _x = store.getValue("en-coin_x") * (SHROOM_SPAWN_CHANNEL_SIZE / SHROOM_SPAWN_CHANNEL_AMOUNT) + 0.5
              if (store.getValue("en-coin_use-rng-x")) {
                _x += sin(this.spawnerXTimer.update().time) * (store.getValue("en-coin_rng-x") * (SHROOM_SPAWN_CHANNEL_SIZE / SHROOM_SPAWN_CHANNEL_AMOUNT) / 2.0)
              }

              if (store.getValue("en-coin_snap-x")) {
                _x = _x - (view.x - floor(view.x / view.width) * view.width)
              }

              if (!Struct.contains(this, "spawnerYTimer")) {
                Struct.set(this, "spawnerYTimer", new Timer(pi * 2, { 
                  loop: Infinity,
                  amount: FRAME_MS * 4,
                  shuffle: true
                }))
              }

              var _y = store.getValue("en-coin_y") * (SHROOM_SPAWN_ROW_SIZE / SHROOM_SPAWN_ROW_AMOUNT) - 0.5
              if (store.getValue("en-coin_use-rng-y")) {
                _y += sin(this.spawnerYTimer.update().time) * (store.getValue("en-coin_rng-y") * (SHROOM_SPAWN_ROW_SIZE / SHROOM_SPAWN_ROW_AMOUNT) / 2.0)
              }

              if (store.getValue("en-coin_snap-y")) {
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
            store: { key: "en-coin_preview" },
            backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            backgroundColor: VETheme.color.accentShadow,
          }
        },
      },
      {
        name: "en-coin_template",  
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Template" },
          field: { store: { key: "en-coin_template" } },
        },
      },
      {
        name: "en-coin_x",
        template: VEComponents.get("text-field-checkbox"),
        layout: VELayouts.get("text-field-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "X" },  
          field: { store: { key: "en-coin_x" } },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-coin_snap-x" },
          },
          title: { 
            text: "Snap",
            enable: { key: "en-coin_snap-x" },
          },
        },
      },
      {
        name: "en-coin_rng-x",
        template: VEComponents.get("text-field-checkbox"),
        layout: VELayouts.get("text-field-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Rng",
            enable: { key: "en-coin_use-rng-x" },
          },  
          field: { 
            store: { key: "en-coin_rng-x" },
            enable: { key: "en-coin_use-rng-x" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-coin_use-rng-x" },
          },
          title: { 
            text: "Enable",
            enable: { key: "en-coin_use-rng-x" },
          },
        },
      },
      {
        name: "en-coin_x-slider",  
        template: VEComponents.get("numeric-slider-button"),
        layout: VELayouts.get("numeric-slider-button"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "" },
          decrease: {
            factor: -1.0,
            minValue: -1.0 * (SHROOM_SPAWN_CHANNEL_AMOUNT / 2),
            maxValue: SHROOM_SPAWN_CHANNEL_AMOUNT / 2,
            store: { key: "en-coin_x" },
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
            minValue: -1.0 * (SHROOM_SPAWN_CHANNEL_AMOUNT / 2),
            maxValue: SHROOM_SPAWN_CHANNEL_AMOUNT / 2,
            snapValue: 0.1,
            store: { key: "en-coin_x" },
          },
          increase: {
            factor: 1.0,
            minValue: -1.0 * (SHROOM_SPAWN_CHANNEL_AMOUNT / 2),
            maxValue: SHROOM_SPAWN_CHANNEL_AMOUNT / 2,
            store: { key: "en-coin_x" },
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
        name: "en-coin_y",
        template: VEComponents.get("text-field-checkbox"),
        layout: VELayouts.get("text-field-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Y" },  
          field: { store: { key: "en-coin_y" } },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-coin_snap-y" },
          },
          title: { 
            text: "Snap",
            enable: { key: "en-coin_snap-y" },
          },
        },
      },
      {
        name: "en-coin_rng-y",
        template: VEComponents.get("text-field-checkbox"),
        layout: VELayouts.get("text-field-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Rng",
            enable: { key: "en-coin_use-rng-y" },
          },  
          field: { 
            store: { key: "en-coin_rng-y" },
            enable: { key: "en-coin_use-rng-y" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-coin_use-rng-y" },
          },
          title: { 
            text: "Enable",
            enable: { key: "en-coin_use-rng-y" },
          },
        },
      },
      {
        name: "en-coin_y-slider",  
        template: VEComponents.get("numeric-slider-button"),
        layout: VELayouts.get("numeric-slider-button"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "" },
          decrease: {
            factor: -1.0,
            minValue: -1.0 * (SHROOM_SPAWN_ROW_AMOUNT / 2),
            maxValue: SHROOM_SPAWN_ROW_AMOUNT / 2,
            store: { key: "en-coin_y" },
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
            minValue: -1.0 * (SHROOM_SPAWN_ROW_AMOUNT / 2),
            maxValue: SHROOM_SPAWN_ROW_AMOUNT / 2,
            snapValue: 0.1,
            store: { key: "en-coin_y" },
          },
          increase: {
            factor: 1.0,
            minValue: -1.0 * (SHROOM_SPAWN_ROW_AMOUNT / 2),
            maxValue: SHROOM_SPAWN_ROW_AMOUNT / 2,
            store: { key: "en-coin_y" },
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