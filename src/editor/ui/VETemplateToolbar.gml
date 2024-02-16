///@package io.alkapivo.visu.editor.ui

///@todo move to VEBrushToolbar
///@static
///@type {Map<String, Callable>}
global.__VisuTemplateContainers = new Map(String, Callable, {
  "type": function(name, templateToolbar, layout) {
    return {
      name: name,
      state: new Map(String, any, {
        "background-alpha": 1.0,
        "background-color": ColorUtil.fromHex(VETheme.color.dark).toGMColor(),
        "types": new Array(Struct, [
          {
            name: "button_type-shader",
            template: VEComponents.get("category-button"),
            layout: VELayouts.get("horizontal-item"),
            config: {
              backgroundColor: VETheme.color.primary,
              backgroundColorOn: ColorUtil.fromHex(VETheme.color.accent).toGMColor(),
              backgroundColorOff: ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
              backgroundMargin: { top: 4, bottom: 4, right: 1, left: 5 },
              callback: function() { 
                this.context.templateToolbar.store
                  .get("type")
                  .set(this.templateType)
                
                this.context.templateToolbar.store
                  .get("template")
                  .set(null)
              },
              updateCustom: function() {
                this.backgroundColor = this.templateType == this.context.templateToolbar.store.getValue("type")
                  ? this.backgroundColorOn
                  : this.backgroundColorOff
              },
              label: { text: "Shader" },
              templateType: VETemplateType.SHADER,
            },
          },
          {
            name: "button_type-shroom",
            template: VEComponents.get("category-button"),
            layout: VELayouts.get("horizontal-item"),
            config: {
              backgroundColor: VETheme.color.primary,
              backgroundColorOn: ColorUtil.fromHex(VETheme.color.accent).toGMColor(),
              backgroundColorOff: ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
              backgroundMargin: { top: 4, bottom: 4, right: 5, left: 1 },
              callback: function() { 
                this.context.templateToolbar.store
                  .get("type")
                  .set(this.templateType)
                
                this.context.templateToolbar.store
                  .get("template")
                  .set(null)
              },
              updateCustom: function() {
                this.backgroundColor = this.templateType == this.context.templateToolbar.store.getValue("type")
                  ? this.backgroundColorOn
                  : this.backgroundColorOff
              },
              label: { text: "Shroom" },
              templateType: VETemplateType.SHROOM,
            },
          },
        ])
      }),
      timer: new Timer(FRAME_MS * GAME_FPS * 0.33, { loop: Infinity, shuffle: true }),
      templateToolbar: templateToolbar,
      layout: layout,
      updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
      render: Callable.run(UIUtil.renderTemplates.get("renderDefault")),
      onInit: function() {
        var container = this
        this.collection = new UICollection(this, { layout: this.layout })
        this.state
          .set("store", this.templateToolbar.store)
          .get("types")
          .forEach(function(component, index, collection) {
            collection.add(new UIComponent(component))
          }, this.collection)
      },
    }
  },
  "add": function(name, templateToolbar, layout) {
    return {
      name: name,
      state: new Map(String, any, {
        "background-alpha": 1.0,
        "background-color": ColorUtil.fromHex(VETheme.color.dark).toGMColor(),
        "template_shader": new Array(Struct, [
          {
            name: "text-field_new-shader-template_name",
            template: VEComponents.get("text-field"),
            layout: VELayouts.get("text-field"),
            config: {
              layout: { type: UILayoutType.VERTICAL },
              label: { text: "Name" },
              field: { store: { key: "name" } },
            },
          },
          {
            name: "text-field_new-shader-template_shader",
            template: VEComponents.get("spin-select"),
            layout: VELayouts.get("spin-select"),
            config: { 
              layout: { type: UILayoutType.VERTICAL },
              label: { text: "Shader" },
              previous: { store: { key: "shader" } },
              preview: Struct.appendRecursive({ 
                store: { key: "shader" },
              }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
              next: { store: { key: "shader" } },
            },
          },
          {
            name: "button_new-shader-template_add",
            template: VEComponents.get("button"),
            layout: VELayouts.get("button"),
            config: {
              layout: { type: UILayoutType.VERTICAL },
              backgroundColor: VETheme.color.accept,
              backgroundMargin: { top: 5, bottom: 5, left: 5, right: 5 },
              callback: function() { 
                Core.print("MOCK add shader template")
                var name = this.context.templateToolbar.store.getValue("name")
                var shader = this.context.templateToolbar.store.getValue("shader")
              },
              label: { text: "Add template" },
            },
          },
        ]),
        "template_shroom": new Array(Struct, [
          {
            name: "text-field_new-shroom-template_name",
            template: VEComponents.get("text-field"),
            layout: VELayouts.get("text-field"),
            config: {
              layout: { type: UILayoutType.VERTICAL },
              label: { text: "Name" },
              field: { store: { key: "name" } },
            },
          },
          {
            name: "button_new-shroom-template_add",
            template: VEComponents.get("button"),
            layout: VELayouts.get("button"),
            config: {
              layout: { type: UILayoutType.VERTICAL },
              backgroundColor: VETheme.color.accept,
              backgroundMargin: { top: 5, bottom: 5, left: 5, right: 5 },
              callback: function() { 
                Core.print("MOCK add shroom template")
                var name = this.context.templateToolbar.store.getValue("name")
              },
              label: { text: "Add template" },
            },
          },
        ]),
      }),
      timer: new Timer(FRAME_MS * GAME_FPS * 0.33, { loop: Infinity, shuffle: true }),
      templateToolbar: templateToolbar,
      layout: layout,
      updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
      updateCustom: function() {
        ///@hack
        this.layout.context.nodes.add.__height = this.fetchViewHeight()
      },
      render: Callable.run(UIUtil.renderTemplates.get("renderDefault")),
      onInit: function() {
        var container = this
        this.collection = new UICollection(this, { layout: this.layout })
        this.templateToolbar.store.get("type").addSubscriber({ 
          name: container.name,
          callback: function(type, data) {
            data.items.forEach(function(item) { item.free() }).clear() ///@todo replace with remove lambda
            data.collection.components.clear() ///@todo replace with remove lambda
            data.state.set("store", data.templateToolbar.store)
            data.addUIComponents(data.state.get(type)
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
        this.templateToolbar.store
          .get("type")
          .removeSubscriber(this.name)
      },
    }
  },
  "template-bar": function(name, templateToolbar, layout) {
    return {
      name: name,
      state: new Map(String, any, {
        "background-alpha": 1.0,
        "background-color": ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
      }),
      timer: new Timer(FRAME_MS * GAME_FPS * 0.33, { loop: Infinity, shuffle: true }),
      templateToolbar: templateToolbar,
      layout: layout,
      updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
      render: Callable.run(UIUtil.renderTemplates.get("renderDefault")),
      items: {
        "label_template-title": Struct.appendRecursiveUnique(
          {
            type: UIText,
            text: "Templates",
            update: Callable.run(UIUtil.updateAreaTemplates.get("applyMargin")),
          },
          VEStyles.get("bar-title"),
          false
        ),
        "button_template-load": Struct.appendRecursiveUnique(
          {
            type: UIButton,
            group: { index: 0, size: 2 },
            label: { text: "L" },
            align: { v: VAlign.CENTER, h: HAlign.RIGHT },
            update: Callable.run(UIUtil.updateAreaTemplates.get("groupByX")),
            onMousePressedLeft: function(event) {
              Core.print("MOCK templates load")
            }
          },
          VEStyles.get("bar-button"),
          false
        ),
        "button_template-save": Struct.appendRecursiveUnique(
          {
            type: UIButton,
            group: { index: 1, size: 2 },
            label: { text: "S" },
            update: Callable.run(UIUtil.updateAreaTemplates.get("groupByX")),
            onMousePressedLeft: function(event) {
              Core.print("MOCK templates save")
              var controller = Beans.get(BeanVisuController)
              var type = this.context.templateToolbar.store.getValue("type")
              var templates = null
              var model = null
              var filename = null
              switch (type) {
                case VETemplateType.SHADER:
                  templates = controller.shaderPipeline.templates
                  model = "Collection<io.alkapivo.core.service.shader.ShaderTemplate>"
                  filename = "shader"
                  break
                case VETemplateType.SHROOM:
                  templates = controller.shroomService.templates
                  model = "Collection<io.alkapivo.visu.service.shroom.ShroomTemplate>"
                  filename = "shroom"
                  break
                default:
                  Logger.error(
                    "VETemplateToolbar", 
                    $"Dispatcher for type '{template.type}' wasn't found"
                  )
                  break
              }
              
              if (!Core.isType(templates, Collection)) {
                return
              }

              var struct = {}
              templates.forEach(function(template, iterator, struct) {
                Struct.set(struct, template.name, template)
              }, struct)

              var data = JSON.stringify({
                "model": model,
                "data": struct,
              }, { pretty: true })

              Beans.get(BeanVisuController).fileService
                .send(new Event("save-file-sync")
                  .setData({
                    path: FileUtil.getPathToSaveWithDialog({ 
                      filename: filename, 
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
  "template-view": function(name, templateToolbar, layout) {
    return {
      name: name,
      state: new Map(String, any, {
        "background-alpha": 1.0,
        "background-color": ColorUtil.fromHex(VETheme.color.dark).toGMColor(),
      }),
      timer: new Timer(FRAME_MS * GAME_FPS * 0.33, { loop: Infinity, shuffle: true }),
      templateToolbar: templateToolbar,
      layout: layout,
      updateArea: Callable.run(UIUtil.updateAreaTemplates.get("scrollableY")),
      yOffset: null,
      updateCustom: function() {
        if (this.yOffset == null) {
          this.yOffset = this.offset.y
        }

        if (this.yOffset != this.offset.y) {
          Logger.debug("template-view", $"prev {this.yOffset}, curr {this.offset.y}, h {this.area.getHeight()}, hv: {this.fetchViewHeight()}")
        }

        this.yOffset = this.offset.y
      },
      render: Callable.run(UIUtil.renderTemplates.get("renderDefaultScrollable")),
      onMouseWheelUp: Callable.run(UIUtil.mouseEventTemplates.get("scrollableOnMouseWheelUpY")),
      onMouseWheelDown: Callable.run(UIUtil.mouseEventTemplates.get("scrollableOnMouseWheelDownY")),
      onInit: function() {
        var container = this
        this.collection = new UICollection(this, { layout: this.layout })
        this.templateToolbar.store.get("type").addSubscriber({ 
          name: container.name,
          callback: function(type, data) {
            data.items.forEach(function(item) { item.free() }).clear() ///@todo replace with remove lambda
            data.collection.components.clear() ///@todo replace with remove lambda
            switch (type) {
              case VETemplateType.SHADER:
                var components = Beans.get(BeanVisuController).shaderPipeline.templates
                  .map(function(template, name) {
                    return {
                      name: template.name,
                      template: VEComponents.get("template-entry"),
                      layout: VELayouts.get("template-entry"),
                      config: {
                        label: { 
                          text: template.name,
                          onMouseReleasedLeft: function() {
                            Core.print("MOCK template shader left press", this.templateName)
                            var shader = Beans.get(BeanVisuController).shaderPipeline.templates
                              .get(this.templateName)
                            if (!Core.isType(shader, ShaderTemplate)) {
                              return
                            }

                            Struct.set(shader, "type", VETemplateType.SHADER)
                            this.context.templateToolbar.store
                              .get("template")
                              .set(new VETemplate(shader))
                          },
                          templateName: template.name,
                        },
                        button: { 
                          sprite: {
                            name: "texture_ve_icon_trash",
                            blend: VETheme.color.textShadow,
                          },
                          callback: function() {
                            this.removeUIItemfromUICollection()
                            Beans.get(BeanVisuController).shaderPipeline.templates
                              .remove(this.templateName)
                          },
                          templateName: template.name,
                          removeUIItemfromUICollection: new BindIntent(Callable
                            .run(UIUtil.templates.get("removeUIItemfromUICollection"))),
                        },
                      },
                    }
                  }, null, String, Struct)
                
                var keys = GMArray.sort(components.keys().getContainer())
                IntStream.forEach(0, components.size(), function(iterator, index, acc) {
                  var component = acc.components.get(acc.keys[iterator])
                  acc.collection.add(new UIComponent(component))
                }, {
                  keys: keys,
                  components: components,
                  collection: data.collection,
                })
                break
              case VETemplateType.SHROOM:
                var components = Beans.get(BeanVisuController).shroomService.templates
                  .map(function(template, name) {
                    return {
                      name: template.name,
                      template: VEComponents.get("template-entry"),
                      layout: VELayouts.get("template-entry"),
                      config: {
                        label: { 
                          text: template.name,
                          onMouseReleasedLeft: function() {
                            Core.print("MOCK template shroom left press")
                            var shroom = Beans.get(BeanVisuController).shroomService.templates
                              .get(this.templateName)
                            if (!Core.isType(shroom, ShroomTemplate)) {
                              return
                            }

                            Struct.set(shroom, "type", VETemplateType.SHROOM)
                            this.context.templateToolbar.store
                              .get("template")
                              .set(new VETemplate(shroom))
                          },
                          templateName: template.name,
                        },
                        button: { 
                          sprite: {
                            name: "texture_ve_icon_trash",
                            blend: VETheme.color.textShadow,
                          },
                          callback: function() {
                            this.removeUIItemfromUICollection()
                            Beans.get(BeanVisuController).shaderPipeline.templates
                              .remove(this.templateName)
                          },
                          templateName: template.name,
                          removeUIItemfromUICollection: new BindIntent(Callable
                            .run(UIUtil.templates.get("removeUIItemfromUICollection"))),
                        },
                      },
                    }
                  }, null, String, Struct)

                var keys = GMArray.sort(components.keys().getContainer())
                IntStream.forEach(0, components.size(), function(iterator, index, acc) {
                  var component = acc.components.get(acc.keys[iterator])
                  acc.collection.add(new UIComponent(component))
                }, {
                  keys: keys,
                  components: components,
                  collection: data.collection,
                })
                break
              default:
                Logger.error(
                  "VETemplateToolbar", 
                  $"template-view dispatcher for type '{type}' wasn't found"
                )
                break
            }
          },
          data: container
        })
      },
      onDestroy: function() {
        this.templateToolbar.store
          .get("type")
          .removeSubscriber(this.name)
      },
    }
  },
  "inspector-bar": function(name, templateToolbar, layout) {
    return {
      name: name,
      state: new Map(String, any, {
        "background-alpha": 1.0,
        "background-color": ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
      }),
      timer: new Timer(FRAME_MS * GAME_FPS * 0.33, { loop: Infinity, shuffle: true }),
      templateToolbar: templateToolbar,
      layout: layout,
      updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
      render: Callable.run(UIUtil.renderTemplates.get("renderDefault")),
      items: {
        "label_inspector-bar-title": Struct.appendRecursiveUnique(
          {
            type: UIText,
            text: "Template inspector",
            update: Callable.run(UIUtil.updateAreaTemplates.get("applyMargin")),
          },
          VEStyles.get("bar-title"),
          false
        ),
      }
    }
  },
  "inspector-view": function(name, templateToolbar, layout) {
    return {
      name: name,
      state: new Map(String, any, {
        "background-alpha": 1.0,
        "background-color": ColorUtil.fromHex(VETheme.color.dark).toGMColor(),
      }),
      timer: new Timer(FRAME_MS * GAME_FPS * 0.33, { loop: Infinity, shuffle: true }),
      templateToolbar: templateToolbar,
      layout: layout,
      updateArea: Callable.run(UIUtil.updateAreaTemplates.get("scrollableY")),
      render: Callable.run(UIUtil.renderTemplates.get("renderDefaultScrollable")),
      onMouseWheelUp: Callable.run(UIUtil.mouseEventTemplates.get("scrollableOnMouseWheelUpY")),
      onMouseWheelDown: Callable.run(UIUtil.mouseEventTemplates.get("scrollableOnMouseWheelDownY")),
      onInit: function() {
        var container = this
        this.collection = new UICollection(this, { layout: container.layout })
        this.templateToolbar.store.get("template").addSubscriber({ 
          name: container.name,
          callback: function(template, data) {
            if (!Core.isType(template, VETemplate)) {
              data.items.forEach(function(item) { item.free() }).clear() ///@todo replace with remove lambda
              data.collection.components.clear() ///@todo replace with remove lambda
              data.state
                .set("template", null)
                .set("store", null)
              return
            }

            data.items.forEach(function(item) { item.free() }).clear() ///@todo replace with remove lambda
            data.collection.components.clear() ///@todo replace with remove lambda
            data.state
              .set("template", template)
              .set("store", template.store)

            data.addUIComponents(template.components
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
        this.templateToolbar.store
          .get("template")
          .removeSubscriber(this.name)
      },
    }
  },
  "control": function(name, templateToolbar, layout) {
    return {
      name: name,
      state: new Map(String, any, {
        "background-alpha": 1.0,
        "background-color": ColorUtil.fromHex(VETheme.color.dark).toGMColor(),
        "components": new Array(Struct, [
          {
            name: "button_control-save",
            template: VEComponents.get("category-button"),
            layout: VELayouts.get("horizontal-item"),
            config: {
              backgroundColor: VETheme.color.accept,
              backgroundMargin: { top: 5, bottom: 5, left: 5, right: 5 },
              label: { text: "Save template" },
              callback: function() { 
                var template = this.context.templateToolbar.store
                  .getValue("template")
                if (!Core.isType(template, VETemplate)) {
                  return
                }

                var name = template.store.getValue("template-name")
                var serialized = template.serialize()
                var controller = Beans.get(BeanVisuController)
                switch (template.type) {
                  case VETemplateType.SHADER:
                    controller.shaderPipeline.templates.set(name, serialized)
                    break
                  case VETemplateType.SHROOM:
                    controller.shroomService.templates.set(name, serialized)
                    break
                  default:
                    Logger.error(
                      "VETemplateToolbar", 
                      $"Dispatcher for type '{template.type}' wasn't found"
                    )
                    break
                }

                ///@description send update event to subscribers
                this.context.templateToolbar.store
                  .get("type")
                  .set(template.type)
              },
            },
          }
        ]),
      }),
      timer: new Timer(FRAME_MS * GAME_FPS * 0.33, { loop: Infinity, shuffle: true }),
      templateToolbar: templateToolbar,
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
#macro VisuTemplateContainers global.__VisuTemplateContainers


///@param {VisuEditor}
function VETemplateToolbar(_editor) constructor {

  ///@type {VisuEditor}
  editor = Assert.isType(_editor, VisuEditor)

  ///@type {UIService}
  uiService = Assert.isType(this.editor.uiService, UIService)

  ///@type {?UILayout}
  layout = null

  ///@type {Map<String, UIContainers>}
  containers = new Map(String, UI)

  ///@type {Store}
  store = new Store({
    "type": {
      type: String,
      value: VETemplateType.SHADER,
    },
    "name": {
      type: String,
      value: "new template",
    },
    "shader": {
      type: String,
      value: "shader_hue",
      validate: function(value) {
        Assert.isType(ShaderUtil.fetch(value), Shader)
        Assert.isTrue(this.data.contains(value))
      },
      data: SHADERS.keys(),
    },
    "shroom": {
      type: String,
      value: "shroom-01",
      validate: function(value) {
        Assert.isTrue(Beans
          .get(BeanVisuController).shroomService.templates
          .contains(value))
      },
    },
    "template": {
      type: Optional.of(VETemplate),
      value: null,
    },
  })

  ///@type {Boolean}
  enable = true

  ///@private
  ///@param {UIlayout} parent
  ///@return {UILayout}
  factoryLayout = function(parent) {
    return new UILayout(
      {
        name: "template-toolbar",
        staticHeight: new BindIntent(function() {
          var type = Struct.get(this.nodes, "type")
          var add = Struct.get(this.nodes, "add")
          var templateBar = Struct.get(this.nodes, "template-bar")
          var inspectorBar = Struct.get(this.nodes, "inspector-bar")
          var control = Struct.get(this.nodes, "control")
          return type.height() + add.height() + templateBar.height() 
            + inspectorBar.height() + control.height()
        }),
        nodes: {
          "type": {
            name: "template-toolbar.type",
            y: function() { return this.context.y() },
            height: function() { return 32 },
          },
          "add": {
            name: "template-toolbar.add",
            y: function() { return this.context.nodes.type.bottom() },
            __height: 32,
            height: function() { return this.__height },
          },
          "template-bar": {
            name: "template-toolbar.template-bar",
            y: function() { return this.context.nodes.add.bottom() },
            height: function() { return 16 },
          },
          "template-view": {
            name: "template-toolbar.template-view",
            percentageHeight: 0.33,
            margin: { top: 2, bottom: 2, left: 10 },
            x: function() { return this.context.x() + this.margin.left },
            y: function() { return this.margin.top + Struct.get(this.context.nodes, "template-bar").bottom() },
            height: function() { return ceil((this.context.height() 
              - this.context.staticHeight()) * this.percentageHeight)
              - this.margin.top - this.margin.bottom },
          },
          "inspector-bar": {
            name: "template-toolbar.inspector-bar",
            y: function() { return Struct.get(this.context.nodes, "template-view").bottom() },
            height: function() { return 16 },
          },
          "inspector-view": {
            name: "template-toolbar.inspector-view",
            percentageHeight: 0.66,
            margin: { top: 2, bottom: 2, left: 10 },
            x: function() { return this.context.x() + this.margin.left },
            y: function() { return this.margin.top + Struct.get(this.context.nodes, "inspector-bar").bottom() },
            height: function() { return ceil((this.context.height() 
              - this.context.staticHeight()) * this.percentageHeight) 
              - this.margin.top - this.margin.bottom },
          },
          "control": {
            name: "template-toolbar.control",
            y: function() { return Struct.get(this.context.nodes, "inspector-view").bottom() },
            height: function() { return 32 },
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
    var templateToolbar = this
    var containers = new Map(String, UI)
    VisuTemplateContainers.forEach(function(template, name, acc) {
      var layout = Assert.isType(Struct.get(acc.templateToolbar.layout.nodes, name), UILayout)
      var ui = new UI(template($"ve-template-toolbar_{name}", acc.templateToolbar, layout))
      acc.containers.add(ui, $"ve-template-toolbar_{name}")
    }, { containers: containers, templateToolbar: templateToolbar })
    return containers
  }

  ///@type {EventPump}
  dispatcher = new EventPump(this, new Map(String, Callable, {
    "open": function(event) {
      this.containers = this.factoryContainers(event.data.layout)
      containers.forEach(function(container, key, uiService) {
        uiService.send(new Event("add", {
          container: container,
          replace: true,
        }))
      }, this.uiService)
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
    this.containers.forEach(function (container, key, enable) {
      container.enable = enable
    }, this.enable)
    return this
  }
}