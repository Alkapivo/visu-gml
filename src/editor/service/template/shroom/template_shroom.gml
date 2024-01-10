///@package io.alkapivo.visu.editor.api.template

///@param {Struct} json
///@return {Struct}
function template_shroom(json = null) {
  var template = {
    name: Assert.isType(json.name, String),
    store: new Map(String, Struct),
    components: new Array(Struct),
  }

  return template
}
