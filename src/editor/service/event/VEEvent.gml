///@package io.alkapivo.visu.editor.service.event

///@param {UIItem} _context
///@param {?Struct} [json]
function VEEvent(_context, json = null) constructor {
  
  ///@type {UIItem}
  context = _context//Assert.isType(_context, UIItem)

  ///@type {String}
  type = Assert.isType(json.type, String) 

  ///@type {Store}
  store = new Store({
    "event-timestamp": {
      type: Number,
      value: Struct.get(json, "event-timestamp"),
      passthrough: function(value) {
        return clamp(value, 0.0, NumberUtil.parse(Beans
          .get(BeanVisuController).trackService.duration))
      }
    },
    "event-channel": {
      type: String,
      value: Struct.get(json, "event-channel"),
      passthrough: function(value) {
        var track = Beans.get(BeanVisuController).trackService.track
        return Core.isType(track, Track) && track.channels.contains(value)
          ? value
          : this.value
      }
    },
    "event-color": {
      type: Color,
      value: ColorUtil.fromHex(Struct.get(json, "event-color"), new Color(1.0, 1.0, 1.0, 1.0)),
      validate: function(value) {
        Assert.isType(ColorUtil.fromHex(value), Color)
      },
    },
    "event-texture": {
      type: String,
      value: Struct.get(json, "event-texture"),
      validate: function(value) {
        Assert.isType(TextureUtil.parse(value), Texture)
        Assert.areEqual(true, this.data.contains(value))
      },
      data: new Array(String, BRUSH_TEXTURES),
    },
  })

  ///@type {Array<Struct>}
  components = new Array(Struct, [
    {
      name: "event-type",
      template: VEComponents.get("property"),
      layout: VELayouts.get("property"),
      config: { 
        layout: { type: UILayoutType.VERTICAL },
        label: { text: $"{Struct.get(VEBrushTypeNames, json.type)}" },
      },
    },
    {
      name: "event-timestamp",  
      template: VEComponents.get("text-field"),
      layout: VELayouts.get("text-field"),
      config: { 
        layout: { type: UILayoutType.VERTICAL },
        label: { text: "Timestamp" },
        field: { store: { key: "event-timestamp" } },
      },
    },
    {
      name: "event-channel",  
      template: VEComponents.get("text-field"),
      layout: VELayouts.get("text-field"),
      config: { 
        layout: { type: UILayoutType.VERTICAL },
        label: { text: "Channel" },
        field: { store: { key: "event-channel" } },
      },
    },
    {
      name: "event-color",
      template: VEComponents.get("color-picker"),
      layout: VELayouts.get("color-picker"),
      config: {
        layout: { type: UILayoutType.VERTICAL },
        title: { 
          label: { text: "Icon" },
          input: { store: { key: "event-color" } }
        },
        red: {
          label: { text: "Red" },
          field: { store: { key: "event-color" } },
          slider: { store: { key: "event-color" } },
        },
        green: {
          label: { text: "Green" },
          field: { store: { key: "event-color" } },
          slider: { store: { key: "event-color" } },
        },
        blue: {
          label: { text: "Blue" },
          field: { store: { key: "event-color" } },
          slider: { store: { key: "event-color" } },
        },
        hex: { 
          label: { text: "Hex" },
          field: { store: { key: "event-color" } },
        },
      },
    },
    {
      name: "event-texture",
      template: VEComponents.get("spin-select"),
      layout: VELayouts.get("spin-select"),
      config: {
        layout: { type: UILayoutType.VERTICAL },
        label: { text: "Texture" },
        previous: { store: { key: "event-texture" } },
        preview: Struct.appendRecursive({ 
          store: { key: "event-texture" },
          imageBlendStoreKey: "event-color",
          updateCustom: function() {
            var key = Struct.get(this, "imageBlendStoreKey")
            if (!Optional.is(this.store)
              || !Core.isType(key, String) 
              || !Core.isType(this.image, Sprite)) {
              return
            }

            var store = this.store.getStore()
            if (!Optional.is(store)) {
              return
            }

            var item = store.get("event-color")
            if (!Optional.is(item)) {
              return
            }
            this.image.blend = item.get().toGMColor()
          },
        }, Struct.get(VEStyles.get("spin-select-image"), "preview"), false),
        next: { store: { key: "event-texture" } },
      }
    },
    {
      name: "event_start-properties-line-h",
      template: VEComponents.get("line-h"),
      layout: VELayouts.get("line-h"),
      config: { layout: { type: UILayoutType.VERTICAL } },
    }
  ])

  var eventHandler = Assert.isType(Beans.get(BeanVisuController).trackService.handlers.get(this.type), Struct)
  
  ///@type {Callable}
  serializeData = Assert.isType(Struct.get(eventHandler, "serialize"), Callable)

  ///@return {Struct}
  toTemplate = function() {
    var event = this
    return {
      channel: Assert.isType(event.store.getValue("event-channel"), String),
      event: {
        callable: Assert.isType(event.type, String),
        timestamp: Assert.isType(event.store.getValue("event-timestamp"), Number),
        data: Struct.appendUnique(
          {
            icon: {
              name: Assert.isType(event.store.getValue("event-texture"), String),
              blend: Assert.isType(event.store.getValue("event-color").toHex(), String),
            }
          },
          event.serializeData(event.store.container
            .filter(function(item) {
              return item.name != "event-timestamp"
                  && item.name != "event-channel"
                  && item.name != "event-color"
                  && item.name != "event-texture"
            })
            .toStruct(function(item) { 
              return item.serialize()
            })
          )
        ),
      }
    }
  }

  ///@description append data
  var uiHandler = Assert.isType(Callable.get(this.type), Callable)
  var eventParser = Assert.isType(Struct.get(eventHandler, "parse"), Callable)
  var data = Assert.isType(eventParser(Struct.getIfType(json, "properties", Struct, { })), Struct)
  var properties = Assert.isType(uiHandler(data), Struct)

  ///@description append StoreItems to default template
  properties.store.forEach(function(json, name, store) {
    store.add(new StoreItem(name, json))
  }, this.store)

  ///@description append components to default template
  properties.components.forEach(function(component, index, components) {
    components.add(component)
  }, this.components)

  ///@description append ending line
  this.components.add({
    name: "event_finish-properties-line-h",
    template: VEComponents.get("line-h"),
    layout: VELayouts.get("line-h"),
    config: { layout: { type: UILayoutType.VERTICAL } },
  })
}
