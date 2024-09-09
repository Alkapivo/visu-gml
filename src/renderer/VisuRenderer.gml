///@package io.alkapivo.visu.renderer

function VisuRenderer() constructor {

  ///@type {Boolean}
  renderVE = true

  ///@type {VisuHUDRenderer}
  hudRenderer = new VisuHUDRenderer()

  ///@type {LyricsRenderer}
  lyricsRenderer = new LyricsRenderer()

  ///@private
  ///@type {UILayout}
  canvas = new UILayout({
    name: "visu-game-canvas",
    x: function() { return 0 },
    y: function() { return 0 },
    width: GuiWidth,
    height: GuiHeight,
  })

  ///@private
  ///@return {VisuRenderer}
  init = function() {
    this.hudRenderer.init()
    return this
  }

  ///@return {VisuRenderer}
  update = function() {
    var controller = Beans.get(BeanVisuController)
    this.renderVE = controller.renderUI ///@hack

    var editor = Beans.get(BeanVisuEditorController)
    var _canvas = editor == null ? this.canvas : editor.layout.nodes.preview
    this.hudRenderer.update(_canvas)
    return this
  }

  ///@return {VisuRenderer}
  render = function() {
    return this
  }

  ///@return {VisuRenderer}
  renderGUI = function() {
    var editor = Beans.get(BeanVisuEditorController)
    var _canvas = editor == null ? this.canvas : editor.layout.nodes.preview
    this.lyricsRenderer.renderGUI(_canvas)
    this.hudRenderer.renderGUI(_canvas)
    return this
  }

  ///@return {VisuRenderer}
  free = function() {
    return this
  }

  this.init()
}