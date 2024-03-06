///@package io.alkapivo.visu.editor.service.brush.

///@static
///@type {Map<String, Callable>}
global.__ShaderUniformTemplates = new Map(String, Callable)
  .set(ShaderUniformType.findKey(ShaderUniformType.COLOR), function(uniform, json) {
    return {
      store: {
        key: uniform.name,
        item: {
          type: Color,
          value: ColorUtil.fromHex("#ffffff"),
        },
      },
      component: {
        name: $"shader-uniform_{uniform.name}",
        template: VEComponents.get("color-picker"),
        layout: VELayouts.get("color-picker"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          title: { 
            label: { text: uniform.name },
            input: { store: { key: uniform.name } },
          },
          red: {
            label: { text: "Red" },
            field: { store: { key: uniform.name } },
            slider: { store: { key: uniform.name } },
          },
          green: {
            label: { text: "Green" },
            field: { store: { key: uniform.name } },
            slider: { store: { key: uniform.name } },
          },
          blue: {
            label: { text: "Blue" },
            field: { store: { key: uniform.name } },
            slider: { store: { key: uniform.name } },
          },
          hex: { 
            label: { text: "Hex" },
            field: { store: { key: uniform.name } },
          },
        }
      }
    }
  })
  .set(ShaderUniformType.findKey(ShaderUniformType.FLOAT), function(uniform, json) {
    return {
      store: {
        key: uniform.name,
        item: {
          type: NumberTransformer,
          value: new NumberTransformer(Struct
            .getDefault(json, uniform.name, { value: 0 })),
        },
      },
      component: {
        name: $"shader-uniform_{uniform.name}",
        template: VEComponents.get("transform-numeric-uniform"),
        layout: VELayouts.get("transform-numeric-uniform"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          title: { label: { text: uniform.name } },
          label: { text: uniform.name },
          value: {
            label: { text: "value" },
            field: { store: { key: uniform.name } },
          },
          target: {
            label: { text: "target" },
            field: { store: { key: uniform.name } },
          },
          factor: {
            label: { text: "factor" },
            field: { store: { key: uniform.name } },
          },
          increment: {
            label: { text: "increment" },
            field: { store: { key: uniform.name } },
          },
        }
      }
    }
  })
  .set(ShaderUniformType.findKey(ShaderUniformType.VECTOR2), function(uniform, json) {
    return {
      store: {
        key: uniform.name,
        item: {
          type: Vector2Transformer,
          value: new Vector2Transformer(Struct
            .getDefault(json, uniform.name, { 
              x: { value: 1.0 }, 
              y: { value: 1.0 },
            })),
        },
      },
      component: {
        name: $"shader-uniform_{uniform.name}",
        template: VEComponents.get("transform-vec2-uniform"),
        layout: VELayouts.get("transform-vec2-uniform"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          label: { text: uniform.name },
          title: { label: { text: uniform.name } },
          valueX: {
            label: { text: "value X" },
            field: { store: { key: uniform.name } },
          },
          targetX: {
            label: { text: "target X" },
            field: { store: { key: uniform.name } },
          },
          factorX: {
            label: { text: "factor X" },
            field: { store: { key: uniform.name } },
          },
          incrementX: {
            label: { text: "inc. X" },
            field: { store: { key: uniform.name } },
          },
          valueY: {
            label: { text: "value Y" },
            field: { store: { key: uniform.name } },
          },
          targetY: {
            label: { text: "target Y" },
            field: { store: { key: uniform.name } },
          },
          factorY: {
            label: { text: "factor Y" },
            field: { store: { key: uniform.name } },
          },
          incrementY: {
            label: { text: "inc. Y" },
            field: { store: { key: uniform.name } },
          },
        }
      }
    }
  })
  /*
  .set(ShaderUniformType.findKey(ShaderUniformType.VECTOR3), function(uniform) {
    return {
      store: {
        name: uniform.name,
        item: {
          type: Number,
          value: 0,
        },
      },
      component: {
        name: $"shader-uniform_{uniform.name}",
        template: VEComponents.get("shader-property"),
        layout: VELayouts.get("shader-property"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          label: { text: uniform.name },
          field: { store: { key: uniform.name } }
        }
      }
    }
  })
  .set(ShaderUniformType.findKey(ShaderUniformType.VECTOR4), function(uniform) {
    return {
      store: {
        name: uniform.name,
        item: {
          type: Number,
          value: 0,
        },
      },
      component: {
        name: $"shader-uniform_{uniform.name}",
        template: VEComponents.get("shader-property"),
        layout: VELayouts.get("shader-property"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          label: { text: uniform.name },
          field: { store: { key: uniform.name } }
        }
      }
    }
  })
  .set(ShaderUniformType.findKey(ShaderUniformType.RESOLUTION), function(uniform) {
    return {
      store: {
        name: uniform.name,
        item: {
          type: Number,
          value: 0,
        },
      },
      component: {
        name: $"shader-uniform_{uniform.name}",
        template: VEComponents.get("shader-property"),
        layout: VELayouts.get("shader-property"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          label: { text: uniform.name },
          field: { store: { key: uniform.name } }
        }
      }
    }
  })
  */
#macro ShaderUniformTemplates global.__ShaderUniformTemplates


///@param {Struct} json
///@return {Struct}
function template_shader(json = null) {
  var shader = Assert.isType(ShaderUtil.fetch(json.shader), Shader)
  var template = {
    name: Assert.isType(json.name, String),
    shader: shader.name,
    store: new Map(String, Struct),
    components: new Array(Struct),
    json: json,
  }

  var inherit = Struct.getDefault(json, "inherit", null)
  if (Core.isType(inherit, String)) {
    Struct.set(template, "inherit", inherit)
  }

  shader.uniforms.forEach(function(uniform, key, template) {
    var type = ShaderUniformType.findKey(Callable.get(Core.getTypeName(uniform)))
    var properties = Struct.getDefault(template.json, "properties", {})
    var property = Callable.run(ShaderUniformTemplates.get(type), uniform, properties)
    if (!Optional.is(property)) {
      return
    }

    var asd = property.store.item
    var def = asd

    template.store.add(property.store.item, property.store.key)
    template.components.add(property.component)
  }, template)

  Struct.remove(template, "json")
  
  return template
}
