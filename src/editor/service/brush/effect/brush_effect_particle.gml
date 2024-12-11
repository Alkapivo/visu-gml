///@package io.alkapivo.visu.editor.service.brush.effect

///@param {Struct} json
///@return {Struct}
function migrateGridOldParticleEvent(json) {
  return {
    "ef-part_preview": Struct.getIfType(json, "grid-particle_use-preview", Boolean, false),
    "ef-part_template": Struct.getIfType(json, "grid-particle_template", String, "particle-default"),
    "ef-part_duration": Struct.getIfType(json, "grid-particle_duration", Number, 1.0),
    "ef-part_interval": Struct.getIfType(json, "grid-particle_interval", Number, 1.0),
    "ef-part_amount": Struct.getIfType(json, "grid-particle_amount", Number, 1.0),
    "ef-part_shape": Struct.get(json, "grid-particle_shape"),
    "ef-part_distribution": Struct.get(json, "grid-particle_distribution"),
    "ef-part_area": {
      "x": Struct.getIfType(json, "grid-particle_beginX", Number, 0.0),
      "y": Struct.getIfType(json, "grid-particle_beginY", Number, 0.0),
      "width": abs(Struct.getIfType(json, "grid-particle_endX", Number, 0.0)
        - Struct.getIfType(json, "grid-particle_beginX", Number, 0.0)),
      "height": abs(Struct.getIfType(json, "grid-particle_endY", Number, 0.0)
        - Struct.getIfType(json, "grid-particle_beginY", Number, 0.0)),
    }
  }
}


