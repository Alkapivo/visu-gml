///@package com.alkapivo.visu.component.grid.renderer.GridOverlayRenderer

///@todo rename to sth that reflects video, background and foreground renderer
///@param {GridRenderer} _renderer
function GridOverlayRenderer(_renderer) constructor {

  ///@type {GridRenderer}
  renderer = Assert.isType(_renderer, GridRenderer)

  ///@type {Array<Task>}
  backgrounds = new Array(Task).enableGC()

  ///@type {Array<Task>}
  foregrounds = new Array(Task).enableGC()

  ///@type {Array<Task>}
  backgroundColors = new Array(Task).enableGC()

  ///@type {Array<Task>}
  foregroundColors = new Array(Task).enableGC()

  ///@return {GridOverlayRenderer}
  clear = function() {
    this.backgrounds.clear()
    this.foregrounds.clear()
    this.backgroundColors.clear()
    this.foregroundColors.clear()
    return this
  }

  ///@return {GridOverlayRenderer}
  renderBackgrounds = function(x = 0, y = 0, zoom = 1.0) {
    static renderBackgroundColor = function(task) {
      var color = task.state.get("color")
      var alpha = color.alpha
      color = color.toGMColor()
      GPU.render.rectangle(0, 0, GuiWidth(), GuiHeight(), false, color, color, color, color, alpha)
    }

    static renderBackground = function(task, index, acc) {
      var sprite = task.state.get("sprite")
      sprite.scaleToFill(GuiWidth() * acc.zoom, GuiHeight() * acc.zoom)
        .render(
          acc.x + (sprite.texture.offsetX / sprite.texture.width) * GuiWidth(),
          acc.y + (sprite.texture.offsetY / sprite.texture.height) * GuiHeight()
        )
    }

    this.backgroundColors.forEach(renderBackgroundColor)
    this.backgrounds.forEach(renderBackground, { x: x, y: y, zoom: zoom })
    return this
  }

  ///@return {GridOverlayRenderer}
  renderForegrounds = function(x = 0, y = 0, zoom = 1.0) {
    static renderForegroundColor = function(task) {
      var color = task.state.get("color")
      var alpha = color.alpha
      color = color.toGMColor()
      GPU.render.rectangle(0, 0, GuiWidth(), GuiHeight(), false, color, color, color, color, alpha)
    }

    static renderForeground = function(task, index, acc) {
      var sprite = task.state.get("sprite")
      sprite.scaleToFill(GuiWidth() * acc.zoom, GuiHeight() * acc.zoom)
        .render(
          acc.x + (sprite.texture.offsetX / sprite.texture.width) * GuiWidth(),
          acc.y + (sprite.texture.offsetY / sprite.texture.height) * GuiHeight()
        )
    }

    GPU.set.blendMode(BlendMode.ADD)
    this.foregroundColors.forEach(renderForegroundColor)
    this.foregrounds.forEach(renderForeground, { x: x, y: y, zoom: zoom })
    GPU.reset.blendMode()
    return this
  }

  ///@return {GridOverlayRenderer}
  renderVideo = function(x = 0, y = 0, zoom = 1.0) {
    var video = this.renderer.controller.videoService.getVideo()
    if (!Core.isType(video, Video) || !video.isLoaded()) {
      return this
    }

    video.surface.update()
      .scaleToFill(round(GuiWidth() * zoom), round(GuiHeight() * zoom))
    video.surface.render(
      x - (video.surface.width / GuiWidth()) / 2.0, 
      y - (video.surface.height / GuiHeight()) / 2.0
    )    
    return this
  }

  ///@return {GridOverlayRenderer}
  update = function() {
    static gcFilter = function(task, index, gc) {
      if (!Core.isType(task, Task)
        || task.name != "fade-sprite"
        || task.status == TaskStatus.FULLFILLED
        || task.status == TaskStatus.REJECTED
        || !Core.isType(task.state.get("sprite"), Sprite)) {
        
        gc.add(index)
      }
    }

    static gcColorFilter = function(task, index, gc) {
      if (!Core.isType(task, Task)
        || task.name != "fade-color"
        || task.status == TaskStatus.FULLFILLED
        || task.status == TaskStatus.REJECTED
        || !Core.isType(task.state.get("color"), Color)) {
        
        gc.add(index)
      }
    }

    this.backgrounds.forEach(gcFilter, this.backgrounds.gc).runGC()
    this.foregrounds.forEach(gcFilter, this.foregrounds.gc).runGC()
    this.backgroundColors.forEach(gcColorFilter, this.backgroundColors.gc).runGC()
    this.foregroundColors.forEach(gcColorFilter, this.foregroundColors.gc).runGC()
    return this
  }
}
