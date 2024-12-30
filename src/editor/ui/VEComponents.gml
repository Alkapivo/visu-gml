///@package io.alkapivo.visu.editor.ui

///@static
///@type {Map<String, Callable>}
global.__VEComponents = new Map(String, Callable, {
  
  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "button": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIButton(
        $"{name}_button", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.button,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            }, 
            VEStyles.get("category-button"),
            false
          ),
          config,
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "bar-title": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIText(
        $"{name}_bar-title", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            }, 
            VEStyles.get("bar-title"),
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
    ])
  },

    ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "template-add-button": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIButton(
        $"{name}_template-add-button", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.button,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
              onMouseHoverOver: Callable.run(UIUtil.mouseEventTemplates.get("onMouseHoverOverBackground")),
              onMouseHoverOut: Callable.run(UIUtil.mouseEventTemplates.get("onMouseHoverOutBackground")),
            }, 
            VEStyles.get("template-add-button"),
            false
          ),
          config,
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "collection-button": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIButton(
        $"{name}_type-button", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
              onMouseHoverOver: Callable.run(UIUtil.mouseEventTemplates.get("onMouseHoverOverBackground")),
              onMouseHoverOut: Callable.run(UIUtil.mouseEventTemplates.get("onMouseHoverOutBackground")),
            }, 
            VEStyles.get("collection-button"),
            false
          ),
          config,
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "image": function(name, layout, config = null) {
    var items = new Array(UIItem, [
      UIImage(
        $"{name}_image",
        Struct.appendRecursive(
          { 
            layout: layout.nodes.image,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          }, 
          config,
          false
        )
      )
    ])

    if (Struct.contains(config, "resolution")) {
      items.add(UIText(
        name,
        Struct.appendRecursive(
          {
            layout: layout.nodes.resolution,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          },
          Struct.appendRecursive(
            Struct.appendRecursive(
              { 
                store: { 
                  callback: function(value, data) {
                    if (!Core.isType(value, Sprite)) {
                      return
                    }
  
                    data.label.text = $"width: {value.getWidth()} height: {value.getHeight()}"
                  },
                  set: function(value) { },
                }
              },
              VEStyles.get("texture-field-ext").resolution,
              false
            ),
            Struct.get(config, "resolution"),
            false
          ),
          false
        )
      ))
    }

    return items
  },
  
  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "texture-field-intent": function(name, layout, config = null) {
    var items = new Array(UIItem, [
      UIImage(
        $"{name}_image",
        Struct.appendRecursive(
          { 
            layout: layout.nodes.image,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          }, 
          config,
          false
        )
      )
    ])

    if (Struct.contains(config, "resolution")) {
      items.add(UIText(
        name,
        Struct.appendRecursive(
          {
            layout: layout.nodes.resolution,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          },
          Struct.appendRecursive(
            Struct.appendRecursive(
              { 
                store: { 
                  callback: function(value, data) {
                    if (!Core.isType(value, Sprite)) {
                      return
                    }
  
                    data.label.text = $"width: {value.getWidth()} height: {value.getHeight()}"
                  },
                  set: function(value) { },
                }
              },
              VEStyles.get("texture-field-ext").resolution,
              false
            ),
            Struct.get(config, "resolution"),
            false
          ),
          false
        )
      ))
    }

    return items
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "line-h": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIImage(
        $"{name}_line-h",
        Struct.appendRecursive(
          { 
            layout: layout.nodes.image,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          }, 
          Struct.appendRecursive(
            Struct.get(config, "image"),
            VEStyles.get("line-h").image,
            false
          ),
          false
        )
      )
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "line-w": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIImage(
        $"{name}_line-w",
        Struct.appendRecursive(
          { 
            layout: layout.nodes.image,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          }, 
          Struct.appendRecursive(
            Struct.get(config, "image"),
            VEStyles.get("line-w").image,
            false
          ),
          false
        )
      )
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {Struct} config
  ///@return {Array<UIItem>}
  "label": function(name, layout, config) {
    return new Array(UIItem, [
      UIText(
        $"label_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("text-field-button").label,
            false
          ),
          Struct.get(config, "label"),
          false
        )
      )
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {Struct} config
  ///@return {Array<UIItem>}
  "checkbox": function(name, layout, config) {
    return new Array(UIItem, [
      UICheckbox(
        $"{name}_checkbox", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.checkbox,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            }, 
            VEStyles.get("checkbox"),
            false
          ),
          Struct.get(config, "checkbox"),
          false
        )
      )
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "category-button": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIButton(
        $"{name}_category-button", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            }, 
            VEStyles.get("category-button"),
            false
          ),
          config,
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "type-button": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIButton(
        $"{name}_type-button", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            }, 
            VEStyles.get("type-button"),
            false
          ),
          config,
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "channel-entry": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIButton(
        $"{name}_channel-entry_settings", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.settings,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            }, 
            VEStyles.get("channel-entry").settings,
            false
          ),
          Struct.get(config, "settings"),
          false
        )
      ),
      UIButton(
        $"{name}_channel-entry_remove", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.remove,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            }, 
            VEStyles.get("channel-entry").remove,
            false
          ),
          Struct.get(config, "remove"),
          false
        )
      ),
      UIText(
        $"{name}_channel-entry_label",
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            }, 
            VEStyles.get("channel-entry").label,
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      UICheckbox(
        $"{name}_channel-entry_mute", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.mute,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            }, 
            VEStyles.get("channel-entry").mute,
            false
          ),
          Struct.get(config, "mute"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "brush-entry": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIImage(
        $"{name}_brush-entry_image",
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.image,
              _updateArea: new BindIntent(Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout"))),
              updateArea: function() {
                this._updateArea()
              }
            }, 
            VEStyles.get("brush-entry").image,
            false
          ),
          Struct.get(config, "image"),
          false
        )
      ),
      UIText(
        $"{name}_brush-entry_label",
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            }, 
            VEStyles.get("brush-entry").label,
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      UIButton(
        $"{name}_brush-entry_remove", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.remove,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            }, 
            VEStyles.get("brush-entry").remove,
            false
          ),
          Struct.get(config, "remove"),
          false
        )
      ),
      UIButton(
        $"{name}_brush-entry_settings", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.settings,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            }, 
            VEStyles.get("brush-entry").settings,
            false
          ),
          Struct.get(config, "settings"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "template-entry": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIButton(
        $"{name}_template-entry_settings", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.settings,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            }, 
            VEStyles.get("template-entry").settings,
            false
          ),
          Struct.get(config, "settings"),
          false
        )
      ),
      UIButton(
        $"{name}_template-entry_remove", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.remove,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            }, 
            VEStyles.get("template-entry").remove,
            false
          ),
          Struct.get(config, "remove"),
          false
        )
      ),
      UIText(
        $"{name}_template-entry_label",
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            }, 
            VEStyles.get("template-entry").label,
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "template-entry-lock": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIButton(
        $"{name}_template-entry-lock-entry_settings", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.settings,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            }, 
            VEStyles.get("template-entry-lock").settings,
            false
          ),
          Struct.get(config, "settings"),
          false
        )
      ),
      UIButton(
        $"{name}_template-entry-lock-entry_remove", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.remove,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            }, 
            VEStyles.get("template-entry-lock").remove,
            false
          ),
          Struct.get(config, "remove"),
          false
        )
      ),
      UIText(
        $"{name}_template-entry-lock-entry_label",
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            }, 
            VEStyles.get("template-entry-lock").label,
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "property": function(name, layout, config = null) {
    var style = VEStyles.get("property")

    
    var cfg = Struct.appendRecursive(
      Struct.appendRecursive(
        { 
          layout: layout.nodes.label,
          updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
        },
        Struct.get(style, "label"),
        false
      ),
      Struct.get(config, "label"),
      false
    )

    return new Array(UIItem, [
      UICheckbox(
        $"{name}_checkbox", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.checkbox,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            }, 
            Struct.get(style, "checkbox"),
            false
          ),
          Struct.get(config, "checkbox"),
          false
        )
      ),
      UIText(
        $"{name}_text", 
        cfg
      ),
      UICheckbox(
        $"{name}_input", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.input,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            }, 
            Struct.get(style, "input"),
            false
          ),
          Struct.get(config, "input"),
          false
        )
      ),
    ])
  },

    ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "property-bar": function(name, layout, config = null) {
    var style = VEStyles.get("property-bar")
    return new Array(UIItem, [
      UICheckbox(
        $"{name}_checkbox", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.checkbox,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            }, 
            Struct.get(style, "checkbox"),
            false
          ),
          Struct.get(config, "checkbox"),
          false
        )
      ),
      UIText(
        $"{name}_text", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            Struct.get(style, "label"),
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      UICheckbox(
        $"{name}_input", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.input,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            }, 
            Struct.get(style, "input"),
            false
          ),
          Struct.get(config, "input"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "text-field": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIText(
        $"label_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("text-field_label"),
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      UITextField(
        $"field_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.field,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayoutTextField")),
            },
            VEStyles.get("text-field"),
            false
          ),
          Struct.get(config, "field"),
          false
        )
      ),
    ])
  },

  "text-field-simple": function(name, layout, config = null) {
    return new Array(UIItem, [
      UITextField(
        $"field_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.field,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayoutTextField")),
            },
            VEStyles.get("text-field-simple"),
            false
          ),
          Struct.get(config, "field"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "text-area": function(name, layout, config = null) {
    return new Array(UIItem, [
      UITextField(
        $"field_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.field,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayoutTextField")),
            },
            VEStyles.get("text-area"),
            false
          ),
          Struct.get(config, "field"),
          false
        )
      )
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "text-field-button": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIText(
        $"label_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("text-field-button").label,
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      UITextField(
        $"field_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.field,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayoutTextField")),
            },
            VEStyles.get("text-field-button").field,
            false
          ),
          Struct.get(config, "field"),
          false
        )
      ),
      UIButton(
        $"button_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.button,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            }, 
            VEStyles.get("text-field-button").button,
            false
          ),
          Struct.get(config, "button"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "text-field-checkbox": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIText(
        $"label_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("text-field-button").label,
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      UITextField(
        $"field_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.field,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayoutTextField")),
            },
            VEStyles.get("text-field-button").field,
            false
          ),
          Struct.get(config, "field"),
          false
        )
      ),
      UICheckbox(
        $"{name}_checkbox", 
        Struct.appendRecursive(
          { 
            layout: layout.nodes.checkbox,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          }, 
          Struct.get(config, "checkbox"),
          false
        )
      ),
      UIText(
        $"{name}_title", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.title,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("text-field-checkbox").title,
            false
          ),
          Struct.get(config, "title"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "text-field-increase": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIText(
        $"label_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("text-field-button").label,
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      UITextField(
        $"field_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.field,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayoutTextField")),
            },
            VEStyles.get("text-field-button").field,
            false
          ),
          Struct.get(config, "field"),
          false
        )
      ),
      UIButton(
        $"{name}_decrease", 
        Struct.appendRecursive(
          { 
            factor: -1.0,
            label: {
              text: "-",
              font: "font_inter_10_regular",
              color: VETheme.color.textFocus,
              align: { v: VAlign.CENTER, h: HAlign.CENTER },
            },
            backgroundColor: VETheme.color.button,
            backgroundColorSelected: VETheme.color.buttonHover,
            backgroundColorOut: VETheme.color.button,
            layout: layout.nodes.decrease,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }
              item.set(item.get() + factor)
            },
            onMouseHoverOver: function(event) {
              if (Struct.get(this.enable, "value") == false) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
                return
              }
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
            },
            onMouseHoverOut: function(event) {
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
            },
          },
          Struct.get(config, "decrease"),
          false
        )
      ),
      UIButton(
        $"{name}_increase", 
        Struct.appendRecursive(
          { 
            factor: 1.0,
            label: { 
              text: "+",
              font: "font_inter_10_regular",
              color: VETheme.color.textFocus,
              align: { v: VAlign.CENTER, h: HAlign.CENTER },
            },
            backgroundColor: VETheme.color.button,
            backgroundColorSelected: VETheme.color.buttonHover,
            backgroundColorOut: VETheme.color.button,
            layout: layout.nodes.increase,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              item.set(item.get() + factor)
            },
            onMouseHoverOver: function(event) {
              if (Struct.get(this.enable, "value") == false) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
                return
              }
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
            },
            onMouseHoverOut: function(event) {
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
            },
          },
          Struct.get(config, "increase"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "text-field-increase-checkbox": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIText(
        $"label_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("text-field-button").label,
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      UITextField(
        $"field_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.field,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayoutTextField")),
            },
            VEStyles.get("text-field-button").field,
            false
          ),
          Struct.get(config, "field"),
          false
        )
      ),
      UIButton(
        $"{name}_decrease", 
        Struct.appendRecursive(
          { 
            factor: -1.0,
            label: {
              text: "-",
              font: "font_inter_10_regular",
              color: VETheme.color.textFocus,
              align: { v: VAlign.CENTER, h: HAlign.CENTER },
            },
            backgroundColor: VETheme.color.button,
            backgroundColorSelected: VETheme.color.buttonHover,
            backgroundColorOut: VETheme.color.button,
            layout: layout.nodes.decrease,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }
              item.set(item.get() + factor)
            },
            onMouseHoverOver: function(event) {
              
              if (Struct.get(this.enable, "value") == false) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
                return
              }
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
            },
            onMouseHoverOut: function(event) {
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
            },
          },
          Struct.get(config, "decrease"),
          false
        )
      ),
      UIButton(
        $"{name}_increase", 
        Struct.appendRecursive(
          { 
            factor: 1.0,
            label: { 
              text: "+",
              font: "font_inter_10_regular",
              color: VETheme.color.textFocus,
              align: { v: VAlign.CENTER, h: HAlign.CENTER },
            },
            backgroundColor: VETheme.color.button,
            backgroundColorSelected: VETheme.color.buttonHover,
            backgroundColorOut: VETheme.color.button,
            layout: layout.nodes.increase,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              item.set(item.get() + factor)
            },
            onMouseHoverOver: function(event) {
              if (Struct.get(this.enable, "value") == false) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
                return
              }
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
            },
            onMouseHoverOut: function(event) {
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
            },
          },
          Struct.get(config, "increase"),
          false
        )
      ),
      UICheckbox(
        $"{name}_checkbox", 
        Struct.appendRecursive(
          { 
            layout: layout.nodes.checkbox,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          }, 
          Struct.get(config, "checkbox"),
          false
        )
      ),
      UIText(
        $"{name}_title", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.title,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("text-field-checkbox").title,
            false
          ),
          Struct.get(config, "title"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "text-field-increase-stick-checkbox": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIText(
        $"label_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("text-field-button").label,
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      UITextField(
        $"field_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.field,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayoutTextField")),
            },
            VEStyles.get("text-field-button").field,
            false
          ),
          Struct.get(config, "field"),
          false
        )
      ),
      UIButton(
        $"{name}_decrease", 
        Struct.appendRecursive(
          { 
            factor: -1.0,
            label: {
              text: "-",
              font: "font_inter_10_regular",
              color: VETheme.color.textFocus,
              align: { v: VAlign.CENTER, h: HAlign.CENTER },
            },
            backgroundColor: VETheme.color.button,
            backgroundColorSelected: VETheme.color.buttonHover,
            backgroundColorOut: VETheme.color.button,
            layout: layout.nodes.decrease,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }
              item.set(item.get() + factor)
            },
            onMouseHoverOver: function(event) {
              
              if (Struct.get(this.enable, "value") == false) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
                return
              }
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
            },
            onMouseHoverOut: function(event) {
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
            },
          },
          Struct.get(config, "decrease"),
          false
        )
      ),
      UIButton(
        $"{name}_increase", 
        Struct.appendRecursive(
          { 
            factor: 1.0,
            label: { 
              text: "+",
              font: "font_inter_10_regular",
              color: VETheme.color.textFocus,
              align: { v: VAlign.CENTER, h: HAlign.CENTER },
            },
            backgroundColor: VETheme.color.button,
            backgroundColorSelected: VETheme.color.buttonHover,
            backgroundColorOut: VETheme.color.button,
            layout: layout.nodes.increase,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              item.set(item.get() + factor)
            },
            onMouseHoverOver: function(event) {
              if (Struct.get(this.enable, "value") == false) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
                return
              }
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
            },
            onMouseHoverOut: function(event) {
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
            },
          },
          Struct.get(config, "increase"),
          false
        )
      ),
      UISliderHorizontal(
        $"stick_{name}",
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.stick,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
              getClipboard: Beans.get(BeanVisuEditorIO).mouse.getClipboard,
              setClipboard: Beans.get(BeanVisuEditorIO).mouse.setClipboard,
            },
            VEStyles.get("slider-horizontal"),
            false
          ),
          Struct.get(config, "stick"),
          false
        )
      ),
      UICheckbox(
        $"{name}_checkbox", 
        Struct.appendRecursive(
          { 
            layout: layout.nodes.checkbox,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          }, 
          Struct.get(config, "checkbox"),
          false
        )
      ),
      UIText(
        $"{name}_title", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.title,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("text-field-checkbox").title,
            false
          ),
          Struct.get(config, "title"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "double-checkbox": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIText(
        $"label_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("double-checkbox").label,
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      UICheckbox(
        $"checkbox1_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.checkbox1,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("double-checkbox").checkbox1,
            false
          ),
          Struct.get(config, "checkbox1"),
          false
        )
      ),
      UIText(
        $"label1_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label1,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("double-checkbox").label1,
            false
          ),
          Struct.get(config, "label1"),
          false
        )
      ),
      UICheckbox(
        $"checkbox2_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.checkbox2,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("double-checkbox").checkbox2,
            false
          ),
          Struct.get(config, "checkbox2"),
          false
        )
      ),
      UIText(
        $"label2_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label2,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("double-checkbox").label2,
            false
          ),
          Struct.get(config, "label2"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "text-field-button-checkbox": function(name, layout, config = null) {
    return new Array(UIItem, [
      UICheckbox(
        $"{name}_checkbox", 
        Struct.appendRecursive(
          { 
            layout: layout.nodes.checkbox,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          }, 
          Struct.get(config, "checkbox"),
          false
        )
      ),
      UIText(
        $"label_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("text-field-button").label,
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      UITextField(
        $"field_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.field,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayoutTextField")),
            },
            VEStyles.get("text-field-button").field,
            false
          ),
          Struct.get(config, "field"),
          false
        )
      ),
      UIButton(
        $"button_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.button,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            }, 
            VEStyles.get("text-field-button").button,
            false
          ),
          Struct.get(config, "button"),
          false
        )
      ),
    ])
  },
  
  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "boolean-field": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIText(
        $"label_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("text-field_label"),
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      UICheckbox(
        $"{name}_checkbox", 
        Struct.appendRecursive(
          { 
            layout: layout.nodes.field,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          }, 
          Struct.get(config, "field"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "__texture-field": function(name, layout, config = null) {
    ///@todo move to Lambda util
    static addItem = function(item, index, items) {
      items.add(item)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryTitle = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryTextField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryTextFieldCheckbox = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field-checkbox"),
        layout: VELayouts.get("text-field-checkbox"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryNumericSliderField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("numeric-slider-field"),
        layout: VELayouts.get("numeric-slider-field"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIItem}
    static factoryImage = function(name, layout, config) {
      return UIImage(
        name, 
        Struct.appendRecursive(
          {
            layout: layout,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          },
          config,
          false
        )
      )
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryProperty = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: config,
      }).toUIItems(layout)
    }

    var items = new Array(UIItem)

    factoryTitle(
      $"{name}_title", 
      layout.nodes.title, 
      Struct.get(config, "title")
    ).forEach(addItem, items)

    factoryTextField(
      $"{name}_texture",
      layout.nodes.texture, 
      Struct.appendRecursive(
        { 
          field: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }
                data.textField.setText(value.texture.name)
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item) || !TextureUtil.exists(value)) {
                  return
                }
                
                var json = item.get().serialize()
                json.name = value
                item.set(SpriteUtil.parse(json))
              },
            }
          }
        }, 
        Struct.get(config, "texture"),
        false
      )
    ).forEach(addItem, items)

    items.add(
      factoryImage(
        $"{name}_preview", 
        layout.nodes.preview, 
        Struct.appendRecursive(
          { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }
                data.image = value
              },
              set: function(value) { },
            }
          },
          Struct.get(config, "preview"),
          false
        )
      )
    )

    factoryNumericSliderField(
      $"{name}_alpha",
      layout.nodes.alpha, 
      Struct.appendRecursive(
        { 
          field: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }
                data.textField.setText(value.getAlpha())
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }
                sprite.setAlpha(NumberUtil.parse(value))
                item.set(sprite)
              },
            }
          },
          slider: { 
            minValue: 0.0,
            maxValue: 1.0,
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }
                data.value = value.getAlpha()
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }
                sprite.setAlpha(NumberUtil.parse(value))
                item.set(sprite)
              },
            },
          },
        },
        Struct.get(config, "alpha"),
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldCheckbox(
      $"{name}_speed",
      layout.nodes.speed, 
      Struct.appendRecursive(
        { 
          field: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }

                if (data.textField.isFocused()) {
                  return
                }

                data.textField.setText(value.getSpeed())
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }
                
                sprite.setSpeed(abs(NumberUtil.parse(value, sprite.getSpeed())))
                item.set(sprite)
              },
            }
          },
          checkbox: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }
                data.updateValue(value.getAnimate())
              },
              set: function(value) { 
                var item = this.get()
                item.get().setAnimate(value)
              },
            }
          },
        },
        Struct.get(config, "speed"),
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldCheckbox(
      $"{name}_frame",
      layout.nodes.frame, 
      Struct.appendRecursive(
        { 
          field: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }

                if (data.textField.isFocused()) {
                  return
                }

                data.textField.setText(value.getFrame())
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }
                
                sprite.setFrame(NumberUtil.parse(value))
                item.set(sprite)
              },
            }
          },
          checkbox: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }
                data.updateValue(value.getRandomFrame())
              },
              set: function(value) { 
                var item = this.get()
                item.get().setRandomFrame(value)
              },
            }
          },
        },
        Struct.get(config, "frame"),
        false
      )
    ).forEach(addItem, items)

    return items
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "texture-field": function(name, layout, config = null) {
    ///@todo move to Lambda util
    static addItem = function(item, index, items) {
      items.add(item)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryTitle = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryTextField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryTextFieldCheckbox = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field-checkbox"),
        layout: VELayouts.get("text-field-checkbox"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryTextFieldIncrease = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field-increase"),
        layout: VELayouts.get("text-field-increase"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryTextFieldIncreaseCheckbox = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field-increase-checkbox"),
        layout: VELayouts.get("text-field-increase-checkbox"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryDoubleCheckbox = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("double-checkbox"),
        layout: VELayouts.get("double-checkbox"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryNumericSliderField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("numeric-slider-field"),
        layout: VELayouts.get("numeric-slider-field"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryNumericSliderIncreaseField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIItem}
    static factoryImage = function(name, layout, config) {
      return UIImage(
        name, 
        Struct.appendRecursive(
          {
            layout: layout,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          },
          config,
          false
        )
      )
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIItem}
    static factoryLabel = function(name, layout, config) {
      return UIText(
        name,
        Struct.appendRecursive(
          {
            layout: layout,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          },
          config,
          false
        )
      )
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryProperty = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: config,
      }).toUIItems(layout)
    }

    var items = new Array(UIItem)

    factoryTitle(
      $"{name}_title", 
      layout.nodes.title, 
      Struct.get(config, "title")
    ).forEach(addItem, items)

    factoryTextField(
      $"{name}_texture",
      layout.nodes.texture, 
      Struct.appendRecursive(
        { 
          label: { text: "Texture" },
          field: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }

                if (data.textField.isFocused()) {
                  return
                }
                
                data.textField.setText(value.texture.name)
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item) || !TextureUtil.exists(value)) {
                  return
                }

                var json = item.get().serialize()
                json.name = value
                item.set(SpriteUtil.parse(json))
              },
            }
          }
        }, 
        Struct.get(config, "texture"),
        false
      )
    ).forEach(addItem, items)
    
    items.add(
      factoryImage(
        $"{name}_preview", 
        layout.nodes.preview, 
        Struct.appendRecursive(
          { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }
                data.image = value
              },
              set: function(value) { },
            },
            preRender: function() {
              if (this.image == null) {
                return
              }

              Struct.inject(this.image, "_restoreFrame", this.image.getFrame())
              this.image.setFrame(Struct.inject(this.image, "_frame", this.image.getFrame()))
            },
            postRender: function() {
              if (this.image == null) {
                return
              }

              Struct.set(this.image, "_frame", this.image.getFrame())
              this.image.setFrame(Struct.inject(this.image, "_restoreFrame", this.image.getFrame()))
            },
          },
          Struct.get(config, "preview"),
          false
        )
      )
    )

    items.add(
      factoryLabel(
        $"{name}_resolution", 
        layout.nodes.resolution, 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              store: { 
                callback: function(value, data) {
                  if (!Core.isType(value, Sprite)) {
                    return
                  }

                  data.label.text = $"width: {value.getWidth()} height: {value.getHeight()}"
                },
                set: function(value) { },
              }
            },
            VEStyles.get("texture-field-ext").resolution,
            false
          ),
          Struct.get(config, "resolution"),
          false
        )
      )
    )

    factoryTextFieldIncreaseCheckbox(
      $"{name}_frame",
      layout.nodes.frame, 
      Struct.appendRecursive(
        { 
          label: { text: "Frame" },
          field: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite) || !Core.isType(data, UIItem)) {
                  return
                }

                if (data.textField.isFocused()) {
                  return
                }

                var frame = value.getFrame()
                Struct.set(value, "_restoreFrame", frame)
                Struct.set(value, "_frame", frame)
                data.textField.setText(frame)
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }

                var frame = sprite.setFrame(NumberUtil.parse(value, sprite.getFrame())).getFrame()
                Struct.set(value, "_restoreFrame", frame)
                Struct.set(value, "_frame", frame)
                item.set(sprite)
              },
            }
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

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              var frame = sprite.setFrame(sprite.getFrame() + factor).getFrame()
              Struct.set(sprite, "_restoreFrame", frame)
              Struct.set(sprite, "_frame", frame)
              item.set(sprite)
            },
            store: { 
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

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              var frame = sprite.setFrame(sprite.getFrame() + factor).getFrame()
              Struct.set(sprite, "_restoreFrame", frame)
              Struct.set(sprite, "_frame", frame)
              item.set(sprite)
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            },
          },
          checkbox: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }

                data.value = value.getRandomFrame()
              },
              set: function(value) { 
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }

                item.set(sprite.setRandomFrame(value))
              },
            }
          },
          title: { text: "Rng frame" }, 
        },
        Struct.get(config, "frame"),
        false
      )
    ).forEach(addItem, items)
    
    factoryTextFieldIncreaseCheckbox(
      $"{name}_speed",
      layout.nodes.speed, 
      Struct.appendRecursive(
        { 
          label: { text: "Speed" },
          field: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }
                
                if (data.textField.isFocused()) {
                  return
                }

                data.textField.setText(value.getSpeed())
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }
                
                sprite.setSpeed(NumberUtil.parse(value))
                item.set(sprite)
              },
            }
          },
          decrease: { 
            factor: -0.5,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              item.set(sprite.setSpeed(sprite.getSpeed() + factor))
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            }
          },
          increase: { 
            factor: 0.5,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              item.set(sprite.setSpeed(sprite.getSpeed() + factor))
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            }
          },
          checkbox: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }

                data.value = value.getAnimate()
              },
              set: function(value) { 
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }
                
                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }
                
                item.set(sprite.setAnimate(value))
              },
            }
          },
          title: { text: "Animate" },
        },
        Struct.get(config, "speed"),
        false
      )
    ).forEach(addItem, items)

    factoryNumericSliderIncreaseField(
      $"{name}_alpha",
      layout.nodes.alpha, 
      Struct.appendRecursive(
        { 
          label: { text: "Alpha" },
          field: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }

                if (data.textField.isFocused()) {
                  return
                }

                data.textField.setText(value.getAlpha())
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }
                sprite.setAlpha(NumberUtil.parse(value))
                item.set(sprite)
              },
            }
          },
          decrease: { 
            factor: -0.01,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              item.set(sprite.setAlpha(sprite.getAlpha() + factor))
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            }
          },
          increase: { 
            factor: 0.01,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              item.set(sprite.setAlpha(sprite.getAlpha() + factor))
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            }
          },
          slider: { 
            minValue: 0.0,
            maxValue: 1.0,
            snapValue: 0.01 / 1.0,
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }
                data.value = value.getAlpha()
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }
                sprite.setAlpha(NumberUtil.parse(value))
                item.set(sprite)
              },
            },
          },
        },
        Struct.get(config, "alpha"),
        false
      )
    ).forEach(addItem, items)

    return items
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "texture-field-simple": function(name, layout, config = null) {
    ///@todo move to Lambda util
    static addItem = function(item, index, items) {
      items.add(item)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryTitle = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryTextField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryTextFieldCheckbox = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field-checkbox"),
        layout: VELayouts.get("text-field-checkbox"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryTextFieldIncrease = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field-increase"),
        layout: VELayouts.get("text-field-increase"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryTextFieldIncreaseCheckbox = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field-increase-checkbox"),
        layout: VELayouts.get("text-field-increase-checkbox"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryDoubleCheckbox = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("double-checkbox"),
        layout: VELayouts.get("double-checkbox"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryNumericSliderField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("numeric-slider-field"),
        layout: VELayouts.get("numeric-slider-field"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryNumericSliderIncreaseField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIItem}
    static factoryImage = function(name, layout, config) {
      return UIImage(
        name, 
        Struct.appendRecursive(
          {
            layout: layout,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          },
          config,
          false
        )
      )
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIItem}
    static factoryLabel = function(name, layout, config) {
      return UIText(
        name,
        Struct.appendRecursive(
          {
            layout: layout,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          },
          config,
          false
        )
      )
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryProperty = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: config,
      }).toUIItems(layout)
    }

    var items = new Array(UIItem)

    factoryTitle(
      $"{name}_title", 
      layout.nodes.title, 
      Struct.get(config, "title")
    ).forEach(addItem, items)

    factoryTextField(
      $"{name}_texture",
      layout.nodes.texture, 
      Struct.appendRecursive(
        { 
          field: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }

                if (data.textField.isFocused()) {
                  return
                }
                
                data.textField.setText(value.texture.name)
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item) || !TextureUtil.exists(value)) {
                  return
                }

                var json = item.get().serialize()
                json.name = value
                item.set(SpriteUtil.parse(json))
              },
            }
          }
        }, 
        Struct.get(config, "texture"),
        false
      )
    ).forEach(addItem, items)
    
    items.add(
      factoryImage(
        $"{name}_preview", 
        layout.nodes.preview, 
        Struct.appendRecursive(
          { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }
                data.image = value
              },
              set: function(value) { },
            },
            preRender: function() {
              if (this.image == null) {
                return
              }

              Struct.inject(this.image, "_restoreFrame", this.image.getFrame())
              this.image.setFrame(Struct.inject(this.image, "_frame", this.image.getFrame()))
            },
            postRender: function() {
              if (this.image == null) {
                return
              }

              Struct.set(this.image, "_frame", this.image.getFrame())
              this.image.setFrame(Struct.inject(this.image, "_restoreFrame", this.image.getFrame()))
            },
          },
          Struct.get(config, "preview"),
          false
        )
      )
    )

    items.add(
      factoryLabel(
        $"{name}_resolution", 
        layout.nodes.resolution, 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              store: { 
                callback: function(value, data) {
                  if (!Core.isType(value, Sprite)) {
                    return
                  }

                  data.label.text = $"width: {value.getWidth()} height: {value.getHeight()}"
                },
                set: function(value) { },
              }
            },
            VEStyles.get("texture-field-ext").resolution,
            false
          ),
          Struct.get(config, "resolution"),
          false
        )
      )
    )

    factoryTextFieldIncreaseCheckbox(
      $"{name}_frame",
      layout.nodes.frame, 
      Struct.appendRecursive(
        { 
          field: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite) || !Core.isType(data, UIItem)) {
                  return
                }

                if (data.textField.isFocused()) {
                  return
                }

                var frame = value.getFrame()
                Struct.set(value, "_restoreFrame", frame)
                Struct.set(value, "_frame", frame)
                data.textField.setText(frame)
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }

                var frame = sprite.setFrame(NumberUtil.parse(value, sprite.getFrame())).getFrame()
                Struct.set(value, "_restoreFrame", frame)
                Struct.set(value, "_frame", frame)
                item.set(sprite)
              },
            }
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

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              var frame = sprite.setFrame(sprite.getFrame() + factor).getFrame()
              Struct.set(sprite, "_restoreFrame", frame)
              Struct.set(sprite, "_frame", frame)
              item.set(sprite)
            },
            store: { 
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

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              var frame = sprite.setFrame(sprite.getFrame() + factor).getFrame()
              Struct.set(sprite, "_restoreFrame", frame)
              Struct.set(sprite, "_frame", frame)
              item.set(sprite)
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            },
          },
          checkbox: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }

                data.value = value.getRandomFrame()
              },
              set: function(value) { 
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }

                item.set(sprite.setRandomFrame(value))
              },
            }
          },
          title: { text: "Rng frame" }, 
        },
        Struct.get(config, "frame"),
        false
      )
    ).forEach(addItem, items)
    
    factoryTextFieldIncreaseCheckbox(
      $"{name}_speed",
      layout.nodes.speed, 
      Struct.appendRecursive(
        { 
          field: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }
                
                if (data.textField.isFocused()) {
                  return
                }

                data.textField.setText(value.getSpeed())
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }
                
                sprite.setSpeed(NumberUtil.parse(value))
                item.set(sprite)
              },
            }
          },
          decrease: { 
            factor: -0.5,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              item.set(sprite.setSpeed(sprite.getSpeed() + factor))
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            }
          },
          increase: { 
            factor: 0.5,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              item.set(sprite.setSpeed(sprite.getSpeed() + factor))
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            }
          },
          checkbox: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }

                data.value = value.getAnimate()
              },
              set: function(value) { 
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }
                
                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }
                
                item.set(sprite.setAnimate(value))
              },
            }
          },
          title: { text: "Animate" },
        },
        Struct.get(config, "speed"),
        false
      )
    ).forEach(addItem, items)
    
    return items
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "texture-field-ext": function(name, layout, config = null) {
    ///@todo move to Lambda util
    static addItem = function(item, index, items) {
      items.add(item)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryTitle = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryTextField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryTextFieldCheckbox = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field-checkbox"),
        layout: VELayouts.get("text-field-checkbox"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryTextFieldIncrease = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field-increase"),
        layout: VELayouts.get("text-field-increase"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryTextFieldIncreaseCheckbox = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field-increase-checkbox"),
        layout: VELayouts.get("text-field-increase-checkbox"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryDoubleCheckbox = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("double-checkbox"),
        layout: VELayouts.get("double-checkbox"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryNumericSliderField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("numeric-slider-field"),
        layout: VELayouts.get("numeric-slider-field"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryNumericSliderIncreaseField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIItem}
    static factoryImage = function(name, layout, config) {
      return UIImage(
        name, 
        Struct.appendRecursive(
          {
            layout: layout,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          },
          config,
          false
        )
      )
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIItem}
    static factoryLabel = function(name, layout, config) {
      return UIText(
        name,
        Struct.appendRecursive(
          {
            layout: layout,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          },
          config,
          false
        )
      )
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryProperty = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: config,
      }).toUIItems(layout)
    }

    var items = new Array(UIItem)

    factoryTitle(
      $"{name}_title", 
      layout.nodes.title, 
      Struct.get(config, "title")
    ).forEach(addItem, items)

    factoryTextField(
      $"{name}_texture",
      layout.nodes.texture, 
      Struct.appendRecursive(
        { 
          field: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }

                if (data.textField.isFocused()) {
                  return
                }
                
                data.textField.setText(value.texture.name)
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item) || !TextureUtil.exists(value)) {
                  return
                }

                var json = item.get().serialize()
                json.name = value
                item.set(SpriteUtil.parse(json))
              },
            }
          }
        }, 
        Struct.get(config, "texture"),
        false
      )
    ).forEach(addItem, items)
    
    items.add(
      factoryImage(
        $"{name}_preview", 
        layout.nodes.preview, 
        Struct.appendRecursive(
          { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }
                data.image = value
              },
              set: function(value) { },
            },
            preRender: function() {
              if (this.image == null) {
                return
              }

              Struct.inject(this.image, "_restoreFrame", this.image.getFrame())
              this.image.setFrame(Struct.inject(this.image, "_frame", this.image.getFrame()))
            },
            postRender: function() {
              if (this.image == null) {
                return
              }

              Struct.set(this.image, "_frame", this.image.getFrame())
              this.image.setFrame(Struct.inject(this.image, "_restoreFrame", this.image.getFrame()))
            },
          },
          Struct.get(config, "preview"),
          false
        )
      )
    )

    items.add(
      factoryLabel(
        $"{name}_resolution", 
        layout.nodes.resolution, 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              store: { 
                callback: function(value, data) {
                  if (!Core.isType(value, Sprite)) {
                    return
                  }

                  data.label.text = $"width: {value.getWidth()} height: {value.getHeight()}"
                },
                set: function(value) { },
              }
            },
            VEStyles.get("texture-field-ext").resolution,
            false
          ),
          Struct.get(config, "resolution"),
          false
        )
      )
    )

    factoryTextFieldIncreaseCheckbox(
      $"{name}_frame",
      layout.nodes.frame, 
      Struct.appendRecursive(
        { 
          field: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite) || !Core.isType(data, UIItem)) {
                  return
                }

                if (data.textField.isFocused()) {
                  return
                }

                var frame = value.getFrame()
                Struct.set(value, "_restoreFrame", frame)
                Struct.set(value, "_frame", frame)
                data.textField.setText(frame)
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }

                var frame = sprite.setFrame(NumberUtil.parse(value, sprite.getFrame())).getFrame()
                Struct.set(value, "_restoreFrame", frame)
                Struct.set(value, "_frame", frame)
                item.set(sprite)
              },
            }
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

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              var frame = sprite.setFrame(sprite.getFrame() + factor).getFrame()
              Struct.set(sprite, "_restoreFrame", frame)
              Struct.set(sprite, "_frame", frame)
              item.set(sprite)
            },
            store: { 
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

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              var frame = sprite.setFrame(sprite.getFrame() + factor).getFrame()
              Struct.set(sprite, "_restoreFrame", frame)
              Struct.set(sprite, "_frame", frame)
              item.set(sprite)
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            },
          },
          checkbox: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }

                data.value = value.getRandomFrame()
              },
              set: function(value) { 
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }

                item.set(sprite.setRandomFrame(value))
              },
            }
          },
          title: { text: "Rng frame" }, 
        },
        Struct.get(config, "frame"),
        false
      )
    ).forEach(addItem, items)
    
    factoryTextFieldIncreaseCheckbox(
      $"{name}_speed",
      layout.nodes.speed, 
      Struct.appendRecursive(
        { 
          field: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }
                
                if (data.textField.isFocused()) {
                  return
                }

                data.textField.setText(value.getSpeed())
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }
                
                sprite.setSpeed(NumberUtil.parse(value))
                item.set(sprite)
              },
            }
          },
          decrease: { 
            factor: -0.5,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              item.set(sprite.setSpeed(sprite.getSpeed() + factor))
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            }
          },
          increase: { 
            factor: 0.5,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              item.set(sprite.setSpeed(sprite.getSpeed() + factor))
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            }
          },
          checkbox: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }

                data.value = value.getAnimate()
              },
              set: function(value) { 
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }
                
                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }
                
                item.set(sprite.setAnimate(value))
              },
            }
          },
          title: { text: "Animate" },
        },
        Struct.get(config, "speed"),
        false
      )
    ).forEach(addItem, items)

    factoryNumericSliderIncreaseField(
      $"{name}_alpha",
      layout.nodes.alpha, 
      Struct.appendRecursive(
        { 
          field: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }

                if (data.textField.isFocused()) {
                  return
                }

                data.textField.setText(value.getAlpha())
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }
                sprite.setAlpha(NumberUtil.parse(value))
                item.set(sprite)
              },
            }
          },
          decrease: { 
            factor: -0.01,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              item.set(sprite.setAlpha(sprite.getAlpha() + factor))
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            }
          },
          increase: { 
            factor: 0.01,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              item.set(sprite.setAlpha(sprite.getAlpha() + factor))
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            }
          },
          slider: { 
            minValue: 0.0,
            maxValue: 1.0,
            snapValue: 0.01 / 1.0,
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }
                data.value = value.getAlpha()
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }
                sprite.setAlpha(NumberUtil.parse(value))
                item.set(sprite)
              },
            },
          },
        },
        Struct.get(config, "alpha"),
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncrease(
      $"{name}_scale_x",
      layout.nodes.scaleX, 
      Struct.appendRecursive(
        { 
          field: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }
                
                if (data.textField.isFocused()) {
                  return
                }

                data.textField.setText(value.getScaleX())
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }
                
                sprite.setScaleX(NumberUtil.parse(value))
                item.set(sprite)
              },
            }
          },
          decrease: { 
            factor: -0.01,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              item.set(sprite.setScaleX(sprite.getScaleX() + factor))
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            }
          },
          increase: { 
            factor: 0.01,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              item.set(sprite.setScaleX(sprite.getScaleX() + factor))
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            }
          },
        },
        Struct.get(config, "scaleX"),
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncrease(
      $"{name}_scale_y",
      layout.nodes.scaleY, 
      Struct.appendRecursive(
        { 
          field: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }

                if (data.textField.isFocused()) {
                  return
                }

                data.textField.setText(value.getScaleY())
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }
                
                sprite.setScaleY(NumberUtil.parse(value))
                item.set(sprite)
              },
            }
          },
          decrease: { 
            factor: -0.01,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              item.set(sprite.setScaleY(sprite.getScaleY() + factor))
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            }
          },
          increase: { 
            factor: 0.01,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              item.set(sprite.setScaleY(sprite.getScaleY() + factor))
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            }
          },
        },
        Struct.get(config, "scaleY"),
        false
      )
    ).forEach(addItem, items)

    return items
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "preview-image-mask": function(name, layout, config = null) {
    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIItem}
    static factoryImage = function(name, layout, config) {
      var uiImage = UIImage(
        name, 
        Struct.appendRecursive(
          {
            layout: layout,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            preRender: function() {
              if (this.image == null) {
                return
              }

              Struct.inject(this.image, "_restoreFrame", this.image.getFrame())
              this.image.setFrame(Struct.inject(this.image, "_frame2", this.image.getFrame()))
            },
            postRender: function() {
              if (this.image == null) {
                return
              }

              Struct.set(this.image, "_frame2", this.image.getFrame())
              this.image.setFrame(Struct.inject(this.image, "_restoreFrame", this.image.getFrame()))
            },
          },
          config,
          false
        )
      )

      Struct.set(uiImage, "_render", uiImage.render)
      uiImage.render = method(uiImage, function() {
        this._render()

        if (!Optional.is(this.mask)) {
          return
        }

        var mask = this.store.getStore().getValue(this.mask)
        if (!Optional.is(mask)) {
          return
        }

        //mask.setX(clamp(mask.getX(), 0, this.image.getWidth()))
        //mask.setY(clamp(mask.getY(), 0, this.image.getHeight()))
        //mask.setWidth(clamp(mask.getWidth(), 0, this.image.getWidth() - mask.getX()))
        //mask.setHeight(clamp(mask.getHeight(), 0, this.image.getHeight() - mask.getY()))

        var alpha = Struct.get(this.enable, "value") == false ? 0.25 : 0.75
        var scaleX = this.image.getScaleX()
        var scaleY = this.image.getScaleY()
        this.image.scaleToFit(this.area.getWidth(), this.area.getHeight())
        var _x = this.context.area.getX() 
          + this.area.getX()
          + (this.area.getWidth() / 2.0)
          - ((image.getWidth() * image.getScaleX()) / 2.0)
          + (mask.getX() * image.getScaleX())
        var _y = this.context.area.getY() 
          + this.area.getY()
          + (this.area.getHeight() / 2.0)
          - ((image.getHeight() * image.getScaleY()) / 2.0)
          + (mask.getY() * image.getScaleY())
        var width = mask.getWidth() * image.getScaleX()
        var height = mask.getHeight() * image.getScaleY()
        this.image.setScaleX(scaleX).setScaleY(scaleY)

        if (width < 1 || height < 1) {
          return
        }
        GPU.render.rectangle(
          _x,
          _y,
          _x + width,
          _y + height,
          false,
          c_black,
          c_black,
          c_black,
          c_black,
          alpha
        )
        GPU.render.rectangle(
          _x,
          _y,
          _x + width,
          _y + height,
          true,
          c_red,
          c_red,
          c_red,
          c_red,
          alpha
        )
      })

      return uiImage
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIItem}
    static factoryLabel = function(name, layout, config) {
      return UIText(
        name,
        Struct.appendRecursive(
          {
            layout: layout,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          },
          config,
          false
        )
      )
    }

    var items = new Array(UIItem)

    items.add(
      factoryImage(
        $"{name}_preview", 
        layout.nodes.preview, 
        Struct.appendRecursive(
          { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }
                data.image = value
              },
              set: function(value) { },
            }
          },
          Struct.get(config, "preview"),
          false
        )
      )
    )

    items.add(
      factoryLabel(
        $"{name}_resolution", 
        layout.nodes.resolution, 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              store: { 
                callback: function(value, data) {
                  if (!Core.isType(value, Sprite)) {
                    return
                  }

                  data.label.text = $"width: {value.getWidth()} height: {value.getHeight()}"
                },
                set: function(value) { },
              }
            },
            VEStyles.get("texture-field-ext").resolution,
            false
          ),
          Struct.get(config, "resolution"),
          false
        )
      )
    )

    return items
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "numeric-slider-field": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIText(
        $"label_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            }, 
            VEStyles.get("text-field_label"),
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      UITextField(
        $"field_{name}",
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.field,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayoutTextField")),
            },
            VEStyles.get("text-field"),
            false
          ),
          Struct.get(config, "field"),
          false
        )
      ),
      UISliderHorizontal(
        $"slider_{name}",
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.slider,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
              getClipboard: Beans.get(BeanVisuEditorIO).mouse.getClipboard,
              setClipboard: Beans.get(BeanVisuEditorIO).mouse.setClipboard,
            },
            VEStyles.get("slider-horizontal"),
            false
          ),
          Struct.get(config, "slider"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "numeric-slider-increase-field": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIText(
        $"label_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            }, 
            VEStyles.get("text-field_label"),
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      UITextField(
        $"field_{name}",
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.field,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayoutTextField")),
            },
            VEStyles.get("text-field"),
            false
          ),
          Struct.get(config, "field"),
          false
        )
      ),
      UIButton(
        $"{name}_decrease", 
        Struct.appendRecursive(
          { 
            factor: -1.0,
            label: {
              text: "-",
              font: "font_inter_10_regular",
              color: VETheme.color.textFocus,
              align: { v: VAlign.CENTER, h: HAlign.CENTER },
            },
            backgroundColor: VETheme.color.button,
            backgroundColorSelected: VETheme.color.buttonHover,
            backgroundColorOut: VETheme.color.button,
            layout: layout.nodes.decrease,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }
              item.set(item.get() + factor)
            },
            onMouseHoverOver: function(event) {
              if (Struct.get(this.enable, "value") == false) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
                return
              }
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
            },
            onMouseHoverOut: function(event) {
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
            },
          },
          Struct.get(config, "decrease"),
          false
        )
      ),
      UIButton(
        $"{name}_increase", 
        Struct.appendRecursive(
          { 
            factor: 1.0,
            label: { 
              text: "+",
              font: "font_inter_10_regular",
              color: VETheme.color.textFocus,
              align: { v: VAlign.CENTER, h: HAlign.CENTER },
            },
            backgroundColor: VETheme.color.button,
            backgroundColorSelected: VETheme.color.buttonHover,
            backgroundColorOut: VETheme.color.button,
            layout: layout.nodes.increase,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              item.set(item.get() + factor)
            },
            onMouseHoverOver: function(event) {
              if (Struct.get(this.enable, "value") == false) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
                return
              }
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
            },
            onMouseHoverOut: function(event) {
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
            },
          },
          Struct.get(config, "increase"),
          false
        )
      ),
      UISliderHorizontal(
        $"slider_{name}",
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: Assert.isType(Struct.get(layout.nodes, "slider"), Struct),
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
              getClipboard: Beans.get(BeanVisuEditorIO).mouse.getClipboard,
              setClipboard: Beans.get(BeanVisuEditorIO).mouse.setClipboard,
            },
            VEStyles.get("slider-horizontal"),
            false
          ),
          Struct.get(config, "slider"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "numeric-slider-field-button": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIText(
        $"label_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            }, 
            VEStyles.get("text-field_label"),
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      UITextField(
        $"field_{name}",
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.field,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayoutTextField")),
            },
            VEStyles.get("text-field"),
            false
          ),
          Struct.get(config, "field"),
          false
        )
      ),
      UIButton(
        $"decrease_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.decrease,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            }, 
            VEStyles.get("text-field-button").button,
            false
          ),
          Struct.get(config, "decrease"),
          false
        )
      ),
      UISliderHorizontal(
        $"slider_{name}",
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: Assert.isType(Struct.get(layout.nodes, "slider"), Struct),
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
              getClipboard: Beans.get(BeanVisuEditorIO).mouse.getClipboard,
              setClipboard: Beans.get(BeanVisuEditorIO).mouse.setClipboard,
            },
            VEStyles.get("slider-horizontal"),
            false
          ),
          Struct.get(config, "slider"),
          false
        )
      ),
      UIButton(
        $"increase_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.increase,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            }, 
            VEStyles.get("text-field-button").button,
            false
          ),
          Struct.get(config, "increase"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "numeric-slider-button": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIText(
        $"label_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            }, 
            VEStyles.get("text-field_label"),
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      UIButton(
        $"decrease_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.decrease,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            }, 
            VEStyles.get("text-field-button").button,
            false
          ),
          Struct.get(config, "decrease"),
          false
        )
      ),
      UISliderHorizontal(
        $"slider_{name}",
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: Assert.isType(Struct.get(layout.nodes, "slider"), Struct),
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
              getClipboard: Beans.get(BeanVisuEditorIO).mouse.getClipboard,
              setClipboard: Beans.get(BeanVisuEditorIO).mouse.setClipboard,
            },
            VEStyles.get("slider-horizontal"),
            false
          ),
          Struct.get(config, "slider"),
          false
        )
      ),
      UIButton(
        $"increase_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.increase,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            }, 
            VEStyles.get("text-field-button").button,
            false
          ),
          Struct.get(config, "increase"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "color-picker": function(name, layout, config = null) {
    ///@todo move to Lambda util
    static addItem = function(item, index, items) {
      items.add(item)
    }

    static factoryBooleanField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("boolean-field"),
        layout: VELayouts.get("boolean-field"),
        config: config,
      }).toUIItems(layout)
    }

    static factoryTitle = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: config,
      }).toUIItems(layout)
    }

    static factoryColor = function(name, layout, config) {
      static factoryStore = {
        callbackField: function() {
          return function(value, data) { 
            var key = Struct.get(data, "colorChannel")
            if (!ColorUtil.isColorProperty(key)) {
              return 
            }
            data.textField.setText(clamp(round(Struct.get(value, key) * 255.0), 0.0, 255.0))
          }
        },
        callbackSlider: function() {
          return function(value, data) {
            var key = Struct.get(data, "colorChannel")
            if (!ColorUtil.isColorProperty(key)) {
              return 
            }
            Struct.set(data, "_color", value)            
            data.value = clamp(round(Struct.get(value, key) * 255.0), 0.0, 255.0)
            data.updateCustom()
          }
        },
        set: function() {
          return function(value) {
            var item = this.get()
            var key = Struct.get(this.context, "colorChannel")
            if (item == null || !ColorUtil.isColorProperty(key)) {
              return 
            }

            var color = item.get()
            item.set(Struct.set(color, key, clamp(NumberUtil
              .parse(value / 255.0, Struct.get(color, key)), 0.0, 1.0)))
          }
        },
      }
      
      return new UIComponent({
        name: name,
        template: VEComponents.get("numeric-slider-field"),
        layout: VELayouts.get("numeric-slider-field"),
        config: Struct.appendRecursive(
          config, 
          {
            field: {
              store: {
                callback: factoryStore.callbackField(),
                set: factoryStore.set(),
              }
            },
            slider: {
              minValue: 0.0,
              maxValue: 255.0,
              snapValue: 1.0 / 255.0,
              store: {
                callback: factoryStore.callbackSlider(),
                set: factoryStore.set()
              },
              backgroundMargin: new Margin({ top: 2, bottom: 3, left: 0, right: 1 }),
              postRender: function() {
                var fromX = this.context.area.getX() + this.area.getX()
                var fromY = this.context.area.getY() + this.area.getY() + (this.area.getHeight() / 2)
                var widthMax = this.area.getWidth()
                var width = ((this.value - this.minValue) / abs(this.minValue - this.maxValue)) * widthMax
                var pointerBorder = Struct.get(this, "pointerBorder")
                if (!Core.isType(pointerBorder, Sprite)) {
                  pointerBorder = SpriteUtil.parse({ name: "texture_slider_pointer_border" })
                  Struct.set(this, "pointerBorder", pointerBorder)
                }
                
                var factor = Struct.get(this.enable, "value") == false ? 0.5 : 1.0    
                var alpha = pointerBorder.getAlpha()
                pointerBorder
                  .setAlpha(alpha * factor)
                  .setScaleX(this.pointer.getScaleX())
                  .setScaleY(this.pointer.getScaleY())
                  .render(fromX + width, fromY)
                  .setAlpha(alpha)
              },
              updateCustom: function() {
                var color = Struct.getIfType(this, "_color", Color)
                if (!Optional.is(color)) {
                  return
                }
                
                this.progress.blend = c_white
                this.progress.thickness = 0.0
                this.background.thickness = (this.area.getHeight() - 4.0) / 4.0
                //this.backgroundMargin = new Margin({ top: 2, bottom: 3, left: 0, right: 1})
                this.pointer.setBlend(color.toGMColor())
                this.backgroundAlpha = Struct.get(this.enable, "value") == false ? 0.5 : 1.0
                switch (Struct.get(this, "colorChannel")) {
                  case "red":
                    this.background.blend = make_color_rgb(255, color.green * 255, color.blue * 255)
                    this.backgroundColor = make_color_rgb(0, color.green * 255, color.blue * 255)
                    break
                  case "green": 
                    this.background.blend = make_color_rgb(color.red * 255, 255, color.blue * 255)
                    this.backgroundColor = make_color_rgb(color.red * 255, 0, color.blue * 255)
                    break
                  case "blue": 
                    this.background.blend = make_color_rgb(color.red * 255, color.green * 255, 255)
                    this.backgroundColor = make_color_rgb(color.red * 255, color.green * 255, 0)
                    break
                }
              },
              progress: {
                line: { name: "texture_empty" },
                cornerFrom: { name: "texture_empty" },
                cornerTo: { name: "texture_empty" },
              },
              background: {
                line: { name: "texture_slider_color_picker" },
                cornerFrom: { name: "texture_empty" },
                cornerTo: { name: "texture_empty" },
              },
            }
          },
          false
        ),
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryColorIncreaseField = function(name, layout, config) {
      static factoryStore = {
        callbackField: function() {
          return function(value, data) { 
            var key = Struct.get(data, "colorChannel")
            if (!ColorUtil.isColorProperty(key)) {
              return 
            }
            data.textField.setText(clamp(round(Struct.get(value, key) * 255.0), 0.0, 255.0))
          }
        },
        callbackSlider: function() {
          return function(value, data) {
            var key = Struct.get(data, "colorChannel")
            if (!ColorUtil.isColorProperty(key)) {
              return 
            }
            Struct.set(data, "_color", value)            
            data.value = clamp(round(Struct.get(value, key) * 255.0), 0.0, 255.0)
            data.updateCustom()
          }
        },
        set: function() {
          return function(value) {
            var item = this.get()
            var key = Struct.get(this.context, "colorChannel")
            if (item == null || !ColorUtil.isColorProperty(key)) {
              return 
            }

            var color = item.get()
            item.set(Struct.set(color, key, clamp(NumberUtil
              .parse(value / 255.0, Struct.get(color, key)), 0.0, 1.0)))
          }
        },
      }

      static factoryIncrease = function(config, factor) {
        return {
          factor: factor,
          enable: Optional.is(Struct.getIfType(config.field, "enable", Struct)) 
            ? JSON.clone(config.field.enable) 
            : null,
          colorChannel: Struct.get(config.field, "colorChannel" ),
          callback: function() {
            var factor = Struct.get(this, "factor")
            var key = Struct.get(this, "colorChannel")
            if (!Core.isType(factor, Number) 
                || !Core.isType(this.store, UIStore)
                || !ColorUtil.isColorProperty(key)) {
              return
            }
  
            var item = this.store.get()
            if (!Core.isType(item, StoreItem)) {
              return
            }
            
            var color = item.get()
            if (!Core.isType(color, Color)) {
              return 
            }
  
            Struct.set(color, key, clamp(Struct.get(color, key) + (factor / 255.0), 0.0, 1.0))
            item.set(color)
          },
          store: Struct.appendRecursive({ callback: function(value, data) { }, set: function(value) { } },
            Optional.is(Struct.get(config.field, "store")) ? JSON.clone(config.field.store) : null,
            false
          ),
        }
      }

      return new UIComponent({
        name: name,
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: Struct.appendRecursive(
          config, 
          {
            field: {
              store: {
                callback: factoryStore.callbackField(),
                set: factoryStore.set(),
              },
              GMTF_DECIMAL: 0,
            },
            slider: {
              minValue: 0.0,
              maxValue: 255.0,
              snapValue: 1.0 / 255.0,
              store: {
                callback: factoryStore.callbackSlider(),
                set: factoryStore.set()
              },
              backgroundMargin: new Margin({ top: 2, bottom: 3, left: 0, right: 1 }),
              postRender: function() {
                var fromX = this.context.area.getX() + this.area.getX()
                var fromY = this.context.area.getY() + this.area.getY() + (this.area.getHeight() / 2)
                var widthMax = this.area.getWidth()
                var width = ((this.value - this.minValue) / abs(this.minValue - this.maxValue)) * widthMax
                var pointerBorder = Struct.get(this, "pointerBorder")
                if (!Core.isType(pointerBorder, Sprite)) {
                  pointerBorder = SpriteUtil.parse({ name: "texture_slider_pointer_border" })
                  Struct.set(this, "pointerBorder", pointerBorder)
                }
                
                var factor = Struct.get(this.enable, "value") == false ? 0.5 : 1.0    
                var alpha = pointerBorder.getAlpha()
                pointerBorder
                  .setAlpha(alpha * factor)
                  .setScaleX(this.pointer.getScaleX())
                  .setScaleY(this.pointer.getScaleY())
                  .render(fromX + width, fromY)
                  .setAlpha(alpha)
              },
              updateCustom: function() {
                var color = Struct.getIfType(this, "_color", Color)
                if (!Optional.is(color)) {
                  return
                }
                
                this.progress.blend = c_white
                this.progress.thickness = 0.0
                this.background.thickness = (this.area.getHeight() - 4.0) / 4.0
                //this.backgroundMargin = new Margin({ top: 2, bottom: 3, left: 0, right: 1})
                this.pointer.setBlend(color.toGMColor())
                this.backgroundAlpha = Struct.get(this.enable, "value") == false ? 0.5 : 1.0
                switch (Struct.get(this, "colorChannel")) {
                  case "red":
                    this.background.blend = make_color_rgb(255, color.green * 255, color.blue * 255)
                    this.backgroundColor = make_color_rgb(0, color.green * 255, color.blue * 255)
                    break
                  case "green": 
                    this.background.blend = make_color_rgb(color.red * 255, 255, color.blue * 255)
                    this.backgroundColor = make_color_rgb(color.red * 255, 0, color.blue * 255)
                    break
                  case "blue": 
                    this.background.blend = make_color_rgb(color.red * 255, color.green * 255, 255)
                    this.backgroundColor = make_color_rgb(color.red * 255, color.green * 255, 0)
                    break
                }
              },
              progress: {
                line: { name: "texture_empty" },
                cornerFrom: { name: "texture_empty" },
                cornerTo: { name: "texture_empty" },
              },
              background: {
                line: { name: "texture_slider_color_picker" },
                cornerFrom: { name: "texture_empty" },
                cornerTo: { name: "texture_empty" },
              },
            },
            increase: factoryIncrease(config, 1.0),
            decrease: factoryIncrease(config, -1.0),
          },
          false
        ),
      }).toUIItems(layout)
    }

    static factoryAlpha = function(name, layout, config) {
      static factoryStore = {
        callbackField: function() {
          return function(value, data) { 
            var key = Struct.get(data, "colorChannel")
            if (!ColorUtil.isColorProperty(key)) {
              return 
            }
            data.textField.setText(clamp(round(Struct.get(value, key) * 255), 0.0, 255.0))
          }
        },
        callbackSlider: function() {
          return function(value, data) {
            var key = Struct.get(data, "colorChannel")
            if (!ColorUtil.isColorProperty(key)) {
              return 
            }
            data.value = clamp(round(Struct.get(value, key) * 255), 0.0, 255.0)
          }
        },
        set: function() {
          return function(value) {
            var item = this.get()
            var key = Struct.get(this.context, "colorChannel")
            if (item == null || !ColorUtil.isColorProperty(key)) {
              return 
            }

            var color = item.get()
            item.set(Struct.set(color, key, clamp(NumberUtil
              .parse(value / 255, Struct.get(color, key)), 0.0, 1.0)))
          }
        },
      }
      
      return new UIComponent({
        name: name,
        template: VEComponents.get("numeric-slider-field"),
        layout: VELayouts.get("numeric-slider-field"),
        config: Struct.appendRecursive(
          config, 
          {
            field: {
              store: {
                callback: factoryStore.callbackField(),
                set: factoryStore.set(),
              }
            },
            slider: {
              minValue: 0,
              maxValue: 255,
              store: {
                callback: factoryStore.callbackSlider(),
                set: factoryStore.set()
              },
            }
          },
          false
        ),
      }).toUIItems(layout)
    }

    static factoryAlphaIncreaseField = function(name, layout, config) {
      static factoryStore = {
        callbackField: function() {
          return function(value, data) { 
            var key = Struct.get(data, "colorChannel")
            if (!ColorUtil.isColorProperty(key)) {
              return 
            }
            data.textField.setText(clamp(round(Struct.get(value, key) * 255), 0.0, 255.0))
          }
        },
        callbackSlider: function() {
          return function(value, data) {
            var key = Struct.get(data, "colorChannel")
            if (!ColorUtil.isColorProperty(key)) {
              return 
            }
            data.value = clamp(round(Struct.get(value, key) * 255), 0.0, 255.0)
          }
        },
        set: function() {
          return function(value) {
            var item = this.get()
            var key = Struct.get(this.context, "colorChannel")
            if (item == null || !ColorUtil.isColorProperty(key)) {
              return 
            }

            var color = item.get()
            item.set(Struct.set(color, key, clamp(NumberUtil
              .parse(value / 255, Struct.get(color, key)), 0.0, 1.0)))
          }
        },
      }

      static factoryIncrease = function(config, factor) {
        return {
          factor: factor,
          enable: Optional.is(Struct.getIfType(config.field, "enable", Struct)) 
            ? JSON.clone(config.field.enable) 
            : null,
          colorChannel: Struct.get(config.field, "colorChannel" ),
          callback: function() {
            var factor = Struct.get(this, "factor")
            var key = Struct.get(this, "colorChannel")
            if (!Core.isType(factor, Number) 
                || !Core.isType(this.store, UIStore)
                || !ColorUtil.isColorProperty(key)) {
              return
            }
  
            var item = this.store.get()
            if (!Core.isType(item, StoreItem)) {
              return
            }
            
            var color = item.get()
            if (!Core.isType(color, Color)) {
              return 
            }
  
            Struct.set(color, key, clamp(Struct.get(color, key) + (factor / 255.0), 0.0, 1.0))
            item.set(color)
          },
          store: Struct.appendRecursive({ callback: function(value, data) { }, set: function(value) { } },
            Optional.is(Struct.get(config.field, "store")) ? JSON.clone(config.field.store) : null,
            false
          ),
        }
      }
      
      return new UIComponent({
        name: name,
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: Struct.appendRecursive(
          config, 
          {
            field: {
              store: {
                callback: factoryStore.callbackField(),
                set: factoryStore.set(),
              },
              GMTF_DECIMAL: 0,
            },
            slider: {
              minValue: 0,
              maxValue: 255,
              store: {
                callback: factoryStore.callbackSlider(),
                set: factoryStore.set()
              },
            },
            increase: factoryIncrease(config, 1.0),
            decrease: factoryIncrease(config, -1.0),
          },
          false
        ),
      }).toUIItems(layout)
    }

    static factoryHex = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field-button"),
        layout: VELayouts.get("text-field-square-center-button"),
        config: Struct.appendRecursive(
          config, 
          {
            field: {
              store: {
                callback: function(value, data) { 
                  data.textField.setText(value.toHex(value.alpha < 1.0))
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var color = item.get()
                  item.set(ColorUtil.fromHex(value, color.toHex(color.alpha < 1.0)))
                },
              },
            },
            button: {
              store: {
                callback: function(value, data) { 
                  var factor = Struct.get(data.enable, "value") == false ? 0.5 : 1.0
                  data.backgroundAlpha = value.alpha * factor
                  data.backgroundColor = value.toGMColor()
                },
                set: function(value) { return },
              },
            }
          },
          false
        ),
      }).toUIItems(layout)
    }

    var items = new Array(UIItem)

   
    
    var button = {}
    if (Struct.contains(config, "title")) {
      button = { button: config.title.input }
      var __input = Struct.get(config.title, "input")
      Struct.remove(config.title, "input")
      if (Struct.contains(button.button, "backgroundColor")) {
        Struct.set(config.title, "input", { backgroundColor: button.button.backgroundColor })
      }

      if (Struct.get(Struct.get(config, "line"), "disable")) {
        layout.nodes.line.height = method(layout.nodes.line, function() { return 0 })
        layout.nodes.line.margin = new Margin()
      } else {
        items.add(UIImage(
          $"{name}_line",
          Struct.appendRecursive(
            { 
              layout: layout.nodes.line,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            }, 
            Struct.appendRecursive(
              Struct.get(config, "line"),
              VEStyles.get("line-h").image,
              false
            ),
            false
          )
        ))
      }
      

      factoryTitle(
        $"{name}_title",
        layout.nodes.title,
        config.title
      ).forEach(addItem, items)
      Struct.set(config.title, "input", __input)
    } else if (Struct.contains(config, "booleanField")) {
      button = { button: config.booleanField.input }
      layout.nodes.hex.margin = new Margin()
      var __input = Struct.get(config.booleanField, "input")
      Struct.remove(config.booleanField, "input")
      factoryBooleanField(
        $"{name}_boolean-field",
        layout.nodes.title,
        config.booleanField
      ).forEach(addItem, items)
      Struct.set(config.booleanField, "input", __input)
    } else {
      button = {
        button: {
          enable: Optional.is(Struct.getIfType(config.hex.field, "enable", Struct)) 
            ? JSON.clone(config.hex.field.enable) 
            : null,
          store: Optional.is(Struct.get(config.hex.field, "store")) 
            ? JSON.clone(config.hex.field.store) 
            : { },
        }
      }
      layout.nodes.title.height = method(layout.nodes.title, function() { return 0 })
      layout.nodes.hex.y = method(layout.nodes.hex, function() { return this.context.y() + this.margin.top })
      layout.nodes.title.margin = new Margin()
      layout.nodes.line.height = method(layout.nodes.line, function() { return 0 })
      layout.nodes.line.margin = new Margin()
    }

    factoryHex(
      $"{name}_hex",
      layout.nodes.hex,
      Struct.appendRecursive(
        button,
        Struct.get(config, "hex"),
        false
      )
      
    ).forEach(addItem, items)
    
    factoryColorIncreaseField(
      $"{name}_red",
      layout.nodes.red,
      Struct.appendRecursive(
        Struct.get(config, "red"), 
        {
          field: { colorChannel: "red" }, 
          slider: { colorChannel: "red" },
          decrease: { colorChannel: "red" },
          increase: { colorChannel: "red" },
        },
        false
      )
    ).forEach(addItem, items)

    factoryColorIncreaseField (
      $"{name}_green",
      layout.nodes.green,
      Struct.appendRecursive(
        Struct.get(config, "green"),
        {
          field: { colorChannel: "green" }, 
          slider: { colorChannel: "green" },
          decrease: { colorChannel: "green" },
          increase: { colorChannel: "green" },
        },
        false
      )
    ).forEach(addItem, items)

    factoryColorIncreaseField (
      $"{name}_blue",
      layout.nodes.blue,
      Struct.appendRecursive(
        Struct.get(config, "blue"),
        {
          field: { colorChannel: "blue" }, 
          slider: { colorChannel: "blue" },
          decrease: { colorChannel: "blue" },
          increase: { colorChannel: "blue" },
        },
        false
      )
    ).forEach(addItem, items)

    if (Struct.contains(config, "alpha")) {
      factoryAlphaIncreaseField (
        $"{name}_alpha",
        layout.nodes.alpha,
        Struct.appendRecursive(
          Struct.get(config, "alpha"),
          {
            field: { colorChannel: "alpha" }, 
            slider: { colorChannel: "alpha" },
            decrease: { colorChannel: "alpha" },
            increase: { colorChannel: "alpha" },
          },
          false
        )
      ).forEach(addItem, items)
    }

    return items
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "spin-select": function(name, layout, config = null) {
    static factoryButton = function(name, layout, config) {
      return UIButton(
        name, 
        Struct.appendRecursive(
          {
            layout: layout,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            callback: function() {
              var increment = Struct.get(this, "increment")
              if (!Optional.is(this.store) || !Core.isType(increment, Number)) {
                return
              }

              var item = this.store.get()
              if (!Optional.is(item)) {
                return
              }

              var data = item.data
              if (!Core.isType(data, Collection)) {
                return
              }

              var index = data.findIndex(Lambda.equal, item.get())
              index = (index == null ? 0 : index) + increment
              if (index < 0) {
                index = data.size() - 1
              } else if (index > data.size() - 1) {
                index = 0
              }
              item.set(data.get(index))
            },
          }, 
          config, 
          false
        )
      )
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {Array<UIItem>}
    static factoryPreview = function(name, layout, config) {
      return UIImage(
        name, 
        Struct.appendRecursive(
          {
            layout: layout,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          }, 
          config, 
          false
        )
      )
    }
    
    return new Array(UIItem, [
      UIText(
        $"{name}_label", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("text-field_label"),
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      factoryButton(
        $"{name}_previous",
        layout.nodes.previous,
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              increment: -1,
              backgroundColor: VETheme.color.button,
              backgroundColorSelected: VETheme.color.buttonHover,
              backgroundColorOut: VETheme.color.button,
              onMouseHoverOver: function(event) {
                if (Struct.get(this.enable, "value") == false) {
                  this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
                  return
                }
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
              },
              onMouseHoverOut: function(event) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
              },
              label: { text: "<" },
            },
            Struct.get(config, "previous"), 
            false
          ), 
          Struct.get(VEStyles.get("spin-select"), "previous"),
          false
        )
      ),
      factoryPreview(
        $"{name}_preview",
        layout.nodes.preview,
        Struct.get(config, "preview")
      ),
      factoryButton(
        $"{name}_next",
        layout.nodes.next,
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              increment: 1,
              backgroundColor: VETheme.color.button,
              backgroundColorSelected: VETheme.color.buttonHover,
              backgroundColorOut: VETheme.color.button,
              onMouseHoverOver: function(event) {
                if (Struct.get(this.enable, "value") == false) {
                  this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
                  return
                }
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
              },
              onMouseHoverOut: function(event) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
              },    
              label: { text: ">" },
            },
            Struct.get(config, "next"),
            false
          ),
          Struct.get(VEStyles.get("spin-select"), "next"),
          false
        )
      ),
    ])
  },
  
  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "spin-select-override": function(name, layout, config = null) {
    static factoryButton = function(name, layout, config) {
      var _config = Struct.appendRecursive(
        config,
        {
          layout: layout,
          updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
        }, 
        false
      )

      if (Struct.get(_config, "callback") == null) {
        Struct.set(_config, method(_config, function() {
          var increment = Struct.get(this, "increment")
          if (!Optional.is(this.store) || !Core.isType(increment, Number)) {
            return
          }

          var item = this.store.get()
          if (!Optional.is(item)) {
            return
          }

          var data = item.data
          if (!Core.isType(data, Collection)) {
            return
          }

          var index = data.findIndex(Lambda.equal, item.get())
          index = (index == null ? 0 : index) + increment
          if (index < 0) {
            index = data.size() - 1
          } else if (index > data.size() - 1) {
            index = 0
          }
          item.set(data.get(index))
        }))
      }

      return UIButton(
        name, 
        _config
      )
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {Array<UIItem>}
    static factoryPreview = function(name, layout, config) {
      return UIImage(
        name, 
        Struct.appendRecursive(
          {
            layout: layout,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          }, 
          config, 
          false
        )
      )
    }
    
    return new Array(UIItem, [
      UIText(
        $"{name}_label", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("text-field_label"),
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      factoryButton(
        $"{name}_previous",
        layout.nodes.previous,
        Struct.appendRecursive(
          Struct.appendRecursive(
            {
              increment: -1,
              backgroundColor: VETheme.color.button,
              backgroundColorSelected: VETheme.color.buttonHover,
              backgroundColorOut: VETheme.color.button,
              onMouseHoverOver: function(event) {
                if (Struct.get(this.enable, "value") == false) {
                  this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
                  return
                }
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
              },
              onMouseHoverOut: function(event) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
              },
              label: { text: "<" },        
            },
            Struct.get(config, "previous"), 
            true
          ), 
          Struct.get(VEStyles.get("spin-select"), "previous"),
          false
        )
      ),
      factoryPreview(
        $"{name}_preview",
        layout.nodes.preview,
        Struct.get(config, "preview")
      ),
      factoryButton(
        $"{name}_next",
        layout.nodes.next,
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              increment: 1,
              backgroundColor: VETheme.color.button,
              backgroundColorSelected: VETheme.color.buttonHover,
              backgroundColorOut: VETheme.color.button,
              onMouseHoverOver: function(event) {
                if (Struct.get(this.enable, "value") == false) {
                  this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
                  return
                }
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
              },
              onMouseHoverOut: function(event) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
              },
              label: { text: ">" }, 
            },
            Struct.get(config, "next"),
            false
          ),
          Struct.get(VEStyles.get("spin-select"), "next"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "transform-numeric-property": function(name, layout, config = null) {
    ///@todo move to Lambda util
    static addItem = function(item, index, items) {
      items.add(item)
    }

    static factoryTitle = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: config,
      }).toUIItems(layout)
    }

    static factoryTextField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: Struct.appendRecursive(
          config, 
          {
            field: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var key = Struct.get(data, "transformNumericProperty")
                  var transformer = item.get()
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)
                    || GMTFContext.get() == data.textField) {
                    return 
                  }

                  data.textField.setText(Struct.get(transformer, key))
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var key = Struct.get(this.context, "transformNumericProperty")
                  var transformer = item.get()
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                    return 
                  }
                  item.set(Struct.set(transformer, key, parsedValue))
                },
              },
            },
          },
          false
        )
      }).toUIItems(layout)
    }

    var items = new Array(UIItem)

    factoryTitle(
      $"{name}_title",
      layout.nodes.title,
      Struct.get(config, "title")
    ).forEach(addItem, items)

    factoryTextField(
      $"{name}_target",
      layout.nodes.target,
      Struct.appendRecursive(
        Struct.get(config, "target"),
        { field: { transformNumericProperty: "target" } },
        false
      )
    ).forEach(addItem, items)

    factoryTextField(
      $"{name}_factor", 
      layout.nodes.factor, 
      Struct.appendRecursive(
        Struct.get(config, "factor"), 
        { field: { transformNumericProperty: "factor" } },
        false
      )
    ).forEach(addItem, items)

    factoryTextField(
      $"{name}_increment",
      layout.nodes.increment, 
      Struct.appendRecursive(
        Struct.get(config, "increment"), 
        { field: { transformNumericProperty: "increase" } },
        false
      )
    ).forEach(addItem, items)

    return items
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "transform-numeric-uniform": function(name, layout, config = null) {
    ///@todo move to Lambda util
    static addItem = function(item, index, items) {
      items.add(item)
    }

    static factoryTitle = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: config,
      }).toUIItems(layout)
    }

    static factoryTextField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: Struct.appendRecursive(
          config, 
          {
            field: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var key = Struct.get(data, "transformNumericProperty")
                  var transformer = item.get()
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)
                    || GMTFContext.get() == data.textField) {
                    return 
                  }
                  data.textField.setText(Struct.get(transformer, key))
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var key = Struct.get(this.context, "transformNumericProperty")
                  var transformer = item.get()
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                    return 
                  }
                  item.set(Struct.set(transformer, key, parsedValue))
                },
              },
            },
          },
          false
        )
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static __factoryTextFieldIncrease = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field-increase"),
        layout: VELayouts.get("text-field-increase"),
        config: Struct.appendRecursive(
          {
            field: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var key = Struct.get(data, "transformNumericProperty")
                  var transformer = item.get()
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)
                    || GMTFContext.get() == data.textField) {
                    return 
                  }
                  data.textField.setText(Struct.get(transformer, key))
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var key = Struct.get(this.context, "transformNumericProperty")
                  var transformer = item.get()
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                    return 
                  }
                  item.set(Struct.set(transformer, key, parsedValue))
                },
              },
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

                var key = Struct.get(this, "transformNumericProperty")
                var transformer = item.get()
                if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                  return 
                }

                Struct.set(transformer, key, Struct.get(transformer, key) + factor)
                item.set(transformer)
              },
              store: {
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

                var key = Struct.get(this, "transformNumericProperty")
                var transformer = item.get()
                if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                  return 
                }

                Struct.set(transformer, key, Struct.get(transformer, key) + factor)
                item.set(transformer)
              },
              store: {
                callback: function(value, data) { },
                set: function(value) { },
              },
            },
          },
          config,
          false
        )
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryTextFieldIncrease = function(name, layout, config) { //factoryNumericSliderIncreaseField
      return new UIComponent({
        name: name,
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-stick-increase-field"),
        config: Struct.appendRecursive(
          {
            field: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var key = Struct.get(data, "transformNumericProperty")
                  var transformer = item.get()
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)
                    || GMTFContext.get() == data.textField) {
                    return 
                  }
                  data.textField.setText(Struct.get(transformer, key))
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var key = Struct.get(this.context, "transformNumericProperty")
                  var transformer = item.get()
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                    return 
                  }
                  item.set(Struct.set(transformer, key, parsedValue))
                },
              },
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

                var key = Struct.get(this, "transformNumericProperty")
                var transformer = item.get()
                if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                  return 
                }

                Struct.set(transformer, key, Struct.get(transformer, key) + factor)
                item.set(transformer)
              },
              store: {
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

                var key = Struct.get(this, "transformNumericProperty")
                var transformer = item.get()
                if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                  return 
                }

                Struct.set(transformer, key, Struct.get(transformer, key) + factor)
                item.set(transformer)
              },
              store: {
                callback: function(value, data) { },
                set: function(value) { },
              },
            },
            slider: {
              store: {
                callback: function(value, data) { },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var key = Struct.get(this.context, "transformNumericProperty")
                  var transformer = item.get()
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                    return 
                  }
                  item.set(Struct.set(transformer, key, parsedValue))
                },
              },
              factor: 0.0001,
              base: null,
              _value: 0.0,
              value: 0.25,
              minValue: 0.0,
              maxValue: 0.5,
              pointer: {
                name: "texture_slider_pointer_simple",
                scaleX: 0.125,
                scaleY: 0.125,
                blend: VETheme.color.stick,
              },
              progress: { thickness: 0.0 },
              background: {
                thickness: 0.0000,
                blend: VETheme.color.stickBackground,
                line: { name: "texture_grid_line_bold" },
              },
              updateValue: function(mouseX, mouseY) {
                var isUIStore = Core.isType(this.store, UIStore)
                var key = Struct.get(this, "transformNumericProperty")
                this.base = !Core.isType(this.base, Number) 
                  ? (isUIStore ? Struct.get(this.store.getValue(), key) : this.value)
                  : this.base 
 
                var distanceX = mouseX - (this.area.getX() + (this.area.getWidth() / 2))
                var distanceY = (this.area.getY() + this.context.offset.y) - mouseY
                var distance = abs(distanceX) > abs(distanceY) ? distanceX : distanceY
                this.value = this.base + (distance * this.factor)
                if (isUIStore && this.value != Struct.get(this.store.getValue(), key)) {
                  this.store.set(this.value)
                }
              },
              colorHoverOver: VETheme.color.stickHover,
              colorHoverOut: VETheme.color.stick,
              onMouseHoverOver: function(event) {
                if (Struct.get(this.enable, "value") == false) {
                  this.pointer.setBlend(ColorUtil.parse(this.colorHoverOut).toGMColor())
                  return
                }

                this.pointer.setBlend(ColorUtil.parse(this.colorHoverOver).toGMColor())
              },
              onMouseHoverOut: function(event) {
                if (Struct.get(Struct.get(this.getClipboard(), "state"), "context") == this) {
                  return
                }
                this.pointer.setBlend(ColorUtil.parse(this.colorHoverOut).toGMColor())
              },
              //onMouseDragLeft: function(event) {
              onMousePressedLeft: function(event) { ///@stickhack
                if (Struct.get(this.enable, "value") == false 
                    || Optional.is(this.getClipboard())) {
                  return
                }
          
                var context = this
                this.base = null
                this.setClipboard(new Promise()
                  .setState({
                    context: context,
                    callback: context.callback,
                  })
                  .whenSuccess(function() {
                    this.state.context.base = null
                    this.state.context.pointer.setBlend(ColorUtil.parse(this.state.context.colorHoverOut).toGMColor())
                    Callable.run(Struct.get(this.state, "callback"))
                  })
                )
              },
              preRender: function() {
                this._value = this.value
                var _base = this.base != null ? this.base : this.value
                var orderOfMagnitude = floor(log10(abs(clamp(abs(this.value), 10, 1000000))))
                this.value = clamp(0.25 - (((_base - this.value) * this.factor) / orderOfMagnitude), this.minValue, this.maxValue)
                //orderOfMagnitude = GuiWidth()
                //this.value = clamp(0.5 - (((_base - this.value) / this.factor) / orderOfMagnitude), this.minValue, this.maxValue)
              },
              postRender: function() {
                this.value = this._value
              },
            },
          },
          config,
          false
        )
      }).toUIItems(layout)
    }

    var items = new Array(UIItem)

    factoryTitle(
      $"{name}_title",
      layout.nodes.title,
      Struct.get(config, "title")
    ).forEach(addItem, items)

    #region NumberTransformer fields
    factoryTextFieldIncrease(
      $"{name}_value",
      layout.nodes.value,
      Struct.appendRecursive(
        Struct.get(config, "value"),
        {
          field: { transformNumericProperty: "value" },
          decrease: { transformNumericProperty: "value" },
          increase: { transformNumericProperty: "value" },
          slider: { transformNumericProperty: "value" },
        },
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncrease(
      $"{name}_target",
      layout.nodes.target,
      Struct.appendRecursive(
        Struct.get(config, "target"),
        {
          field: { transformNumericProperty: "target" },
          decrease: { transformNumericProperty: "target" },
          increase: { transformNumericProperty: "target" },
          slider: { transformNumericProperty: "target" },
        },
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncrease(
      $"{name}_factor", 
      layout.nodes.factor, 
      Struct.appendRecursive(
        Struct.get(config, "factor"), 
        {
          field: { transformNumericProperty: "factor" },
          decrease: { transformNumericProperty: "factor" },
          increase: { transformNumericProperty: "factor" },
          slider: { transformNumericProperty: "increase" },
        },
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncrease(
      $"{name}_increase",
      layout.nodes.increase, 
      Struct.appendRecursive(
        Struct.get(config, "increase"), 
        {
          field: { transformNumericProperty: "increase" },
          decrease: { transformNumericProperty: "increase" },
          increase: { transformNumericProperty: "increase" },
          slider: { transformNumericProperty: "increase" },
        },
        false
      )
    ).forEach(addItem, items)
    
    #endregion

    return items
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "transform-vec2-uniform": function(name, layout, config = null) {
    ///@todo move to Lambda util
    static addItem = function(item, index, items) {
      items.add(item)
    }

    static factoryTitle = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: config,
      }).toUIItems(layout)
    }

    static factoryTextField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: Struct.appendRecursive(
          config, 
          {
            field: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var vec2 = Struct.get(data, "transformVector2Property")
                  var vec2Transformer = item.get()
                  if (!Core.isType(vec2Transformer, Vector2Transformer) 
                    || !Struct.contains(vec2Transformer, vec2)) {
                    return 
                  }

                  var key = Struct.get(data, "transformNumericProperty")
                  var transformer = Struct.get(vec2Transformer, vec2)
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)
                    || GMTFContext.get() == data.textField) {
                    return 
                  }

                  data.textField.setText(Struct.get(transformer, key))
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var vec2 = Struct.get(this.context, "transformVector2Property")
                  var vec2Transformer = item.get()
                  if (!Core.isType(vec2Transformer, Vector2Transformer) 
                    || !Struct.contains(vec2Transformer, vec2)) {
                    return 
                  }

                  var key = Struct.get(this.context, "transformNumericProperty")
                  var transformer = Struct.get(vec2Transformer, vec2)
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                    return 
                  }

                  Struct.set(transformer, key, parsedValue)
                  item.set(vec2Transformer)
                },
              },
            },
          },
          false
        )
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryTextFieldIncrease = function(name, layout, config) { //factoryNumericSliderIncreaseField
      return new UIComponent({
        name: name,
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-stick-increase-field"),
        config: Struct.appendRecursive(
          {
            field: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var vec2 = Struct.get(data, "transformVector2Property")
                  var vec2Transformer = item.get()
                  if (!Core.isType(vec2Transformer, Vector2Transformer) 
                    || !Struct.contains(vec2Transformer, vec2)) {
                    return 
                  }

                  var key = Struct.get(data, "transformNumericProperty")
                  var transformer = Struct.get(vec2Transformer, vec2)
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)
                    || GMTFContext.get() == data.textField) {
                    return 
                  }

                  data.textField.setText(Struct.get(transformer, key))
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var vec2 = Struct.get(this.context, "transformVector2Property")
                  var vec2Transformer = item.get()
                  if (!Core.isType(vec2Transformer, Vector2Transformer) 
                    || !Struct.contains(vec2Transformer, vec2)) {
                    return 
                  }

                  var key = Struct.get(this.context, "transformNumericProperty")
                  var transformer = Struct.get(vec2Transformer, vec2)
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                    return 
                  }

                  Struct.set(transformer, key, parsedValue)
                  item.set(vec2Transformer)
                },
              },
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

                var vec2 = Struct.get(this, "transformVector2Property")
                var vec2Transformer = item.get()
                if (!Core.isType(vec2Transformer, Vector2Transformer) 
                  || !Struct.contains(vec2Transformer, vec2)) {
                  return 
                }

                var key = Struct.get(this, "transformNumericProperty")
                var transformer = Struct.get(vec2Transformer, vec2)
                if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                  return 
                }

                Struct.set(transformer, key, Struct.get(transformer, key) + factor)
                item.set(vec2Transformer)
              },
              store: {
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

                var vec2 = Struct.get(this, "transformVector2Property")
                var vec2Transformer = item.get()
                if (!Core.isType(vec2Transformer, Vector2Transformer) 
                  || !Struct.contains(vec2Transformer, vec2)) {
                  return 
                }

                var key = Struct.get(this, "transformNumericProperty")
                var transformer = Struct.get(vec2Transformer, vec2)
                if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                  return 
                }

                Struct.set(transformer, key, Struct.get(transformer, key) + factor)
                item.set(vec2Transformer)
              },
              store: {
                callback: function(value, data) { },
                set: function(value) { },
              },
            },
            slider: {
              store: {
                callback: function(value, data) { },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var vec2 = Struct.get(this.context, "transformVector2Property")
                  var vec2Transformer = item.get()
                  if (!Core.isType(vec2Transformer, Vector2Transformer) 
                    || !Struct.contains(vec2Transformer, vec2)) {
                    return 
                  }
  
                  var key = Struct.get(this.context, "transformNumericProperty")
                  var transformer = Struct.get(vec2Transformer, vec2)
                  if (!Core.isType(transformer, NumberTransformer) 
                      || !Struct.contains(transformer, key)) {
                    return 
                  }
                  Struct.set(transformer, key, parsedValue)
                  item.set(vec2Transformer)
                },
              },
              factor: 0.0001,
              base: null,
              _value: 0.0,
              value: 0.25,
              minValue: 0.0,
              maxValue: 0.5,
              pointer: {
                name: "texture_slider_pointer_simple",
                scaleX: 0.125,
                scaleY: 0.125,
                blend: VETheme.color.stick,
              },
              progress: { thickness: 0.0 },
              background: {
                thickness: 0.0000,
                blend: VETheme.color.stickBackground,
                line: { name: "texture_grid_line_bold" },
              },
              updateValue: function(mouseX, mouseY) {
                var isUIStore = Core.isType(this.store, UIStore)
                var vec2 = Struct.get(this, "transformVector2Property")
                var vec2Transformer = isUIStore ? this.store.getValue() : null
                if (!Core.isType(vec2Transformer, Vector2Transformer) 
                  || !Struct.contains(vec2Transformer, vec2)) {
                  return 
                }

                var key = Struct.get(this, "transformNumericProperty")
                var transformer = Struct.get(vec2Transformer, vec2)
                if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                  return 
                }

                this.base = !Core.isType(this.base, Number) 
                  ? (isUIStore ? Struct.get(transformer, key) : this.value)
                  : this.base 

                var distanceX = mouseX - (this.area.getX() + (this.area.getWidth() / 2))
                var distanceY = (this.area.getY() + this.context.offset.y) - mouseY
                var distance = abs(distanceX) > abs(distanceY) ? distanceX : distanceY
                this.value = this.base + (distance * this.factor)
                if (isUIStore && this.value != Struct.get(transformer, key)) {
                  this.store.set(this.value)
                }
              },
              colorHoverOver: VETheme.color.stickHover,
              colorHoverOut: VETheme.color.stick,
              onMouseHoverOver: function(event) {
                if (Struct.get(this.enable, "value") == false) {
                  this.pointer.setBlend(ColorUtil.parse(this.colorHoverOut).toGMColor())
                  return
                }
                
                this.pointer.setBlend(ColorUtil.parse(this.colorHoverOver).toGMColor())
              },
              onMouseHoverOut: function(event) {
                if (Struct.get(Struct.get(this.getClipboard(), "state"), "context") == this) {
                  return
                }
                this.pointer.setBlend(ColorUtil.parse(this.colorHoverOut).toGMColor())
              },
              //onMouseDragLeft: function(event) {
              onMousePressedLeft: function(event) { ///@stickhack
                if (Struct.get(this.enable, "value") == false 
                    || Optional.is(this.getClipboard())) {
                  return
                }
          
                var context = this
                this.base = null
                this.setClipboard(new Promise()
                  .setState({
                    context: context,
                    callback: context.callback,
                  })
                  .whenSuccess(function() {
                    this.state.context.base = null
                    this.state.context.pointer.setBlend(ColorUtil.parse(this.state.context.colorHoverOut).toGMColor())
                    Callable.run(Struct.get(this.state, "callback"))
                  })
                )
              },
              preRender: function() {
                this._value = this.value
                var _base = this.base != null ? this.base : this.value
                var orderOfMagnitude = floor(log10(abs(clamp(abs(this.value), 10, 1000000))))
                this.value = clamp(0.25 - (((_base - this.value) * this.factor) / orderOfMagnitude), this.minValue, this.maxValue)
                //orderOfMagnitude = GuiWidth()
                //this.value = clamp(0.5 - (((_base - this.value) / this.factor) / orderOfMagnitude), this.minValue, this.maxValue)
              },
              postRender: function() {
                this.value = this._value
              },
            },
          },
          config,
          false
        )
      }).toUIItems(layout)
    }

    var items = new Array(UIItem)

    factoryTitle(
      $"{name}_title",
      layout.nodes.title,
      Struct.get(config, "title")
    ).forEach(addItem, items)

    #region X
    factoryTextFieldIncrease(
      $"{name}_valueX",
      layout.nodes.valueX,
      Struct.appendRecursive(
        Struct.get(config, "valueX"),
        {
          field: {
            transformNumericProperty: "value",
            transformVector2Property: "x",
          },
          decrease: {
            transformNumericProperty: "value",
            transformVector2Property: "x",
          },
          increase: {
            transformNumericProperty: "value",
            transformVector2Property: "x",
          },
          slider: {
            transformNumericProperty: "value",
            transformVector2Property: "x",
          },
        },
        false
      )
    ).forEach(addItem, items)
    
    factoryTextFieldIncrease(
      $"{name}_targetX",
      layout.nodes.targetX,
      Struct.appendRecursive(
        Struct.get(config, "targetX"),
        {
          field: {
            transformNumericProperty: "target",
            transformVector2Property: "x",
          },
          decrease: {
            transformNumericProperty: "target",
            transformVector2Property: "x",
          },
          increase: {
            transformNumericProperty: "target",
            transformVector2Property: "x",
          },
          slider: {
            transformNumericProperty: "target",
            transformVector2Property: "x",
          },
        },
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncrease(
      $"{name}_factorX",
      layout.nodes.factorX,
      Struct.appendRecursive(
        Struct.get(config, "factorX"),
        {
          field: {
            transformNumericProperty: "factor",
            transformVector2Property: "x",
          },
          decrease: {
            transformNumericProperty: "factor",
            transformVector2Property: "x",
          },
          increase: {
            transformNumericProperty: "factor",
            transformVector2Property: "x",
          },
          slider: {
            transformNumericProperty: "factor",
            transformVector2Property: "x",
          },
        },
        false
      )
    ).forEach(addItem, items)
 
    factoryTextFieldIncrease(
      $"{name}_increaseX",
      layout.nodes.increaseX,
      Struct.appendRecursive(
        Struct.get(config, "increaseX"),
        {
          field: {
            transformNumericProperty: "increase",
            transformVector2Property: "x",
          },
          decrease: {
            transformNumericProperty: "increase",
            transformVector2Property: "x",
          },
          increase: {
            transformNumericProperty: "increase",
            transformVector2Property: "x",
          },
          slider: {
            transformNumericProperty: "increase",
            transformVector2Property: "x",
          },
        },
        false
      )
    ).forEach(addItem, items)

    items.add(
      UIImage(
        $"{name}_x-line-h",
        Struct.appendRecursive(
          { 
            layout: layout.nodes.lineX,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          }, 
          VEStyles.get("line-h").image,
          false
        )
      )
    )
    #endregion

    #region Y
    factoryTextFieldIncrease(
      $"{name}_valueY",
      layout.nodes.valueY,
      Struct.appendRecursive(
        Struct.get(config, "valueY"),
        {
          field: {
            transformNumericProperty: "value",
            transformVector2Property: "y",
          },
          decrease: {
            transformNumericProperty: "value",
            transformVector2Property: "y",
          },
          increase: {
            transformNumericProperty: "value",
            transformVector2Property: "y",
          },
          slider: {
            transformNumericProperty: "value",
            transformVector2Property: "y",
          },
        },
        false
      )
    ).forEach(addItem, items)
    
    factoryTextFieldIncrease(
      $"{name}_targetY",
      layout.nodes.targetY,
      Struct.appendRecursive(
        Struct.get(config, "targetY"),
        {
          field: {
            transformNumericProperty: "target",
            transformVector2Property: "y",
          },
          decrease: {
            transformNumericProperty: "target",
            transformVector2Property: "y",
          },
          increase: {
            transformNumericProperty: "target",
            transformVector2Property: "y",
          },
          slider: {
            transformNumericProperty: "target",
            transformVector2Property: "y",
          },
        },
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncrease(
      $"{name}_factorY",
      layout.nodes.factorY,
      Struct.appendRecursive(
        Struct.get(config, "valueY"),
        {
          field: {
            transformNumericProperty: "factor",
            transformVector2Property: "y",
          },
          decrease: {
            transformNumericProperty: "factor",
            transformVector2Property: "y",
          },
          increase: {
            transformNumericProperty: "factor",
            transformVector2Property: "y",
          },
          slider: {
            transformNumericProperty: "factor",
            transformVector2Property: "y",
          },
        },
        false
      )
    ).forEach(addItem, items)
 
    factoryTextFieldIncrease(
      $"{name}_increaseY",
      layout.nodes.increaseY,
      Struct.appendRecursive(
        Struct.get(config, "increaseY"),
        {
          field: {
            transformNumericProperty: "increase",
            transformVector2Property: "y",
          },
          decrease: {
            transformNumericProperty: "increase",
            transformVector2Property: "y",
          },
          increase: {
            transformNumericProperty: "increase",
            transformVector2Property: "y",
          },
          slider: {
            transformNumericProperty: "increase",
            transformVector2Property: "y",
          },
        },
        false
      )
    ).forEach(addItem, items)
    #endregion

    return items
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "transform-vec3-uniform": function(name, layout, config = null) {
    ///@todo move to Lambda util
    static addItem = function(item, index, items) {
      items.add(item)
    }

    static factoryTitle = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: config,
      }).toUIItems(layout)
    }

    static factoryTextField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: Struct.appendRecursive(
          config, 
          {
            field: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var vec3 = Struct.get(data, "transformVector3Property")
                  var vec3Transformer = item.get()
                  if (!Core.isType(vec3Transformer, Vector3Transformer) 
                    || !Struct.contains(vec3Transformer, vec3)) {
                    return 
                  }

                  var key = Struct.get(data, "transformNumericProperty")
                  var transformer = Struct.get(vec3Transformer, vec3)
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)
                    || GMTFContext.get() == data.textField) {
                    return 
                  }

                  data.textField.setText(Struct.get(transformer, key))
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var vec3 = Struct.get(this.context, "transformVector3Property")
                  var vec3Transformer = item.get()
                  if (!Core.isType(vec3Transformer, Vector3Transformer) 
                    || !Struct.contains(vec3Transformer, vec3)) {
                    return 
                  }

                  var key = Struct.get(this.context, "transformNumericProperty")
                  var transformer = Struct.get(vec3Transformer, vec3)
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                    return 
                  }

                  Struct.set(transformer, key, parsedValue)
                  item.set(vec3Transformer)
                },
              },
            },
          },
          false
        )
      }).toUIItems(layout)
    }

    static factoryTextFieldIncrease = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-stick-increase-field"),
        config: Struct.appendRecursive(
          config, 
          {
            field: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var vec3 = Struct.get(data, "transformVector3Property")
                  var vec3Transformer = item.get()
                  if (!Core.isType(vec3Transformer, Vector3Transformer) 
                    || !Struct.contains(vec3Transformer, vec3)) {
                    return 
                  }

                  var key = Struct.get(data, "transformNumericProperty")
                  var transformer = Struct.get(vec3Transformer, vec3)
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)
                    || GMTFContext.get() == data.textField) {
                    return 
                  }

                  data.textField.setText(Struct.get(transformer, key))
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var vec3 = Struct.get(this.context, "transformVector3Property")
                  var vec3Transformer = item.get()
                  if (!Core.isType(vec3Transformer, Vector3Transformer) 
                    || !Struct.contains(vec3Transformer, vec3)) {
                    return 
                  }

                  var key = Struct.get(this.context, "transformNumericProperty")
                  var transformer = Struct.get(vec3Transformer, vec3)
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                    return 
                  }

                  Struct.set(transformer, key, parsedValue)
                  item.set(vec3Transformer)
                },
              },
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

                var vec3 = Struct.get(this, "transformVector3Property")
                var vec3Transformer = item.get()
                if (!Core.isType(vec3Transformer, Vector3Transformer) 
                  || !Struct.contains(vec3Transformer, vec3)) {
                  return 
                }

                var key = Struct.get(this, "transformNumericProperty")
                var transformer = Struct.get(vec3Transformer, vec3)
                if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                  return 
                }

                Struct.set(transformer, key, Struct.get(transformer, key) + factor)
                item.set(vec3Transformer)
              },
              store: {
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

                var vec3 = Struct.get(this, "transformVector3Property")
                var vec3Transformer = item.get()
                if (!Core.isType(vec3Transformer, Vector3Transformer) 
                  || !Struct.contains(vec3Transformer, vec3)) {
                  return 
                }

                var key = Struct.get(this, "transformNumericProperty")
                var transformer = Struct.get(vec3Transformer, vec3)
                if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                  return 
                }

                Struct.set(transformer, key, Struct.get(transformer, key) + factor)
                item.set(vec3Transformer)
              },
              store: {
                callback: function(value, data) { },
                set: function(value) { },
              },
            },
            slider: {
              store: {
                callback: function(value, data) { },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var vec3 = Struct.get(this.context, "transformVector3Property")
                  var vec3Transformer = item.get()
                  if (!Core.isType(vec3Transformer, Vector3Transformer) 
                    || !Struct.contains(vec3Transformer, vec3)) {
                    return 
                  }
  
                  var key = Struct.get(this.context, "transformNumericProperty")
                  var transformer = Struct.get(vec3Transformer, vec3)
                  if (!Core.isType(transformer, NumberTransformer) 
                      || !Struct.contains(transformer, key)) {
                    return 
                  }
                  Struct.set(transformer, key, parsedValue)
                  item.set(vec3Transformer)
                },
              },
              factor: 0.0001,
              base: null,
              _value: 0.0,
              value: 0.25,
              minValue: 0.0,
              maxValue: 0.5,
              pointer: {
                name: "texture_slider_pointer_simple",
                scaleX: 0.125,
                scaleY: 0.125,
                blend: VETheme.color.stick,
              },
              progress: { thickness: 0.0 },
              background: {
                thickness: 0.0000,
                blend: VETheme.color.stickBackground,
                line: { name: "texture_grid_line_bold" },
              },
              updateValue: function(mouseX, mouseY) {
                var isUIStore = Core.isType(this.store, UIStore)
                var vec3 = Struct.get(this, "transformVector3Property")
                var vec3Transformer = isUIStore ? this.store.getValue() : null
                if (!Core.isType(vec3Transformer, Vector3Transformer) 
                  || !Struct.contains(vec3Transformer, vec3)) {
                  return 
                }

                var key = Struct.get(this, "transformNumericProperty")
                var transformer = Struct.get(vec3Transformer, vec3)
                if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                  return 
                }

                this.base = !Core.isType(this.base, Number) 
                  ? (isUIStore ? Struct.get(transformer, key) : this.value)
                  : this.base 
 
                var distanceX = mouseX - (this.area.getX() + (this.area.getWidth() / 2))
                var distanceY = (this.area.getY() + this.context.offset.y) - mouseY
                var distance = abs(distanceX) > abs(distanceY) ? distanceX : distanceY
                this.value = this.base + (distance * this.factor)
                if (isUIStore && this.value != Struct.get(transformer, key)) {
                  this.store.set(this.value)
                }
              },
              colorHoverOver: VETheme.color.stickHover,
              colorHoverOut: VETheme.color.stick,
              onMouseHoverOver: function(event) {
                if (Struct.get(this.enable, "value") == false) {
                  this.pointer.setBlend(ColorUtil.parse(this.colorHoverOut).toGMColor())
                  return
                }
                
                this.pointer.setBlend(ColorUtil.parse(this.colorHoverOver).toGMColor())
              },
              onMouseHoverOut: function(event) {
                if (Struct.get(Struct.get(this.getClipboard(), "state"), "context") == this) {
                  return
                }
                this.pointer.setBlend(ColorUtil.parse(this.colorHoverOut).toGMColor())
              },
              //onMouseDragLeft: function(event) {
              onMousePressedLeft: function(event) { ///@stickhack
                if (Struct.get(this.enable, "value") == false 
                    || Optional.is(this.getClipboard())) {
                  return
                }
          
                var context = this
                this.base = null
                this.setClipboard(new Promise()
                  .setState({
                    context: context,
                    callback: context.callback,
                  })
                  .whenSuccess(function() {
                    this.state.context.base = null
                    this.state.context.pointer.setBlend(ColorUtil.parse(this.state.context.colorHoverOut).toGMColor())
                    Callable.run(Struct.get(this.state, "callback"))
                  })
                )
              },
              preRender: function() {
                this._value = this.value
                var _base = this.base != null ? this.base : this.value
                var orderOfMagnitude = floor(log10(abs(clamp(abs(this.value), 10, 1000000))))
                this.value = clamp(0.25 - (((_base - this.value) * this.factor) / orderOfMagnitude), this.minValue, this.maxValue)
                //orderOfMagnitude = GuiWidth()
                //this.value = clamp(0.5 - (((_base - this.value) / this.factor) / orderOfMagnitude), this.minValue, this.maxValue)
              },
              postRender: function() {
                this.value = this._value
              },
            },
          },
          false
        )
      }).toUIItems(layout)
    }

    var items = new Array(UIItem)

    factoryTitle(
      $"{name}_title",
      layout.nodes.title,
      Struct.get(config, "title")
    ).forEach(addItem, items)

    #region X
    factoryTextFieldIncrease(
      $"{name}_valueX",
      layout.nodes.valueX,
      Struct.appendRecursive(
        Struct.get(config, "valueX"),
        {
          field: {
            transformNumericProperty: "value",
            transformVector3Property: "x",
          },
          decrease: {
            transformNumericProperty: "value",
            transformVector3Property: "x",
          },
          increase: {
            transformNumericProperty: "value",
            transformVector3Property: "x",
          },
          slider: {
            transformNumericProperty: "value",
            transformVector3Property: "x",
          },
        },
        false
      )
    ).forEach(addItem, items)
    
    factoryTextFieldIncrease(
      $"{name}_targetX",
      layout.nodes.targetX,
      Struct.appendRecursive(
        Struct.get(config, "targetX"),
        {
          field: {
            transformNumericProperty: "target",
            transformVector3Property: "x",
          },
          decrease: {
            transformNumericProperty: "target",
            transformVector3Property: "x",
          },
          increase: {
            transformNumericProperty: "target",
            transformVector3Property: "x",
          },
          slider: {
            transformNumericProperty: "target",
            transformVector3Property: "x",
          },
        },
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncrease(
      $"{name}_factorX",
      layout.nodes.factorX,
      Struct.appendRecursive(
        Struct.get(config, "factorX"),
        {
          field: {
            transformNumericProperty: "factor",
            transformVector3Property: "x",
          },
          decrease: {
            transformNumericProperty: "factor",
            transformVector3Property: "x",
          },
          increase: {
            transformNumericProperty: "factor",
            transformVector3Property: "x",
          },
          slider: {
            transformNumericProperty: "factor",
            transformVector3Property: "x",
          },
        },
        false
      )
    ).forEach(addItem, items)
 
    factoryTextFieldIncrease(
      $"{name}_increaseX",
      layout.nodes.increaseX,
      Struct.appendRecursive(
        Struct.get(config, "increaseX"),
        {
          field: {
            transformNumericProperty: "increase",
            transformVector3Property: "x",
          },
          decrease: {
            transformNumericProperty: "increase",
            transformVector3Property: "x",
          },
          increase: {
            transformNumericProperty: "increase",
            transformVector3Property: "x",
          },
          slider: {
            transformNumericProperty: "increase",
            transformVector3Property: "x",
          },
        },
        false
      )
    ).forEach(addItem, items)

    items.add(
      UIImage(
        $"{name}_x-line-h",
        Struct.appendRecursive(
          { 
            layout: layout.nodes.lineX,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          }, 
          VEStyles.get("line-h").image,
          false
        )
      )
    )
    #endregion

    #region Y
    factoryTextFieldIncrease(
      $"{name}_valueY",
      layout.nodes.valueY,
      Struct.appendRecursive(
        Struct.get(config, "valueY"),
        {
          field: {
            transformNumericProperty: "value",
            transformVector3Property: "y",
          },
          decrease: {
            transformNumericProperty: "value",
            transformVector3Property: "y",
          },
          increase: {
            transformNumericProperty: "value",
            transformVector3Property: "y",
          },
          slider: {
            transformNumericProperty: "value",
            transformVector3Property: "y",
          },
        },
        false
      )
    ).forEach(addItem, items)
    
    factoryTextFieldIncrease(
      $"{name}_targetY",
      layout.nodes.targetY,
      Struct.appendRecursive(
        Struct.get(config, "targetY"),
        {
          field: {
            transformNumericProperty: "target",
            transformVector3Property: "y",
          },
          decrease: {
            transformNumericProperty: "target",
            transformVector3Property: "y",
          },
          increase: {
            transformNumericProperty: "target",
            transformVector3Property: "y",
          },
          slider: {
            transformNumericProperty: "target",
            transformVector3Property: "y",
          },
        },
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncrease(
      $"{name}_factorY",
      layout.nodes.factorY,
      Struct.appendRecursive(
        Struct.get(config, "valueY"),
        {
          field: {
            transformNumericProperty: "factor",
            transformVector3Property: "y",
          },
          decrease: {
            transformNumericProperty: "factor",
            transformVector3Property: "y",
          },
          increase: {
            transformNumericProperty: "factor",
            transformVector3Property: "y",
          },
          slider: {
            transformNumericProperty: "factor",
            transformVector3Property: "y",
          },
        },
        false
      )
    ).forEach(addItem, items)
 
    factoryTextFieldIncrease(
      $"{name}_increaseY",
      layout.nodes.increaseY,
      Struct.appendRecursive(
        Struct.get(config, "increaseY"),
        {
          field: {
            transformNumericProperty: "increase",
            transformVector3Property: "y",
          },
          decrease: {
            transformNumericProperty: "increase",
            transformVector3Property: "y",
          },
          increase: {
            transformNumericProperty: "increase",
            transformVector3Property: "y",
          },
          slider: {
            transformNumericProperty: "increase",
            transformVector3Property: "y",
          },
        },
        false
      )
    ).forEach(addItem, items)
    #endregion

    #region Z
    factoryTextFieldIncrease(
      $"{name}_valueZ",
      layout.nodes.valueZ,
      Struct.appendRecursive(
        Struct.get(config, "valueZ"),
        {
          field: {
            transformNumericProperty: "value",
            transformVector3Property: "z",
          },
          decrease: {
            transformNumericProperty: "value",
            transformVector3Property: "z",
          },
          increase: {
            transformNumericProperty: "value",
            transformVector3Property: "z",
          },
          slider: {
            transformNumericProperty: "value",
            transformVector3Property: "z",
          },
        },
        false
      )
    ).forEach(addItem, items)
    
    factoryTextFieldIncrease(
      $"{name}_targetZ",
      layout.nodes.targetZ,
      Struct.appendRecursive(
        Struct.get(config, "targetZ"),
        {
          field: {
            transformNumericProperty: "target",
            transformVector3Property: "z",
          },
          decrease: {
            transformNumericProperty: "target",
            transformVector3Property: "z",
          },
          increase: {
            transformNumericProperty: "target",
            transformVector3Property: "z",
          },
          slider: {
            transformNumericProperty: "target",
            transformVector3Property: "z",
          },
        },
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncrease(
      $"{name}_factorZ",
      layout.nodes.factorZ,
      Struct.appendRecursive(
        Struct.get(config, "valueZ"),
        {
          field: {
            transformNumericProperty: "factor",
            transformVector3Property: "z",
          },
          decrease: {
            transformNumericProperty: "factor",
            transformVector3Property: "z",
          },
          increase: {
            transformNumericProperty: "factor",
            transformVector3Property: "z",
          },
          slider: {
            transformNumericProperty: "factor",
            transformVector3Property: "z",
          },
        },
        false
      )
    ).forEach(addItem, items)
 
    factoryTextFieldIncrease(
      $"{name}_increaseZ",
      layout.nodes.increaseZ,
      Struct.appendRecursive(
        Struct.get(config, "increaseZ"),
        {
          field: {
            transformNumericProperty: "increase",
            transformVector3Property: "z",
          },
          decrease: {
            transformNumericProperty: "increase",
            transformVector3Property: "z",
          },
          increase: {
            transformNumericProperty: "increase",
            transformVector3Property: "z",
          },
          slider: {
            transformNumericProperty: "increase",
            transformVector3Property: "z",
          },
        },
        false
      )
    ).forEach(addItem, items)
    #endregion

    return items
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "transform-vec4-uniform": function(name, layout, config = null) {
    ///@todo move to Lambda util
    static addItem = function(item, index, items) {
      items.add(item)
    }

    static factoryTitle = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: config,
      }).toUIItems(layout)
    }

    static factoryTextField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: Struct.appendRecursive(
          config, 
          {
            field: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var vec4 = Struct.get(data, "transformVector4Property")
                  var vec4Transformer = item.get()
                  if (!Core.isType(vec4Transformer, Vector4Transformer) 
                    || !Struct.contains(vec4Transformer, vec4)) {
                    return 
                  }

                  var key = Struct.get(data, "transformNumericProperty")
                  var transformer = Struct.get(vec4Transformer, vec4)
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)
                    || GMTFContext.get() == data.textField) {
                    return 
                  }

                  data.textField.setText(Struct.get(transformer, key))
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var vec4 = Struct.get(this.context, "transformVector4Property")
                  var vec4Transformer = item.get()
                  if (!Core.isType(vec4Transformer, Vector4Transformer) 
                    || !Struct.contains(vec4Transformer, vec4)) {
                    return 
                  }

                  var key = Struct.get(this.context, "transformNumericProperty")
                  var transformer = Struct.get(vec4Transformer, vec4)
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                    return 
                  }

                  Struct.set(transformer, key, parsedValue)
                  item.set(vec4Transformer)
                },
              },
            },
          },
          false
        )
      }).toUIItems(layout)
    }

    static factoryTextFieldIncrease = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-stick-increase-field"),
        config: Struct.appendRecursive(
          config, 
          {
            field: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var vec4 = Struct.get(data, "transformVector4Property")
                  var vec4Transformer = item.get()
                  if (!Core.isType(vec4Transformer, Vector4Transformer) 
                    || !Struct.contains(vec4Transformer, vec4)) {
                    return 
                  }

                  var key = Struct.get(data, "transformNumericProperty")
                  var transformer = Struct.get(vec4Transformer, vec4)
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)
                    || GMTFContext.get() == data.textField) {
                    return 
                  }

                  data.textField.setText(Struct.get(transformer, key))
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var vec4 = Struct.get(this.context, "transformVector4Property")
                  var vec4Transformer = item.get()
                  if (!Core.isType(vec4Transformer, Vector4Transformer) 
                    || !Struct.contains(vec4Transformer, vec4)) {
                    return 
                  }

                  var key = Struct.get(this.context, "transformNumericProperty")
                  var transformer = Struct.get(vec4Transformer, vec4)
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                    return 
                  }

                  Struct.set(transformer, key, parsedValue)
                  item.set(vec4Transformer)
                },
              },
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

                var vec4 = Struct.get(this, "transformVector4Property")
                var vec4Transformer = item.get()
                if (!Core.isType(vec4Transformer, Vector4Transformer) 
                  || !Struct.contains(vec4Transformer, vec4)) {
                  return 
                }

                var key = Struct.get(this, "transformNumericProperty")
                var transformer = Struct.get(vec4Transformer, vec4)
                if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                  return 
                }

                Struct.set(transformer, key, Struct.get(transformer, key) + factor)
                item.set(vec4Transformer)
              },
              store: {
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

                var vec4 = Struct.get(this, "transformVector4Property")
                var vec4Transformer = item.get()
                if (!Core.isType(vec4Transformer, Vector4Transformer) 
                  || !Struct.contains(vec4Transformer, vec4)) {
                  return 
                }

                var key = Struct.get(this, "transformNumericProperty")
                var transformer = Struct.get(vec4Transformer, vec4)
                if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                  return 
                }

                Struct.set(transformer, key, Struct.get(transformer, key) + factor)
                item.set(vec4Transformer)
              },
              store: {
                callback: function(value, data) { },
                set: function(value) { },
              },
            },
            slider: {
              store: {
                callback: function(value, data) { },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var vec4 = Struct.get(this.context, "transformVector4Property")
                  var vec4Transformer = item.get()
                  if (!Core.isType(vec4Transformer, Vector4Transformer) 
                    || !Struct.contains(vec4Transformer, vec4)) {
                    return 
                  }
  
                  var key = Struct.get(this.context, "transformNumericProperty")
                  var transformer = Struct.get(vec4Transformer, vec4)
                  if (!Core.isType(transformer, NumberTransformer) 
                      || !Struct.contains(transformer, key)) {
                    return 
                  }
                  Struct.set(transformer, key, parsedValue)
                  item.set(vec4Transformer)
                },
              },
              factor: 0.0001,
              base: null,
              _value: 0.0,
              value: 0.25,
              minValue: 0.0,
              maxValue: 0.5,
              pointer: {
                name: "texture_slider_pointer_simple",
                scaleX: 0.125,
                scaleY: 0.125,
                blend: VETheme.color.stick,
              },
              progress: { thickness: 0.0 },
              background: {
                thickness: 0.0000,
                blend: VETheme.color.stickBackground,
                line: { name: "texture_grid_line_bold" },
              },
              updateValue: function(mouseX, mouseY) {
                var isUIStore = Core.isType(this.store, UIStore)
                var vec4 = Struct.get(this, "transformVector4Property")
                var vec4Transformer = isUIStore ? this.store.getValue() : null
                if (!Core.isType(vec4Transformer, Vector4Transformer) 
                  || !Struct.contains(vec4Transformer, vec4)) {
                  return 
                }

                var key = Struct.get(this, "transformNumericProperty")
                var transformer = Struct.get(vec4Transformer, vec4)
                if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                  return 
                }

                this.base = !Core.isType(this.base, Number) 
                  ? (isUIStore ? Struct.get(transformer, key) : this.value)
                  : this.base 

                var distanceX = mouseX - (this.area.getX() + (this.area.getWidth() / 2))
                var distanceY = (this.area.getY() + this.context.offset.y) - mouseY
                var distance = abs(distanceX) > abs(distanceY) ? distanceX : distanceY
                this.value = this.base + (distance * this.factor)
                if (isUIStore && this.value != Struct.get(transformer, key)) {
                  this.store.set(this.value)
                }
              },
              colorHoverOver: VETheme.color.stickHover,
              colorHoverOut: VETheme.color.stick,
              onMouseHoverOver: function(event) {
                if (Struct.get(this.enable, "value") == false) {
                  this.pointer.setBlend(ColorUtil.parse(this.colorHoverOut).toGMColor())
                  return
                }
                
                this.pointer.setBlend(ColorUtil.parse(this.colorHoverOver).toGMColor())
              },
              onMouseHoverOut: function(event) {
                if (Struct.get(Struct.get(this.getClipboard(), "state"), "context") == this) {
                  return
                }
                this.pointer.setBlend(ColorUtil.parse(this.colorHoverOut).toGMColor())
              },
              //onMouseDragLeft: function(event) {
              onMousePressedLeft: function(event) { ///@stickhack
                if (Struct.get(this.enable, "value") == false 
                    || Optional.is(this.getClipboard())) {
                  return
                }
          
                var context = this
                this.base = null
                this.setClipboard(new Promise()
                  .setState({
                    context: context,
                    callback: context.callback,
                  })
                  .whenSuccess(function() {
                    this.state.context.base = null
                    this.state.context.pointer.setBlend(ColorUtil.parse(this.state.context.colorHoverOut).toGMColor())
                    Callable.run(Struct.get(this.state, "callback"))
                  })
                )
              },
              preRender: function() {
                this._value = this.value
                var _base = this.base != null ? this.base : this.value
                var orderOfMagnitude = floor(log10(abs(clamp(abs(this.value), 10, 1000000))))
                this.value = clamp(0.25 - (((_base - this.value) * this.factor) / orderOfMagnitude), this.minValue, this.maxValue)
                //orderOfMagnitude = GuiWidth()
                //this.value = clamp(0.5 - (((_base - this.value) / this.factor) / orderOfMagnitude), this.minValue, this.maxValue)
              },
              postRender: function() {
                this.value = this._value
              },
            },
          },
          false
        )
      }).toUIItems(layout)
    }

    var items = new Array(UIItem)

    factoryTitle(
      $"{name}_title",
      layout.nodes.title,
      Struct.get(config, "title")
    ).forEach(addItem, items)

    #region X
    factoryTextFieldIncrease(
      $"{name}_valueX",
      layout.nodes.valueX,
      Struct.appendRecursive(
        Struct.get(config, "valueX"),
        {
          field: {
            transformNumericProperty: "value",
            transformVector4Property: "x",
          },
          decrease: {
            transformNumericProperty: "value",
            transformVector4Property: "x",
          },
          increase: {
            transformNumericProperty: "value",
            transformVector4Property: "x",
          },
          slider: {
            transformNumericProperty: "value",
            transformVector4Property: "x",
          },
        },
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncrease(
      $"{name}_targetX",
      layout.nodes.targetX,
      Struct.appendRecursive(
        Struct.get(config, "targetX"),
        {
          field: {
            transformNumericProperty: "target",
            transformVector4Property: "x",
          },
          decrease: {
            transformNumericProperty: "target",
            transformVector4Property: "x",
          },
          increase: {
            transformNumericProperty: "target",
            transformVector4Property: "x",
          },
          slider: {
            transformNumericProperty: "target",
            transformVector4Property: "x",
          },
        },
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncrease(
      $"{name}_factorX",
      layout.nodes.factorX,
      Struct.appendRecursive(
        Struct.get(config, "factorX"),
        {
          field: {
            transformNumericProperty: "factor",
            transformVector4Property: "x",
          },
          decrease: {
            transformNumericProperty: "factor",
            transformVector4Property: "x",
          },
          increase: {
            transformNumericProperty: "factor",
            transformVector4Property: "x",
          },
          slider: {
            transformNumericProperty: "factor",
            transformVector4Property: "x",
          },
        },
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncrease(
      $"{name}_increaseX",
      layout.nodes.increaseX,
      Struct.appendRecursive(
        Struct.get(config, "increaseX"),
        {
          field: {
            transformNumericProperty: "increase",
            transformVector4Property: "x",
          },
          decrease: {
            transformNumericProperty: "increase",
            transformVector4Property: "x",
          },
          increase: {
            transformNumericProperty: "increase",
            transformVector4Property: "x",
          },
          slider: {
            transformNumericProperty: "increase",
            transformVector4Property: "x",
          },
        },
        false
      )
    ).forEach(addItem, items)

    items.add(
      UIImage(
        $"{name}_x-line-h",
        Struct.appendRecursive(
          { 
            layout: layout.nodes.lineX,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          }, 
          VEStyles.get("line-h").image,
          false
        )
      )
    )
    #endregion

    #region Y
    factoryTextFieldIncrease(
      $"{name}_valueY",
      layout.nodes.valueY,
      Struct.appendRecursive(
        Struct.get(config, "valueY"),
        {
          field: {
            transformNumericProperty: "value",
            transformVector4Property: "y",
          },
          decrease: {
            transformNumericProperty: "value",
            transformVector4Property: "y",
          },
          increase: {
            transformNumericProperty: "value",
            transformVector4Property: "y",
          },
          slider: {
            transformNumericProperty: "value",
            transformVector4Property: "y",
          },
        },
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncrease(
      $"{name}_targetY",
      layout.nodes.targetY,
      Struct.appendRecursive(
        Struct.get(config, "targetY"),
        {
          field: {
            transformNumericProperty: "target",
            transformVector4Property: "y",
          },
          decrease: {
            transformNumericProperty: "target",
            transformVector4Property: "y",
          },
          increase: {
            transformNumericProperty: "target",
            transformVector4Property: "y",
          },
          slider: {
            transformNumericProperty: "target",
            transformVector4Property: "y",
          },
        },
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncrease(
      $"{name}_factorY",
      layout.nodes.factorY,
      Struct.appendRecursive(
        Struct.get(config, "valueY"),
        {
          field: {
            transformNumericProperty: "factor",
            transformVector4Property: "y",
          },
          decrease: {
            transformNumericProperty: "factor",
            transformVector4Property: "y",
          },
          increase: {
            transformNumericProperty: "factor",
            transformVector4Property: "y",
          },
          slider: {
            transformNumericProperty: "factor",
            transformVector4Property: "y",
          },
        },
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncrease(
      $"{name}_increaseY",
      layout.nodes.increaseY,
      Struct.appendRecursive(
        Struct.get(config, "increaseY"),
        {
          field: {
            transformNumericProperty: "increase",
            transformVector4Property: "y",
          },
          decrease: {
            transformNumericProperty: "increase",
            transformVector4Property: "y",
          },
          increase: {
            transformNumericProperty: "increase",
            transformVector4Property: "y",
          },
          slider: {
            transformNumericProperty: "increase",
            transformVector4Property: "y",
          },
        },
        false
      )
    ).forEach(addItem, items)
    #endregion

    #region Z
    factoryTextFieldIncrease(
      $"{name}_valueZ",
      layout.nodes.valueZ,
      Struct.appendRecursive(
        Struct.get(config, "valueZ"),
        {
          field: {
            transformNumericProperty: "value",
            transformVector4Property: "z",
          },
          decrease: {
            transformNumericProperty: "value",
            transformVector4Property: "z",
          },
          increase: {
            transformNumericProperty: "value",
            transformVector4Property: "z",
          },
          slider: {
            transformNumericProperty: "value",
            transformVector4Property: "z",
          },
        },
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncrease(
      $"{name}_targetZ",
      layout.nodes.targetZ,
      Struct.appendRecursive(
        Struct.get(config, "targetZ"),
        {
          field: {
            transformNumericProperty: "target",
            transformVector4Property: "z",
          },
          decrease: {
            transformNumericProperty: "target",
            transformVector4Property: "z",
          },
          increase: {
            transformNumericProperty: "target",
            transformVector4Property: "z",
          },
          slider: {
            transformNumericProperty: "target",
            transformVector4Property: "z",
          },
        },
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncrease(
      $"{name}_factorZ",
      layout.nodes.factorZ,
      Struct.appendRecursive(
        Struct.get(config, "valueZ"),
        {
          field: {
            transformNumericProperty: "factor",
            transformVector4Property: "z",
          },
          decrease: {
            transformNumericProperty: "factor",
            transformVector4Property: "z",
          },
          increase: {
            transformNumericProperty: "factor",
            transformVector4Property: "z",
          },
          slider: {
            transformNumericProperty: "factor",
            transformVector4Property: "z",
          },
        },
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncrease(
      $"{name}_increaseZ",
      layout.nodes.increaseZ,
      Struct.appendRecursive(
        Struct.get(config, "increaseZ"),
        {
          field: {
            transformNumericProperty: "increase",
            transformVector4Property: "z",
          },
          decrease: {
            transformNumericProperty: "increase",
            transformVector4Property: "z",
          },
          increase: {
            transformNumericProperty: "increase",
            transformVector4Property: "z",
          },
          slider: {
            transformNumericProperty: "increase",
            transformVector4Property: "z",
          },
        },
        false
      )
    ).forEach(addItem, items)
    #endregion
    
    #region A
    factoryTextFieldIncrease(
      $"{name}_valueA",
      layout.nodes.valueA,
      Struct.appendRecursive(
        Struct.get(config, "valueA"),
        {
          field: {
            transformNumericProperty: "value",
            transformVector4Property: "a",
          },
          decrease: {
            transformNumericProperty: "value",
            transformVector4Property: "a",
          },
          increase: {
            transformNumericProperty: "value",
            transformVector4Property: "a",
          },
          slider: {
            transformNumericProperty: "value",
            transformVector4Property: "a",
          },
        },
        false
      )
    ).forEach(addItem, items)
    
    factoryTextFieldIncrease(
      $"{name}_targetA",
      layout.nodes.targetA,
      Struct.appendRecursive(
        Struct.get(config, "targetA"),
        {
          field: {
            transformNumericProperty: "target",
            transformVector4Property: "a",
          },
          decrease: {
            transformNumericProperty: "target",
            transformVector4Property: "a",
          },
          increase: {
            transformNumericProperty: "target",
            transformVector4Property: "a",
          },
          slider: {
            transformNumericProperty: "target",
            transformVector4Property: "a",
          },
        },
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncrease(
      $"{name}_factorA",
      layout.nodes.factorA,
      Struct.appendRecursive(
        Struct.get(config, "factorA"),
        {
          field: {
            transformNumericProperty: "factor",
            transformVector4Property: "a",
          },
          decrease: {
            transformNumericProperty: "factor",
            transformVector4Property: "a",
          },
          increase: {
            transformNumericProperty: "factor",
            transformVector4Property: "a",
          },
          slider: {
            transformNumericProperty: "factor",
            transformVector4Property: "a",
          },
        },
        false
      )
    ).forEach(addItem, items)
  
    factoryTextFieldIncrease(
      $"{name}_increaseA",
      layout.nodes.increaseA,
      Struct.appendRecursive(
        Struct.get(config, "increaseA"),
        {
          field: {
            transformNumericProperty: "increase",
            transformVector4Property: "a",
          },
          decrease: {
            transformNumericProperty: "increase",
            transformVector4Property: "a",
          },
          increase: {
            transformNumericProperty: "increase",
            transformVector4Property: "a",
          },
          slider: {
            transformNumericProperty: "increase",
            transformVector4Property: "a",
          },
        },
        false
      )
    ).forEach(addItem, items)
    #endregion
    return items
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "uniform-vec2-field": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIText(
        $"label_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("transform-numeric-uniform").label,
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      UITextField(
        $"field_vec2x_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.vec2x,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayoutTextField")),
              store: {
                callback: function(value, data) { 
                  if (!Core.isType(value, Vector2)
                    || GMTFContext.get() == data.textField) {
                    return 
                  }
                  data.textField.setText(value.x)
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var vec2 = item.get()
                  if (!Core.isType(vec2, Vector2)) {
                    return 
                  }
                  vec2.x = NumberUtil.parse(value, 0)
                  item.set(vec2)
                },
              },
            },
            VEStyles.get("text-field"),
            false
          ),
          Struct.get(config, "vec2x"),
          false
        )
      ),
      UITextField(
        $"field_vec2y_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.vec2y,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayoutTextField")),
              store: {
                callback: function(value, data) { 
                  if (!Core.isType(value, Vector2)
                    || GMTFContext.get() == data.textField) {
                    return 
                  }
                  data.textField.setText(value.y)
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var vec2 = item.get()
                  if (!Core.isType(vec2, Vector2)) {
                    return 
                  }
                  vec2.y = NumberUtil.parse(value, 0)
                  item.set(vec2)
                },
              },
            },
            VEStyles.get("text-field"),
            false
          ),
          Struct.get(config, "vec2y"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "vec4": function(name, layout, config = null) {
    ///@todo move to Lambda util
    static addItem = function(item, index, items) {
      items.add(item)
    }

    static factoryTextField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: Struct.appendRecursive(
          config, 
          {
            field: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var key = Struct.get(data, "vec4Property")
                  var vec4 = item.get()
                  if (!Core.isType(vec4, Vector4) 
                    || !Struct.contains(vec4, key)
                    || GMTFContext.get() == data.textField) {
                    return 
                  }
                  data.textField.setText(Struct.get(vec4, key))
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var key = Struct.get(this.context, "vec4Property")
                  var vec4 = item.get()
                  if (!Core.isType(vec4, Vector4) || !Struct.contains(vec4, key)) {
                    return 
                  }
                  item.set(Struct.set(vec4, key, parsedValue))
                },
              },
            },
          },
          false
        )
      }).toUIItems(layout)
    }

    var items = new Array(UIItem)

    factoryTextField(
      $"{name}_x",
      layout.nodes.x,
      Struct.appendRecursive(
        Struct.get(config, "x"),
        { field: { vec4Property: "x" } },
        false
      )
    ).forEach(addItem, items)

    factoryTextField(
      $"{name}_y",
      layout.nodes.y,
      Struct.appendRecursive(
        Struct.get(config, "y"),
        { field: { vec4Property: "y" } },
        false
      )
    ).forEach(addItem, items)

    factoryTextField(
      $"{name}_z",
      layout.nodes.z,
      Struct.appendRecursive(
        Struct.get(config, "z"),
        { field: { vec4Property: "z" } },
        false
      )
    ).forEach(addItem, items)

    factoryTextField(
      $"{name}_a",
      layout.nodes.a,
      Struct.appendRecursive(
        Struct.get(config, "a"),
        { field: { vec4Property: "a" } },
        false
      )
    ).forEach(addItem, items)

    return items
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "vec4-increase": function(name, layout, config = null) {
    ///@todo move to Lambda util
    static addItem = function(item, index, items) {
      items.add(item)
    }

    static factoryTextField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field-increase"),
        layout: VELayouts.get("text-field-increase"),
        config: Struct.appendRecursive(
          {
            field: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var key = Struct.get(data, "vec4Property")
                  var vec4 = item.get()
                  if (!Core.isType(vec4, Vector4) 
                    || !Struct.contains(vec4, key)
                    || GMTFContext.get() == data.textField) {
                    return 
                  }
                  data.textField.setText(Struct.get(vec4, key))
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var key = Struct.get(this.context, "vec4Property")
                  var vec4 = item.get()
                  if (!Core.isType(vec4, Vector4) || !Struct.contains(vec4, key)) {
                    return 
                  }
                  item.set(Struct.set(vec4, key, parsedValue))
                },
              },
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

                var key = Struct.get(this, "vec4Property")
                var vec4 = item.get()
                if (!Core.isType(vec4, Vector4) || !Struct.contains(vec4, key)) {
                  return 
                }

                Struct.set(vec4, key, Struct.get(vec4, key) + factor)
                item.set(vec4)
              },
              store: {
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

                var key = Struct.get(this, "vec4Property")
                var vec4 = item.get()
                if (!Core.isType(vec4, Vector4) || !Struct.contains(vec4, key)) {
                  return 
                }

                Struct.set(vec4, key, Struct.get(vec4, key) + factor)
                item.set(vec4)
              },
              store: {
                callback: function(value, data) { },
                set: function(value) { },
              },
            },
          },
          config,
          false
        )
      }).toUIItems(layout)
    }

    var items = new Array(UIItem)

    factoryTextField(
      $"{name}_x",
      layout.nodes.x,
      Struct.appendRecursive(
        Struct.get(config, "x"),
        { 
          field: { vec4Property: "x" },
          decrease: { vec4Property: "x" },
          increase: { vec4Property: "x" },
        },
        false
      )
    ).forEach(addItem, items)

    factoryTextField(
      $"{name}_y",
      layout.nodes.y,
      Struct.appendRecursive(
        Struct.get(config, "y"),
        { 
          field: { vec4Property: "y" },
          decrease: { vec4Property: "y" },
          increase: { vec4Property: "y" },
        },
        false
      )
    ).forEach(addItem, items)

    factoryTextField(
      $"{name}_z",
      layout.nodes.z,
      Struct.appendRecursive(
        Struct.get(config, "z"),
        { 
          field: { vec4Property: "z" },
          decrease: { vec4Property: "z" },
          increase: { vec4Property: "z" },
        },
        false
      )
    ).forEach(addItem, items)

    factoryTextField(
      $"{name}_a",
      layout.nodes.a,
      Struct.appendRecursive(
        Struct.get(config, "a"),
        { 
          field: { vec4Property: "a" },
          decrease: { vec4Property: "a" },
          increase: { vec4Property: "a" },
        },
        false
      )
    ).forEach(addItem, items)

    return items
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "number-transformer-increase": function(name, layout, config = null) {
    ///@todo move to Lambda util
    static addItem = function(item, index, items) {
      items.add(item)
    }

    static factoryTitle = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: config,
      }).toUIItems(layout)
    }

    static factoryDoubleCheckbox = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("double-checkbox"),
        layout: VELayouts.get("double-checkbox"),
        config: config,
      }).toUIItems(layout)
    }

    static factoryTextField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: Struct.appendRecursive(
          config, 
          {
            field: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var key = Struct.get(data, "transformNumericProperty")
                  var transformer = item.get()
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)
                    || GMTFContext.get() == data.textField) {
                    return 
                  }
                  data.textField.setText(Struct.get(transformer, key))
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var key = Struct.get(this.context, "transformNumericProperty")
                  var transformer = item.get()
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                    return 
                  }
                  item.set(Struct.set(transformer, key, parsedValue))
                },
              },
            },
          },
          false
        )
      }).toUIItems(layout)
    }

    static factoryTextFieldCheckbox = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field-checkbox"),
        layout: VELayouts.get("text-field-checkbox"),
        config: Struct.appendRecursive(
          config, 
          {
            field: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var key = Struct.get(data, "transformNumericProperty")
                  var transformer = item.get()
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)
                    || GMTFContext.get() == data.textField) {
                    return 
                  }
                  data.textField.setText(Struct.get(transformer, key))
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var key = Struct.get(this.context, "transformNumericProperty")
                  var transformer = item.get()
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                    return 
                  }
                  item.set(Struct.set(transformer, key, parsedValue))
                },
              },
            },
          },
          false
        )
      }).toUIItems(layout)
    }

    static factoryTextFieldIncreaseCheckbox = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field-increase-checkbox"),
        layout: VELayouts.get("text-field-increase-checkbox"),
        config: Struct.appendRecursive(
          {
            field: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var key = Struct.get(data, "transformNumericProperty")
                  var transformer = item.get()
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)
                    || GMTFContext.get() == data.textField) {
                    return 
                  }
                  data.textField.setText(Struct.get(transformer, key))
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var key = Struct.get(this.context, "transformNumericProperty")
                  var transformer = item.get()
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                    return 
                  }
                  item.set(Struct.set(transformer, key, parsedValue))
                },
              },
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

                var key = Struct.get(this, "transformNumericProperty")
                var transformer = item.get()
                if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                  return 
                }

                Struct.set(transformer, key, Struct.get(transformer, key) + factor)
                item.set(transformer)
              },
              store: {
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

                var key = Struct.get(this, "transformNumericProperty")
                var transformer = item.get()
                if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                  return 
                }

                Struct.set(transformer, key, Struct.get(transformer, key) + factor)
                item.set(transformer)
              },
              store: {
                callback: function(value, data) { },
                set: function(value) { },
              },
            },
          },
          config, 
          false
        )
      }).toUIItems(layout)
    }
    
    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryTextFieldIncrease = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field-increase"),
        layout: VELayouts.get("text-field-increase"),
        config: Struct.appendRecursive(
          config,
          {
            field: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var key = Struct.get(data, "transformNumericProperty")
                  var transformer = item.get()
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)
                    || GMTFContext.get() == data.textField) {
                    return 
                  }
                  data.textField.setText(Struct.get(transformer, key))
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var key = Struct.get(this.context, "transformNumericProperty")
                  var transformer = item.get()
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                    return 
                  }
                  item.set(Struct.set(transformer, key, parsedValue))
                },
              },
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

                var key = Struct.get(this, "transformNumericProperty")
                var transformer = item.get()
                if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                  return 
                }

                Struct.set(transformer, key, Struct.get(transformer, key) + factor)
                item.set(transformer)
              },
              store: {
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

                var key = Struct.get(this, "transformNumericProperty")
                var transformer = item.get()
                if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                  return 
                }

                Struct.set(transformer, key, Struct.get(transformer, key) + factor)
                item.set(transformer)
              },
              store: {
                callback: function(value, data) { },
                set: function(value) { },
              },
            },
          },
          false
        )
      }).toUIItems(layout)
    }

    var items = new Array(UIItem)

    //factoryTitle(
    //  $"{name}_title",
    //  layout.nodes.title,
    //  Struct.get(config, "title")
    //).forEach(addItem, items)
    
    factoryTextFieldIncrease(
      $"{name}_value",
      layout.nodes.value,
      Struct.appendRecursive(
        { 
          field: { transformNumericProperty: "value" },
          decrease: { transformNumericProperty: "value" },
          increase: { transformNumericProperty: "value" },
        },
        Struct.get(config, "value"),
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncrease(
      $"{name}_target",
      layout.nodes.target,
      Struct.appendRecursive(
        Struct.get(config, "target"),
        { 
          field: { transformNumericProperty: "target" },
          decrease: { transformNumericProperty: "target" },
          increase: { transformNumericProperty: "target" },
        },
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncrease(
      $"{name}_factor",
      layout.nodes.factor,
      Struct.appendRecursive(
        Struct.get(config, "factor"),
        {
          field: { transformNumericProperty: "factor" },
          decrease: { transformNumericProperty: "factor" },
          increase: { transformNumericProperty: "factor" },
        },
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncrease(
      $"{name}_increase",
      layout.nodes.increase,
      Struct.appendRecursive(
        Struct.get(config, "increase"),
        {
          field: { transformNumericProperty: "increase" },
          decrease: { transformNumericProperty: "increase" },
          increase: { transformNumericProperty: "increase" },
        },
        false
      )
    ).forEach(addItem, items)

    return items
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "number-transformer-increase-checkbox": function(name, layout, config = null) {
    ///@todo move to Lambda util
    static addItem = function(item, index, items) {
      items.add(item)
    }

    static factoryTitle = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: config,
      }).toUIItems(layout)
    }

    static factoryDoubleCheckbox = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("double-checkbox"),
        layout: VELayouts.get("double-checkbox"),
        config: config,
      }).toUIItems(layout)
    }

    static factoryTextField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: Struct.appendRecursive(
          config, 
          {
            field: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var key = Struct.get(data, "transformNumericProperty")
                  var transformer = item.get()
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)
                    || GMTFContext.get() == data.textField) {
                    return 
                  }
                  data.textField.setText(Struct.get(transformer, key))
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var key = Struct.get(this.context, "transformNumericProperty")
                  var transformer = item.get()
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                    return 
                  }
                  item.set(Struct.set(transformer, key, parsedValue))
                },
              },
            },
          },
          false
        )
      }).toUIItems(layout)
    }

    static factoryTextFieldCheckbox = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field-checkbox"),
        layout: VELayouts.get("text-field-checkbox"),
        config: Struct.appendRecursive(
          config, 
          {
            field: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var key = Struct.get(data, "transformNumericProperty")
                  var transformer = item.get()
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)
                    || GMTFContext.get() == data.textField) {
                    return 
                  }
                  data.textField.setText(Struct.get(transformer, key))
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var key = Struct.get(this.context, "transformNumericProperty")
                  var transformer = item.get()
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                    return 
                  }
                  item.set(Struct.set(transformer, key, parsedValue))
                },
              },
            },
          },
          false
        )
      }).toUIItems(layout)
    }

    static factoryTextFieldIncreaseCheckbox = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field-increase-checkbox"),
        layout: VELayouts.get("text-field-increase-checkbox"),
        config: Struct.appendRecursive(
          {
            field: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var key = Struct.get(data, "transformNumericProperty")
                  var transformer = item.get()
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)
                    || GMTFContext.get() == data.textField) {
                    return 
                  }
                  data.textField.setText(Struct.get(transformer, key))
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var key = Struct.get(this.context, "transformNumericProperty")
                  var transformer = item.get()
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                    return 
                  }
                  item.set(Struct.set(transformer, key, parsedValue))
                },
              },
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

                var key = Struct.get(this, "transformNumericProperty")
                var transformer = item.get()
                if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                  return 
                }

                Struct.set(transformer, key, Struct.get(transformer, key) + factor)
                item.set(transformer)
              },
              store: {
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

                var key = Struct.get(this, "transformNumericProperty")
                var transformer = item.get()
                if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                  return 
                }

                Struct.set(transformer, key, Struct.get(transformer, key) + factor)
                item.set(transformer)
              },
              store: {
                callback: function(value, data) { },
                set: function(value) { },
              },
            },
          },
          config, 
          false
        )
      }).toUIItems(layout)
    }

    static factoryTextFieldIncreaseStickCheckbox = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field-increase-stick-checkbox"),
        layout: VELayouts.get("text-field-increase-stick-checkbox"),
        config: Struct.appendRecursive(
          {
            field: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var key = Struct.get(data, "transformNumericProperty")
                  var transformer = item.get()
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)
                    || GMTFContext.get() == data.textField) {
                    return 
                  }
                  data.textField.setText(Struct.get(transformer, key))
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var key = Struct.get(this.context, "transformNumericProperty")
                  var transformer = item.get()
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                    return 
                  }
                  item.set(Struct.set(transformer, key, parsedValue))
                },
              },
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

                var key = Struct.get(this, "transformNumericProperty")
                var transformer = item.get()
                if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                  return 
                }

                Struct.set(transformer, key, Struct.get(transformer, key) + factor)
                item.set(transformer)
              },
              store: {
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

                var key = Struct.get(this, "transformNumericProperty")
                var transformer = item.get()
                if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                  return 
                }

                Struct.set(transformer, key, Struct.get(transformer, key) + factor)
                item.set(transformer)
              },
              store: {
                callback: function(value, data) { },
                set: function(value) { },
              },
            },
            stick: {
              store: {
                callback: function(value, data) { },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var key = Struct.get(this.context, "transformNumericProperty")
                  var transformer = item.get()
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                    return 
                  }
                  item.set(Struct.set(transformer, key, parsedValue))
                },
              },
              factor: 0.01,
              base: null,
              _value: 0.0,
              value: 0.25,
              minValue: 0.0,
              maxValue: 0.5,
              pointer: {
                name: "texture_slider_pointer_simple",
                scaleX: 0.125,
                scaleY: 0.125,
                blend: VETheme.color.stick,
              },
              progress: { thickness: 0.0 },
              background: {
                thickness: 0.0000,
                blend: VETheme.color.stickBackground,
                line: { name: "texture_grid_line_bold" },
              },
              updateValue: function(mouseX, mouseY) {
                var isUIStore = Core.isType(this.store, UIStore)
                var key = Struct.get(this, "transformNumericProperty")
                this.base = !Core.isType(this.base, Number) 
                  ? (isUIStore ? Struct.get(this.store.getValue(), key) : this.value)
                  : this.base 

                var distanceX = mouseX - (this.area.getX() + (this.area.getWidth() / 2))
                var distanceY = (this.area.getY() + this.context.offset.y) - mouseY
                var distance = abs(distanceX) > abs(distanceY) ? distanceX : distanceY
                this.value = this.base + (distance * this.factor)
                if (isUIStore && this.value != Struct.get(this.store.getValue(), key)) {
                  this.store.set(this.value)
                }
              },
              colorHoverOver: VETheme.color.stickHover,
              colorHoverOut: VETheme.color.stick,
              onMouseHoverOver: function(event) {
                if (Struct.get(this.enable, "value") == false) {
                  this.pointer.setBlend(ColorUtil.parse(this.colorHoverOut).toGMColor())
                  return
                }
                
                this.pointer.setBlend(ColorUtil.parse(this.colorHoverOver).toGMColor())
              },
              onMouseHoverOut: function(event) {
                if (Struct.get(Struct.get(this.getClipboard(), "state"), "context") == this) {
                  return
                }
                this.pointer.setBlend(ColorUtil.parse(this.colorHoverOut).toGMColor())
              },
              //onMouseDragLeft: function(event) {
              onMousePressedLeft: function(event) { ///@stickhack
                if (Struct.get(this.enable, "value") == false 
                    || Optional.is(this.getClipboard())) {
                  return
                }
          
                var context = this
                this.base = null
                this.setClipboard(new Promise()
                  .setState({
                    context: context,
                    callback: context.callback,
                  })
                  .whenSuccess(function() {
                    this.state.context.base = null
                    this.state.context.pointer.setBlend(ColorUtil.parse(this.state.context.colorHoverOut).toGMColor())
                    Callable.run(Struct.get(this.state, "callback"))
                  })
                )
              },
              preRender: function() {
                this._value = this.value
                var _base = this.base != null ? this.base : this.value
                var orderOfMagnitude = floor(log10(abs(clamp(abs(this.value), 10, 1000000))))
                this.value = clamp(0.25 - (((_base - this.value) * this.factor) / orderOfMagnitude), this.minValue, this.maxValue)
                //orderOfMagnitude = GuiWidth()
                //this.value = clamp(0.5 - (((_base - this.value) / this.factor) / orderOfMagnitude), this.minValue, this.maxValue)
              },
              postRender: function() {
                this.value = this._value
              },
            },
            checkbox: {
              margin: { top: 2, bottom: 2, left: 2, right: 2 },
            },
            title: {
              store: Struct.get(Struct.get(config, "checkbox"), "store"),
              onMouseReleasedLeft: function(event) {
                if (!Core.isType(this.store, UIStore)) {
                  return
                }

                var item = this.store.get()
                if (!Core.isType(item, StoreItem)) {
                  return
                }

                item.set(!item.get())

                if (Core.isType(this.context, UI) 
                    && Optional.is(this.context.updateTimer)) {
                  ///@updateTimerNow
                  this.context.updateTimer.time = clamp(
                    this.context.updateTimer.time,
                    this.context.updateTimer.duration * 0.7500,
                    this.context.updateTimer.duration
                  )
                }
              }
            }
          },
          config, 
          false
        )
      }).toUIItems(layout)
    }
    
    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryTextFieldIncrease = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field-increase"),
        layout: VELayouts.get("text-field-increase"),
        config: Struct.appendRecursive(
          config,
          {
            field: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var key = Struct.get(data, "transformNumericProperty")
                  var transformer = item.get()
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)
                    || GMTFContext.get() == data.textField) {
                    return 
                  }
                  data.textField.setText(Struct.get(transformer, key))
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var key = Struct.get(this.context, "transformNumericProperty")
                  var transformer = item.get()
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                    return 
                  }
                  item.set(Struct.set(transformer, key, parsedValue))
                },
              },
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

                var key = Struct.get(this, "transformNumericProperty")
                var transformer = item.get()
                if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                  return 
                }

                Struct.set(transformer, key, Struct.get(transformer, key) + factor)
                item.set(transformer)
              },
              store: {
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

                var key = Struct.get(this, "transformNumericProperty")
                var transformer = item.get()
                if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                  return 
                }

                Struct.set(transformer, key, Struct.get(transformer, key) + factor)
                item.set(transformer)
              },
              store: {
                callback: function(value, data) { },
                set: function(value) { },
              },
            },
          },
          false
        )
      }).toUIItems(layout)
    }

    var items = new Array(UIItem)

    //factoryTitle(
    //  $"{name}_title",
    //  layout.nodes.title,
    //  Struct.get(config, "title")
    //).forEach(addItem, items)

    factoryTextFieldIncreaseStickCheckbox(
      $"{name}_value",
      layout.nodes.value,
      Struct.appendRecursive(
        { 
          field: { transformNumericProperty: "value" },
          decrease: { transformNumericProperty: "value" },
          increase: { transformNumericProperty: "value" },
          stick: {
            transformNumericProperty: "value",
            factor: Struct.getIfType(Struct.get(Struct.get(config, "value"), "increase"), "factor", Number, 0.1) * 0.1,
            enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "value"), "field"), "enable", Struct, { })),
            store: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "value"), "field"), "store", Struct, { })),
          },
        },
        Struct.get(config, "value"),
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncreaseStickCheckbox(
      $"{name}_target",
      layout.nodes.target,
      Struct.appendRecursive(
        Struct.get(config, "target"),
        { 
          field: { transformNumericProperty: "target" },
          decrease: { transformNumericProperty: "target" },
          increase: { transformNumericProperty: "target" },
          stick: {
            transformNumericProperty: "target",
            factor: Struct.getIfType(Struct.get(Struct.get(config, "target"), "increase"), "factor", Number, 0.1) * 0.1,
            enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "enable", Struct, { })),
            store: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "store", Struct, { })),
          },
        },
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncreaseStickCheckbox(
      $"{name}_factor",
      layout.nodes.factor,
      Struct.appendRecursive(
        Struct.get(config, "factor"),
        {
          field: { transformNumericProperty: "factor" },
          decrease: { transformNumericProperty: "factor" },
          increase: { transformNumericProperty: "factor" },
          stick: {
            transformNumericProperty: "factor",
            factor: Struct.getIfType(Struct.get(Struct.get(config, "factor"), "increase"), "factor", Number, 0.1) * 0.1,
            enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "factor"), "field"), "enable", Struct, { })),
            store: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "factor"), "field"), "store", Struct, { })),
          },
        },
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncreaseStickCheckbox(
      $"{name}_increase",
      layout.nodes.increase,
      Struct.appendRecursive(
        Struct.get(config, "increase"),
        {
          field: { transformNumericProperty: "increase" },
          decrease: { transformNumericProperty: "increase" },
          increase: { transformNumericProperty: "increase" },
          stick: {
            transformNumericProperty: "increase",
            factor: Struct.getIfType(Struct.get(Struct.get(config, "increase"), "increase"), "factor", Number, 0.1) * 0.1,
            enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "increase"), "field"), "enable", Struct, { })),
            store: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "increase"), "field"), "store", Struct, { })),
          },
        },
        false
      )
    ).forEach(addItem, items)

    return items
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "vec4-slider": function(name, layout, config = null) {
    ///@todo move to Lambda util
    static addItem = function(item, index, items) {
      items.add(item)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryNumericSliderField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("numeric-slider-field"),
        layout: VELayouts.get("numeric-slider-field"),
        config: Struct.appendRecursive(
          config, 
          {
            field: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var key = Struct.get(data, "vec4Property")
                  var vec4 = item.get()
                  if (!Core.isType(vec4, Vector4) 
                    || !Struct.contains(vec4, key)
                    || GMTFContext.get() == data.textField) {
                    return 
                  }
                  data.textField.setText(Struct.get(vec4, key))
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var key = Struct.get(this.context, "vec4Property")
                  var vec4 = item.get()
                  if (!Core.isType(vec4, Vector4) || !Struct.contains(vec4, key)) {
                    return 
                  }
                  item.set(Struct.set(vec4, key, parsedValue))
                },
              },
            },
            slider: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var key = Struct.get(data, "vec4Property")
                  var vec4 = item.get()
                  if (!Core.isType(vec4, Vector4) 
                    || !Struct.contains(vec4, key)) {
                    return 
                  }
                  data.value = Struct.get(vec4, key)
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var key = Struct.get(this.context, "vec4Property")
                  var vec4 = item.get()
                  if (!Core.isType(vec4, Vector4) || !Struct.contains(vec4, key)) {
                    return 
                  }
                  item.set(Struct.set(vec4, key, parsedValue))
                },
              },
            }
          },
          false
        )
      }).toUIItems(layout)
    }

    static factoryTextField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: Struct.appendRecursive(
          config, 
          {
            field: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var key = Struct.get(data, "vec4Property")
                  var vec4 = item.get()
                  if (!Core.isType(vec4, Vector4) 
                    || !Struct.contains(vec4, key)
                    || GMTFContext.get() == data.textField) {
                    return 
                  }
                  data.textField.setText(Struct.get(vec4, key))
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var key = Struct.get(this.context, "vec4Property")
                  var vec4 = item.get()
                  if (!Core.isType(vec4, Vector4) || !Struct.contains(vec4, key)) {
                    return 
                  }
                  item.set(Struct.set(vec4, key, parsedValue))
                },
              },
            },
          },
          false
        )
      }).toUIItems(layout)
    }

    var items = new Array(UIItem)

    factoryNumericSliderField(
      $"{name}_x",
      layout.nodes.x,
      Struct.appendRecursive(
        Struct.get(config, "x"),
        {
          field: { vec4Property: "x" },
          slider: { vec4Property: "x" },
        },
        false
      )
    ).forEach(addItem, items)

    factoryNumericSliderField(
      $"{name}_y",
      layout.nodes.y,
      Struct.appendRecursive(
        Struct.get(config, "y"),
        { 
          field: { vec4Property: "y" },
          slider: { vec4Property: "y" },
        },
        false
      )
    ).forEach(addItem, items)

    factoryNumericSliderField(
      $"{name}_z",
      layout.nodes.z,
      Struct.appendRecursive(
        Struct.get(config, "z"),
        {
          field: { vec4Property: "z" },
          slider: { vec4Property: "z" },
        },
        false
      )
    ).forEach(addItem, items)

    factoryNumericSliderField(
      $"{name}_a",
      layout.nodes.a,
      Struct.appendRecursive(
        Struct.get(config, "a"),
        {
          field: { vec4Property: "a" },
          slider: { vec4Property: "a" },
        },
        false
      )
    ).forEach(addItem, items)

    return items
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "vec4-slider-increase": function(name, layout, config = null) {
    ///@todo move to Lambda util
    static addItem = function(item, index, items) {
      items.add(item)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryNumericSliderField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("numeric-slider-field"),
        layout: VELayouts.get("numeric-slider-field"),
        config: Struct.appendRecursive(
          config, 
          {
            field: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var key = Struct.get(data, "vec4Property")
                  var vec4 = item.get()
                  if (!Core.isType(vec4, Vector4) 
                    || !Struct.contains(vec4, key)
                    || GMTFContext.get() == data.textField) {
                    return 
                  }
                  data.textField.setText(Struct.get(vec4, key))
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var key = Struct.get(this.context, "vec4Property")
                  var vec4 = item.get()
                  if (!Core.isType(vec4, Vector4) || !Struct.contains(vec4, key)) {
                    return 
                  }
                  item.set(Struct.set(vec4, key, parsedValue))
                },
              },
            },
            slider: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var key = Struct.get(data, "vec4Property")
                  var vec4 = item.get()
                  if (!Core.isType(vec4, Vector4) 
                    || !Struct.contains(vec4, key)) {
                    return 
                  }
                  data.value = Struct.get(vec4, key)
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var key = Struct.get(this.context, "vec4Property")
                  var vec4 = item.get()
                  if (!Core.isType(vec4, Vector4) || !Struct.contains(vec4, key)) {
                    return 
                  }
                  item.set(Struct.set(vec4, key, parsedValue))
                },
              },
            }
          },
          false
        )
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIComponent}
    static factoryNumericSliderIncreaseField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: Struct.appendRecursive(
          {
            field: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var key = Struct.get(data, "vec4Property")
                  var vec4 = item.get()
                  if (!Core.isType(vec4, Vector4) 
                    || !Struct.contains(vec4, key)
                    || GMTFContext.get() == data.textField) {
                    return 
                  }
                  data.textField.setText(Struct.get(vec4, key))
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var key = Struct.get(this.context, "vec4Property")
                  var vec4 = item.get()
                  if (!Core.isType(vec4, Vector4) || !Struct.contains(vec4, key)) {
                    return 
                  }
                  item.set(Struct.set(vec4, key, parsedValue))
                },
              },
            },
            slider: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var key = Struct.get(data, "vec4Property")
                  var vec4 = item.get()
                  if (!Core.isType(vec4, Vector4) 
                    || !Struct.contains(vec4, key)) {
                    return 
                  }
                  data.value = Struct.get(vec4, key)
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var key = Struct.get(this.context, "vec4Property")
                  var vec4 = item.get()
                  if (!Core.isType(vec4, Vector4) || !Struct.contains(vec4, key)) {
                    return 
                  }
                  item.set(Struct.set(vec4, key, parsedValue))
                },
              },
            },
            decrease: {
              factor: -0.01,
              callback: function() {
                var factor = Struct.get(this, "factor")
                if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                  return
                }
  
                var item = this.store.get()
                if (!Core.isType(item, StoreItem)) {
                  return
                }

                var key = Struct.get(this, "vec4Property")
                var vec4 = item.get()
                if (!Core.isType(vec4, Vector4) || !Struct.contains(vec4, key)) {
                  return 
                }
                
                Struct.set(vec4, key, Struct.get(vec4, key) + factor)
                item.set(vec4)
              },
              store: {
                callback: function(value, data) { },
                set: function(value) { },
              },
            },
            increase: {
              factor: 0.01,
              callback: function() {
                var factor = Struct.get(this, "factor")
                if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                  return
                }
  
                var item = this.store.get()
                if (!Core.isType(item, StoreItem)) {
                  return
                }

                var key = Struct.get(this, "vec4Property")
                var vec4 = item.get()
                if (!Core.isType(vec4, Vector4) || !Struct.contains(vec4, key)) {
                  return 
                }
                
                Struct.set(vec4, key, Struct.get(vec4, key) + factor)
                item.set(vec4)
              },
              store: {
                callback: function(value, data) { },
                set: function(value) { },
              },
            },
          },
          config,
          false
        )
      }).toUIItems(layout)
    }

    static factoryTextField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: Struct.appendRecursive(
          config, 
          {
            field: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var key = Struct.get(data, "vec4Property")
                  var vec4 = item.get()
                  if (!Core.isType(vec4, Vector4) 
                    || !Struct.contains(vec4, key)
                    || GMTFContext.get() == data.textField) {
                    return 
                  }
                  data.textField.setText(Struct.get(vec4, key))
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var key = Struct.get(this.context, "vec4Property")
                  var vec4 = item.get()
                  if (!Core.isType(vec4, Vector4) || !Struct.contains(vec4, key)) {
                    return 
                  }
                  item.set(Struct.set(vec4, key, parsedValue))
                },
              },
            },
          },
          false
        )
      }).toUIItems(layout)
    }

    var items = new Array(UIItem)

    factoryNumericSliderIncreaseField(
      $"{name}_x",
      layout.nodes.x,
      Struct.appendRecursive(
        Struct.get(config, "x"),
        {
          field: { vec4Property: "x" },
          slider: { vec4Property: "x" },
          decrease: { vec4Property: "x" },
          increase: { vec4Property: "x" },
        },
        false
      )
    ).forEach(addItem, items)

    factoryNumericSliderIncreaseField(
      $"{name}_y",
      layout.nodes.y,
      Struct.appendRecursive(
        Struct.get(config, "y"),
        { 
          field: { vec4Property: "y" },
          slider: { vec4Property: "y" },
          decrease: { vec4Property: "y" },
          increase: { vec4Property: "y" },
        },
        false
      )
    ).forEach(addItem, items)

    factoryNumericSliderIncreaseField(
      $"{name}_z",
      layout.nodes.z,
      Struct.appendRecursive(
        Struct.get(config, "z"),
        {
          field: { vec4Property: "z" },
          slider: { vec4Property: "z" },
          decrease: { vec4Property: "z" },
          increase: { vec4Property: "z" },
        },
        false
      )
    ).forEach(addItem, items)

    factoryNumericSliderIncreaseField(
      $"{name}_a",
      layout.nodes.a,
      Struct.appendRecursive(
        Struct.get(config, "a"),
        {
          field: { vec4Property: "a" },
          slider: { vec4Property: "a" },
          decrease: { vec4Property: "a" },
          increase: { vec4Property: "a" },
        },
        false
      )
    ).forEach(addItem, items)

    return items
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "numeric-input": function(name, layout, config = null) {
    
    ///@param {String} name
    ///@param {?UILayout} layout
    ///@param {?Struct} [config]
    ///@return {Array<UIItem>}
    static factoryNumericIncreaseStickField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("text-field-increase-slider-checkbox"),
        config: Struct.appendRecursive(
          {
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

                var value = item.get()
                if (!Core.isType(value, Number)) {
                  return
                }

                item.set(value + factor)
              },
              store: {
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

                var value = item.get()
                if (!Core.isType(value, Number)) {
                  return
                }

                item.set(value + factor)
              },
              store: {
                callback: function(value, data) { },
                set: function(value) { },
              },
            },
            slider: {
              store: {
                callback: function(value, data) { },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  item.set(parsedValue)
                },
              },
              factor: 0.001,
              base: null,
              _value: 0.0,
              value: 0.25,
              minValue: 0.0,
              maxValue: 0.5,
              pointer: {
                name: "texture_slider_pointer_simple",
                scaleX: 0.125,
                scaleY: 0.125,
                blend: VETheme.color.stick,
              },
              progress: { thickness: 0.0 },
              background: {
                thickness: 0.0000,
                blend: VETheme.color.stickBackground,
                line: { name: "texture_grid_line_bold" },
              },
              updateValue: function(mouseX, mouseY) {
                var isUIStore = Core.isType(this.store, UIStore)
                this.base = !Core.isType(this.base, Number) 
                  ? (isUIStore ? this.store.getValue() : this.value)
                  : this.base 

                var distanceX = mouseX - (this.area.getX() + (this.area.getWidth() / 2))
                var distanceY = (this.area.getY() + this.context.offset.y) - mouseY
                var distance = abs(distanceX) > abs(distanceY) ? distanceX : distanceY
                this.value = this.base + (distance * this.factor)
                if (isUIStore && this.value != this.store.getValue()) {
                  this.store.set(this.value)
                }
              },
              colorHoverOver: VETheme.color.stickHover,
              colorHoverOut: VETheme.color.stick,
              onMouseHoverOver: function(event) {
                if (Struct.get(this.enable, "value") == false) {
                  this.pointer.setBlend(ColorUtil.parse(this.colorHoverOut).toGMColor())
                  return
                }

                this.pointer.setBlend(ColorUtil.parse(this.colorHoverOver).toGMColor())
              },
              onMouseHoverOut: function(event) {
                if (Struct.get(Struct.get(this.getClipboard(), "state"), "context") == this) {
                  return
                }
                this.pointer.setBlend(ColorUtil.parse(this.colorHoverOut).toGMColor())
              },
              //onMouseDragLeft: function(event) {
              onMousePressedLeft: function(event) { ///@stickhack
                if (Struct.get(this.enable, "value") == false 
                    || Optional.is(this.getClipboard())) {
                  return
                }
          
                var context = this
                this.base = null
                this.setClipboard(new Promise()
                  .setState({
                    context: context,
                    callback: context.callback,
                  })
                  .whenSuccess(function() {
                    this.state.context.base = null
                    this.state.context.pointer.setBlend(ColorUtil.parse(this.state.context.colorHoverOut).toGMColor())
                    Callable.run(Struct.get(this.state, "callback"))
                  })
                )
              },
              preRender: function() {
                this._value = this.value
                var _base = this.base != null ? this.base : this.value
                var orderOfMagnitude = floor(log10(abs(clamp(abs(this.value), 10, 1000000))))
                this.value = clamp(0.25 - (((_base - this.value) * this.factor) / orderOfMagnitude), this.minValue, this.maxValue)
                //orderOfMagnitude = GuiWidth()
                //this.value = clamp(0.5 - (((_base - this.value) / this.factor) / orderOfMagnitude), this.minValue, this.maxValue)
              },
              postRender: function() {
                this.value = this._value
              },
            },
          },
          config,
          false
        )
      }).toUIItems(layout)
    }

    return factoryNumericIncreaseStickField(name, layout, config)
  }
})
#macro VEComponents global.__VEComponents
