///@package io.alkapivo.visu.editor.api.template

///@param {Struct} json
///@return {Struct}
function template_lyrics(json = null) {
  var template = {
    name: Assert.isType(json.name, String),
    store: new Map(String, Struct, {
      "lines": {
        type: String,
        value: Struct.getDefault(json, "lines", new Array(String)).join("\n"),
      },
      "font": {
        type: String,
        value: "",
      },
      "fontHeight": {
        type: String,
        value: "",
      },
      "charSpeed": {
        type: String,
        value: "",
      },
      "color": {
        type: String,
        value: "",
      },
      "align": {
        type: String,
        value: "",
      },
      "area": {
        type: String,
        value: "",
      },
      "use-outline": {
        type: Boolean,
        value: Struct.getDefault(json, "use-outline", false),
      },
      "outline": {
        type: String,
        value: "",
      },
      "use-lineDelay": {
        type: Boolean,
        value: Struct.getDefault(json, "use-lineDelay", false),
      },
      "lineDelay": {
        type: Number,
        value: Struct.getDefault(json, "lineDelay", 0.0),
      },
      "use-finishDelay": {
        type: Boolean,
        value: Struct.getDefault(json, "use-finishDelay", false),
      },
      "finishDelay": {
        type: String,
        value: Struct.getDefault(json, "finishDelay", 0.0),
      },
    }),
    components: new Array(Struct, [
      {
        name: "lyrics_lines",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Lines" },
        },
      },
      {
        name: "lyrics_lines_text-area",
        template: VEComponents.get("text-area"),
        layout: VELayouts.get("text-area"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          field: { 
            v_grow: true,
            store: { key: "lines" },
          },
        },
      },
    ]),
  }

  return template
}
