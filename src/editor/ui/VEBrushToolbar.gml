///@package io.alkapivo.visu.editor.ui

///@todo move to VEBrushToolbar
///@static
///@type {Map<String, Callable>}
global.__VisuBrushContainers = new Map(String, Callable, {
  "accordion": function(name, brushToolbar, layout) {
    return {
      name: name,
      state: new Map(String, any, {
        "background-alpha": 1.0,
        "background-color": ColorUtil.fromHex(VETheme.color.dark).toGMColor(),
      }),
      timer: new Timer(FRAME_MS * GAME_FPS * 0.33, { loop: Infinity, randomize: true }),
      layout: layout,
      updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
      render: Callable.run(UIUtil.renderTemplates.get("renderDefault")),
    }
  },
  "category": function(name, brushToolbar, layout) {
    return {
      name: name,
      state: new Map(String, any, {
        "background-alpha": 1.0,
        "background-color": ColorUtil.fromHex(VETheme.color.dark).toGMColor(),
        "components": new Array(Struct, [
          {
            name: "button_category-shader",
            template: VEComponents.get("category-button"),
            layout: VELayouts.get("vertical-item"),
            config: {
              backgroundColor: VETheme.color.primary,
              backgroundColorOn: ColorUtil.fromHex(VETheme.color.accent).toGMColor(),
              backgroundColorOff: ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
              backgroundMargin: { top: 0, bottom: 1, left: 1, right: 0 },
              callback: function() { 
                var category = this.context.brushToolbar.store.get("category")
                if (category.get() != this.category) {
                  category.set(this.category)
                }
              },
              updateCustom: function() {
                this.backgroundColor = this.category == this.context.brushToolbar.store.getValue("category")
                  ? this.backgroundColorOn
                  : this.backgroundColorOff
              },
              onMouseHoverOver: function(event) { },
              onMouseHoverOut: function(event) { },
              label: { text: String.toArray("SHADER").join("\n") },
              category: "shader",
            },
          },
          {
            name: "button_category-shroom",
            template: VEComponents.get("category-button"),
            layout: VELayouts.get("vertical-item"),
            config: {
              backgroundColor: VETheme.color.primary,
              backgroundColorOn: ColorUtil.fromHex(VETheme.color.accent).toGMColor(),
              backgroundColorOff: ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
              backgroundMargin: { top: 1, bottom: 1, left: 1, right: 0 },
              callback: function() { 
                var category = this.context.brushToolbar.store.get("category")
                if (category.get() != this.category) {
                  category.set(this.category)
                }
              },
              updateCustom: function() {
                this.backgroundColor = this.category == this.context.brushToolbar.store.getValue("category")
                  ? this.backgroundColorOn
                  : this.backgroundColorOff
              },
              onMouseHoverOver: function(event) { },
              onMouseHoverOut: function(event) { },
              label: { text: String.toArray("SHROOM").join("\n") },
              category: "shroom",
            },
          },
          {
            name: "button_category-grid",
            template: VEComponents.get("category-button"),
            layout: VELayouts.get("vertical-item"),
            config: {
              backgroundColor: VETheme.color.primary,
              backgroundColorOn: ColorUtil.fromHex(VETheme.color.accent).toGMColor(),
              backgroundColorOff: ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
              backgroundMargin: { top: 1, bottom: 1, left: 1, right: 0 },
              callback: function() { 
                var category = this.context.brushToolbar.store.get("category")
                if (category.get() != this.category) {
                  category.set(this.category)
                }
              },
              updateCustom: function() {
                this.backgroundColor = this.category == this.context.brushToolbar.store.getValue("category")
                  ? this.backgroundColorOn
                  : this.backgroundColorOff
              },
              onMouseHoverOver: function(event) { },
              onMouseHoverOut: function(event) { },
              label: { text: String.toArray("GRID").join("\n") },
              category: "grid",
            },
          },
          {
            name: "button_category-view",
            template: VEComponents.get("category-button"),
            layout: VELayouts.get("vertical-item"),
            config: {
              backgroundColor: VETheme.color.primary,
              backgroundColorOn: ColorUtil.fromHex(VETheme.color.accent).toGMColor(),
              backgroundColorOff: ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
              backgroundMargin: { top: 1, bottom: 0, left: 1, right: 0 },
              callback: function() { 
                var category = this.context.brushToolbar.store.get("category")
                if (category.get() != this.category) {
                  category.set(this.category)
                }
              },
              updateCustom: function() {
                this.backgroundColor = this.category == this.context.brushToolbar.store.getValue("category")
                  ? this.backgroundColorOn
                  : this.backgroundColorOff
              },
              onMouseHoverOver: function(event) { },
              onMouseHoverOut: function(event) { },
              label: { text: String.toArray("VIEW").join("\n") },
              category: "view",
            },
          },
        ]),
      }),
      timer: new Timer(FRAME_MS * GAME_FPS * 0.33, { loop: Infinity, randomize: true }),
      brushToolbar: brushToolbar,
      layout: layout,
      updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
      render: Callable.run(UIUtil.renderTemplates.get("renderDefault")),
      onInit: function() {
        this.collection = new UICollection(this, { layout: this.layout })
        this.state.get("components")
          .forEach(function(component, index, collection) {
            collection.add(new UIComponent(component))
          }, this.collection)
      },
    }
  },
  "type": function(name, brushToolbar, layout) {
    return {
      name: name,
      state: new Map(String, any, {
        "background-alpha": 1.0,
        "background-color": ColorUtil.fromHex("#282828").toGMColor(),
        "category": null,
        "type": null,
        "shader": new Array(Struct, [
          {
            name: "button_category-shader_type-spawn",
            template: VEComponents.get("category-button"),
            layout: VELayouts.get("horizontal-item"),
            config: {
              backgroundColor: VETheme.color.primary,
              backgroundColorOn: ColorUtil.fromHex(VETheme.color.accent).toGMColor(),
              backgroundColorOff: ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
              backgroundMargin: { top: 1, bottom: 1, left: 1, right: 1 },
              callback: function() { 
                var type = this.context.brushToolbar.store.get("type")
                if (type.get() != this.brushType) {
                  type.set(this.brushType)
                }
              },
              updateCustom: function() {
                this.backgroundColor = this.brushType == this.context.brushToolbar.store.getValue("type")
                  ? this.backgroundColorOn
                  : this.backgroundColorOff
              },
              label: { text: "Spawn" },
              brushType: VEBrushType.SHADER_SPAWN,
            },
          },
          {
            name: "button_category-shader_type-overlay",
            template: VEComponents.get("category-button"),
            layout: VELayouts.get("horizontal-item"),
            config: {
              backgroundColor: VETheme.color.primary,
              backgroundColorOn: ColorUtil.fromHex(VETheme.color.accent).toGMColor(),
              backgroundColorOff: ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
              backgroundMargin: { top: 1, bottom: 1, left: 1, right: 1 },
              callback: function() { 
                var type = this.context.brushToolbar.store.get("type")
                if (type.get() != this.brushType) {
                  type.set(this.brushType)
                }
              },
              updateCustom: function() {
                this.backgroundColor = this.brushType == this.context.brushToolbar.store.getValue("type")
                  ? this.backgroundColorOn
                  : this.backgroundColorOff
              },
              label: { text: "Overlay" },
              brushType: VEBrushType.SHADER_OVERLAY,
            },
            
          },
          {
            name: "button_category-shader_type-clear",
            template: VEComponents.get("category-button"),
            layout: VELayouts.get("horizontal-item"),
            config: {
              backgroundColor: VETheme.color.primary,
              backgroundColorOn: ColorUtil.fromHex(VETheme.color.accent).toGMColor(),
              backgroundColorOff: ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
              backgroundMargin: { top: 1, bottom: 1, left: 1, right: 1 },
              callback: function() { 
                var type = this.context.brushToolbar.store.get("type")
                if (type.get() != this.brushType) {
                  type.set(this.brushType)
                }
              },
              updateCustom: function() {
                this.backgroundColor = this.brushType == this.context.brushToolbar.store.getValue("type")
                  ? this.backgroundColorOn
                  : this.backgroundColorOff
              },
              label: { text: "Clear" },
              brushType: VEBrushType.SHADER_CLEAR,
            },
          },
          {
            name: "button_category-shader_type-config",
            template: VEComponents.get("category-button"),
            layout: VELayouts.get("horizontal-item"),
            config: {
              backgroundColor: VETheme.color.primary,
              backgroundColorOn: ColorUtil.fromHex(VETheme.color.accent).toGMColor(),
              backgroundColorOff: ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
              backgroundMargin: { top: 1, bottom: 1, left: 1, right: 2 },
              callback: function() { 
                var type = this.context.brushToolbar.store.get("type")
                if (type.get() != this.brushType) {
                  type.set(this.brushType)
                }
              },
              updateCustom: function() {
                this.backgroundColor = this.brushType == this.context.brushToolbar.store.getValue("type")
                  ? this.backgroundColorOn
                  : this.backgroundColorOff
              },
              label: { text: "Config" },
              brushType: VEBrushType.SHADER_CONFIG,
            },
          },
        ]),
        "shroom": new Array(Struct, [
          {
            name: "button_category-shroom_type-spawn",
            template: VEComponents.get("category-button"),
            layout: VELayouts.get("horizontal-item"),
            config: {
              backgroundColor: VETheme.color.primary,
              backgroundColorOn: ColorUtil.fromHex(VETheme.color.accent).toGMColor(),
              backgroundColorOff: ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
              backgroundMargin: { top: 1, bottom: 1, left: 1, right: 1 },
              callback: function() { 
                var type = this.context.brushToolbar.store.get("type")
                if (type.get() != this.brushType) {
                  type.set(this.brushType)
                }
              },
              updateCustom: function() {
                this.backgroundColor = this.brushType == this.context.brushToolbar.store.getValue("type")
                  ? this.backgroundColorOn
                  : this.backgroundColorOff
              },
              label: { text: "Spawn" },
              brushType: VEBrushType.SHROOM_SPAWN,
            },
          },
          {
            name: "button_category-shader_type-clear",
            template: VEComponents.get("category-button"),
            layout: VELayouts.get("horizontal-item"),
            config: {
              backgroundColor: VETheme.color.primary,
              backgroundColorOn: ColorUtil.fromHex(VETheme.color.accent).toGMColor(),
              backgroundColorOff: ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
              backgroundMargin: { top: 1, bottom: 1, left: 1, right: 1 },
              callback: function() { 
                var type = this.context.brushToolbar.store.get("type")
                if (type.get() != this.brushType) {
                  type.set(this.brushType)
                }
              },
              updateCustom: function() {
                this.backgroundColor = this.brushType == this.context.brushToolbar.store.getValue("type")
                  ? this.backgroundColorOn
                  : this.backgroundColorOff
              },
              label: { text: "Clear" },
              brushType: VEBrushType.SHROOM_CLEAR,
            },
          },
          {
            name: "button_category-shader_type-config",
            template: VEComponents.get("category-button"),
            layout: VELayouts.get("horizontal-item"),
            config: {
              backgroundColor: VETheme.color.primary,
              backgroundColorOn: ColorUtil.fromHex(VETheme.color.accent).toGMColor(),
              backgroundColorOff: ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
              backgroundMargin: { top: 1, bottom: 1, left: 1, right: 1 },
              callback: function() { 
                var type = this.context.brushToolbar.store.get("type")
                if (type.get() != this.brushType) {
                  type.set(this.brushType)
                }
              },
              updateCustom: function() {
                this.backgroundColor = this.brushType == this.context.brushToolbar.store.getValue("type")
                  ? this.backgroundColorOn
                  : this.backgroundColorOff
              },
              label: { text: "Config" },
              brushType: VEBrushType.SHROOM_CONFIG,
            },
          },
        ]),
        "grid": new Array(Struct, [
          {
            name: "button_category-grid_type-channel",
            template: VEComponents.get("category-button"),
            layout: VELayouts.get("horizontal-item"),
            config: {
              backgroundColor: VETheme.color.primary,
              backgroundColorOn: ColorUtil.fromHex(VETheme.color.accent).toGMColor(),
              backgroundColorOff: ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
              backgroundMargin: { top: 1, bottom: 1, left: 1, right: 1 },
              callback: function() { 
                var type = this.context.brushToolbar.store.get("type")
                if (type.get() != this.brushType) {
                  type.set(this.brushType)
                }
              },
              updateCustom: function() {
                this.backgroundColor = this.brushType == this.context.brushToolbar.store.getValue("type")
                  ? this.backgroundColorOn
                  : this.backgroundColorOff
              },
              label: { text: "Channel" },
              brushType: VEBrushType.GRID_CHANNEL,
            },
          },
          {
            name: "button_category-grid_type-separator",
            template: VEComponents.get("category-button"),
            layout: VELayouts.get("horizontal-item"),
            config: {
              backgroundColor: VETheme.color.primary,
              backgroundColorOn: ColorUtil.fromHex(VETheme.color.accent).toGMColor(),
              backgroundColorOff: ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
              backgroundMargin: { top: 1, bottom: 1, left: 1, right: 1 },
              callback: function() { 
                var type = this.context.brushToolbar.store.get("type")
                if (type.get() != this.brushType) {
                  type.set(this.brushType)
                }
              },
              updateCustom: function() {
                this.backgroundColor = this.brushType == this.context.brushToolbar.store.getValue("type")
                  ? this.backgroundColorOn
                  : this.backgroundColorOff
              },
              label: { text: "Separator" },
              brushType: VEBrushType.GRID_SEPARATOR,
            },
          },
          {
            name: "button_category-grid_type-config",
            template: VEComponents.get("category-button"),
            layout: VELayouts.get("horizontal-item"),
            config: {
              backgroundColor: VETheme.color.primary,
              backgroundColorOn: ColorUtil.fromHex(VETheme.color.accent).toGMColor(),
              backgroundColorOff: ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
              backgroundMargin: { top: 1, bottom: 1, left: 1, right: 1 },
              callback: function() { 
                var type = this.context.brushToolbar.store.get("type")
                if (type.get() != this.brushType) {
                  type.set(this.brushType)
                }
              },
              updateCustom: function() {
                this.backgroundColor = this.brushType == this.context.brushToolbar.store.getValue("type")
                  ? this.backgroundColorOn
                  : this.backgroundColorOff
              },
              label: { text: "Config" },
              brushType: VEBrushType.GRID_CONFIG,
            },
          },
        ]),
        "view": new Array(Struct, [
          {
            name: "button_category-view_type-wallpaper",
            template: VEComponents.get("category-button"),
            layout: VELayouts.get("horizontal-item"),
            config: {
              backgroundColor: VETheme.color.primary,
              backgroundColorOn: ColorUtil.fromHex(VETheme.color.accent).toGMColor(),
              backgroundColorOff: ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
              backgroundMargin: { top: 1, bottom: 1, left: 1, right: 1 },
              callback: function() { 
                var type = this.context.brushToolbar.store.get("type")
                if (type.get() != this.brushType) {
                  type.set(this.brushType)
                }
              },
              updateCustom: function() {
                this.backgroundColor = this.brushType == this.context.brushToolbar.store.getValue("type")
                  ? this.backgroundColorOn
                  : this.backgroundColorOff
              },
              label: { text: "Wallpaper" },
              brushType: VEBrushType.VIEW_WALLPAPER,
            },
          },
          {
            name: "button_category-view_type-camera",
            template: VEComponents.get("category-button"),
            layout: VELayouts.get("horizontal-item"),
            config: {
              backgroundColor: VETheme.color.primary,
              backgroundColorOn: ColorUtil.fromHex(VETheme.color.accent).toGMColor(),
              backgroundColorOff: ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
              backgroundMargin: { top: 1, bottom: 1, left: 1, right: 1 },
              callback: function() { 
                var type = this.context.brushToolbar.store.get("type")
                if (type.get() != this.brushType) {
                  type.set(this.brushType)
                }
              },
              updateCustom: function() {
                this.backgroundColor = this.brushType == this.context.brushToolbar.store.getValue("type")
                  ? this.backgroundColorOn
                  : this.backgroundColorOff
              },
              label: { text: "Camera" },
              brushType: VEBrushType.VIEW_CAMERA,
            },
          },
          {
            name: "button_category-view_type-lyrics",
            template: VEComponents.get("category-button"),
            layout: VELayouts.get("horizontal-item"),
            config: {
              backgroundColor: VETheme.color.primary,
              backgroundColorOn: ColorUtil.fromHex(VETheme.color.accent).toGMColor(),
              backgroundColorOff: ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
              backgroundMargin: { top: 1, bottom: 1, left: 1, right: 1 },
              callback: function() { 
                var type = this.context.brushToolbar.store.get("type")
                if (type.get() != this.brushType) {
                  type.set(this.brushType)
                }
              },
              updateCustom: function() {
                this.backgroundColor = this.brushType == this.context.brushToolbar.store.getValue("type")
                  ? this.backgroundColorOn
                  : this.backgroundColorOff
              },
              label: { text: "Lyrics" },
              brushType: VEBrushType.VIEW_LYRICS,
            },
          },
          {
            name: "button_category-view_type-config",
            template: VEComponents.get("category-button"),
            layout: VELayouts.get("horizontal-item"),
            config: {
              backgroundColor: VETheme.color.primary,
              backgroundColorOn: ColorUtil.fromHex(VETheme.color.accent).toGMColor(),
              backgroundColorOff: ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
              backgroundMargin: { top: 1, bottom: 1, left: 1, right: 1 },
              callback: function() { 
                var type = this.context.brushToolbar.store.get("type")
                if (type.get() != this.brushType) {
                  type.set(this.brushType)
                }
              },
              updateCustom: function() {
                this.backgroundColor = this.brushType == this.context.brushToolbar.store.getValue("type")
                  ? this.backgroundColorOn
                  : this.backgroundColorOff
              },
              label: { text: "Config" },
              brushType: VEBrushType.VIEW_CONFIG,
            },
          },
        ]),
      }),
      timer: new Timer(FRAME_MS * GAME_FPS * 0.33, { loop: Infinity, randomize: true }),
      brushToolbar: brushToolbar,
      layout: layout,
      updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
      render: Callable.run(UIUtil.renderTemplates.get("renderDefault")),
      onInit: function() {
        this.collection = new UICollection(this, { layout: this.layout })
        var container = this
        var store = this.brushToolbar.store
        
        store.get("category").addSubscriber({ 
          name: this.name,
          callback: function(category, context) { 
            if (category == context.state.get("category")) {
              return
            }
            
            context.state.set("category", category)
            context.brushToolbar.store
              .get("type")
              .set(context.brushToolbar.categories
                .get(category)
                .getFirst())
          },
          data: container,
        })

        store.get("type").addSubscriber({ 
          name: this.name,
          callback: function(type, context) {
            //if (type == context.state.get("type")) {
            //  return
            //}

            data.items.forEach(function(item) { item.free() }).clear() ///@todo replace with remove lambda
            data.collection.components.clear() ///@todo replace with remove lambda
            context.state
              .set("type", type)
              .get(context.brushToolbar.store.getValue("category"))
              .forEach(function(component, index, collection) {
                collection.add(new UIComponent(component))
              }, context.collection)
          },
          data: container
        })
      },
      onDestroy: function() {
        var store = this.brushToolbar.store
        store.get("category").removeSubscriber(this.name)
        store.get("type").removeSubscriber(this.name)
      },
    }
  },
  "brush-bar": function(name, brushToolbar, layout) {
    return {
      name: name,
      state: new Map(String, any, {
        "background-color": ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
      }),
      timer: new Timer(FRAME_MS * GAME_FPS * 0.33, { loop: Infinity, randomize: true }),
      brushToolbar: brushToolbar,
      layout: layout,
      updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
      render: Callable.run(UIUtil.renderTemplates.get("renderDefault")),
      items: {
        "label_brush-control-title": Struct.appendRecursiveUnique(
          {
            type: UIText,
            text: "Brushes",
            update: Callable.run(UIUtil.updateAreaTemplates.get("applyMargin")),
          },
          VEStyles.get("bar-title"),
          false
        ),
        "button_brush-control-load": Struct.appendRecursiveUnique(
          {
            type: UIButton,
            group: { index: 0, size: 2 },
            label: { text: "L" },
            align: { v: VAlign.CENTER, h: HAlign.RIGHT },
            update: Callable.run(UIUtil.updateAreaTemplates.get("groupByX")),
            onMousePressedLeft: function(event) {
              var type = this.context.brushToolbar.store.getValue("type")
              var saveTemplate = this.context.brushToolbar.editor.brushService.saveTemplate
              var promise = Beans.get(BeanVisuController).fileService.send(
                new Event("fetch-file-dialog")
                  .setData({
                    filename: "brush", 
                    extension: "json"
                  })
                  .setPromise(new Promise()
                    .setState({ 
                      callback: function(prototype, json, index, acc) {
                        var template = new prototype(json)
                        acc.saveTemplate(template)
                      },
                      acc: {
                        saveTemplate: saveTemplate,
                      },
                      steps: MAGIC_NUMBER_TASK,
                    })
                    .whenSuccess(function(result) {
                      var task = JSON.parserTask(result.data, this.state)
                      Beans.get(BeanVisuController).executor.add(task)
                      return task
                    }))
              )
            }
          },
          VEStyles.get("bar-button"),
          false
        ),
        "button_brush-control-save": Struct.appendRecursiveUnique(
          {
            type: UIButton,
            group: { index: 1, size: 2 },
            label: { text: "S" },
            update: Callable.run(UIUtil.updateAreaTemplates.get("groupByX")),
            onMousePressedLeft: function(event) {
              var type = this.context.brushToolbar.store.getValue("type")
              var templates = this.context.brushToolbar.editor.brushService.fetchTemplates(type)
              var data = JSON.stringify({
                "model": "Collection<io.alkapivo.visu.editor.api.VEBrushTemplate>",
                "data": Assert.isType(this.context.brushToolbar.editor.brushService
                  .fetchTemplates(type)
                  .getContainer(), GMArray),
              }, { pretty: true })

              Beans.get(BeanVisuController).fileService
                .send(new Event("save-file-sync")
                  .setData({
                    path: FileUtil.getPathToSaveWithDialog({ 
                      filename: "brush", 
                      extension: "json"
                    }),
                    data: data
                  }))
            }
          },
          VEStyles.get("bar-button"),
          false
        ),
      }
    }
  },
  "brush-view": function(name, brushToolbar, layout) {
    return {
      name: name,
      state: new Map(String, any, {
        "background-alpha": 1.0,
        "type": null,
        "background-color": ColorUtil.fromHex(VETheme.color.dark).toGMColor(),
        "empty-label": new UILabel({
          text: "Click to\nadd template",
          font: "font_inter_10_regular",
          color: VETheme.color.textShadow,
          align: { v: VAlign.CENTER, h: HAlign.CENTER },
        }),
        "components": new Array(Struct, [
          {
            name: "brush-test-1",
            template: VEComponents.get("brush-entry"),
            layout: VELayouts.get("brush-entry"),
            config: {
              image: {
                image: {
                  name: "texture_button",
                  blend: c_blue,
                },
              },
              label: { text: "brush-test-1" },
              button: { 
                sprite: {
                  name: "texture_ve_icon_trash",
                  blend: VETheme.color.textShadow,
                },
                callback: Callable.run(UIUtil.templates.get("removeUIItemfromUICollection"))
              },
            },
          },
          {
            name: "brush-test-2",
            template: VEComponents.get("brush-entry"),
            layout: VELayouts.get("brush-entry"),
            config: {
              image: {
                image: {
                  name: "texture_button",
                  blend: c_red,
                },
              },
              label: { text: "brush-test-2" },
              button: { 
                sprite: {
                  name: "texture_ve_icon_trash",
                  blend: VETheme.color.textShadow,
                },
                callback: Callable.run(UIUtil.templates.get("removeUIItemfromUICollection"))
              },
            },
          },
          {
            name: "brush-test-3",
            template: VEComponents.get("brush-entry"),
            layout: VELayouts.get("brush-entry"),
            config: {
              image: {
                image: {
                  name: "texture_button",
                  blend: c_red,
                },
              },
              label: { text: "brush-test-3" },
              button: { 
                sprite: {
                  name: "texture_ve_icon_trash",
                  blend: VETheme.color.textShadow,
                },
                callback: Callable.run(UIUtil.templates.get("removeUIItemfromUICollection"))
              },
            },
          },
          {
            name: "brush-test-4",
            template: VEComponents.get("brush-entry"),
            layout: VELayouts.get("brush-entry"),
            config: {
              image: {
                image: {
                  name: "texture_button",
                  blend: c_red,
                },
              },
              label: { text: "brush-test-4" },
              button: { callback: Callable.run(UIUtil.templates.get("removeUIItemfromUICollection")) },
            },
          },
          {
            name: "brush-test-5",
            template: VEComponents.get("brush-entry"),
            layout: VELayouts.get("brush-entry"),
            config: {
              image: {
                image: {
                  name: "texture_button",
                  blend: c_red,
                },
              },
              label: { text: "brush-test-5" },
              button: { callback: Callable.run(UIUtil.templates.get("removeUIItemfromUICollection")) },
            },
          },
          {
            name: "brush-test-6",
            template: VEComponents.get("brush-entry"),
            layout: VELayouts.get("brush-entry"),
            config: {
              image: {
                image: {
                  name: "texture_button",
                  blend: c_red,
                },
              },
              label: { text: "brush-test-6" },
              button: { callback: Callable.run(UIUtil.templates.get("removeUIItemfromUICollection")) },
            },
          },
        ])
      }),
      timer: new Timer(FRAME_MS * GAME_FPS * 0.33, { loop: Infinity, randomize: true }),
      brushToolbar: brushToolbar,
      layout: layout,
      scrollbarY: { align: HAlign.RIGHT },
      updateArea: Callable.run(UIUtil.updateAreaTemplates.get("scrollableY")),
      renderDefaultScrollable: new BindIntent(Callable.run(UIUtil.renderTemplates.get("renderDefaultScrollable"))),
      render: function() {
        this.renderDefaultScrollable()
        if (!Core.isType(this.collection, UICollection) 
          || this.collection.size() == 0) {
          this.state.get("empty-label").render(
            this.area.getX() + (this.area.getWidth() / 2),
            this.area.getY() + (this.area.getHeight() / 2)
          )
        }
      },
      onMouseWheelUp: Callable.run(UIUtil.mouseEventTemplates.get("scrollableOnMouseWheelUpY")),
      onMouseWheelDown: Callable.run(UIUtil.mouseEventTemplates.get("scrollableOnMouseWheelDownY")),
      onInit: function() {
        var container = this
        this.collection = new UICollection(this, { layout: this.layout })
        this.brushToolbar.store.get("type").addSubscriber({ 
          name: container.name,
          callback: function(type, data) {
            data.items.forEach(function(item) { item.free() }).clear() ///@todo replace with remove lambda
            data.collection.components.clear() ///@todo replace with remove lambda
            data.state.set("type", type)

            Assert.isType(data.brushToolbar.editor.brushService.templates
              .get(type), Array)
              .map(function(template) {
                return {
                  name: template.name,
                  template: VEComponents.get("brush-entry"),
                  layout: VELayouts.get("brush-entry"),
                  config: {
                    image: {
                      image: {
                        name: template.texture,
                        blend: template.color,
                      },
                    },
                    label: { 
                      text: template.name,
                      onMouseReleasedLeft: function() {
                        var template = this.context.brushToolbar.store.get("template")
                        if (!Core.isType(template.get(), VEBrushTemplate)
                          || template.get().name != this.brushTemplate.name) {
                          template.set(this.brushTemplate)
                        }
                      },
                      brushTemplate: template,
                    },
                    button: { 
                      sprite: {
                        name: "texture_ve_icon_trash",
                        blend: VETheme.color.textShadow,
                      },
                      callback: function() {
                        this.removeUIItemfromUICollection()
                        this.context.brushToolbar.editor.brushService
                          .removeTemplate(this.brushTemplate)
                      },
                      brushTemplate: template,
                      removeUIItemfromUICollection: new BindIntent(Callable
                        .run(UIUtil.templates.get("removeUIItemfromUICollection"))),
                    },
                  },
                }
              })
              .forEach(function(component, index, collection) {
                collection.add(new UIComponent(component))
              }, data.collection)
          },
          data: container
        })
      },
      onDestroy: function() {
        this.brushToolbar.store
          .get("type")
          .removeSubscriber(this.name)
      },
      onMouseReleasedLeft: function() {
        if (!Core.isType(this.collection, UICollection) || this.collection.size() == 0) {
          var type = this.brushToolbar.store.getValue("type")
          var template = new VEBrushTemplate({
            "name": "new brush template",
            "type": type,
            "color":"#FFFFFF",
            "texture":"texture_baron",
          })
          this.brushToolbar.editor.brushService.saveTemplate(template)
          this.brushToolbar.store.get("type").set(type)
          this.brushToolbar.store.get("template").set(template)
        }
      }

    }
  },
  "inspector-bar": function(name, brushToolbar, layout) {
    return {
      name: name,
      state: new Map(String, any, {
        "background-color": ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
      }),
      timer: new Timer(FRAME_MS * GAME_FPS * 0.33, { loop: Infinity, randomize: true }),
      brushToolbar: brushToolbar,
      layout: layout,
      updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
      render: Callable.run(UIUtil.renderTemplates.get("renderDefault")),
      items: {
        "label_inspector-control-title": Struct.appendRecursiveUnique(
          {
            type: UIText,
            text: "Inspector",
            update: Callable.run(UIUtil.updateAreaTemplates.get("applyMargin")),
            onMouseReleasedLeft: function() {
              var view = this.context.brushToolbar.containers.get("ve-brush-toolbar_inspector-view")
              view.items.forEach(function(item) { item.free() }).clear() ///@todo replace with remove lambda
              view.collection.components.clear() ///@todo replace with remove lambda
              view.state
                .set("template", null)
                .set("brush", null)
                .set("store", null)
              this.context.brushToolbar.store.get("template").set(null)
              this.context.brushToolbar.store.get("brush").set(null)
            },
          },
          VEStyles.get("bar-title"),
          false
        ),
      }
    }
  },
  "inspector-view": function(name, brushToolbar, layout) {
    return {
      name: name,
      state: new Map(String, any, {
        "background-color": ColorUtil.fromHex(VETheme.color.dark).toGMColor(),
      }),
      timer: new Timer(FRAME_MS * GAME_FPS * 0.33, { loop: Infinity, randomize: true }),
      brushToolbar: brushToolbar,
      layout: layout,
      scrollbarY: { align: HAlign.RIGHT },
      updateArea: Callable.run(UIUtil.updateAreaTemplates.get("scrollableY")),
      render: Callable.run(UIUtil.renderTemplates.get("renderDefaultScrollable")),
      onMouseWheelUp: Callable.run(UIUtil.mouseEventTemplates.get("scrollableOnMouseWheelUpY")),
      onMouseWheelDown: Callable.run(UIUtil.mouseEventTemplates.get("scrollableOnMouseWheelDownY")),
      onInit: function() {
        var container = this
        this.collection = new UICollection(this, { layout: container.layout })
        this.brushToolbar.store.get("template").addSubscriber({ 
          name: this.name,
          callback: function(template, data) {
            if (!Optional.is(template)) {
              data.items.forEach(function(item) { item.free() }).clear() ///@todo replace with remove lambda
              data.collection.components.clear() ///@todo replace with remove lambda
              data.state
                .set("template", null)
                .set("brush", null)
                .set("store", null)
              return
            }

            var brush = new VEBrush(template)
            data.items.forEach(function(item) { item.free() }).clear() ///@todo replace with remove lambda
            data.collection.components.clear() ///@todo replace with remove lambda
            data.brushToolbar.store.get("brush").set(brush)
            data.state
              .set("template", template)
              .set("brush", brush)
              .set("store", brush.store)

            data.updateArea()
            data.addUIComponents(brush.components
              .map(function(component) {
                return new UIComponent(component)
              }),
              new UILayout({
                area: data.area,
                width: function() { return this.area.getWidth() },
              })
            )
          },
          data: container
        })
      },
      onDestroy: function() {
        var store = this.brushToolbar.store
        store.get("template").removeSubscriber(this.name)
        store.get("type").removeSubscriber(this.name)
      },
    }
  },
  "control": function(name, brushToolbar, layout) {
    return {
      name: name,
      state: new Map(String, any, {
        "background-color": ColorUtil.fromHex(VETheme.color.dark).toGMColor(),
        "components": new Array(Struct, [
          {
            name: "button_control-preview",
            template: VEComponents.get("category-button"),
            layout: VELayouts.get("horizontal-item"),
            config: {
              colorHoverOver: VETheme.color.accentShadow,
              colorHoverOut: VETheme.color.primaryShadow,
              backgroundColor: VETheme.color.primaryShadow,
              backgroundMargin: { top: 1, bottom: 1, left: 1, right: 1 },
              label: { text: "Preview" },
              callback: function() { 
                var brushToolbar = this.context.brushToolbar
                var brush = brushToolbar.store.getValue("brush")
                if (!Core.isType(brush, VEBrush)) {
                  return
                }
                
                Callable.run(
                  Struct.get(TRACK_EVENT_HANDLERS, brush.type), 
                  brush.toTemplate().properties
                )
              },
              onMouseHoverOver: function(event) {
                this.backgroundColor = ColorUtil.fromHex(this.colorHoverOver).toGMColor()
              },
              onMouseHoverOut: function(event) {
                this.backgroundColor = ColorUtil.fromHex(this.colorHoverOut).toGMColor()
              },
            },
          },
          {
            name: "button_control-save",
            template: VEComponents.get("category-button"),
            layout: VELayouts.get("horizontal-item"),
            config: {
              colorHoverOver: VETheme.color.accentShadow,
              colorHoverOut: VETheme.color.primaryShadow,
              backgroundColor: VETheme.color.primaryShadow,
              backgroundMargin: { top: 1, bottom: 1, left: 1, right: 1 },
              label: { text: "Save" },
              callback: function() { 
                var brushToolbar = this.context.brushToolbar
                var template = brushToolbar.containers
                  .get("ve-brush-toolbar_inspector-view").state
                  .get("brush")
                  .toTemplate()

                brushToolbar.editor.brushService
                  .saveTemplate(template)
                brushToolbar.store
                  .get("type")
                  .set(template.type)
              },
              onMouseHoverOver: function(event) {
                this.backgroundColor = ColorUtil.fromHex(this.colorHoverOver).toGMColor()
              },
              onMouseHoverOut: function(event) {
                this.backgroundColor = ColorUtil.fromHex(this.colorHoverOut).toGMColor()
              },
            },
            
          }
        ]),
      }),
      timer: new Timer(FRAME_MS * GAME_FPS * 0.33, { loop: Infinity, randomize: true }),
      brushToolbar: brushToolbar,
      layout: layout,
      updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
      render: Callable.run(UIUtil.renderTemplates.get("renderDefault")),
      onInit: function() {
        this.collection = new UICollection(this, { layout: this.layout })
        this.state.get("components")
          .forEach(function(component, index, collection) {
            collection.add(new UIComponent(component))
          }, this.collection)
      },
    }
  },
})
#macro VisuBrushContainers global.__VisuBrushContainers


