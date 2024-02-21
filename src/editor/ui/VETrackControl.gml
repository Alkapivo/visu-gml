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
            margin: { left: 1, right: 33 },
            x: function() { return this.margin.left },
            y: function() { return 0 },
            width: function() { return this.context.width() 
              - this.margin.left
              - this.margin.right },
            height: function() { 
              return 32
            },
            
          },
          toolbar: {
            name: "track-control.toolbar",
            width: function() { return 200 },
            height: function() { return 32 },
            margin: { top: 8, bottom: 0, left: 8, right: 8 },
            y: function() { return this.context.nodes.timeline.bottom()
              + this.margin.top },
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
          snap: {
            name: "track-control.snap",
            width: function() { return 56 },
            height: function() { return 32 },
            margin: { top: 8, bottom: 0, left: 8, right: 8 },
            x: function() { return this.context.nodes.snapLabel.left() 
              - this.width()
              - this.margin.right
              - this.margin.left },
            y: function() { return this.context.nodes.timeline.bottom()
              + this.margin.top },
          },
          snapLabel: {
            name: "track-control.snapLabel",
            width: function() { return 56 },
            height: function() { return 32 },
            margin: { top: 8, bottom: 0, left: 8, right: 8 },
            x: function() { return this.context.nodes.timestamp.left()
              - this.width()
              - this.margin.right
              - this.margin.left },
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
          progress: { 
            thickness: 1.5, 
            blend: "#ff0000",
            cornerFrom: { name: "texture_empty" },
            cornerTo: { name: "texture_empty" },
          },
          background: { thickness: 1.0, blend: "#000000", alpha: 0.0 },
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
          updateCustom: Struct.contains(json, "updateCustom") 
             ? json.updateCustom
             : function() {},
          onMouseHoverOver: function(event) {
            this.sprite.setBlend(ColorUtil.fromHex(VETheme.color.accent).toGMColor())
          },
          onMouseHoverOut: function(event) {
            this.sprite.setBlend(c_white)
          },
        },
        VEStyles.get("ve-track-control").button,
        false
      )
    }

    static factoryLabel = function(json) {
      var struct = {
        type: UIText,
        layout: json.layout,
        text: json.text,
        updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
      }

      if (Struct.contains(json, "updateCustom")) {
        Struct.set(struct, "updateCustom", json.updateCustom)
      }

      if (Struct.contains(json, "align")) {
        Struct.set(struct, "align", json.align)
      }
      
      return Struct.appendRecursiveUnique(
        struct,
        VEStyles.get("ve-track-control").label,
        false
      )
    }

    static factoryToolItem = function(json) {
      return {
        name: json.name,
        template: VEComponents.get("category-button"),
        layout: function(config = null) {
          return {
            name: "horizontal-item",
            type: UILayoutType.HORIZONTAL,
            collection: true,
            width: function() { return (this.context.width() - this.margin.top - this.margin.bottom) / this.collection.getSize() },
            x: function() { return this.margin.left + this.collection.getIndex() * this.width() },
          }
        },
        config: {
          backgroundColor: VETheme.color.primary,
          backgroundColorOn: ColorUtil.fromHex(VETheme.color.accent).toGMColor(),
          backgroundColorHover: ColorUtil.fromHex(VETheme.color.accentShadow).toGMColor(),
          backgroundColorOff: ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
          backgroundMargin: { top: 2, bottom: 2, right: 2, left: 2 },
          callback: function() { 
            this.context.state.get("store")
              .get("tool")
              .set(this.tool)
          },
          updateCustom: function() {
            this.backgroundColor = this.tool == this.context.state.get("store").getValue("tool")
              ? this.backgroundColorOn
              : (this.isHoverOver ? this.backgroundColorHover : this.backgroundColorOff)
          },
          onMouseHoverOver: function(event) { },
          onMouseHoverOut: function(event) { },
          label: { text: json.text },
          tool: json.tool,
        },
      }
    }

    var controller = this
    var layout = this.factoryLayout(parent)
    return new Map(String, UI, {
      "ve-track-control": new UI({
        name: "ve-track-control",
        state: new Map(String, any, {
          "background-color": ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
          "background-alpha": 0.85,
          "store": controller.editor.store,
          "tools": new Array(Struct, [
            factoryToolItem({ 
              name: "ve-track-control_tool_brush", 
              text: "Brush", 
              tool: "tool_brush",
            }),
            factoryToolItem({ 
              name: "ve-track-control_tool_eraser", 
              text: "Erase", 
              tool: "tool_erase",
            }),
            factoryToolItem({ 
              name: "ve-track-control_tool_clone", 
              text: "Clone", 
              tool: "tool_clone",
            }),
            factoryToolItem({ 
              name: "ve-track-control_tool_select", 
              text: "Select", 
              tool: "tool_select",
            }),
          ])
        }),
        controller: controller,
        layout: layout,
        updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
        spinner: SpriteUtil.parse({ name: "texture_spinner", scaleX: 0.25, scaleY: 0.25 }),
        spinnerFactor: 0,
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
          
          this.items.forEach(this.renderItem, this.area)

          if (Beans.get(BeanVisuController).fsm.getStateName() == "rewind") {
            this.spinnerFactor = lerp(this.spinnerFactor, 100.0, 0.1)
            this.spinner
              .setAlpha(this.spinnerFactor / 100.0)
              .render(
                (GuiWidth() / 2) - ((this.spinner.getWidth() * this.spinner.getScaleX()) / 2),
                (GuiHeight() / 2) - ((this.spinner.getHeight() * this.spinner.getScaleY()) / 2)
                  - (this.spinnerFactor / 2)
            )
          } else {
            this.spinnerFactor = lerp(this.spinnerFactor, 0.0, 0.1)
            if (this.spinnerFactor > 0) {
              this.spinner
                .setAlpha(this.spinnerFactor / 100.0)
                .render(
                (GuiWidth() / 2) - ((this.spinner.getWidth() * this.spinner.getScaleX()) / 2),
                (GuiHeight() / 2) - ((this.spinner.getHeight() * this.spinner.getScaleY()) / 2)
                  - (this.spinnerFactor / 2)
              )
            }
          }
        },
        items: {
          "slider_ve-track-control_timeline": factorySlider({
            layout: layout.nodes.timeline,
          }),
          "button_ve-track-control_backward": factoryButton({
            layout: layout.nodes.backward,
            sprite: { name: "texture_ve_trackcontrol_button_rewind_left" },
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
            sprite: { name: "texture_ve_trackcontrol_button_play" },
            callback: function() {
              Logger.debug("VETrackControl", $"Button pressed: {this.name}")
              Beans.get(BeanVisuController).send(new Event("play"))
            },
          }),
          "button_ve-track-control_pause": factoryButton({
            layout: layout.nodes.pause,
            sprite: { name: "texture_ve_trackcontrol_button_pause" },
            callback: function() {
              Logger.debug("VETrackControl", $"Button pressed: {this.name}")
              Beans.get(BeanVisuController).send(new Event("pause"))
            },
          }),
          "button_ve-track-control_forward": factoryButton({
            layout: layout.nodes.forward,
            sprite: { name: "texture_ve_trackcontrol_button_rewind_right" },
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
            align: { v: VAlign.CENTER, h: HAlign.CENTER },
            updateCustom: function() {
              this.label.text = String.formatTimestampMilisecond(
                NumberUtil.parse(Struct
                  .get(this.context.controller.editor.trackService, "time"), 
                  0.0
                )
              )
            },
          }),
          "text_ve-track-control_snapLabel": factoryLabel({
            layout: layout.nodes.snap,
            text: "Snap to grid",
            align: { v: VAlign.CENTER, h: HAlign.LEFT },
          }),
          "checkbox_ve-track-control_snap": Struct.appendRecursiveUnique(
            {
              type: UICheckbox,
              layout: layout.nodes.snapLabel,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
              spriteOn: { name: "visu_texture_checkbox_switch_on" },
              spriteOff: { name: "visu_texture_checkbox_switch_off" },
              store: { key: "snap"},
              config: {
                callback: function() { 
                  this.context.state.get("store")
                    .get("snap")
                    .set(!this.value)
                },
              },
            },
            VEStyles.get("ve-track-control").button,
            false
          ),
        },
        onInit: function() {
          var container = this
          this.collection = new UICollection(this, { layout: container.layout.nodes.toolbar })
          this.state.get("tools")
            .forEach(function(component, index, collection) {
              collection.add(new UIComponent(component))
            }, this.collection)
        },
      })
    })
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
  send = function(event) {
    return this.dispatcher.send(event)
  }

  ///@return {VETrackControl}
  update = function() { 
    this.dispatcher.update()
    return this
  }
}