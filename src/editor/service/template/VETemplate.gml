///@package io.alkapivo.visu.editor.api.tilemap_get_cell_x_at_pixel

///@enum
function _VETemplateType(): Enum() constructor {
  SHADER = "template_shader"
  SHROOM = "template_shroom"
  BULLET = "template_bullet"
}
global.__VETemplateType = new _VETemplateType()
#macro VETemplateType global.__VETemplateType


///@static
///@type {Map<VETemplateType, String>}
global.__VETemplateTypeNames = new Map(String, String)
  .set(VETemplateType.SHADER, "Shader template")
  .set(VETemplateType.SHROOM, "Shroom template")
  .set(VETemplateType.BULLET, "Bullet template")
#macro VETemplateTypeNames global.__VETemplateTypeNames


///@param {Struct} json
function VETemplate(json) constructor {

  ///@private
  ///@param {VETemplateType} type
  ///@param {Struct} json
  ///@throws {Exception}
  ///@return {Struct}
  static parseStoreConfig = function(type, json) {
    var storeConfig = {
      "template-name": {
        type: String,
        value: json.name,
      }
    }

    switch (type) {
      case VETemplateType.SHADER: return Struct
        .append(storeConfig, {
          "template-shader": {
            type: String,
            value: json.shader,   
          },
          "template-inherit": {
            type: Optional.of(String),
            value: Struct.getDefault(json, "inherit", null),
          },
        })
      case VETemplateType.SHROOM: return Struct
        .append(storeConfig, {
          "template-shroom": {
            type: String,
            value: json.name,   
          },
        })
      case VETemplateType.BULLET: return Struct
        .append(storeConfig, {
          "template-bullet": {
            type: String,
            value: json.name,   
          },
        })
      default: throw new Exception($"Found unsupported VETemplateType: {type}")
    }
  }

  ///@type {VETemplateType}
  type = Assert.isEnum(json.type, VETemplateType)

  ///@type {Store}
  store = new Store(this.parseStoreConfig(this.type, json))

  ///@type {Array<Struct>}
  components = new Array(Struct, [
    {
      name: "template-type",
      template: VEComponents.get("property"),
      layout: VELayouts.get("property"),
      config: { 
        layout: { type: UILayoutType.VERTICAL },
        label: { text: $"{VETemplateTypeNames.get(json.type)}" },
      },
    },
    {
      name: "template-name",
      template: VEComponents.get("text-field"),
      layout: VELayouts.get("text-field"),
      config: { 
        layout: { type: UILayoutType.VERTICAL },
        label: { text: "Name" },
        field: { store: { key: "template-name" } },
      },
    },
  ])

  ///@private
  ///@return {ShaderTemplate}
  toShaderTemplate = function() {
    var json = {
      name: Assert.isType(this.store.getValue("template-name"), String),
      shader: Assert.isType(this.store.getValue("template-shader"), String),
      type: Assert.isEnum(this.type, VETemplateType),
    }

    var inherit = this.store.getValue("template-inherit")
    if (Core.isType(inherit, String)) {
      Struct.set(json, "inherit", inherit)
    }

    var properties = this.store.container
      .filter(function(item) {
        return item.name != "template-name" 
          && item.name != "template-shader" 
          && item.name != "template-inherit" 
      })
      .toStruct(function(item) { 
        return item.serialize()
      })
    
    if (Struct.size(properties) > 0) {
      Struct.set(json, "properties", properties)
    }
    return new ShaderTemplate(json.name, json)
  }

  ///@private
  ///@return {ShroomTemplate}
  toShroomTemplate = function() {
    var sprite = this.store.getValue("shroom_texture")
    var json = {
      name: Assert.isType(this.store.getValue("template-name"), String),
      sprite: {
        name: sprite.getName(),
        frame: sprite.getFrame(),
        speed: sprite.getSpeed(),
        alpha: sprite.getAlpha(),
      },
      gameModes: {
        bulletHell: {
          features: JSON.parse(this.store.getValue("shroom_game-mode_bullet-hell_features")).getContainer()
        },
        platformer: {
          features: JSON.parse(this.store.getValue("shroom_game-mode_platformer_features")).getContainer()
        },
        idle: {
          features: JSON.parse(this.store.getValue("shroom_game-mode_idle_features")).getContainer()
        },
      }
    }

    if (this.store.getValue("use_shroom_mask")) {
      Struct.set(json, "mask", this.store.getValue("shroom_mask").serialize())
    }
    return new ShroomTemplate(json.name, json)
  }

  ///@private
  ///@return {ShroomTemplate}
  toBulletTemplate = function() {
    var sprite = this.store.getValue("bullet_texture")
    var json = {
      name: Assert.isType(this.store.getValue("template-name"), String),
      sprite: {
        name: sprite.getName(),
        frame: sprite.getFrame(),
        speed: sprite.getSpeed(),
        alpha: sprite.getAlpha(),
      },
      gameModes: {
        bulletHell: {
          features: JSON.parse(this.store.getValue("bullet_game-mode_bullet-hell_features")).getContainer()
        },
        platformer: {
          features: JSON.parse(this.store.getValue("bullet_game-mode_platformer_features")).getContainer()
        },
        idle: {
          features: JSON.parse(this.store.getValue("bullet_game-mode_idle_features")).getContainer()
        },
      }
    }

    if (this.store.getValue("use_bullet_mask")) {
      Struct.set(json, "mask", this.store.getValue("bullet_mask").serialize())
    }
    return new BulletTemplate(json.name, json)
  }

  ///@throws {Exception}
  ///@return {ShaderTemplate|ShroomTemplate}
  serialize = function() {
    switch (this.type) {
      case VETemplateType.SHADER: return this.toShaderTemplate()
      case VETemplateType.SHROOM: return this.toShroomTemplate()
      case VETemplateType.BULLET: return this.toBulletTemplate()
      default: throw new Exception($"Serialize dispatcher for type '{this.type}' wasn't found")
    }
  }

  ///@description append data
  var data = Assert.isType(Callable.run(this.type, json), Struct)
  data.store.forEach(function(json, name, store) {
    store.add(new StoreItem(name, json))
  }, this.store)
  data.components.forEach(function(component, index, components) {
    components.add(component)
  }, this.components)
}