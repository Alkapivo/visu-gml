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
        $"{name}_brush-entry_settings", 
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
        $"{name}_brush-entry_remove", 
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
        $"{name}_brush-entry_label",
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
  "property": function(name, layout, config = null) {
    var style = VEStyles.get("property")
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
      ),
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
            backgroundColor: VETheme.color.primary,
            backgroundColorSelected: VETheme.color.accent,
            backgroundColorOut: VETheme.color.primary,
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
              if (Optional.is(this.enable) && !this.enable.value) {
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
            backgroundColor: VETheme.color.primary,
            backgroundColorSelected: VETheme.color.accent,
            backgroundColorOut: VETheme.color.primary,
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
              if (Optional.is(this.enable) && !this.enable.value) {
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
            backgroundColor: VETheme.color.primary,
            backgroundColorSelected: VETheme.color.accent,
            backgroundColorOut: VETheme.color.primary,
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
              if (Optional.is(this.enable) && !this.enable.value) {
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
            backgroundColor: VETheme.color.primary,
            backgroundColorSelected: VETheme.color.accent,
            backgroundColorOut: VETheme.color.primary,
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
              if (Optional.is(this.enable) && !this.enable.value) {
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
            backgroundColor: VETheme.color.primary,
            backgroundColorSelected: VETheme.color.accent,
            backgroundColorOut: VETheme.color.primary,
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
              if (Optional.is(this.enable) && !this.enable.value) {
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
            backgroundColor: VETheme.color.primary,
            backgroundColorSelected: VETheme.color.accent,
            backgroundColorOut: VETheme.color.primary,
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
              if (Optional.is(this.enable) && !this.enable.value) {
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

    static factoryTitle = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: Struct.appendRecursive(
          config,
          {
            input: {
              store: {
                callback: function(value, data) { 
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

    static factoryColor = function(name, layout, config) {
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

    static factoryHex = function(name, layout, config) {
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
          },
          false
        ),
      }).toUIItems(layout)
    }

    var items = new Array(UIItem)

    factoryTitle(
      $"{name}_title",
      layout.nodes.title,
      Struct.get(config, "title")
    ).forEach(addItem, items)

    factoryColor(
      $"{name}_red",
      layout.nodes.red,
      Struct.appendRecursive(
        Struct.get(config, "red"), 
        {
          field: { colorChannel: "red" }, 
          slider: { colorChannel: "red" },
        },
        false
      )
    ).forEach(addItem, items)

    factoryColor(
      $"{name}_green",
      layout.nodes.green,
      Struct.appendRecursive(
        Struct.get(config, "green"),
        {
          field: { colorChannel: "green" }, 
          slider: { colorChannel: "green" },
        },
        false
      )
    ).forEach(addItem, items)

    factoryColor(
      $"{name}_blue",
      layout.nodes.blue,
      Struct.appendRecursive(
        Struct.get(config, "blue"),
        {
          field: { colorChannel: "blue" }, 
          slider: { colorChannel: "blue" },
        },
        false
      )
    ).forEach(addItem, items)

    if (Struct.contains(config, "alpha")) {
      factoryColor(
        $"{name}_alpha",
        layout.nodes.alpha,
        Struct.appendRecursive(
          Struct.get(config, "alpha"),
          {
            field: { colorChannel: "alpha" }, 
            slider: { colorChannel: "alpha" },
          },
          false
        )
      ).forEach(addItem, items)
    }

    factoryHex(
      $"{name}_hex",
      layout.nodes.hex,
      Struct.get(config, "hex")
    ).forEach(addItem, items)

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
              backgroundColor: VETheme.color.primary,
              backgroundColorSelected: VETheme.color.accent,
              backgroundColorOut: VETheme.color.primary,
              onMouseHoverOver: function(event) {
                if (Optional.is(this.enable) && !this.enable.value) {
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
              backgroundColor: VETheme.color.primary,
              backgroundColorSelected: VETheme.color.accent,
              backgroundColorOut: VETheme.color.primary,
              onMouseHoverOver: function(event) {
                if (Optional.is(this.enable) && !this.enable.value) {
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
              backgroundColor: VETheme.color.primary,
              backgroundColorSelected: VETheme.color.accent,
              backgroundColorOut: VETheme.color.primary,
              onMouseHoverOver: function(event) {
                if (Optional.is(this.enable) && !this.enable.value) {
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
              backgroundColor: VETheme.color.primary,
              backgroundColorSelected: VETheme.color.accent,
              backgroundColorOut: VETheme.color.primary,
              onMouseHoverOver: function(event) {
                if (Optional.is(this.enable) && !this.enable.value) {
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

    var items = new Array(UIItem)

    factoryTitle(
      $"{name}_title",
      layout.nodes.title,
      Struct.get(config, "title")
    ).forEach(addItem, items)

    #region NumberTransformer fields
    factoryTextField(
      $"{name}_value",
      layout.nodes.value,
      Struct.appendRecursive(
        Struct.get(config, "value"),
        { field: { transformNumericProperty: "value" } },
        false
      )
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
      $"{name}_increase",
      layout.nodes.increase, 
      Struct.appendRecursive(
        Struct.get(config, "increase"), 
        { field: { transformNumericProperty: "increase" } },
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

    var items = new Array(UIItem)

    factoryTitle(
      $"{name}_title",
      layout.nodes.title,
      Struct.get(config, "title")
    ).forEach(addItem, items)

    #region X
    factoryTextField(
      $"{name}_valueX",
      layout.nodes.valueX,
      Struct.appendRecursive(
        Struct.get(config, "valueX"), 
        { 
          field: { 
            transformNumericProperty: "value",
            transformVector2Property: "x",
          }
        },
        false
      )
    ).forEach(addItem, items)
    
    factoryTextField(
      $"{name}_targetX",
      layout.nodes.targetX,
      Struct.appendRecursive(
        { 
          field: { 
            transformNumericProperty: "target",
            transformVector2Property: "x",
          },
        },
        Struct.get(config, "targetX"), 
        false
      )
    ).forEach(addItem, items)

    factoryTextField(
      $"{name}_factorX", 
      layout.nodes.factorX, 
      Struct.appendRecursive(
        { 
          field: { 
            transformNumericProperty: "factor",
            transformVector2Property: "x",
          }
        },
        Struct.get(config, "factorX"), 
        false
      )
    ).forEach(addItem, items)
 
    factoryTextField(
      $"{name}_incrementX",
      layout.nodes.incrementX, 
      Struct.appendRecursive(
        { 
          field: { 
            transformNumericProperty: "increase",
            transformVector2Property: "x",
          }
        },
        Struct.get(config, "incrementX"), 
        false
      )
    ).forEach(addItem, items)
    #endregion

    #region Y
    factoryTextField(
      $"{name}_valueY",
      layout.nodes.valueY,
      Struct.appendRecursive(
        { 
          field: { 
            transformNumericProperty: "value",
            transformVector2Property: "y",
          }
        },
        Struct.get(config, "valueY"), 
        false
      )
    ).forEach(addItem, items)

    factoryTextField(
      $"{name}_targetY",
      layout.nodes.targetY,
      Struct.appendRecursive(
        { 
          field: { 
            transformNumericProperty: "target",
            transformVector2Property: "y",
          }
        },
        Struct.get(config, "targetY"), 
        false
      )
    ).forEach(addItem, items)

    factoryTextField(
      $"{name}_factorY", 
      layout.nodes.factorY, 
      Struct.appendRecursive(
        { 
          field: { 
            transformNumericProperty: "factor",
            transformVector2Property: "y",
          }
        },
        Struct.get(config, "factorY"), 
        false
      )
    ).forEach(addItem, items)

    factoryTextField(
      $"{name}_incrementY",
      layout.nodes.incrementY, 
      Struct.appendRecursive(
        { 
          field: { 
            transformNumericProperty: "increase",
            transformVector2Property: "y",
          }
        },
        Struct.get(config, "incrementY"), 
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

    var items = new Array(UIItem)

    factoryTitle(
      $"{name}_title",
      layout.nodes.title,
      Struct.get(config, "title")
    ).forEach(addItem, items)

    #region X
    factoryTextField(
      $"{name}_valueX",
      layout.nodes.valueX,
      Struct.appendRecursive(
        Struct.get(config, "valueX"), 
        { 
          field: { 
            transformNumericProperty: "value",
            transformVector3Property: "x",
          }
        },
        false
      )
    ).forEach(addItem, items)
    
    factoryTextField(
      $"{name}_targetX",
      layout.nodes.targetX,
      Struct.appendRecursive(
        { 
          field: { 
            transformNumericProperty: "target",
            transformVector3Property: "x",
          },
        },
        Struct.get(config, "targetX"), 
        false
      )
    ).forEach(addItem, items)

    factoryTextField(
      $"{name}_factorX", 
      layout.nodes.factorX, 
      Struct.appendRecursive(
        { 
          field: { 
            transformNumericProperty: "factor",
            transformVector3Property: "x",
          }
        },
        Struct.get(config, "factorX"), 
        false
      )
    ).forEach(addItem, items)
 
    factoryTextField(
      $"{name}_incrementX",
      layout.nodes.incrementX, 
      Struct.appendRecursive(
        { 
          field: { 
            transformNumericProperty: "increase",
            transformVector3Property: "x",
          }
        },
        Struct.get(config, "incrementX"), 
        false
      )
    ).forEach(addItem, items)
    #endregion

    #region Y
    factoryTextField(
      $"{name}_valueY",
      layout.nodes.valueY,
      Struct.appendRecursive(
        { 
          field: { 
            transformNumericProperty: "value",
            transformVector3Property: "y",
          }
        },
        Struct.get(config, "valueY"), 
        false
      )
    ).forEach(addItem, items)

    factoryTextField(
      $"{name}_targetY",
      layout.nodes.targetY,
      Struct.appendRecursive(
        { 
          field: { 
            transformNumericProperty: "target",
            transformVector3Property: "y",
          }
        },
        Struct.get(config, "targetY"), 
        false
      )
    ).forEach(addItem, items)

    factoryTextField(
      $"{name}_factorY", 
      layout.nodes.factorY, 
      Struct.appendRecursive(
        { 
          field: { 
            transformNumericProperty: "factor",
            transformVector3Property: "y",
          }
        },
        Struct.get(config, "factorY"), 
        false
      )
    ).forEach(addItem, items)

    factoryTextField(
      $"{name}_incrementY",
      layout.nodes.incrementY, 
      Struct.appendRecursive(
        { 
          field: { 
            transformNumericProperty: "increase",
            transformVector3Property: "y",
          }
        },
        Struct.get(config, "incrementY"), 
        false
      )
    ).forEach(addItem, items)
    #endregion

    #region Z
    factoryTextField(
      $"{name}_valueZ",
      layout.nodes.valueZ,
      Struct.appendRecursive(
        Struct.get(config, "valueZ"), 
        { 
          field: { 
            transformNumericProperty: "value",
            transformVector3Property: "z",
          }
        },
        false
      )
    ).forEach(addItem, items)
    
    factoryTextField(
      $"{name}_targetZ",
      layout.nodes.targetZ,
      Struct.appendRecursive(
        { 
          field: { 
            transformNumericProperty: "target",
            transformVector3Property: "z",
          },
        },
        Struct.get(config, "targetZ"), 
        false
      )
    ).forEach(addItem, items)

    factoryTextField(
      $"{name}_factorZ", 
      layout.nodes.factorZ, 
      Struct.appendRecursive(
        { 
          field: { 
            transformNumericProperty: "factor",
            transformVector3Property: "z",
          }
        },
        Struct.get(config, "factorZ"), 
        false
      )
    ).forEach(addItem, items)
  
    factoryTextField(
      $"{name}_incrementZ",
      layout.nodes.incrementZ, 
      Struct.appendRecursive(
        { 
          field: { 
            transformNumericProperty: "increase",
            transformVector3Property: "z",
          }
        },
        Struct.get(config, "incrementZ"), 
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

    var items = new Array(UIItem)

    factoryTitle(
      $"{name}_title",
      layout.nodes.title,
      Struct.get(config, "title")
    ).forEach(addItem, items)

    #region X
    factoryTextField(
      $"{name}_valueX",
      layout.nodes.valueX,
      Struct.appendRecursive(
        Struct.get(config, "valueX"), 
        { 
          field: { 
            transformNumericProperty: "value",
            transformVector4Property: "x",
          }
        },
        false
      )
    ).forEach(addItem, items)
    
    factoryTextField(
      $"{name}_targetX",
      layout.nodes.targetX,
      Struct.appendRecursive(
        { 
          field: { 
            transformNumericProperty: "target",
            transformVector4Property: "x",
          },
        },
        Struct.get(config, "targetX"), 
        false
      )
    ).forEach(addItem, items)

    factoryTextField(
      $"{name}_factorX", 
      layout.nodes.factorX, 
      Struct.appendRecursive(
        { 
          field: { 
            transformNumericProperty: "factor",
            transformVector4Property: "x",
          }
        },
        Struct.get(config, "factorX"), 
        false
      )
    ).forEach(addItem, items)
 
    factoryTextField(
      $"{name}_incrementX",
      layout.nodes.incrementX, 
      Struct.appendRecursive(
        { 
          field: { 
            transformNumericProperty: "increase",
            transformVector4Property: "x",
          }
        },
        Struct.get(config, "incrementX"), 
        false
      )
    ).forEach(addItem, items)
    #endregion

    #region Y
    factoryTextField(
      $"{name}_valueY",
      layout.nodes.valueY,
      Struct.appendRecursive(
        { 
          field: { 
            transformNumericProperty: "value",
            transformVector4Property: "y",
          }
        },
        Struct.get(config, "valueY"), 
        false
      )
    ).forEach(addItem, items)

    factoryTextField(
      $"{name}_targetY",
      layout.nodes.targetY,
      Struct.appendRecursive(
        { 
          field: { 
            transformNumericProperty: "target",
            transformVector4Property: "y",
          }
        },
        Struct.get(config, "targetY"), 
        false
      )
    ).forEach(addItem, items)

    factoryTextField(
      $"{name}_factorY", 
      layout.nodes.factorY, 
      Struct.appendRecursive(
        { 
          field: { 
            transformNumericProperty: "factor",
            transformVector4Property: "y",
          }
        },
        Struct.get(config, "factorY"), 
        false
      )
    ).forEach(addItem, items)

    factoryTextField(
      $"{name}_incrementY",
      layout.nodes.incrementY, 
      Struct.appendRecursive(
        { 
          field: { 
            transformNumericProperty: "increase",
            transformVector4Property: "y",
          }
        },
        Struct.get(config, "incrementY"), 
        false
      )
    ).forEach(addItem, items)
    #endregion

    #region Z
    factoryTextField(
      $"{name}_valueZ",
      layout.nodes.valueZ,
      Struct.appendRecursive(
        Struct.get(config, "valueZ"), 
        { 
          field: { 
            transformNumericProperty: "value",
            transformVector4Property: "z",
          }
        },
        false
      )
    ).forEach(addItem, items)
    
    factoryTextField(
      $"{name}_targetZ",
      layout.nodes.targetZ,
      Struct.appendRecursive(
        { 
          field: { 
            transformNumericProperty: "target",
            transformVector4Property: "z",
          },
        },
        Struct.get(config, "targetZ"), 
        false
      )
    ).forEach(addItem, items)

    factoryTextField(
      $"{name}_factorZ", 
      layout.nodes.factorZ, 
      Struct.appendRecursive(
        { 
          field: { 
            transformNumericProperty: "factor",
            transformVector4Property: "z",
          }
        },
        Struct.get(config, "factorZ"), 
        false
      )
    ).forEach(addItem, items)
  
    factoryTextField(
      $"{name}_incrementZ",
      layout.nodes.incrementZ, 
      Struct.appendRecursive(
        { 
          field: { 
            transformNumericProperty: "increase",
            transformVector4Property: "z",
          }
        },
        Struct.get(config, "incrementZ"), 
        false
      )
    ).forEach(addItem, items)
    #endregion

    #region A
    factoryTextField(
      $"{name}_valueA",
      layout.nodes.valueA,
      Struct.appendRecursive(
        { 
          field: { 
            transformNumericProperty: "value",
            transformVector4Property: "a",
          }
        },
        Struct.get(config, "valueA"), 
        false
      )
    ).forEach(addItem, items)

    factoryTextField(
      $"{name}_targetA",
      layout.nodes.targetA,
      Struct.appendRecursive(
        { 
          field: { 
            transformNumericProperty: "target",
            transformVector4Property: "a",
          }
        },
        Struct.get(config, "targetA"), 
        false
      )
    ).forEach(addItem, items)

    factoryTextField(
      $"{name}_factorA", 
      layout.nodes.factorA, 
      Struct.appendRecursive(
        { 
          field: { 
            transformNumericProperty: "factor",
            transformVector4Property: "a",
          }
        },
        Struct.get(config, "factorA"), 
        false
      )
    ).forEach(addItem, items)

    factoryTextField(
      $"{name}_incrementA",
      layout.nodes.incrementA, 
      Struct.appendRecursive(
        { 
          field: { 
            transformNumericProperty: "increase",
            transformVector4Property: "a",
          }
        },
        Struct.get(config, "incrementA"), 
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
    
    factoryTextFieldIncreaseCheckbox(
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

    factoryTextFieldIncreaseCheckbox(
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

    factoryTextFieldIncreaseCheckbox(
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

    factoryTextFieldIncreaseCheckbox(
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
})
#macro VEComponents global.__VEComponents
