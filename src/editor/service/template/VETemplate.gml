///@package io.alkapivo.visu.editor.api.tilemap_get_cell_x_at_pixel

///@enum
function _VETemplateType(): Enum() constructor {
  SHADER = "template_shader"
  SHROOM = "template_shroom"
}
global.__VETemplateType = new _VETemplateType()
#macro VETemplateType global.__VETemplateType


///@static
///@type {Map<VETemplateType, String>}
global.__VETemplateTypeNames = new Map(String, String)
  .set(VETemplateType.SHADER, "Shader template")
  .set(VETemplateType.SHROOM, "Shroom template")
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
            value: json,   
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
    throw new Exception("toShroomTemplate NotImplemented")
  }

  ///@throws {Exception}
  ///@return {ShaderTemplate|ShroomTemplate}
  serialize = function() {
    switch (this.type) {
      case VETemplateType.SHADER:
        return this.toShaderTemplate()
      case VETemplateType.SHROOM:
        return this.toShroomTemplate()
      default:
        throw new Exception($"Serialize dispatcher for type '{this.type}' wasn't found")
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