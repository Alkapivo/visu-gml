///@package io.alkapivo.visu.service.ui.track

///@param {VisuController} _controller
function VisuEditor(_controller) constructor {
  
  ///@type {VisuController}
  controller = Assert.isType(_controller, VisuController)

  ///@type {FileService}
  fileService = Assert.isType(this.controller.fileService, FileService)
  
  ///@type {UIService}
  uiService = Assert.isType(this.controller.uiService, UIService)
  
  ///@type {TrackService}
  trackService = Assert.isType(this.controller.trackService, TrackService)

  ///@type {ShaderPipeline}
  shaderPipeline = Assert.isType(this.controller.shaderPipeline, ShaderPipeline)

  ///@type {ShroomService}
  shroomService = Assert.isType(this.controller.shroomService, ShroomService)

  ///@type {VEBrushService}
  brushService = new VEBrushService(this)
  
  ///@type {VETitleBar}
  titleBar = new VETitleBar(this)

  ///@type {VEAccordion}
  accordion = new VEAccordion(this)

  ///@type {VEPreview}
  //preview = new VEPreview(this)

  ///@type {VETrackControl}
  trackControl = new VETrackControl(this)

  ///@type {VisuTimeline}
  timeline = new VETimeline(this)

  ///@type {VEBrushToolbar}
  brushToolbar = new VEBrushToolbar(this)

  ///@type {VEStatusBar}
  statusBar = new VEStatusBar(this)

  ///@type {Store}
  store = new Store({
    "render-event": {
      type: Boolean,
      value: false,
    },
    "render-timeline": {
      type: Boolean,
      value: false,
    },
    "render-brush": {
      type: Boolean,
      value: true,
    },
    "new-channel-name": {
      type: String,
      value: "channel name",
    },
    "selected-event": {
      type: Optional.of(Struct),
      value: null,
    },
    "target-locked": {
      type: Boolean,
      value: false
    }
  })

  ///@private
  ///@return {UILayout}
  factoryLayout = function() {
    return new UILayout({
      name: "visu-editor",
      width: function() { return GuiWidth() },
      height: function() { return GuiHeight() },
      x: function() { return 0 },
      y: function() { return 0 },
      nodes: {
        "title-bar": {
          height: function() { return 20 },
        },
        "accordion": {
          minWidth: 200,
          maxWidth: 320,
          percentageWidth: 0.2,
          width: function() { return clamp(max(this.percentageWidth * this.context.width(), 
            this.minWidth), this.minWidth, this.maxWidth) },
          height: function() { return Struct.get(this.context.nodes, "timeline").top()
            - Struct.get(this.context.nodes, "title-bar").bottom() },
          y: function() { return Struct.get(this.context.nodes, "title-bar").bottom() },
        },
        "preview": {
          width: function() { return this.context.width()
            - Struct.get(this.context.nodes, "accordion").width()
            - Struct.get(this.context.nodes, "brush-toolbar").width() },
          height: function() { return this.context.height()
            - Struct.get(this.context.nodes, "title-bar").height()
            - Struct.get(this.context.nodes, "track-control").height()
            - Struct.get(this.context.nodes, "timeline").height()
            - Struct.get(this.context.nodes, "status-bar").height()},
          x: function() { return Struct
            .get(this.context.nodes, "accordion").right() },
          y: function() { return Struct
            .get(this.context.nodes, "title-bar").bottom() },
        },
        "track-control": {
          width: function() { return Struct.get(this.context.nodes, "preview").width() },
          height: function() { return 80 },
          x: function() { return Struct.get(this.context.nodes, "preview").x() },
          y: function() { return Struct.get(this.context.nodes, "preview").bottom() },
        },
        "brush-toolbar": {
          minWidth: 200,
          maxWidth: 320,
          percentageWidth: 0.2,
          width: function() { return clamp(max(this.percentageWidth * this.context.width(), 
            this.minWidth), this.minWidth, this.maxWidth) },
          height: function() { return this.context.height()
            - Struct.get(this.context.nodes, "title-bar").height()
            - Struct.get(this.context.nodes, "status-bar").height() },
          x: function() { return this.context.x() + this.context.width() - this.width() },
          y: function() { return Struct.get(this.context.nodes, "title-bar").bottom() },
        },
        "timeline": {
          minHeight: 80,
          maxHeight: 400,
          percentageHeight: 0.25,
          width: function() { return this.context.width()
            - Struct.get(this.context.nodes, "brush-toolbar").width() },
          height: function() { return clamp(max(this.percentageHeight * this.context.height(), 
            this.minHeight), this.minHeight, this.maxHeight) },
          y: function() { return this.context.height() - this.height()
            - Struct.get(this.context.nodes, "status-bar").height() },
        },
        "status-bar": {
          height: function() { return 24 },
          y: function() { return this.context.height() - this.height() },
        },
      },
    })
  }

  ///@type {UILayout}
  layout = this.factoryLayout()

  ///@debug
  render = function() {
    static renderLayout = function(layout, color) {
      var beginX = layout.x()
      var beginY = layout.y()
      var endX = beginX + layout.width()
      var endY = beginY + layout.height()
      GPU.render.rectangle(beginX, beginY, endX, endY, false, color, color, color, color, 0.5)
    }

    renderLayout(this.layout, c_red)
    renderLayout(Struct.get(this.layout.nodes, "title-bar"), c_blue)
    renderLayout(Struct.get(this.layout.nodes, "accordion"), c_yellow)
    renderLayout(Struct.get(this.layout.nodes, "preview"), c_fuchsia)
    renderLayout(Struct.get(this.layout.nodes, "track-control"), c_lime)
    renderLayout(Struct.get(this.layout.nodes, "brush-toolbar"), c_orange)
    renderLayout(Struct.get(this.layout.nodes, "timeline"), c_green)
    renderLayout(Struct.get(this.layout.nodes, "status-bar"), c_grey)
  }

  ///@type {EventPump}
  dispatcher = new EventPump(this, new Map(String, Callable, {
    "open": function(event) {
      return {
        "titleBar": this.titleBar.send(new Event("open")
          .setData({ layout: Struct.get(this.layout.nodes, "title-bar") })),
        "accordion": this.accordion.send(new Event("open")
          .setData({ layout: Struct.get(this.layout.nodes, "accordion") })),
        //"preview": this.preview.send(new Event("open")
        //  .setData({ layout: Struct.get(this.layout.nodes, "preview") })),
        "trackControl": this.trackControl.send(new Event("open")
          .setData({ layout: Struct.get(this.layout.nodes, "track-control") })),
        "brushToolbar": this.brushToolbar.send(new Event("open")
          .setData({ layout: Struct.get(this.layout.nodes, "brush-toolbar") })),
        "timeline": this.timeline.send(new Event("open")
          .setData({ layout: Struct.get(this.layout.nodes, "timeline") })),
        "statusBar": this.statusBar.send(new Event("open")
          .setData({ layout: Struct.get(this.layout.nodes, "status-bar") })),
      }
    },
    "close": function(event) {
      return {
        //"titleBar": this.titleBar.send(new Event("close")),
        "accordion": this.accordion.send(new Event("close")),
        //"preview": this.preview.send(new Event("close")),
        "trackControl": this.trackControl.send(new Event("close")),
        "brushToolbar": this.brushToolbar.send(new Event("close")),
        "timeline": this.timeline.send(new Event("close")),
        //"statusBar": this.statusBar.send(new Event("close")),
      }
    },
    "load": function(event) {
      return {
        //"timeline": this.timeline.send(new Event(event.name, event.data, event.promise)),
      }
    },
    "select": function(event) { },
    "deselect": function(event) { },
  }))

  ///@param {Event} event
  ///@return {?Promise}
  send = function(event) {
    return this.dispatcher.send(event)
  }

  ///@return {VisuEditor}
  update = function() {
    this.dispatcher.update()
    this.titleBar.update()
    this.accordion.update()
    //this.preview.update()
    this.trackControl.update()
    this.brushToolbar.update()
    this.timeline.update()
    this.statusBar.update()

    var renderBrush = this.store.getValue("render-brush")
    var brushNode = Struct.get(this.layout.nodes, "brush-toolbar")
    brushNode.minWidth = renderBrush ? 200 : 0
    brushNode.maxWidth = renderBrush ? 320 : 0
    this.brushToolbar.containers.forEach(function(container, key, enable) {
      container.enable = enable
    }, renderBrush)

    var renderTimeline = this.store.getValue("render-timeline")
    var timelineNode = Struct.get(this.layout.nodes, "timeline")
    timelineNode.minHeight = renderTimeline ? 80 : 0
    timelineNode.maxHeight = renderTimeline ? 400 : 0
    this.timeline.containers.forEach(function(container, key, enable) {
      container.enable = enable
    }, renderTimeline)

    var renderEvent = this.store.getValue("render-event")
    var accordionNode = Struct.get(this.layout.nodes, "accordion")
    accordionNode.minWidth = renderEvent ? 200 : 0
    accordionNode.maxWidth = renderEvent ? 320 : 0
    this.accordion.containers.forEach(function(container, key, enable) {
      if (key == "_ve-accordion_accordion-items") {
        container.enable = enable
      } else {
        if (!enable) {
          container.enable = false
        }
      }
    }, renderEvent)

    return this
  }
}
