///@package io.alkapivo.visu.service.lyrics

///@param {Controller} _controller
///@param {Struct} [config]
function LyricsRenderer(_controller, config = {}) constructor {

  ///@type {VisuController}
  controller = Assert.isType(_controller, VisuController)

  ///@type {Surface}
  surface = new Surface({ width: GuiWidth(), height: GuiHeight() })

  ///@type {Number}
  alpha = 1.0
  
  ///@type {Number}
  shake = 1.0

  ///@private
  ///@param {LyricsService} renderer
  renderSurface = function(renderer) {
    if (!this.renderLyrics) {
      return
    }
  }

  ///@return {LyricsService}
  render = function() {
    this.surface.update(GuiWidth(), GuiHeight())
      .renderOn(function() {

      }, this)
    return this
  }

  free = function() {
    this.surface.free()
  }
}