///@package io.alkapivo.visu.editor.ui.controller

///@param {VisuEditorController} _editor
function VETrackControl(_editor) constructor {

  ///@type {VisuEditorController}
  editor = Assert.isType(_editor, VisuEditorController)
  
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
          timestamp: {
            name: "track-control.timestamp",
            width: function() { return 64 },
            height: function() { return 32 },
            margin: { top: 12, right: 6 },
            x: function() { return this.margin.right },
            y: function() { return this.context.nodes.timeline.bottom()
              + this.margin.top },
          },
          backward: {
            name: "track-control.backward",
            width: function() { return 32 },
            height: function() { return 32 },
            margin: { top: 8 },
            x: function() { return this.context.fetchNodeX(0, 4, this.width(), 4) },
            y: function() { return this.context.nodes.timeline.bottom()
              + this.margin.top },
          },
          play: {
            name: "track-control.play",
            width: function() { return 32 },
            height: function() { return 32 },
            margin: { top: 8 },
            x: function() { return this.context.fetchNodeX(1, 4, this.width(), 4) },
            y: function() { return this.context.nodes.timeline.bottom()
              + this.margin.top },
          },
          pause: {
            name: "track-control.pause",
            width: function() { return 32 },
            height: function() { return 32 },
            margin: { top: 8 },
            x: function() { return this.context.fetchNodeX(2, 4, this.width(), 4) },
            y: function() { return this.context.nodes.timeline.bottom()
              + this.margin.top },
          },
          forward: {
            name: "track-control.forward",
            width: function() { return 32 },
            height: function() { return 32 },
            margin: { top: 8 },
            x: function() { return this.context.fetchNodeX(3, 4, this.width(), 4) },
            y: function() { return this.context.nodes.timeline.bottom()
              + this.margin.top },
          },
          snap: {
            name: "track-control.snap",
            width: function() { return 48 },
            height: function() { return 24 },
            margin: { top: 1, bottom: 1, left: 0, right: 1 },
            x: function() { return this.context.width() 
              - this.margin.right
              - this.width() },
            y: function() { return this.context.height()
              - this.margin.bottom 
              - this.height() },
          },
          toolbar: {
            name: "track-control.toolbar",
            width: function() { return 100 },
            height: function() { return 24 },
            margin: { top: 1, bottom: 1, left: 0, right: 0 },
            x: function() { return this.context.nodes.snap.left() 
              - this.margin.right
              - this.width() },
            y: function() { return this.context.height()
              - this.margin.bottom
              - this.height() },
          },
          zoomIn: {
            name: "track-control.zoomOut",
            width: function() { return 14 },
            height: function() { return 24 },
            margin: { top: 1, bottom: 1, left: 0, right: 0 },
            x: function() { return this.context.nodes.toolbar.left() 
              - this.margin.right
              - this.width() },
            y: function() { return this.context.height()
              - this.margin.bottom 
              - this.height()
            },
          },
          zoomOut: {
            name: "track-control.zoomIn",
            width: function() { return 14 },
            height: function() { return 24 },
            margin: { top: 1, bottom: 1, left: 0, right: 0 },
            x: function() { return this.context.nodes.zoomIn.left() 
              - this.margin.right
              - this.width() },
            y: function() { return this.context.height()
              - this.margin.bottom
              - this.height()
            },
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
          getClipboard: Beans.get(BeanVisuEditorIO).mouse.getClipboard,
          setClipboard: Beans.get(BeanVisuEditorIO).mouse.setClipboard,
          pointer: {
            name: "texture_slider_pointer_track_control",
            scaleX: 0.125,
            scaleY: 0.125,
          },
          progress: { 
            thickness: 1.75, 
            alpha: 1.0,
            blend: VETheme.color.accentLight,
            line: { name: "texture_grid_line_bold" },
            cornerFrom: { name: "texture_empty" },
            cornerTo: { name: "texture_empty" },
          },
          background: {
            thickness: 0.0, 
            blend: VETheme.color.side,
            alpha: 0.0,
          },
          preRender: function() {
            var background = Struct.get(this, "_background")
            if (!Core.isType(background, TexturedLine)) {
              background = new TexturedLine({
                thickness: 2.0, 
                blend: VETheme.color.side,
                alpha: 0.75,
                line: { name: "texture_grid_line_default" },
                cornerFrom: { name: "texture_empty" },
                cornerTo: { name: "texture_empty" },
              })
              Struct.set(this, "_background", background)
            }

            var fromX = this.context.area.getX() + this.area.getX()
            var fromY = this.context.area.getY() + this.area.getY() + (this.area.getHeight() / 2)
            var widthMax = this.area.getWidth() + (this.pointer.getWidth() * this.pointer.scaleX())
            var width = ((this.value - this.minValue) / abs(this.minValue - this.maxValue)) * widthMax
            background.render(fromX, fromY, fromX + widthMax, fromY)
          },
          state: new Map(String, any),
          updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          updateCustom: function() {
            var controller = Beans.get(BeanVisuController)
            var trackService = controller.trackService
            var mousePromise = Beans.get(BeanVisuEditorIO).mouse.getClipboard()
            var context = Struct.get(Struct.get(mousePromise, "state"), "context")
            var ruler = Beans.get(BeanVisuEditorController).timeline.containers.get("ve-timeline-ruler")
            if (context == this) {
              this.updatePosition(MouseUtil.getMouseX() - this.context.area.getX())
              return
            } else if (context != null && context == ruler) {
              var mouseXTime = ruler.state.get("mouseXTime")
              if (Core.isType(mouseXTime, Number)) {
                this.value = clamp(
                  mouseXTime / trackService.duration, 
                  this.minValue, 
                  this.maxValue
                )
                return
              }
            }

            if (this.state.contains("promise")) {
              var promise = this.state.get("promise")
              if (Struct.get(promise, "status") == PromiseStatus.PENDING) {
                return
              }
              this.state.remove("promise")
            }
            
            if (controller.fsm.getStateName() == "rewind") {
              return
            }

            this.value = clamp(
              trackService.time / trackService.duration, 
              this.minValue, 
              this.maxValue
            )
          },
          updatePosition: function(mouseX) {
            var width = this.area.getWidth() - (this.area.getX() * 2)
            this.value = clamp(mouseX / width, this.minValue, this.maxValue)

            var controller = Beans.get(BeanVisuController)
            var editor = Beans.get(BeanVisuEditorController)
            var ruler = editor.uiService.find("ve-timeline-ruler")
            if (Optional.is(ruler)) {
              ruler.state.set("time", this.value * controller.trackService.duration)
            }

            var events = editor.uiService.find("ve-timeline-events")
            if (Optional.is(events)) {
              events.state.set("time", this.value * controller.trackService.duration)
            }
          },
          onMousePressedLeft: function(event) {
            this.updatePosition(event.data.x - this.context.area.getX())
          },
          onMouseReleasedLeft: function(event) {
            this.updatePosition(event.data.x - this.context.area.getX())
            this.sendEvent()
          },
          onMouseDragLeft: function(event) {
            var context = this
            var mouse = Beans.get(BeanVisuEditorIO).mouse
            var name = Struct.get(mouse.getClipboard(), "name")
            if (name == "resize_accordion"
                || name == "resize_brush_toolbar"
                || name == "resize_brush_inspector"
                || name == "resize_template_inspector"
                || name == "resize_timeline"
                || name == "resize_event_title"
                || !Beans.get(BeanVisuController).trackService.isTrackLoaded()) {
              return
            }

            Beans.get(BeanVisuEditorIO).mouse.setClipboard(new Promise()
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
            var controller = Beans.get(BeanVisuController)
            var timestamp = this.value * (controller.trackService.duration - (FRAME_MS * 4))
            var promise = controller
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
            this.sprite.setBlend(ColorUtil.fromHex(VETheme.color.accentLight).toGMColor())
          },
          onMouseHoverOut: function(event) {
            this.sprite.setBlend(ColorUtil.fromHex(VETheme.color.textShadow).toGMColor())
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
            width: function() { return (this.context.width() - this.margin.left - this.margin.right) 
              / this.collection.getSize() },
            x: function() { return this.context.x()
              + (this.collection.getIndex() * this.width())
              + (this.collection.getIndex() * this.margin.right) },
          }
        },
        config: {
          backgroundColorSelected: VETheme.color.accentShadow,
          backgroundColor: VETheme.color.primaryDark,
          backgroundColorHover: ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
          backgroundColorOn: ColorUtil.fromHex(VETheme.color.accentShadow).toGMColor(),
          backgroundColorOff: ColorUtil.fromHex(VETheme.color.primaryDark).toGMColor(),
          backgroundMargin: { top: 1, bottom: 1, right: 1, left: 1 },
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
          label: {
            text: json.text,
            color: VETheme.color.textShadow,
            align: { v: VAlign.CENTER, h: HAlign.CENTER },
            font: "font_inter_8_bold",
          },
          tool: json.tool,
          description: json.description,
          render: function() {
            if (Optional.is(this.preRender)) {
              this.preRender()
            }
            this.renderBackgroundColor()
      
            if (this.sprite != null) {
              var alpha = this.sprite.getAlpha()
              this.sprite
                .setAlpha(alpha * (Struct.get(this.enable, "value") == false ? 0.5 : 1.0))
                .scaleToFillStretched(this.area.getWidth(), this.area.getHeight())
                .render(
                  this.context.area.getX() + this.area.getX(),
                  this.context.area.getY() + this.area.getY())
                .setAlpha(alpha)
            }
      
            if (this.label != null) {
              this.label.render(
                // todo VALIGN HALIGN
                this.context.area.getX() + this.area.getX() + (this.area.getWidth() / 2),
                this.context.area.getY() + this.area.getY() + (this.area.getHeight() / 2)
              )
            }

            if (this.isHoverOver) {
              var text = this.label.text
              this.label.text = this.description
              this.label.render(
                // todo VALIGN HALIGN
                this.context.area.getX() + this.area.getX() + (this.area.getWidth() / 2),
                this.context.area.getY() + this.area.getY() + (this.area.getHeight() / 2) - 24
              )
              this.label.text = text
            }
            return this
          },
        },
      }
    }

    var controller = this
    var layout = this.factoryLayout(parent)
    return new Map(String, UI, {
      "ve-track-control": new UI({
        name: "ve-track-control",
        state: new Map(String, any, {
          "background-color": ColorUtil.fromHex(VETheme.color.primaryDark).toGMColor(),
          "background-alpha": 0.7,
          "store": Beans.get(BeanVisuEditorController).store,
          "tools": new Array(Struct, [
            factoryToolItem({ 
              name: "ve-track-control_tool_brush", 
              text: "B", 
              description: "Brush", 
              tool: "tool_brush",
            }),
            factoryToolItem({ 
              name: "ve-track-control_tool_eraser", 
              text: "E", 
              description: "Erase", 
              tool: "tool_erase",
            }),
            factoryToolItem({ 
              name: "ve-track-control_tool_clone", 
              text: "C", 
              description: "Clone", 
              tool: "tool_clone",
            }),
            factoryToolItem({ 
              name: "ve-track-control_tool_select", 
              text: "S", 
              description: "Select", 
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
          } else if (this.spinnerFactor > 0) {
            this.spinnerFactor = lerp(this.spinnerFactor, 0.0, 0.1)
            this.spinner
              .setAlpha(this.spinnerFactor / 100.0)
              .render(
              (GuiWidth() / 2) - ((this.spinner.getWidth() * this.spinner.getScaleX()) / 2),
              (GuiHeight() / 2) - ((this.spinner.getHeight() * this.spinner.getScaleY()) / 2)
                - (this.spinnerFactor / 2)
            )
          }
        },
        items: {
          "slider_ve-track-control_timeline": factorySlider({
            layout: layout.nodes.timeline,
          }),
          "button_ve-track-control_backward": factoryButton({
            layout: layout.nodes.backward,
            sprite: { 
              name: "texture_ve_trackcontrol_button_rewind_left",
              blend: VETheme.color.textShadow,
            },
            callback: function() {
              Logger.debug("VETrackControl", $"Button pressed: {this.name}")
              var controller = Beans.get(BeanVisuController)
              controller.send(new Event("rewind").setData({
                timestamp: clamp(
                  controller.trackService.time - 10.0, 
                  0, 
                  controller.trackService.duration),
              }))
            },
          }),
          "button_ve-track-control_play": factoryButton({
            layout: layout.nodes.play,
            sprite: {
              name: "texture_ve_trackcontrol_button_play",
              blend: VETheme.color.textShadow,
            },
            callback: function() {
              Logger.debug("VETrackControl", $"Button pressed: {this.name}")
              Beans.get(BeanVisuController).send(new Event("play"))
            },
          }),
          "button_ve-track-control_pause": factoryButton({
            layout: layout.nodes.pause,
            sprite: {
              name: "texture_ve_trackcontrol_button_pause",
              blend: VETheme.color.textShadow,
            },
            callback: function() {
              Logger.debug("VETrackControl", $"Button pressed: {this.name}")
              Beans.get(BeanVisuController).send(new Event("pause"))
            },
          }),
          "button_ve-track-control_forward": factoryButton({
            layout: layout.nodes.forward,
            sprite: {
              name: "texture_ve_trackcontrol_button_rewind_right",
              blend: VETheme.color.textShadow,
            },
            callback: function() {
              Logger.debug("VETrackControl", $"Button pressed: {this.name}")
              var controller = Beans.get(BeanVisuController)
              controller.send(new Event("rewind").setData({
                timestamp: clamp(
                  controller.trackService.time + 10.0, 
                  0, 
                  controller.trackService.duration),
              }))
            },
          }),
          "text_ve-track-control_timestamp": factoryLabel({
            layout: layout.nodes.timestamp,
            text: "",
            align: { v: VAlign.CENTER, h: HAlign.LEFT },
            updateCustom: function() {
              var trackService = Beans.get(BeanVisuController).trackService
              var value = Struct.get(this.context.items
                .get("slider_ve-track-control_timeline"), "value")
              if (!trackService.isTrackLoaded()
                  || !Core.isType(value, Number) 
                  || Math.isNaN(value) 
                  || Math.isNaN(trackService.duration)) {

                this.label.text = ""
                return
              }
              
              this.label.text = String
                .formatTimestampMilisecond(NumberUtil
                .parse(trackService.duration * value, 0.0))
            },
          }),
          "checkbox_ve-track-control_snap": Struct.appendRecursiveUnique(
            {
              type: UIButton,
              layout: layout.nodes.snap,
              store: { key: "snap" },
              label: {
                text: "Snap",
                font: "font_inter_10_bold",
                color: VETheme.color.textShadow,
                align: { v: VAlign.CENTER, h: HAlign.CENTER },
              },
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
              updateCustom: function() { },
              callback: function() { 
                this.context.state.get("store").get("snap").set(!this.value)
                this.onMouseHoverOut()
              },
              backgroundMargin: { top: 1, bottom: 1, left: 1, right: 1 },
              backgroundColor: (Beans.get(BeanVisuEditorController).store.getValue("snap")
                ? VETheme.color.primary
                : VETheme.color.primaryDark),
              onMouseHoverOver: function(event) {
                this.backgroundColor = this.context.state.get("store").getValue("snap")
                  ? ColorUtil.fromHex(VETheme.color.accentShadow).toGMColor()
                  : ColorUtil.fromHex(VETheme.color.primaryShadow).toGMColor()
              },
              onMouseHoverOut: function(event) {
                this.backgroundColor = this.context.state.get("store").getValue("snap")
                  ? ColorUtil.fromHex(VETheme.color.accentShadow).toGMColor()
                  : ColorUtil.fromHex(VETheme.color.primaryDark).toGMColor()
              },
            },
            null,//VEStyles.get("ve-track-control"),
            false
          ),
          "button-ve-track-control_zoom-in": Struct.appendRecursiveUnique(
            {
              type: UIButton,
              label: { 
                text: "+",
                color: VETheme.color.textShadow,
                align: { v: VAlign.CENTER, h: HAlign.CENTER },
                font: "font_inter_8_bold",
              },
              layout: layout.nodes.zoomIn,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
              callback: function() { 
                var item = Beans.get(BeanVisuEditorController).store
                  .get("timeline-zoom")
                item.set(clamp(item.get() - 1, 5, 20))
              },
              backgroundMargin: { top: 1, bottom: 1, left: 1, right: 1 },
              backgroundColor: VETheme.color.primary,
              backgroundColorSelected: VETheme.color.primaryLight,
              backgroundColorOut: VETheme.color.primary,
              onMouseHoverOver: function(event) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
              },
              onMouseHoverOut: function(event) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
              },
              description: "Zoom in",
              render: function() {
                if (Optional.is(this.preRender)) {
                  this.preRender()
                }
                this.renderBackgroundColor()
          
                if (this.sprite != null) {
                  var alpha = this.sprite.getAlpha()
                  this.sprite
                    .setAlpha(alpha * (Struct.get(this.enable, "value") == false ? 0.5 : 1.0))
                    .scaleToFillStretched(this.area.getWidth(), this.area.getHeight())
                    .render(
                      this.context.area.getX() + this.area.getX(),
                      this.context.area.getY() + this.area.getY())
                    .setAlpha(alpha)
                }
          
                if (this.label != null) {
                  this.label.render(
                    // todo VALIGN HALIGN
                    this.context.area.getX() + this.area.getX() + (this.area.getWidth() / 2),
                    this.context.area.getY() + this.area.getY() + (this.area.getHeight() / 2)
                  )
                }
    
                if (this.isHoverOver) {
                  var text = this.label.text
                  this.label.text = this.description
                  this.label.render(
                    // todo VALIGN HALIGN
                    this.context.area.getX() + this.area.getX() + (this.area.getWidth() / 2),
                    this.context.area.getY() + this.area.getY() + (this.area.getHeight() / 2) - 24
                  )
                  this.label.text = text
                }
                return this
              },
            },
            null,//VEStyles.get("ve-track-control").button,
            false
          ),
          "button-ve-track-control_zoom-out": Struct.appendRecursiveUnique(
            {
              type: UIButton,
              label: { 
                text: "-",
                color: VETheme.color.textShadow,
                align: { v: VAlign.CENTER, h: HAlign.CENTER },
                font: "font_inter_8_bold",
              },
              layout: layout.nodes.zoomOut,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
              callback: function() { 
                var item = Beans.get(BeanVisuEditorController).store
                  .get("timeline-zoom")
                item.set(clamp(item.get() + 1, 5, 20))
              },
              backgroundMargin: { top: 1, bottom: 1, left: 1, right: 1 },
              backgroundColor: VETheme.color.primary,
              backgroundColorSelected: VETheme.color.primaryLight,
              backgroundColorOut: VETheme.color.primary,
              onMouseHoverOver: function(event) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
              },
              onMouseHoverOut: function(event) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
              },
              description: "Zoom out",
              render: function() {
                if (Optional.is(this.preRender)) {
                  this.preRender()
                }
                this.renderBackgroundColor()
          
                if (this.sprite != null) {
                  var alpha = this.sprite.getAlpha()
                  this.sprite
                    .setAlpha(alpha * (Struct.get(this.enable, "value") == false ? 0.5 : 1.0))
                    .scaleToFillStretched(this.area.getWidth(), this.area.getHeight())
                    .render(
                      this.context.area.getX() + this.area.getX(),
                      this.context.area.getY() + this.area.getY())
                    .setAlpha(alpha)
                }
          
                if (this.label != null) {
                  this.label.render(
                    // todo VALIGN HALIGN
                    this.context.area.getX() + this.area.getX() + (this.area.getWidth() / 2),
                    this.context.area.getY() + this.area.getY() + (this.area.getHeight() / 2)
                  )
                }
    
                if (this.isHoverOver) {
                  var text = this.label.text
                  this.label.text = this.description
                  this.label.render(
                    // todo VALIGN HALIGN
                    this.context.area.getX() + this.area.getX() + (this.area.getWidth() / 2),
                    this.context.area.getY() + this.area.getY() + (this.area.getHeight() / 2) - 24
                  )
                  this.label.text = text
                }
                return this
              },
            },
            null,//VEStyles.get("ve-track-control").button,
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
      }, Beans.get(BeanVisuEditorController).uiService)
    },
    "close": function(event) {
      var context = this
      this.containers.forEach(function(container, key, uiService) {
        uiService.dispatcher.execute(new Event("remove", { 
          name: key, 
          quiet: true,
        }))
      }, Beans.get(BeanVisuEditorController).uiService).clear()
    },
  }), { 
    enableLogger: false, 
    catchException: false,
  })

  ///@param {Event} event
  ///@return {?Promise}
  send = function(event) {
    return this.dispatcher.send(event)
  }

  ///@return {VETrackControl}
  update = function() { 
    try {
      this.dispatcher.update()
    } catch (exception) {
      var message = $"VETrackControl dispatcher fatal error: {exception.message}"
      Beans.get(BeanVisuController).send(new Event("spawn-popup", { message: message }))
      Logger.error("UI", message)
    }
    return this
  }
}