///@param {?Struct} [json]
///@return {Struct}
function brush_effect_particle(json = null) {
  return {
    name: "brush_effect_particle",
    store: new Map(String, Struct, {
      "ef-part_preview": {
        type: Boolean,
        value: Struct.getIfType(json, "ef-part_preview", Boolean, true),
      },
      "ef-part_template": {
        type: String,
        value: Struct.getIfType(json, "ef-part_template", String, "particle-default"),
        passthrough: function(value) {
          static contains = function(value) {
            var particleService = Beans.get(BeanVisuController).particleService
            return particleService.templates.contains(value) 
                || Visu.assets().particleTemplates.contains(value)  
          }

          return contains(value) 
            ? value 
            : (contains(this.value) ? this.value : "particle-default")
        },
      },
      "ef-part_area": {
        type: Rectangle,
        value: new Rectangle(Struct.getIfType(json, "ef-part_area", Struct, {
          x: 0.0,
          y: 0.0,
          width: 1.0,
          height: 1.0
        })),
      },
      "ef-part_amount": {
        type: Number,
        value: Struct.getIfType(json, "ef-part_amount", Number, 10),
        passthrough: function(value) {
          return round(clamp(NumberUtil.parse(value, this.value), 1, 999.0))
        },
      },
      "ef-part_duration": {
        type: Number,
        value: Struct.getIfType(json, "ef-part_duration", Number, 0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 999.9) 
        },
      },
      "ef-part_interval": {
        type: Number,
        value: Struct.getIfType(json, "ef-part_interval", Number, FRAME_MS),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), FRAME_MS, 999.9) 
        },
      },
      "ef-part_shape": {
        type: String,
        value: Struct.getIfType(json, "ef-part_shape", String, ParticleEmitterShape
          .keys().getFirst()),
        passthrough: function(value) {
          var keys = ParticleEmitterShape.keys()
          return keys.contains(value) 
            ? value 
            : (keys.contains(this.value) ? this.value : keys.getFirst())
        },
        data: ParticleEmitterShape.keys(),
      },
      "ef-part_distribution": {
        type: String,
        value: Struct.getIfType(json, "ef-part_distribution", String, ParticleEmitterDistribution
          .keys().getFirst()),
        passthrough: function(value) {
          var keys = ParticleEmitterDistribution.keys()
          return keys.contains(value) 
            ? value 
            : (keys.contains(this.value) ? this.value : keys.getFirst())
        },
        data: ParticleEmitterDistribution.keys(),
      },
    }),
    components: new Array(Struct, [
      {
        name: "ef-part_preview",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Preview emitter area",
            enable: { key: "ef-part_preview" },
            backgroundColor: VETheme.color.accentShadow,
            updateCustom: function() {
              this.preRender()
              if (Core.isType(this.context.updateTimer, Timer)) {
                var inspectorType = this.context.state.get("inspectorType")
                switch (inspectorType) {
                  case VEEventInspector:
                    var shroomService = Beans.get(BeanVisuController).shroomService
                    if (shroomService.particleAreaEvent != null) {
                      shroomService.particleAreaEvent.timeout = ceil(this.context.updateTimer.duration * 60)
                    }
                    break
                  case VEBrushToolbar:
                    var shroomService = Beans.get(BeanVisuController).shroomService
                    if (shroomService.particleArea != null) {
                      shroomService.particleArea.timeout = ceil(this.context.updateTimer.duration * 60)
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

              if (!Optional.is(store) || !store.getValue("ef-part_preview")) {
                return
              }

              var area = store.getValue("ef-part_area")
              if (!Core.isType(area, Rectangle)) {
                return
              }

              var inspectorType = this.context.state.get("inspectorType")
              switch (inspectorType) {
                case VEEventInspector:
                  var shroomService = Beans.get(BeanVisuController).shroomService
                  shroomService.particleAreaEvent = {
                    topLeft: shroomService.factorySpawner({
                      x: area.getX() + 0.5,
                      y: area.getY() + 0.5,
                      sprite: SpriteUtil.parse({ name: "texture_bazyl" }),
                    }),
                    topRight: shroomService.factorySpawner({
                      x: area.getX() + area.getWidth() + 0.5,
                      y: area.getY() + 0.5,
                      sprite: SpriteUtil.parse({ name: "texture_bazyl" }),
                    }),
                    bottomLeft: shroomService.factorySpawner({
                      x: area.getX() + 0.5,
                      y: area.getY() + area.getHeight() + 0.5,
                      sprite: SpriteUtil.parse({ name: "texture_bazyl" }),
                    }),
                    bottomRight: shroomService.factorySpawner({
                      x: area.getX() + area.getWidth() + 0.5,
                      y: area.getY() + area.getHeight() + 0.5,
                      sprite: SpriteUtil.parse({ name: "texture_bazyl" }),
                    }),
                    timeout: 5.0,
                  }
                  break
                case VEBrushToolbar:
                  var shroomService = Beans.get(BeanVisuController).shroomService
                  shroomService.particleArea = {
                    topLeft: shroomService.factorySpawner({
                      x: area.getX() + 0.5,
                      y: area.getY() + 0.5,
                      sprite: SpriteUtil.parse({ name: "texture_baron" }),
                    }),
                    topRight: shroomService.factorySpawner({
                      x: area.getX() + area.getWidth() + 0.5,
                      y: area.getY() + 0.5,
                      sprite: SpriteUtil.parse({ name: "texture_baron" }),
                    }),
                    bottomLeft: shroomService.factorySpawner({
                      x: area.getX() + 0.5,
                      y: area.getY() + area.getHeight() + 0.5,
                      sprite: SpriteUtil.parse({ name: "texture_baron" }),
                    }),
                    bottomRight: shroomService.factorySpawner({
                      x: area.getX() + area.getWidth() + 0.5,
                      y: area.getY() + area.getHeight() + 0.5,
                      sprite: SpriteUtil.parse({ name: "texture_baron" }),
                    }),
                    timeout: 5.0,
                  }
                  break
              }
            },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "ef-part_preview" },
            backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            backgroundColor: VETheme.color.accentShadow,
          }
        },
      },
      {
        name: "ef-part_template",  
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Template" },
          field: { store: { key: "ef-part_template" } },
        },
      },
      {
        name: "ef-part_amount",  
        template: VEComponents.get("text-field-increase"),
        layout: VELayouts.get("text-field-increase"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Amount" },
          field: { store: { key: "ef-part_amount" } },
          decrease: { store: { key: "ef-part_amount" } },
          increase: { store: { key: "ef-part_amount" } },
        },
      },
      {
        name: "ef-part_duration",  
        template: VEComponents.get("text-field-increase"),
        layout: VELayouts.get("text-field-increase"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Duration" },
          field: { store: { key: "ef-part_duration" } },
          decrease: {
            store: { key: "ef-part_duration" },
            factor: -0.25,
          },
          increase: {
            store: { key: "ef-part_duration" },
            factor: 0.25,
          },
        },
      },
      {
        name: "ef-part_interval",  
        template: VEComponents.get("text-field-increase"),
        layout: VELayouts.get("text-field-increase"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Interval" },
          field: { store: { key: "ef-part_interval" } },
          decrease: {
            store: { key: "ef-part_interval" },
            factor: -1.0 * FRAME_MS,
          },
          increase: {
            store: { key: "ef-part_interval" },
            factor: FRAME_MS,
          },
        },
      },
      {
        name: "ef-part_area-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "ef-part_area",
        template: VEComponents.get("vec4-slider"),
        layout: VELayouts.get("vec4"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          x: {
            label: { text: "Emitter X" },
            field: { store: { key: "ef-part_area" } },
            slider: {
              snapValue: 0.01 / 5.0,
              minValue: -2.5,
              maxValue: 2.5,
              store: { key: "ef-part_area" }
            },
          },
          y: {
            label: { text: "Emitter Y" },
            field: { store: { key: "ef-part_area" } },
            slider: {
              snapValue: 0.01 / 5.0,
              minValue: -2.5,
              maxValue: 2.5,
              store: { key: "ef-part_area" }
            },
          },
          z: {
            label: { text: "Width" },
            field: { store: { key: "ef-part_area" } },
            slider: {
              snapValue: 0.01 / 5.0,
              minValue: 0.0,
              maxValue: 5.0,
              store: { key: "ef-part_area" }
            },
          },
          a: {
            label: { text: "Height" },
            field: { store: { key: "ef-part_area" } },
            slider: {
              snapValue: 0.01 / 5.0,
              minValue: 0.0,
              maxValue: 5.0,
              store: { key: "ef-part_area" }
            },
          },
        },
      },
      {
        name: "ef-part_shape-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "ef-part_shape",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Shape" },
          previous: { store: { key: "ef-part_shape" } },
          preview: Struct.appendRecursive({ 
            store: { key: "ef-part_shape" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: { store: { key: "ef-part_shape" } },
        },
      },
      {
        name: "ef-part_distribution",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Dist." },
          previous: { store: { key: "ef-part_distribution" } },
          preview: Struct.appendRecursive({ 
            store: { key: "ef-part_distribution" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: { store: { key: "ef-part_distribution" } },
        },
      },
      /*
      {
        name: "ef-part_area-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Emitter area" },
        },
      },
      */
    ]),
  }
}