///@package io.alkapivo.visu.editor.ui

///@param {VisuEditor} _editor
function VEEventInspector(_editor) constructor {

  ///@type {VisuEditor}
  editor = Assert.isType(_editor, VisuEditor)

  ///@type {UIService}
  uiService = Assert.isType(this.editor.uiService, UIService)

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
      margin: { left: 10 },
      x: function() { return this.context.x() + this.margin.left },
    }, parent)
  }

  ///@private
  ///@param {UIlayout} parent
  ///@return {Map<String, UI>}
  factoryContainers = function(parent) {
    var eventInspector = this
    this.layout = this.factoryLayout(parent)
    return new Map(String, UI, {
      "ve-event-inspector-properties": new UI({
        name: "ve-event-inspector-properties",
        state: new Map(String, any, {
          "background-color": ColorUtil.fromHex(VETheme.color.dark).toGMColor(),
          "empty-label": new UILabel({
            text: "Click on\ntimeline\nevent",
            font: "font_inter_10_regular",
            color: VETheme.color.textShadow,
            align: { v: VAlign.CENTER, h: HAlign.CENTER },
          }),
          "updateTrackEvent": false,
        }),
        timer: new Timer(FRAME_MS * 3, { loop: Infinity, randomize: true }),
        eventInspector: eventInspector,
        layout: layout,
        updateArea: Callable.run(UIUtil.updateAreaTemplates.get("scrollableY")),
        updateCustom: function() {
          if (!this.state.get("updateTrackEvent")) {
            return
          }

          this.state.set("updateTrackEvent", false)
          var selectedEvent = Beans.get(BeanVisuController).visuEditor.store
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

          var container = this.eventInspector.uiService
            .find("ve-timeline-events")
          if (!Core.isType(container, UI)) {
            return
          }

          selectedEvent.name = container.updateEvent(
            selectedEvent.channel, 
            selectedEvent.data, 
            selectedEvent.name
          ).name
        },
        renderDefaultScrollable: new BindIntent(Callable.run(UIUtil.renderTemplates.get("renderDefaultScrollable"))),
        render: function() {
          this.renderDefaultScrollable()
          if (!Optional.is(this.state.get("selectedEvent"))) {
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
          this.collection = new UICollection(this, { layout: container.layout })
          Beans.get(BeanVisuController).visuEditor.store
            .get("selected-event")
            .addSubscriber({ 
              name: container.name,
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
                var event = new VEEvent(null, {
                  "event-color": Struct.getDefault(trackEvent.data.icon, "blend", "#FFFFFF"),
                  "event-texture": trackEvent.data.icon.name,
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

                data.addUIComponents(event.components
                  .map(function(component) {
                    return new UIComponent(component)
                  }),
                  new UILayout({
                    area: data.area,
                    width: function() { return this.area.getWidth() },
                  })
                )

                event.store.container.forEach(function(item, name, acc) {
                  item.addSubscriber(acc)
                }, {
                  name: data.name,
                  callback: function(value, data) { 
                    data.state.set("updateTrackEvent", true)
                  },
                  data: data,
                })
              },
              data: container,
            })
        },
      }),
    })
  }

  ///@type {EventDispatcher}
  dispatcher = new EventDispatcher(this, new Map(String, Callable, {
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

  ///@return {VEBrushToolbar}
  update = function() { 
    this.dispatcher.update()
    this.containers.forEach(function (container, key, enable) {
      container.enable = enable
    }, this.enable)
    return this
  }
}