///@package io.alkapivo.visu.editor.ui.controller

///@param {VisuEditorController} _editor
function VEEventInspector(_editor) constructor {

  ///@type {VisuEditorController}
  editor = Assert.isType(_editor, VisuEditorController)

  ///@type {Map<String, Containers>}
  containers = new Map(String, UI)

  ///@type {Store}
  store = new Store({
    "event": {
      type: Optional.of(VEEvent),
      value: null,
    },
  })

  ///@type {Boolean}
  enable = true

  ///@private
  ///@param {UIlayout} parent
  ///@return {UILayout}
  factoryLayout = function(parent) {
    return new UILayout({ 
      name: "event-inspector",
      staticHeight: new BindIntent(function() { return this.nodes.title.height() + this.nodes.control.height() }),
      nodes: {
        "title": {
          name: "event-inspector.title",
          height: function() { return 16 },
        },
        "view": {
          name: "event-inspector.view",
          margin: { left: 10 },
          height: function() { return this.context.height() - this.context.staticHeight() },
          y: function() { return this.context.nodes.title.bottom() },
        },
        "control": {
          name: "event-inspector.control",
          height: function() { return 24 },
          margin: { left: 0, right: 1 },
          y: function() { return this.context.nodes.view.bottom() },
        }
      }
    }, parent)
  }

  ///@private
  ///@param {UIlayout} parent
  ///@return {Task}
  factoryOpenTask = function(parent) {
    var eventInspector = this
    var layout = this.factoryLayout(parent)
    this.layout = layout
    var containerIntents = new Map(String, Struct, {
      "ve-event-inspector-title": {
        name: "ve-event-inspector-title",
        state: new Map(String, any, {
          "background-alpha": 1.0,
          "background-color": ColorUtil.fromHex(VETheme.color.darkShadow).toGMColor(),
        }),
        updateTimer: new Timer(FRAME_MS * 2, { loop: Infinity, shuffle: true }),
        layout: layout.nodes.title,
        updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
        render: Callable.run(UIUtil.renderTemplates.get("renderDefaultNoSurface")),
        items: {
          "label_ve-event-inspector-title": {
            type: UIText,
            text: "Event inspector",
            update: Callable.run(UIUtil.updateAreaTemplates.get("applyMargin")),
            backgroundColor: VETheme.color.accentShadow,
            font: "font_inter_8_regular",
            color: VETheme.color.textFocus,
            align: { v: VAlign.CENTER, h: HAlign.LEFT },
            offset: { x: 4 },
          }, 
        }
      },
      "ve-event-inspector-properties": {
        name: "ve-event-inspector-properties",
        state: new Map(String, any, {
          "background-color": ColorUtil.fromHex(VETheme.color.dark).toGMColor(),
          "empty-label": new UILabel({
            text: "Click on\ntimeline\nevent",
            font: "font_inter_10_regular",
            color: VETheme.color.textShadow,
            align: { v: VAlign.CENTER, h: HAlign.CENTER },
          }),
          "inspectorType": VEEventInspector,
          "updateTrackEvent": false,
        }),
        updateTimer: new Timer(FRAME_MS * Core.getProperty("visu.editor.ui.event-inspector.properties.updateTimer", 60), { loop: Infinity, shuffle: true }),
        eventInspector: eventInspector,
        layout: layout.nodes.view,
        _updateTrackEvent: new BindIntent(function() {
          if (!this.state.get("updateTrackEvent")) {
            return
          }

          this.state.set("updateTrackEvent", false)
          var selectedEvent = Beans.get(BeanVisuEditorController).store
            .getValue("selected-event")
          if (!Core.isType(selectedEvent, Struct)) {
            return
          }

          var event = this.state.get("event")
          if (!Core.isType(event, VEEvent)) {
            return
          }

          var template = event.toTemplate()
          selectedEvent.data.timestamp = template.event.timestamp
          selectedEvent.data.data = template.event.data
          selectedEvent.channel = template.channel

          var container = Beans.get(BeanVisuEditorController).uiService
            .find("ve-timeline-events")
          if (!Core.isType(container, UI)) {
            return
          }

          selectedEvent.name = container.updateEvent(
            selectedEvent.channel, 
            selectedEvent.data, 
            selectedEvent.name
          ).name
        }),
        updateArea: Callable.run(UIUtil.updateAreaTemplates.get("scrollableY")),
        renderItem: Callable.run(UIUtil.renderTemplates.get("renderItemDefaultScrollable")),
        renderDefaultScrollable: new BindIntent(Callable.run(UIUtil.renderTemplates.get("renderDefaultScrollable"))),
        render: function() {
          if (this.executor != null) {
            this.executor.update()
          }

          this._updateTrackEvent()
          this.renderDefaultScrollable()
          if (!Optional.is(this.state.get("selectedEvent"))) {
            this.state.get("empty-label").render(
              this.area.getX() + (this.area.getWidth() / 2),
              this.area.getY() + (this.area.getHeight() / 2)
            )
          }
        },
        executor: null,
        scrollbarY: { align: HAlign.LEFT },
        onMousePressedLeft: Callable.run(UIUtil.mouseEventTemplates.get("onMouseScrollbarY")),
        onMouseWheelUp: Callable.run(UIUtil.mouseEventTemplates.get("scrollableOnMouseWheelUpY")),
        onMouseWheelDown: Callable.run(UIUtil.mouseEventTemplates.get("scrollableOnMouseWheelDownY")),
        onInit: function() {
          var container = this
          this.executor = new TaskExecutor(this, {
            enableLogger: true,
            catchException: false,
          })
          this.collection = new UICollection(this, { layout: container.layout })
          Beans.get(BeanVisuEditorController).store
            .get("selected-event")
            .addSubscriber({ 
              name: container.name,
              overrideSubscriber: true, ///@todo investigate
              callback: function(selectedEvent, data) { 
                if (!Optional.is(selectedEvent)) {
                  data.collection.components.clear() ///@todo replace with remove lambda
                  data.items.clear() ///@todo replace with remove lambda
                  data.state
                    .set("selectedEvent", null)
                    .set("event", null)
                    .set("store", null)
                  return
                }

                var trackEvent = selectedEvent.data
                var icon = Struct.get(trackEvent.data, "icon")
                var event = new VEEvent(null, {
                  "event-color": Struct.getIfType(icon, "blend", String, "#FFFFFF"),
                  "event-texture": Struct.getIfType(icon, "name", String, "texture_missing"),
                  "event-timestamp": trackEvent.timestamp,
                  "event-channel": selectedEvent.channel,
                  "type": trackEvent.callableName,
                  "properties": Struct.remove(JSON.clone(trackEvent.data), "icon")
                })
                data.collection.components.clear() ///@todo replace with remove lambda
                data.items.clear() ///@todo replace with remove lambda
                data.eventInspector.store.get("event").set(event)
                data.state
                  .set("selectedEvent", selectedEvent)
                  .set("event", event)
                  .set("store", event.store)

                data.executor.tasks.forEach(function(task, iterator, name) {
                  if (task.name == name) {
                    task.fullfill()
                  }
                }, "init-ui-components")

                var task = new Task("init-ui-components")
                  .setTimeout(60)
                  .setState({
                    stage: "load-components",
                    context: data,
                    components: event.components,
                    componentsQueue: new Queue(String, GMArray
                      .map(event.components.container, function(component, index) { 
                        return index 
                      })),
                    componentsConfig: {
                      context: data,
                      layout: new UILayout({
                        area: data.area,
                        width: function() { return this.area.getWidth() },
                      }),
                      textField: null,
                    },
                    subscribers: event.store.container,
                    subscribersQueue: new Queue(String, event.store.container
                      .keys()
                      .map(function(key) { return key }).container),
                    subscribersConfig: {
                      name: data.name,
                      callback: function(value, data) { 
                        data.state.set("updateTrackEvent", true)
                      },
                      data: data,
                    },
                    "load-components": function(task) {
                      static factoryComponent = function(component, index, acc) {
                        static add = function(item, index, acc) {
                          if (item.type == UITextField) {
                            var textField = item.textField
                            if (Optional.is(acc.textField)) {
                              acc.textField.setNext(textField)
                              textField.setPrevious(acc.textField)
                            }
                            acc.textField = textField
                          }
                  
                          acc.context.add(item, item.name)
                          if (Optional.is(item.updateArea())) {
                            item.updateArea()
                          }
                        }
                  
                        acc.layout = component
                          .toUIItems(acc.layout)
                          .forEach(add, acc)
                          .getLast().layout.context
                      }
                      
                      var index = task.state.componentsQueue.pop()
                      if (!Optional.is(index)) {
                        task.state.stage = "set-subscribers"
                        return
                      }

                      var component = new UIComponent(task.state.components.get(index))
                      factoryComponent(component, index, task.state.componentsConfig)
                    },
                    "set-subscribers": function(task) {
                      var key = task.state.subscribersQueue.pop()
                      if (!Optional.is(key)) {
                        if (Optional.is(task.state.context.updateTimer)) {
                          task.state.context.updateTimer.time = task.state.context.updateTimer.duration + random(task.state.context.updateTimer.duration / 2.0)
                        }

                        task.fullfill()
                        return
                      }

                      var item = task.state.subscribers.get(key)
                      item.addSubscriber(task.state.subscribersConfig)
                    }
                  })
                  .whenUpdate(function() {
                    var stage = Struct.get(this.state, this.state.stage)
                    stage(this)
                    return this
                  })
                
                data.executor.add(task)
              },
              data: container,
            })
        },
        onDestroy: function() {
          if (Optional.is(this.executor)) {
            this.executor.tasks.forEach(function(task) { 
              task.fullfill() 
            }).clear()
          }

          if (Core.isType(this.eventInspector.editor, VisuEditorController)) {
            this.eventInspector.editor.store
              .get("selected-event")
              .removeSubscriber(this.name)
          }
        },
      },
      "ve-event-inspector-control": {
        name: "ve-event-inspector-control",
        state: new Map(String, any, {
          "background-alpha": 1.0,
          "background-color": ColorUtil.fromHex(VETheme.color.darkShadow).toGMColor(),
          "components": new Array(Struct, [
            {
              name: "button_control-preview",
              template: VEComponents.get("category-button"),
              layout: VELayouts.get("horizontal-item"),
              config: {
                colorHoverOver: VETheme.color.accentShadow,
                colorHoverOut: VETheme.color.primaryShadow,
                backgroundColor: VETheme.color.primaryShadow,
                backgroundMargin: { top: 1, bottom: 0, left: 0, right: 1 },
                label: { 
                  font: "font_inter_10_bold",
                  text: "Preview",
                },
                callback: function() { 
                  var eventInspector = this.context.eventInspector
                  var event = eventInspector.store.getValue("event")
                  if (!Core.isType(event, VEEvent)) {
                    return
                  }

                  var handler = Beans.get(BeanVisuController).trackService.handlers.get(event.type)
                  handler.run(handler.parse(event.toTemplate().event.data))
                },
                onMouseHoverOver: function(event) {
                  this.backgroundColor = ColorUtil.fromHex(this.colorHoverOver).toGMColor()
                },
                onMouseHoverOut: function(event) {
                  this.backgroundColor = ColorUtil.fromHex(this.colorHoverOut).toGMColor()
                },
              },
            },
            /* 
            {
              name: "button_control-to-brush",
              template: VEComponents.get("category-button"),
              layout: VELayouts.get("horizontal-item"),
              config: {
                colorHoverOver: VETheme.color.accentShadow,
                colorHoverOut: VETheme.color.primaryShadow,
                backgroundColor: VETheme.color.primaryShadow,
                backgroundMargin: { top: 1, bottom: 1, left: 1, right: 1 },
                label: { text: "To brush" },
                callback: function() { 
                  Core.print("callback to brush")
                },
                onMouseHoverOver: function(event) {
                  this.backgroundColor = ColorUtil.fromHex(this.colorHoverOver).toGMColor()
                },
                onMouseHoverOut: function(event) {
                  this.backgroundColor = ColorUtil.fromHex(this.colorHoverOut).toGMColor()
                },
              },
            }
            */
          ]),
        }),
        updateTimer: new Timer(FRAME_MS * 2, { loop: Infinity, shuffle: true }),
        eventInspector: eventInspector,
        layout: layout.nodes.control,
        updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
        render: Callable.run(UIUtil.renderTemplates.get("renderDefaultNoSurface")),
        onInit: function() {
          var layout = this.layout
          this.collection = new UICollection(this, { layout: layout })
          this.state.get("components")
            .forEach(function(component, index, collection) {
              collection.add(new UIComponent(component))
            }, this.collection)
        },
      },
    })

    return new Task("init-container")
      .setState({
        context: eventInspector,
        containers: containerIntents,
        queue: new Queue(String, GMArray.sort(containerIntents.keys().getContainer())),
      })
      .whenUpdate(function() {
        var key = this.state.queue.pop()
        if (key == null) {
          this.fullfill()
          return
        }
        this.state.context.containers.set(key, new UI(this.state.containers.get(key)))
      })
      .whenFinish(function() {
        var containers = this.state.context.containers
        IntStream.forEach(0, containers.size(), function(iterator, index, acc) {
          Beans.get(BeanVisuEditorController).uiService.send(new Event("add", {
            container: acc.containers.get(acc.keys[iterator]),
            replace: true,
          }))
        }, {
          keys: GMArray.sort(containers.keys().getContainer()),
          containers: containers,
        })
      })
  }

  ///@type {EventPump}
  dispatcher = new EventPump(this, new Map(String, Callable, {
    "open": function(event) {
      this.dispatcher.execute(new Event("close"))
      Beans.get(BeanVisuEditorController).executor
        .add(this.factoryOpenTask(event.data.layout))
    },
    "close": function(event) {
      var context = this
      this.containers.forEach(function (container, key, uiService) {
        uiService.dispatcher.execute(new Event("remove", { 
          name: key, 
          quiet: true,
        }))
      }, Beans.get(BeanVisuEditorController).uiService).clear()

      this.store.get("event").set(null)
    },
  }), { 
    enableLogger: false, 
    catchException: false,
  })

  ///@param {Event} event
  ///@return {?Promise}
  send = method(this, EventPumpUtil.send())

  ///@return {VEBrushToolbar}
  update = function() { 
    try {
      this.dispatcher.update()
    } catch (exception) {
      var message = $"VEBrushToolbar dispatcher fatal error: {exception.message}"
      Beans.get(BeanVisuController).send(new Event("spawn-popup", { message: message }))
      Logger.error("UI", message)
    }

    this.containers.forEach(function (container, key, enable) {
      container.enable = enable
    }, this.enable)
    return this
  }
}