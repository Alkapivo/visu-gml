///@package io.alkapivo.visu.editor.api.template

///@param {Struct} json
///@return {Struct}
function template_texture(json = null) {
  var template = {
    name: Assert.isType(json.name, String),
    store: new Map(String, Struct, {
      "texture-template": {
        type: TextureTemplate,
        value: new TextureTemplate(json.name, json),
      },
    }),
    components: new Array(Struct, [
      {
        name: "texture-preview",
        template: VEComponents.get("texture-field-intent"),
        layout: VELayouts.get("texture-field-intent"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          image: { 
            name: json.name,
            disableTextureService: json.file == "",
          },
          origin: "texture-template",
          store: { key: "texture-template" },
          resolution: { 
            store: { 
              key: "texture-template",
              callback: function(value, data) { 
                if (!Core.isType(value, TextureTemplate)) {
                  return
                }
                
                data.label.text = $"width: {sprite_get_width(value.asset)} height: {sprite_get_height(value.asset)}"
              },
            },
          },
        },
      },
      {
        name: "texture-origin-x",
        template: VEComponents.get("text-field-increase"),
        layout: VELayouts.get("text-field-increase"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Origin X" },
          field: { 
            store: { 
              key: "texture-template",
              set: function(value) { 
                var parsed = NumberUtil.parse(value)
                var item = this.get()
                if (!Core.isType(parsed, Number)
                  || !Core.isType(item, StoreItem) 
                  || !Core.isType(item.get(), TextureTemplate)) {
                  return
                }

                var intent = item.get()
                intent.originX = parsed
                item.set(intent)
              },
              callback: function(value, data) { 
                if (!Core.isType(value, TextureTemplate)) {
                  return
                }
                
                data.textField.setText(value.originX)
              },
            },
            GMTF_DECIMAL: 0,
          },
          decrease: {
            factor: -1.0,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return 
              }

              var intent = item.get()
              if (!Core.isType(item.get(), TextureTemplate)) {
                return
              }

              intent.originX += factor
              item.set(intent)
            },
            store: {
              key: "texture-template",
              callback: function(value, data) { },
              set: function(value) { },
            },
          },
          increase: {
            factor: 1.0,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return 
              }

              var intent = item.get()
              if (!Core.isType(item.get(), TextureTemplate)) {
                return
              }

              intent.originX += factor
              item.set(intent)
            },
            store: {
              key: "texture-template",
              callback: function(value, data) { },
              set: function(value) { },
            },
          },
        },
      },
      {
        name: "texture-origin-y",
        template: VEComponents.get("text-field-increase"),
        layout: VELayouts.get("text-field-increase"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Origin Y" },
          field: { 
            store: { 
              key: "texture-template",
              set: function(value) { 
                var parsed = NumberUtil.parse(value)
                var item = this.get()
                if (!Core.isType(parsed, Number)
                  || !Core.isType(item, StoreItem) 
                  || !Core.isType(item.get(), TextureTemplate)) {
                  return
                }

                var intent = item.get()
                intent.originY = parsed
                item.set(intent)
              },
              callback: function(value, data) { 
                if (!Core.isType(value, TextureTemplate)) {
                  return
                }
                
                data.textField.setText(value.originY)
              },
            },
            GMTF_DECIMAL: 0,
          },
          decrease: {
            factor: -1.0,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return 
              }

              var intent = item.get()
              if (!Core.isType(item.get(), TextureTemplate)) {
                return
              }

              intent.originY += factor
              item.set(intent)
            },
            store: {
              key: "texture-template",
              callback: function(value, data) { },
              set: function(value) { },
            },
          },
          increase: {
            factor: 1.0,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return 
              }

              var intent = item.get()
              if (!Core.isType(item.get(), TextureTemplate)) {
                return
              }

              intent.originY += factor
              item.set(intent)
            },
            store: {
              key: "texture-template",
              callback: function(value, data) { },
              set: function(value) { },
            },
          },
        },
      },
    ]),
  }

  return template
}
