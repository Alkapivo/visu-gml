///@package io.alkapivo.visu.editor.ui

///@param {VisuEditor} _editor
function VEStatusBar(_editor) constructor {

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
        name: "status-bar",
        nodes: {
          fpsLabel: {
            name: "status-bar.fpsLabel",
            x: function() { return this.context.x() + this.margin.left },
            y: function() { return 0 },
            width: function() { return 40 },
          },
          fpsValue: {
            name: "status-bar.fpsValue",
            x: function() { return this.context.nodes.fpsLabel.right() + this.margin.left  },
            y: function() { return 0 },
            margin: { left: 4 },
            width: function() { return 24 },
          },
          timestampLabel: {
            name: "status-bar.timestampLabel",
            x: function() { return this.context.nodes.fpsValue.right() + this.margin.left  },
            y: function() { return 0 },
            width: function() { return 80 },
          },
          timestampValue: {
            name: "status-bar.timestampValue",
            x: function() { return this.context.nodes.timestampLabel.right() + this.margin.left  },
            y: function() { return 0 },
            margin: { left: 4 },
            width: function() { return 48 },
          },
          durationLabel: {
            name: "status-bar.durationLabel",
            x: function() { return this.context.nodes.timestampValue.right()
              + this.margin.left },
            y: function() { return 0 },
            width: function() { return 64 },
          },
          durationValue: {
            name: "status-bar.durationValue",
            x: function() { return this.context.nodes.durationLabel.right()
              + this.margin.left },
            y: function() { return 0 },
            margin: { left: 4 },
            width: function() { return 48 },
          },
          stateLabel: {
            name: "status-bar.stateLabel",
            x: function() { return this.context.nodes.stateValue.left() 
              - this.width() },
            y: function() { return 0 },
            width: function() { return 48 },
          },
          stateValue: {
            name: "status-bar.stateValue",
            x: function() { return this.context.nodes.videoLabel.left() 
              - this.width() },
            y: function() { return 0 },
            margin: { left: 4 },
            width: function() { return 48 },
          },
          videoLabel: {
            name: "status-bar.videoLabel",
            x: function() { return this.context.nodes.videoValue.left() 
              - this.width() },
            y: function() { return 0 },
            width: function() { return 48 },
          },
          videoValue: {
            name: "status-bar.videoValue",
            x: function() { return this.context.x() + this.context.width()
              - this.width() },
            y: function() { return 0 },
            margin: { left: 4 },
            width: function() { return 64 },
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
    static factoryLabel = function(json) {
      return Struct.appendRecursiveUnique(
        {
          type: UIText,
          layout: json.layout,
          text: json.text,
          updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
        },
        VEStyles.get("ve-status-bar").label,
        false
      )
    }

    static factoryValue = function(json) {
      return Struct.appendRecursiveUnique(
        {
          type: UIText,
          layout: json.layout,
          text: "VALUE",
          updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          updateCustom: json.updateCustom,
        },
        VEStyles.get("ve-status-bar").value,
        false
      )
    }

    var controller = this
    var layout = this.factoryLayout(parent)
    return new Map(String, UI, {
      "ve-status-bar": new UI({
        name: "ve-status-bar",
        state: new Map(String, any, {
          "background-color": ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
          "store": controller.editor.store,
        }),
        controller: controller,
        layout: layout,
        updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
        render: Callable.run(UIUtil.renderTemplates.get("renderDefault")),
        items: {
          "text_ve-status-bar_fpsLabel": factoryLabel({
            text: "FPS:",
            layout: layout.nodes.fpsLabel,
          }),
          "text_ve-status-bar_fpsValue": factoryValue({
            layout: layout.nodes.fpsValue,
            updateCustom: function() {
              this.label.text = string(fps)
            },
          }),
          "text_ve-status-bar_timestampLabel": factoryLabel({
            text: "Timestamp:",
            layout: layout.nodes.timestampLabel,
          }),
          "text_ve-status-bar_timestampValue": factoryValue({
            layout: layout.nodes.timestampValue,
            updateCustom: function() {
              try {
                this.label.text = String.formatTimestamp(Beans
                  .get(BeanVisuController).trackService.time)
              } catch (exception) {
                this.label.text = "N/A"
              }
            },
          }),
          "text_ve-status-bar_durationLabel": factoryLabel({
            text: "Duration:",
            layout: layout.nodes.durationLabel,
          }),
          "text_ve-status-bar_durationValue": factoryValue({
            layout: layout.nodes.durationValue,
            updateCustom: function() {
              try {
                this.label.text = String.formatTimestamp(Beans
                  .get(BeanVisuController).trackService.duration)
              } catch (exception) {
                this.label.text = "N/A"
              }
            },
          }),
          "text_ve-status-bar_stateLabel": factoryLabel({
            text: "State:",
            layout: layout.nodes.stateLabel,
          }),
          "text_ve-status-bar_stateValue": factoryValue({
            layout: layout.nodes.stateValue,
            updateCustom: function() {
              try {
                this.label.text = String.toUpperCase(Beans
                  .get(BeanVisuController).fsm
                  .getStateName())
              } catch (exception) {
                this.label.text = "N/A"
              }
            },
          }),
          "text_ve-status-bar_videoLabel": factoryLabel({
            text: "Video:",
            layout: layout.nodes.videoLabel,
          }),
          "text_ve-status-bar_videoValue": factoryValue({
            layout: layout.nodes.videoValue,
            updateCustom: function() {
              try {
                this.label.text = Beans
                  .get(BeanVisuController).videoService
                  .getVideo()
                  .getStatusName()
              } catch (exception) {
                this.label.text = "N/A"
              }
            },
          }),
        },
      }),
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

  ///@return {VEBrushToolbar}
  update = function() { 
    this.dispatcher.update()
    return this
  }
}