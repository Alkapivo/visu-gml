///@package io.alkapivo.visu.editor.ui

///@param {VisuEditor} _editor
function VETrackControl(_editor) constructor {

  ///@type {VisuEditor}
  editor = Assert.isType(_editor, VisuEditor)
  
  ///@type {UIService}
  uiService = Assert.isType(this.editor.uiService, UIService)
  
  ///@type {Map<String, Containers>}
  containers = new Map(String, UI)

  ///@private
  ///@param {UIlayout} parent
  ///@return {UILayout}
  factoryLayout = function(parent) {
    return new UILayout(
      {
        name: "track-control",
        fetchNodeX: new BindIntent(function(index, amount, width, margin) {
          var halfX = this.context.width() / 2
          var halfWidth = ((width * amount) + (margin * (amount + 2))) / 2
          return halfX - halfWidth + (width * index) + (margin * (index + 2))
        }),
        nodes: {
          timeline: {
            name: "track-control.timeline",
            height: function() { 
              return 32
            },
            x: function() { return 0 },
            y: function() { return 0 },

          },
          backward: {
            name: "track-control.backward",
            width: function() { return 32 },
            height: function() { return 32 },
            margin: { top: 8 },
            x: function() { return this.context.fetchNodeX(0, 4, this.width(), 8) },
            y: function() { return this.context.nodes.timeline.bottom()
              + this.margin.top },
          },
          play: {
            name: "track-control.play",
            width: function() { return 32 },
            height: function() { return 32 },
            margin: { top: 8 },
            x: function() { return this.context.fetchNodeX(1, 4, this.width(), 8) },
            y: function() { return this.context.nodes.timeline.bottom()
              + this.margin.top },
          },
          pause: {
            name: "track-control.pause",
            width: function() { return 32 },
            height: function() { return 32 },
            margin: { top: 8 },
            x: function() { return this.context.fetchNodeX(2, 4, this.width(), 8) },
            y: function() { return this.context.nodes.timeline.bottom()
              + this.margin.top },
          },
          forward: {
            name: "track-control.forward",
            width: function() { return 32 },
            height: function() { return 32 },
            margin: { top: 8 },
            x: function() { return this.context.fetchNodeX(3, 4, this.width(), 8) },
            y: function() { return this.context.nodes.timeline.bottom()
              + this.margin.top },
          },
          timestamp: {
            name: "track-control.timestamp",
            width: function() { return 80 },
            height: function() { return 32 },
            margin: { top: 8 },
            x: function() { return this.context.width() - this.width() },
            y: function() { return this.context.nodes.timeline.bottom()
              + this.margin.top },
          },
        }
      }, 
      parent
    )
  }

  ///@private
  ///@param {UIlayout} parent
  ///@return {Map<String, UI>}
  factoryContainers = function(parent) {
    static factorySlider = function(json) {
      return Struct.appendRecursiveUnique(
        {
          type: UISliderHorizontal,
          layout: json.layout,
          value: 0.0,
          minValue: 0.0,
          maxValue: 1.0,
          pointer: {
            name: "texture_slider_pointer_default",
            scaleX: 0.125,
            scaleY: 0.125,
          },
          progress: { thickness: 1.0, blend: "#ff0000" },
          background: { thickness: 1.0, blend: "#000000" },
          state: new Map(String, any),
          updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          updateCustom: function() {
            var mousePromise = MouseUtil.getClipboard()
            if (Struct.get(Struct.get(mousePromise, "state"), "context") == this) {
              this.updatePosition(MouseUtil.getMouseX())
              return
            }

            if (this.state.contains("promise")) {
              var promise = this.state.get("promise")
              if (Struct.get(promise, "status") == PromiseStatus.PENDING) {
                return
              }
              this.state.remove("promise")
            }

            var controller = this.context.controller.editor.controller
            if (controller.fsm.getStateName() == "rewind") {
              return
            }

            var trackService = controller.trackService
            this.value = clamp(
              trackService.time / trackService.duration, 
              this.minValue, 
              this.maxValue
            )
          },
          updatePosition: function(mouseX) {
            var position = mouseX - this.context.area.getX()
            var width = this.area.getWidth() - (this.area.getX() * 2)
            this.value = clamp(position / width, this.minValue, this.maxValue)

            var rulerView = this.context.controller.uiService
              .find("ve-timeline-ruler")
            if (Core.isType(rulerView, UI)) {
              rulerView.state.set("time", this.value
                * this.context.controller.editor.trackService.duration)
            }

            var eventsView = this.context.controller.uiService
              .find("ve-timeline-events")
            if (Core.isType(eventsView, UI)) {
              eventsView.state.set("time", this.value 
                * this.context.controller.editor.trackService.duration)
            }
          },
          onMouseReleasedLeft: function(event) {
            this.updatePosition(event.data.x)
            this.sendEvent()
          },
          onMouseDragLeft: function(event) {
            var context = this
            MouseUtil.setClipboard(new Promise()
              .setState({
                context: context,
                callback: context.sendEvent,
              })
              .whenSuccess(function() {
                Callable.run(Struct.get(this.state, "callback"))
              })
            )
          },
          sendEvent: new BindIntent(function() {
            var timestamp = this.value * this.context.controller.editor.trackService.duration
            var promise = this.context.controller.editor.controller
              .send(new Event("rewind")
              .setData({ timestamp: timestamp })
              .setPromise(new Promise()))
            this.state.set("promise", promise)
            return promise
          }),
        },
        VEStyles.get("ve-track-control").slider,
        false
      )
    }

    static factoryButton = function(json) {
      return Struct.appendRecursiveUnique(
        {
          type: UIButton,
          layout: json.layout,
          sprite: json.sprite,
          callback: json.callback,
          updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
        },
        VEStyles.get("ve-track-control").button,
        false
      )
    }

    static factoryLabel = function(json) {
      return Struct.appendRecursiveUnique(
        {
          type: UIText,
          layout: json.layout,
          text: json.text,
          updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          updateCustom: json.updateCustom,
        },
        VEStyles.get("ve-track-control").label,
        false
      )
    }

    var controller = this
    var layout = this.factoryLayout(parent)
    return new Map(String, UI, {
      "ve-track-control": new UI({
        name: "ve-track-control",
        state: new Map(String, any, {
          "background-color": ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
          "store": controller.editor.store,
        }),
        controller: controller,
        layout: layout,
        updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
        render: function() {
          var color = this.state.get("background-color")
          if (Core.isType(color, GMColor)) {
            GPU.render.rectangle(
              this.area.x, this.area.y + 16, 
              this.area.x + this.area.getWidth(), this.area.y + this.area.getHeight(), 
              false,
              color, color, color, color, 
              this.state.get("background-alpha")
            )
          }
          
          this.items.forEach(this.renderItem)
        },
        items: {
          "slider_ve-track-control_timeline": factorySlider({
            layout: layout.nodes.timeline,
          }),
          "button_ve-track-control_backward": factoryButton({
            layout: layout.nodes.backward,
            sprite: { name: "texture_button", frame: 5, animate: false },
            callback: function() {
              Logger.debug("VETrackControl", $"Button pressed: {this.name}")
              var trackService = this.context.controller.editor.trackService
              Beans.get(BeanVisuController).send(new Event("rewind").setData({
                timestamp: clamp(trackService.time - 10.0, 0, trackService.duration),
              }))
            },
          }),
          "button_ve-track-control_play": factoryButton({
            layout: layout.nodes.play,
            sprite: { name: "texture_button", frame: 1, animate: false },
            callback: function() {
              Logger.debug("VETrackControl", $"Button pressed: {this.name}")
              Beans.get(BeanVisuController).send(new Event("play"))
            },
          }),
          "button_ve-track-control_pause": factoryButton({
            layout: layout.nodes.pause,
            sprite: { name: "texture_button", frame: 2, animate: false },
            callback: function() {
              Logger.debug("VETrackControl", $"Button pressed: {this.name}")
              Beans.get(BeanVisuController).send(new Event("pause"))
            },
          }),
          "button_ve-track-control_forward": factoryButton({
            layout: layout.nodes.forward,
            sprite: { name: "texture_button", frame: 4, animate: false },
            callback: function() {
              Logger.debug("VETrackControl", $"Button pressed: {this.name}")
              var trackService = this.context.controller.editor.trackService
              Beans.get(BeanVisuController).send(new Event("rewind").setData({
                timestamp: clamp(trackService.time + 10.0, 0, trackService.duration),
              }))
            },
          }),
          "text_ve-track-control_timestamp": factoryLabel({
            layout: layout.nodes.timestamp,
            text: "00:00.00",
            updateCustom: function() {
              this.label.text = String.formatTimestampMilisecond(
                NumberUtil.parse(Struct
                  .get(this.context.controller.editor.trackService, "time"), 
                  0.0
                )
              )
            },
          }),
        },
      })
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
  send = function(event) {
    return this.dispatcher.send(event)
  }

  ///@return {VETrackControl}
  update = function() { 
    this.dispatcher.update()
    return this
  }
}