///@param {VisuEditor}
function VEBrushToolbar(_editor) constructor {

  ///@type {VisuEditor}
  editor = Assert.isType(_editor, VisuEditor)

  ///@type {UIService}
  uiService = Assert.isType(this.editor.uiService, UIService)

  ///@type {?UILayout}
  layout = null

  ///@type {Map<String, Containers>}
  containers = new Map(String, UI)

  ///@type {Store}
  store = new Store({
    "category": {
      type: String,
      value: "shroom",
    },
    "type": {
      type: String,
      value: VEBrushType.SHROOM_CLEAR,
    },
    "template": {
      type: Optional.of(VEBrushTemplate),
      value: null,
    },
    "brush": {
      type: Optional.of(VEBrush),
      value: null,
    }
  })

  ///@type {Map<String, Array>}
  categories = new Map(String, Array, {
    "shader": new Array(String, [ 
      VEBrushType.SHADER_SPAWN, 
      VEBrushType.SHADER_OVERLAY, 
      VEBrushType.SHADER_CLEAR, 
      VEBrushType.SHADER_CONFIG 
    ]),
    "shroom": new Array(String, [ 
      VEBrushType.SHROOM_SPAWN, 
      VEBrushType.SHROOM_CLEAR, 
      VEBrushType.SHROOM_CONFIG 
    ]),
    "grid": new Array(String, [ 
      VEBrushType.GRID_CHANNEL, 
      VEBrushType.GRID_CONFIG, 
      VEBrushType.GRID_SEPARATOR 
    ]),
    "view": new Array(String, [ 
      VEBrushType.VIEW_WALLPAPER, 
      VEBrushType.VIEW_CAMERA, 
      VEBrushType.VIEW_CONFIG 
    ]),
  })

  ///@private
  ///@param {UIlayout} parent
  ///@return {UILayout}
  factoryLayout = function(parent) {
    return new UILayout(
      {
        name: "brush-toolbar",
        staticHeight: new BindIntent(function() {
          var type = Struct.get(this.nodes, "type")
          var brushBar = Struct.get(this.nodes, "brush-bar")
          var inspectorBar = Struct.get(this.nodes, "inspector-bar")
          var control = Struct.get(this.nodes, "control")
          return type.height() + brushBar.height() + inspectorBar.height() + control.height()
        }),
        nodes: {
          "accordion": {},
          "category": {
            name: "brush-toolbar.category",
            x: function() { return this.context.x() - this.width() - 1 },
            width: function() { return 24 },
            height: function() { return 420 },
          },
          "type": {
            name: "brush-toolbar.type",
            height: function() { return 40 },
          },
          "brush-bar": {
            name: "brush-toolbar.brushBar",
            y: function() { return this.context.nodes.type.bottom() },
            height: function() { return 16 },
          },
          "brush-view": {
            name: "brush-toolbar.brushView",
            percentageHeight: 0.23,
            margin: { top: 1, bottom: 1, left: 0, right: 10 },
            x: function() { return this.context.x() + this.margin.left },
            width: function() { return this.context.width()
               - this.margin.left - this.margin.right },
            y: function() { return this.margin.top
               + Struct.get(this.context.nodes, "brush-bar").bottom() },
            height: function() { return ceil((this.context.height() 
               - this.context.staticHeight()) * this.percentageHeight) 
               - this.margin.top - this.margin.bottom },
          },
          "inspector-bar": {
            name: "brush-toolbar.inspector-bar",
            y: function() { return Struct.get(this.context.nodes, "brush-view").bottom() },
            height: function() { return 16 },
          },
          "inspector-view": {
            name: "brush-toolbar.inspector-view",
            percentageHeight: 0.77,
            margin: { top: 1, bottom: 1, left: 0, right: 10 },
            x: function() { return this.context.x() + this.margin.left },
            width: function() { return this.context.width()
               - this.margin.left - this.margin.right },
            y: function() { return this.margin.top
              + Struct.get(this.context.nodes, "inspector-bar").bottom() },
            height: function() { return ceil((this.context.height() 
              - this.context.staticHeight()) * this.percentageHeight) 
              - this.margin.top - this.margin.bottom },
          },
          "control": {
            name: "brush-toolbar.category",
            y: function() { return Struct.get(this.context.nodes, "inspector-view").bottom() },
            height: function() { return 40 },
          }
        }
      },
      parent
    )
  }

  ///@private
  ///@param {UIlayout} parent
  ///@return {Map<String, UI>}
  factoryContainers = function(parent) {
    this.layout = this.factoryLayout(parent)
    var brushToolbar = this
    var containers = new Map(String, UI)
    VisuBrushContainers.forEach(function(template, name, acc) {
      var layout = Assert.isType(Struct.get(acc.brushToolbar.layout.nodes, name), UILayout)
      var ui = new UI(template($"ve-brush-toolbar_{name}", acc.brushToolbar, layout))
      acc.containers.add(ui, $"ve-brush-toolbar_{name}")
    }, { containers: containers, brushToolbar: brushToolbar })
    return containers
  }

  ///@type {EventPump}
  dispatcher = new EventPump(this, new Map(String, Callable, {
    "open": function(event) {
      this.containers = this.factoryContainers(event.data.layout)
      var context = this
      var keys = GMArray.sort(this.containers.keys().getContainer())
      IntStream.forEach(0, VisuBrushContainers.size(), function(iterator, index, acc) {
        acc.uiService.send(new Event("add", {
          container: acc.containers.get(acc.keys[iterator]),
          replace: true,
        }))
      }, {
        keys: keys,
        uiService: context.uiService,
        containers: context.containers,
      })
    },
    "close": function(event) {
      var context = this
      this.containers.forEach(function (container, key, uiService) {
        uiService.send(new Event("remove", { 
          name: key, 
          quiet: true,
        }))
      }, this.uiService).clear()
    },
  }))

  ///@param {Event} event
  ///@return {?Promise}
  send = method(this, EventPumpUtil.send())

  ///@return {VEBrushToolbar}
  update = function() { 
    this.dispatcher.update()
    return this
  }
}
