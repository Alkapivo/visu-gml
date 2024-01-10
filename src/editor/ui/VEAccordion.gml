///@package io.alkapivo.visu.editor.ui

///@param {VisuEditor} _editor
///@param {?Struct} [config]
function VEAccordion(_editor, config = null) constructor {

  ///@type {VisuEditor}
  editor = _editor

  ///@type {UIService}
  uiService = Assert.isType(this.editor.uiService, UIService)

  ///@type {?UILayout}
  layout = null

  ///@type {VEEventInspector}
  eventInspector = new VEEventInspector(this.editor)

  ///@type {VETemplateToolbar}
  templateToolbar = new VETemplateToolbar(this.editor)

  ///@type {Map<String, Containers>}
  containers = new Map(String, UI)

  ///@type {Store}
  store = new Store({
    "render_event-inspector": {
      type: Boolean,
      value: false,
    },
    "render_template-toolbar": {
      type: Boolean,
      value: false,
    },
  })

  
  ///@private
  ///@type {Map<String, Callable>}
  __containers = new Map(String, Callable, {
    "accordion-items": function(name, accordion, layout) {
      return {
        name: name,
        state: new Map(String, any, {
          "background-alpha": 1.0,
          "background-color": ColorUtil.fromHex(VETheme.color.dark).toGMColor(),
          
        }),
        accordion: accordion,
        layout: layout,
        updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
        updateCustom: function() {
          var store = this.state.get("store")
          if (!Core.isType(store, Store)
            || !Core.isType(this.layout, UILayout)) {
            return
          }
          
          Struct.set(this.layout.store, "render_event-inspector", store
            .getValue("render_event-inspector"))
          Struct.set(this.layout.store, "render_template-toolbar", store
            .getValue("render_template-toolbar"))
        },
        render: Callable.run(UIUtil.renderTemplates.get("renderDefault")),
        onInit: function() {
          var context = this
          this.state.set("store", this.accordion.store)
          context
            .add(UIText(
              "accordion-item_event-inspector_label",
              {
                updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
                backgroundColor: VETheme.color.accentShadow,
                font: "font_inter_10_regular",
                color: VETheme.color.textFocus,
                align: { v: VAlign.CENTER, h: HAlign.LEFT },
                text: "Event inspector",
                offset: { x: 32 },
                layout: Struct.get(context.layout.nodes, "bar_event-inspector").nodes.label,
              }
            ))
            .add(UICheckbox(
              "accordion-item_event-inspector_checkbox",
              {
                spriteOn: { name: "visu_texture_checkbox_switch_on" },
                spriteOff: { name: "visu_texture_checkbox_switch_off" },
                updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
                backgroundColor: VETheme.color.accentShadow,
                layout: Struct.get(context.layout.nodes, "bar_event-inspector").nodes.checkbox,
                store: { key: "render_event-inspector" },
              }
            ))
            add(UIText(
              "accordion-item_template-toolbar_label",
              {
                updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
                backgroundColor: VETheme.color.accentShadow,
                font: "font_inter_10_regular",
                color: VETheme.color.textFocus,
                align: { v: VAlign.CENTER, h: HAlign.LEFT },
                text: "Template toolbar",
                offset: { x: 32 },
                layout: Struct.get(context.layout.nodes, "bar_template-toolbar").nodes.label,
              }
            ))
            .add(UICheckbox(
              "accordion-item_template-toolbar_checkbox",
              {
                spriteOn: { name: "visu_texture_checkbox_switch_on" },
                spriteOff: { name: "visu_texture_checkbox_switch_off" },
                updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
                backgroundColor: VETheme.color.accentShadow,
                layout: Struct.get(context.layout.nodes, "bar_template-toolbar").nodes.checkbox,
                store: { key: "render_template-toolbar" },
                callback: function() {
                  var deb = "ugger"
                }
              }
            ))
        },
      }
    },
  })

  ///@private
  ///@param {UIlayout} parent
  ///@return {UILayout}
  factoryLayout = function(parent) {
    return new UILayout(
      {
        name: "ve-accordion",
        store: {
          "render_event-inspector": false,
          "render_template-toolbar": false,
        },
        nodes: {
          "bar_event-inspector": {
            name: "bar_event-inspector",
            y: function() { return 0 },
            height: function() { return 32 },
            nodes: {
              label: {
                name: "bar_event-inspector.label",
                width: function() { return this.context.width() - 56 },
              },
              checkbox: {
                name: "bar_event-inspector.checkbox",
                x: function() { return this.context.nodes.label.right() },
                width: function() { return 56 },
              },
            },
          },
          "view_event-inspector": {
            name: "view_event-inspector",
            margin: { top: 2, bottom: 2, right: 0, left: 1 },
            y: function() { return this.context.y() + this.margin.top
               + Struct.get(this.context.nodes, "bar_event-inspector").bottom() },
            height: function() { 
              if (!Struct.get(this.context.store, "render_event-inspector")) {
                return this.margin.top + this.margin.bottom
              }
              var height = this.context.height()
               - this.margin.top - this.margin.bottom
               - Struct.get(this.context.nodes, "bar_event-inspector").height()
               - Struct.get(this.context.nodes, "bar_template-toolbar").height()
              if (Struct.get(this.context.store, "render_template-toolbar")) {
                height = height * 0.3
              }
              return height
            },
            
          },
          "bar_template-toolbar": {
            name: "bar_template-toolbar",
            y: function() { return Struct.get(this.context.nodes, "view_event-inspector").bottom() 
               - this.context.y() },
            height: function() { return 32 },
            nodes: {
              label: {
                name: "bar_template-toolbar.label",
                width: function() { return this.context.width() - 56 },
              },
              checkbox: {
                name: "bar_template-toolbar.checkbox",
                x: function() { return this.context.nodes.label.right() },
                width: function() { return 56 },
              },
            },
          },
          "view_template-toolbar": {
            name: "view_template-toolbar",
            margin: { top: 2, bottom: 8, right: 0, left: 1 },
            y: function() { return this.context.y() + this.margin.top
               + Struct.get(this.context.nodes, "bar_template-toolbar").bottom() },
            height: function() { 
              if (!Struct.get(this.context.store, "render_template-toolbar")) {
                return this.margin.top + this.margin.bottom
              }

              var height = this.context.height()
               - this.margin.top - this.margin.bottom
               - Struct.get(this.context.nodes, "bar_event-inspector").height()
               - Struct.get(this.context.nodes, "bar_template-toolbar").height()
              if (Struct.get(this.context.store, "render_event-inspector")) {
                height = height * 0.7
              }

              return height
            },
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
    this.eventInspector.containers = this.eventInspector
      .factoryContainers(Struct.get(this.layout.nodes, "view_event-inspector"))
    this.templateToolbar.containers = this.templateToolbar
      .factoryContainers(Struct.get(this.layout.nodes, "view_template-toolbar"))
    return this.__containers
      .map(function(item, name, accordion) {
        var layout = Assert.isType(accordion.layout, UILayout)
        return new UI(item($"ve-accordion_{name}", accordion, layout))
      }, this, String, UI)
      .merge(this.eventInspector.containers, this.templateToolbar.containers)
  }

  ///@type {EventDispatcher}
  dispatcher = new EventDispatcher(this, new Map(String, Callable, {
    "open": function(event) {
      var context = this
      this.containers = this.factoryContainers(event.data.layout)
      IntStream.forEach(0, this.containers.size(), function(iterator, index, acc) {
        acc.uiService.send(new Event("add", {
          container: acc.containers.get(acc.keys[iterator]),
          replace: true,
        }))
      }, {
        keys: GMArray.sort(this.containers.keys().getContainer()),
        containers: context.containers,
        uiService: context.uiService,
      })
    },
    "close": function(event) {
      var context = this
      this.containers.forEach(function (container, key, uiService) {
        data.uiService.send(new Event("remove", { 
          name: key, 
          quiet: true,
        }))
      }, this.uiService).clear()
    },
  }))

  ///@param {Event} event
  ///@return {?Promise}
  send = method(this, EventDispatcherUtil.send())

  ///@private
  ///@params {Struct} context
  ///@params {Boolean} enable
  updateContainerObject = function(context, enable) {
    if (!context.enable && enable) {
      context.containers.forEach(function(container, name) {
        if (Optional.is(container.updateArea)) {
          container.updateArea()
        }
        container.items.forEach(function(item) {
          if (Optional.is(item.updateArea)) {
            item.updateArea()
          }
        }) 
      })
    }
    context.enable = enable
    context.update()
  }

  ///@return {VEBrushToolbar}
  update = function() { 
    this.dispatcher.update()
    this.updateContainerObject(this.eventInspector, this.store
      .getValue("render_event-inspector"))
    this.updateContainerObject(this.templateToolbar, this.store
      .getValue("render_template-toolbar"))
    return this
  }
}