///@package io.alkapivo.visu.editor.api.template

///@param {Struct} json
///@return {Struct}
function template_texture(json = null) {
  var template = {
    name: Assert.isType(json.name, String),
    store: new Map(String, Struct, {
      "name": {
        type: String,
        value: Assert.isType(json.name, String),
      },
    }),
    components: new Array(Struct, [
      {
        name: "texture_name",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Texture name" },
        },
      },
    ]),
  }

  return template
}
