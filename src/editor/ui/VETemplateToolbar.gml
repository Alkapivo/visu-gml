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
              backgroundColorHover: ColorUtil.fromHex(VETheme.color.accentShadow).toGMColor(),
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
                  : (this.isHoverOver ? this.backgroundColorHover : this.backgroundColorOff)
              },
              onMouseHoverOver: function(event) { },
              onMouseHoverOut: function(event) { },
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
              backgroundColorHover: ColorUtil.fromHex(VETheme.color.accentShadow).toGMColor(),
              backgroundColorOff: ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
              backgroundMargin: { top: 4, bottom: 4, right: 1, left: 1 },
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
                  : (this.isHoverOver ? this.backgroundColorHover : this.backgroundColorOff)
              },
              onMouseHoverOver: function(event) { },
              onMouseHoverOut: function(event) { },
              label: { text: "Shroom" },
              templateType: VETemplateType.SHROOM,
            },
          },
          {
            name: "button_type-bullet",
            template: VEComponents.get("category-button"),
            layout: VELayouts.get("horizontal-item"),
            config: {
              backgroundColor: VETheme.color.primary,
              backgroundColorOn: ColorUtil.fromHex(VETheme.color.accent).toGMColor(),
              backgroundColorHover: ColorUtil.fromHex(VETheme.color.accentShadow).toGMColor(),
              backgroundColorOff: ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
              backgroundMargin: { top: 4, bottom: 4, right: 1, left: 1 },
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
                  : (this.isHoverOver ? this.backgroundColorHover : this.backgroundColorOff)
              },
              onMouseHoverOver: function(event) { },
              onMouseHoverOut: function(event) { },
              label: { text: "Bullet" },
              templateType: VETemplateType.BULLET,
            },
          },
          {
            name: "button_type-lyrics",
            template: VEComponents.get("category-button"),
            layout: VELayouts.get("horizontal-item"),
            config: {
              backgroundColor: VETheme.color.primary,
              backgroundColorOn: ColorUtil.fromHex(VETheme.color.accent).toGMColor(),
              backgroundColorHover: ColorUtil.fromHex(VETheme.color.accentShadow).toGMColor(),
              backgroundColorOff: ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
              backgroundMargin: { top: 4, bottom: 4, right: 1, left: 1 },
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
                  : (this.isHoverOver ? this.backgroundColorHover : this.backgroundColorOff)
              },
              onMouseHoverOver: function(event) { },
              onMouseHoverOut: function(event) { },
              label: { text: "Lyrics" },
              templateType: VETemplateType.LYRICS,
            },
          },
          {
            name: "button_type-particle",
            template: VEComponents.get("category-button"),
            layout: VELayouts.get("horizontal-item"),
            config: {
              backgroundColor: VETheme.color.primary,
              backgroundColorOn: ColorUtil.fromHex(VETheme.color.accent).toGMColor(),
              backgroundColorHover: ColorUtil.fromHex(VETheme.color.accentShadow).toGMColor(),
              backgroundColorOff: ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
              backgroundMargin: { top: 4, bottom: 4, right: 1, left: 1 },
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
                  : (this.isHoverOver ? this.backgroundColorHover : this.backgroundColorOff)
              },
              onMouseHoverOver: function(event) { },
              onMouseHoverOut: function(event) { },
              label: { text: "Particle" },
              templateType: VETemplateType.PARTICLE,
            },
          },
          {
            name: "button_type-texture",
            template: VEComponents.get("category-button"),
            layout: VELayouts.get("horizontal-item"),
            config: {
              backgroundColor: VETheme.color.primary,
              backgroundColorOn: ColorUtil.fromHex(VETheme.color.accent).toGMColor(),
              backgroundColorHover: ColorUtil.fromHex(VETheme.color.accentShadow).toGMColor(),
              backgroundColorOff: ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
              backgroundMargin: { top: 4, bottom: 4, right: 1, left: 1 },
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
                  : (this.isHoverOver ? this.backgroundColorHover : this.backgroundColorOff)
              },
              onMouseHoverOver: function(event) { },
              onMouseHoverOut: function(event) { },
              label: { text: "Texture" },
              templateType: VETemplateType.TEXTURE,
            },
          },
        ])
      }),
      timer: new Timer(FRAME_MS * 2, { loop: Infinity, shuffle: true }),
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
                var name = this.context.templateToolbar.store.getValue("name")
                if (!Core.isType(name, String) || name == "") {
                  return
                }

                Beans.get(BeanVisuController).shaderPipeline.templates
                  .set(name, new ShaderTemplate(name, {
                    name: name,
                    shader: this.context.templateToolbar.store.getValue("shader"),
                  }))

                ///@description send update event to subscribers
                this.context.templateToolbar.store
                  .get("type")
                  .set(VETemplateType.SHADER)
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
                var name = this.context.templateToolbar.store.getValue("name")
                if (!Core.isType(name, String) || name == "") {
                  return
                }

                Beans.get(BeanVisuController).shroomService.templates
                  .set(name, new ShroomTemplate(name, {
                    name: name,
                    sprite: { name: "texture_baron" },
                  }))

                ///@description send update event to subscribers
                this.context.templateToolbar.store
                  .get("type")
                  .set(VETemplateType.SHROOM)
              },
              label: { text: "Add template" },
            },
          },
        ]),
        "template_bullet": new Array(Struct, [
          {
            name: "text-field_new-bullet-template_name",
            template: VEComponents.get("text-field"),
            layout: VELayouts.get("text-field"),
            config: {
              layout: { type: UILayoutType.VERTICAL },
              label: { text: "Name" },
              field: { store: { key: "name" } },
            },
          },
          {
            name: "button_new-bullet-template_add",
            template: VEComponents.get("button"),
            layout: VELayouts.get("button"),
            config: {
              layout: { type: UILayoutType.VERTICAL },
              backgroundColor: VETheme.color.accept,
              backgroundMargin: { top: 5, bottom: 5, left: 5, right: 5 },
              callback: function() { 
                var name = this.context.templateToolbar.store.getValue("name")
                if (!Core.isType(name, String) || name == "") {
                  return
                }

                Beans.get(BeanVisuController).bulletService.templates
                  .set(name, new BulletTemplate(name, {
                    name: name,
                    sprite: { name: "texture_baron" },
                  }))

                ///@description send update event to subscribers
                this.context.templateToolbar.store
                  .get("type")
                  .set(VETemplateType.BULLET)
              },
              label: { text: "Add template" },
            },
          },
        ]),
        "template_lyrics": new Array(Struct, [
          {
            name: "text-field_new-lyrics-template_name",
            template: VEComponents.get("text-field"),
            layout: VELayouts.get("text-field"),
            config: {
              layout: { type: UILayoutType.VERTICAL },
              label: { text: "Name" },
              field: { store: { key: "name" } },
            },
          },
          {
            name: "button_new-lyrics-template_add",
            template: VEComponents.get("button"),
            layout: VELayouts.get("button"),
            config: {
              layout: { type: UILayoutType.VERTICAL },
              backgroundColor: VETheme.color.accept,
              backgroundMargin: { top: 5, bottom: 5, left: 5, right: 5 },
              callback: function() { 
                var name = this.context.templateToolbar.store.getValue("name")
                if (!Core.isType(name, String) || name == "") {
                  return
                }

                Beans.get(BeanVisuController).lyricsService.templates
                  .set(name, new LyricsTemplate(name, { todo: "json" }))

                ///@description send update event to subscribers
                this.context.templateToolbar.store
                  .get("type")
                  .set(VETemplateType.LYRICS)
              },
              label: { text: "Add template" },
            },
          },
        ]),
        "template_particle": new Array(Struct, [
          {
            name: "text-field_new-particle-template_name",
            template: VEComponents.get("text-field"),
            layout: VELayouts.get("text-field"),
            config: {
              layout: { type: UILayoutType.VERTICAL },
              label: { text: "Name" },
              field: { store: { key: "name" } },
            },
          },
          {
            name: "button_new-particle-template_add",
            template: VEComponents.get("button"),
            layout: VELayouts.get("button"),
            config: {
              layout: { type: UILayoutType.VERTICAL },
              backgroundColor: VETheme.color.accept,
              backgroundMargin: { top: 5, bottom: 5, left: 5, right: 5 },
              callback: function() { 
                var name = this.context.templateToolbar.store.getValue("name")
                if (!Core.isType(name, String) || name == "") {
                  return
                }

                Beans.get(BeanVisuController).particleService.templates
                  .set(name, new ParticleTemplate(name, { todo: "json" }))

                ///@description send update event to subscribers
                this.context.templateToolbar.store
                  .get("type")
                  .set(VETemplateType.PARTICLE)
              },
              label: { text: "Add template" },
            },
          },
        ]),
        "template_texture": new Array(Struct, [
          {
            name: "text-field_new-texture-template_name",
            template: VEComponents.get("text-field"),
            layout: VELayouts.get("text-field"),
            config: {
              layout: { type: UILayoutType.VERTICAL },
              label: { text: "Name" },
              field: { store: { key: "name" } },
            },
          },
          {
            name: "text-field_new-texture-template_file",  
            template: VEComponents.get("text-field-button"),
            layout: VELayouts.get("text-field-button"),
            config: { 
              layout: { type: UILayoutType.VERTICAL },
              label: { text: "Texture" },
              field: { 
                read_only: true,
                updateCustom: function() {
                  var intent = this.context.state.get("store").getValue("texture-intent")
                  if (intent.file != "" && Core.isType(intent.file, String)) {
                    this.textField.setText(FileUtil.getFilenameFromPath(intent.file))
                  } else {
                    this.textField.setText("")
                  }
                },
              },
              button: { 
                label: { text: "Open" },
                callback: function() {
                  var path = FileUtil.getPathToOpenWithDialog({
                    description: "PNG, JPG, BMP file",
                    extension: "png;*.jpg;*.jpeg;*.bmp",
                  })
                  if (!FileUtil.fileExists(path)) {
                    return
                  }
      
                  var intent = this.context.state.get("store").getValue("texture-intent")
                  intent.file = path
                }},
            },
          },
          {
            name: "text-field_new-texture-template_frames",
            template: VEComponents.get("text-field"),
            layout: VELayouts.get("text-field"),
            config: {
              layout: { type: UILayoutType.VERTICAL },
              label: { text: "Frames" },
              field: { 
                store: { 
                  key: "texture-intent",
                  set: function(value) { 
                    var parsed = NumberUtil.parse(value)
                    if (!Core.isType(parsed, Number)) {
                      return
                    }
                    
                    var intent = this.context.context.state.get("store")
                      .getValue("texture-intent")
                    if (!Core.isType(intent, TextureIntent)) {
                      return
                    }

                    intent.frames = parsed
                  },
                  callback: function(value, data) { 
                    if (!Core.isType(value, TextureIntent)) {
                      return
                    }
                    
                    data.textField.setText(value.frames)
                  },
                }
              },
            },
          },
          {
            name: "button_new-texture-template_add",
            template: VEComponents.get("button"),
            layout: VELayouts.get("button"),
            config: {
              layout: { type: UILayoutType.VERTICAL },
              backgroundColor: VETheme.color.accept,
              backgroundMargin: { top: 5, bottom: 5, left: 5, right: 5 },
              callback: function() { 
                var name = this.context.templateToolbar.store.getValue("name")
                if (!Core.isType(name, String) 
                  || name == "" 
                  || String.contains(name, " ")) {
                  return
                }

                var store = this.context.state.get("store")
                var intent = store.getValue("texture-intent")
                if (!Core.isType(intent, TextureIntent) && intent.file == "") {
                  return
                }
                intent.name = name
                intent = new TextureIntent(intent)

                Beans.get(BeanTextureService)
                  .send(new Event("load-texture")
                    .setData(intent)
                    .setPromise(new Promise()
                      .setState(Assert.isType(store.get("type"), StoreItem))
                      .whenSuccess(function() {
                        this.state.set(VETemplateType.TEXTURE)
                      })))
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

        if (!Core.isType(this.templateToolbar.editor.trackService.track, Track)) {
          return
        }

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
                case VETemplateType.BULLET:
                  templates = controller.bulletService.templates
                  model = "Collection<io.alkapivo.visu.service.bullet.BulletTemplate>"
                  filename = "bullet"
                  break
                case VETemplateType.LYRICS:
                  templates = controller.lyricsService.templates
                  model = "Collection<io.alkapivo.visu.service.lyrics.LyricsTemplate>"
                  filename = "lyrics"
                  break
                case VETemplateType.PARTICLE:
                  templates = controller.particleService.templates
                  model = "Collection<io.alkapivo.core.service.particle.ParticleTemplate>"
                  filename = "particle"
                  break
                case VETemplateType.TEXTURE:
                  templates = Beans.get(BeanTextureService).templates
                  model = "Collection<io.alkapivo.core.service.texture.TextureTemplate>"
                  filename = "texture"
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
                Struct.set(struct, template.name, template.serialize())
              }, struct)

              var data = JSON.stringify({
                "model": model,
                "data": struct,
              }, { pretty: true })

              Beans.get(BeanVisuController).fileService
                .send(new Event("save-file-sync")
                  .setData(new File({
                    path: FileUtil.getPathToSaveWithDialog({ 
                      description: "JSON file",
                      filename: filename, 
                      extension: "json",
                    }),
                    data: data
                  })))
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

        this.yOffset = this.offset.y
      },
      updateVerticalSelectedIndex: new BindIntent(Callable.run(UIUtil.templates.get("updateVerticalSelectedIndex"))),
      renderItem: Callable.run(UIUtil.renderTemplates.get("renderItemDefaultScrollable")),
      __render: new BindIntent(Callable.run(UIUtil.renderTemplates.get("renderDefaultScrollable"))),
      render: function() {
        this.updateVerticalSelectedIndex(32.0)
        this.__render()
      },
      scrollbarY: { align: HAlign.LEFT },
      onMousePressedLeft: Callable.run(UIUtil.mouseEventTemplates.get("onMouseScrollbarY")),
      onMouseWheelUp: Callable.run(UIUtil.mouseEventTemplates.get("scrollableOnMouseWheelUpY")),
      onMouseWheelDown: Callable.run(UIUtil.mouseEventTemplates.get("scrollableOnMouseWheelDownY")),
      onInit: function() {
        var container = this
        this.collection = new UICollection(this, { layout: this.layout })

        if (!Core.isType(this.templateToolbar.editor.trackService.track, Track)) {
          return
        }

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
                          colorHoverOver: VETheme.color.accentShadow,
                          colorHoverOut: VETheme.color.primaryShadow,
                          onMouseReleasedLeft: function() {
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
                          colorHoverOver: VETheme.color.accentShadow,
                          colorHoverOut: VETheme.color.primaryShadow,
                          onMouseReleasedLeft: function() {
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
                            Beans.get(BeanVisuController).shroomService.templates
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
              case VETemplateType.BULLET:
                var components = Beans.get(BeanVisuController).bulletService.templates
                  .map(function(template, name) {
                    return {
                      name: template.name,
                      template: VEComponents.get("template-entry"),
                      layout: VELayouts.get("template-entry"),
                      config: {
                        label: { 
                          text: template.name,
                          colorHoverOver: VETheme.color.accentShadow,
                          colorHoverOut: VETheme.color.primaryShadow,
                          onMouseReleasedLeft: function() {
                            var bullet = Beans.get(BeanVisuController).bulletService.templates
                              .get(this.templateName)
                            if (!Core.isType(bullet, BulletTemplate)) {
                              return
                            }

                            Struct.set(bullet, "type", VETemplateType.BULLET)
                            this.context.templateToolbar.store
                              .get("template")
                              .set(new VETemplate(bullet))
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
                            Beans.get(BeanVisuController).bulletService.templates
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
              case VETemplateType.LYRICS:
                var components = Beans.get(BeanVisuController).lyricsService.templates
                  .map(function(template, name) {
                    return {
                      name: template.name,
                      template: VEComponents.get("template-entry"),
                      layout: VELayouts.get("template-entry"),
                      config: {
                        label: { 
                          text: template.name,
                          colorHoverOver: VETheme.color.accentShadow,
                          colorHoverOut: VETheme.color.primaryShadow,
                          onMouseReleasedLeft: function() {
                            var lyrics = Beans.get(BeanVisuController).lyricsService.templates
                              .get(this.templateName)
                            if (!Core.isType(lyrics, LyricsTemplate)) {
                              return
                            }

                            Struct.set(lyrics, "type", VETemplateType.LYRICS)
                            this.context.templateToolbar.store
                              .get("template")
                              .set(new VETemplate(lyrics))
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
                            Beans.get(BeanVisuController).lyricsService.templates
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
              case VETemplateType.PARTICLE:
                var components = Beans.get(BeanVisuController).particleService.templates
                  .map(function(template, name) {
                    return {
                      name: template.name,
                      template: VEComponents.get("template-entry"),
                      layout: VELayouts.get("template-entry"),
                      config: {
                        label: { 
                          text: template.name,
                          colorHoverOver: VETheme.color.accentShadow,
                          colorHoverOut: VETheme.color.primaryShadow,
                          onMouseReleasedLeft: function() {
                            var particle = Beans.get(BeanVisuController).particleService.templates
                              .get(this.templateName)
                            if (!Core.isType(particle, ParticleTemplate)) {
                              return
                            }

                            Struct.set(particle, "type", VETemplateType.PARTICLE)
                            this.context.templateToolbar.store
                              .get("template")
                              .set(new VETemplate(particle))
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
                            Beans.get(BeanVisuController).particleService.templates
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
              case VETemplateType.TEXTURE:
                var components = Beans.get(BeanTextureService).templates
                  .map(function(template, name) {
                    return {
                      name: template.name,
                      template: VEComponents.get("template-entry"),
                      layout: VELayouts.get("template-entry"),
                      config: {
                        label: { 
                          text: template.name,
                          colorHoverOver: VETheme.color.accentShadow,
                          colorHoverOut: VETheme.color.primaryShadow,
                          onMouseReleasedLeft: function() {
                            var texture = Beans.get(BeanTextureService).templates
                              .get(this.templateName)
                            if (!Core.isType(texture, TextureTemplate)) {
                              return
                            }

                            Struct.set(texture, "type", VETemplateType.TEXTURE)
                            this.context.templateToolbar.store
                              .get("template")
                              .set(new VETemplate(texture))
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
                            Beans.get(BeanTextureService).templates
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
            __update: new BindIntent(Callable.run(UIUtil.updateAreaTemplates.get("applyMargin"))),
            updateCustom: function() {
              this.__update()
              var context = MouseUtil.getClipboard()
              if (context == this) {
                this.updateLayout(MouseUtil.getMouseY())
              }
      
              if (context == this && !mouse_check_button(mb_left)) {
                MouseUtil.clearClipboard()
              }
            },
            updateLayout: new BindIntent(function(_position) {
              var titleBar = this.context.templateToolbar.uiService.find("ve-title-bar")
              var statusBar = this.context.templateToolbar.uiService.find("ve-status-bar")

              var typeNode = Struct.get(this.context.layout.context.nodes, "type")
              var addNode = Struct.get(this.context.layout.context.nodes, "add")
              var templateBarNode = Struct.get(this.context.layout.context.nodes, "template-bar")
              var templateViewNode = Struct.get(this.context.layout.context.nodes, "template-view")
              var controlNode = Struct.get(this.context.layout.context.nodes, "control")
              var inspectorNode = Struct.get(this.context.layout.context.nodes, "inspector-view")

              var nodes = this.context.templateToolbar.editor.accordion.layout.nodes
              var barEventInspectorNode = Struct.get(nodes, "bar_event-inspector")
              var viewEventInspectorNode = Struct.get(nodes, "view_event-inspector")
              var barTemplateToolbarNode = Struct.get(nodes, "bar_template-toolbar")
              var timelineNode = Beans.get(BeanVisuController).editor.layout.nodes.timeline
              
              var top = titleBar.layout.height() + titleBar.margin.top + titleBar.margin.bottom
                + barEventInspectorNode.height() + barEventInspectorNode.margin.top + barEventInspectorNode.margin.bottom
                + viewEventInspectorNode.height() + viewEventInspectorNode.margin.top + viewEventInspectorNode.margin.bottom
                + barTemplateToolbarNode.height() + barTemplateToolbarNode.margin.top + barTemplateToolbarNode.margin.bottom
                + typeNode.height() + typeNode.margin.top + typeNode.margin.bottom
                + addNode.height() + addNode.margin.top + addNode.margin.bottom
                + templateBarNode.height() + templateBarNode.margin.top + templateBarNode.margin.bottom
              var bottom = GuiHeight()
                -  statusBar.layout.height() 
                - (timelineNode.height() + timelineNode.margin.top + timelineNode.margin.bottom)
                - (controlNode.height() + controlNode.margin.top + controlNode.margin.bottom)
              var length = bottom - top
              var position = clamp(_position - top, 0, length)
              inspectorNode.percentageHeight = clamp((length - position) / length, 0.1, 0.9)
              templateViewNode.percentageHeight = 1.0 - inspectorNode.percentageHeight
            }),
            onMousePressedLeft: function(event) {
              MouseUtil.setClipboard(this)
            },
            onMouseReleasedLeft: function(event) {
              if (MouseUtil.getClipboard() == this) {
                MouseUtil.clearClipboard()
              }
            },
            onMouseHoverOver: function(event) {
              window_set_cursor(cr_size_ns)
            },
            onMouseHoverOut: function(event) {
              window_set_cursor(cr_default)
            },
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
      renderItem: Callable.run(UIUtil.renderTemplates.get("renderItemDefaultScrollable")),
      render: Callable.run(UIUtil.renderTemplates.get("renderDefaultScrollable")),
      scrollbarY: { align: HAlign.LEFT },
      onMouseOnLeft: Callable.run(UIUtil.mouseEventTemplates.get("onMouseScrollbarY")),
      onMousePressedLeft: Callable.run(UIUtil.mouseEventTemplates.get("onMouseScrollbarY")),
      onMouseWheelUp: Callable.run(UIUtil.mouseEventTemplates.get("scrollableOnMouseWheelUpY")),
      onMouseWheelDown: Callable.run(UIUtil.mouseEventTemplates.get("scrollableOnMouseWheelDownY")),
      onInit: function() {
        var container = this
        this.collection = new UICollection(this, { layout: container.layout })

        if (!Core.isType(this.templateToolbar.editor.trackService.track, Track)) {
          return
        }
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
                  case VETemplateType.BULLET:
                    controller.bulletService.templates.set(name, serialized)
                    break
                  case VETemplateType.LYRICS:
                    controller.lyricsService.templates.set(name, serialized)
                    break
                  case VETemplateType.PARTICLE:
                    controller.particleService.templates.set(name, serialized)
                    break
                  case VETemplateType.TEXTURE:
                    Beans.get(BeanTextureService).templates.set(name, serialized)
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
    "texture-intent": {
      type: TextureIntent,
      value: new TextureIntent({ name: "", file: "" }),
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
            percentageHeight: 0.25,
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
            percentageHeight: 0.75,
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