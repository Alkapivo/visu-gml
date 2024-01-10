///@package com.alkapivo.visu.service.grid.GridRenderer

///@param {Controller} _controller
///@param {Struct} [config]
function GridRenderer(_controller, config = {}) constructor {

  ///@todo move from GridRenderer
  application_surface_draw_enable(false)
  gpu_set_ztestenable(false)
	gpu_set_zwriteenable(false)
	gpu_set_cullmode(cull_counterclockwise)

  ///@type {Controller}
  controller = Assert.isType(_controller, Struct)

  ///@type {GridOverlayRenderer}
  overlayRenderer = new GridOverlayRenderer(this)

  ///@type {Surface}
  gameSurface = new Surface({ width: GuiWidth(), height: GuiHeight() })

  ///@type {Surface}
  gridSurface = new Surface({ width: GuiWidth(), height: GuiHeight() })

  ///@type {Surface}
  shaderSurface = new Surface({ width: GuiWidth(), height: GuiHeight() })

  ///@type {GridCamera}
  camera = new GridCamera()
  
  ///@type {GMVertexBuffer}
  vertexBuffer = new DefaultVertexBuffer(new Array(DefaultVertex, [
	  new DefaultVertex(0, 0, 0, 0, 0, 1, 0, 0, ColorUtil.WHITE, 1),
    new DefaultVertex(GRID_SERVICE_PIXEL_WIDTH, 0, 0,  0, 0, 1, 1, 0, ColorUtil.WHITE, 1),
    new DefaultVertex(GRID_SERVICE_PIXEL_WIDTH, GRID_SERVICE_PIXEL_HEIGHT, 0, 0, 0, 1, 1, 1, ColorUtil.WHITE, 1),
    new DefaultVertex(GRID_SERVICE_PIXEL_WIDTH, GRID_SERVICE_PIXEL_HEIGHT, 0, 0, 0, 1, 1, 1, ColorUtil.WHITE, 1),
    new DefaultVertex(0, GRID_SERVICE_PIXEL_HEIGHT, 0, 0, 0, 1, 0, 1, ColorUtil.WHITE, 1),
    new DefaultVertex(0, 0, 0, 0, 0, 1, 0, 0, ColorUtil.WHITE, 1)
  ])).build().buffer

  ///@private
  ///@return {GridRenderer}
  renderSeparators = function() {
    static _renderSeparators = function(thickness, alpha) {
      var gridService = this.controller.gridService
      var color = gridService.properties.accentWireframeColor.toGMColor()
      var separatorHeight = (gridService.view.height * 2) / gridService.properties.separators
      var time = gridService.properties.separatorTimer.time
      //var offset = (gridService.view.y - floor(gridService.view.y))
      var offset = gridService.view.y - 2.0 - (floor(gridService.view.y / separatorHeight) * separatorHeight)
      //gridService.view.x + 2.0 - (floor(gridService.view.x / channelWidth) * channelWidth)
      for (var index = 0; index <= gridService.properties.separators * 3; index++) {
        var beginX = -5.0 * GRID_SERVICE_PIXEL_WIDTH
        var beginY = (-5 * (gridService.view.height) + index * separatorHeight - offset + time) * GRID_SERVICE_PIXEL_HEIGHT
        var endX = 5.0 * GRID_SERVICE_PIXEL_WIDTH
        var endY = beginY
        GPU.render.texturedLine(beginX, beginY, endX, endY, thickness, alpha, color)
      }
    }

    var gridService = this.controller.gridService
    if (!gridService.properties.renderMesh) {
      return this
    }

    var accentWireframeThickness = gridService.properties.accentWireframeThickness
    if (gridService.properties.separators > 0) {
      _renderSeparators(accentWireframeThickness, 1.0)
    }

     return this
  }

  ///@private
  ///@return {GridRenderer}
  renderChannels = function() {
    static renderMainChannels = function(viewXOffset, thickness, alpha) {
      var gridService = this.controller.gridService
      var color = gridService.properties.primaryWireframeColor.toGMColor()
      var channelWidth = gridService.view.width / gridService.properties.channels
      for (var index = 0; index <= gridService.properties.channels; index++) {
        var beginX = ((index * channelWidth) - viewXOffset) * GRID_SERVICE_PIXEL_WIDTH
        var beginY = -5.0 * GRID_SERVICE_PIXEL_HEIGHT
        var endX = beginX
        var endY = (gridService.view.height + 5.0) * GRID_SERVICE_PIXEL_HEIGHT
        var scale = index >= gridService.properties.channels / 2.0
          ? index + 1
          : gridService.properties.channels - index
        GPU.render.texturedLine(beginX, beginY, endX, endY, thickness + scale, alpha, color)
      }
    }

    static renderBorderChannels = function(viewXOffset, thickness, alpha, amount) {
      var gridService = this.controller.gridService
      var color = gridService.properties.primaryWireframeColor.toGMColor()
      var channelWidth = gridService.view.width / gridService.properties.channels
      for (var index = 0; index <= amount; index++) {
        var beginX = ((index * channelWidth) - viewXOffset) * GRID_SERVICE_PIXEL_WIDTH
        var beginY = -5.0 * GRID_SERVICE_PIXEL_HEIGHT
        var endX = beginX
        var endY = (gridService.view.height + 5.0) * GRID_SERVICE_PIXEL_HEIGHT  
        GPU.render.texturedLine(beginX, beginY, endX, endY, thickness, alpha, color)
      }
    }

    var gridService = this.controller.gridService
    if (!gridService.properties.renderMesh) {
      return this
    }

    var primaryWireframeThickness = gridService.properties.primaryWireframeThickness
    var accentWireframeThickness = gridService.properties.accentWireframeThickness
    if (gridService.properties.channels > 0) {
      var channelWidth = gridService.view.width / gridService.properties.channels
      renderBorderChannels( // left
        gridService.view.x + 2.0 - (floor(gridService.view.x / channelWidth) * channelWidth),
        accentWireframeThickness, 0.75, gridService.properties.channels * 2.0
      )
      renderBorderChannels( // right
        gridService.view.x - 1.0 - (floor(gridService.view.x / channelWidth) * channelWidth),
        accentWireframeThickness, 0.75, gridService.properties.channels * 2.0
      )
      renderMainChannels( // center
        gridService.view.x - (floor(gridService.view.x / channelWidth) * channelWidth), 
        primaryWireframeThickness, 0.85
      )
    }
    return this
  }

  ///@deprecated
  ///@private
  ///@return {GridRenderer}
  renderMesh = function() {
    renderSeparators = function(thickness, alpha) {
      var gridService = this.controller.gridService
      var color = gridService.properties.accentWireframeColor.toGMColor()
      var separatorHeight = (gridService.view.height * 2) / gridService.properties.separators
      var time = gridService.properties.separatorTimer.time
      //var offset = (gridService.view.y - floor(gridService.view.y))
      var offset = gridService.view.y - 2.0 - (floor(gridService.view.y / separatorHeight) * separatorHeight)
      //gridService.view.x + 2.0 - (floor(gridService.view.x / channelWidth) * channelWidth)
      for (var index = 0; index <= gridService.properties.separators * 3; index++) {
        var beginX = -5.0 * GRID_SERVICE_PIXEL_WIDTH
        var beginY = (-5 * (gridService.view.height) + index * separatorHeight - offset + time) * GRID_SERVICE_PIXEL_HEIGHT
        var endX = 5.0 * GRID_SERVICE_PIXEL_WIDTH
        var endY = beginY
        GPU.render.texturedLine(beginX, beginY, endX, endY, thickness, alpha, color)
      }
    }

    renderMainChannels = function(viewXOffset, thickness, alpha) {
      var gridService = this.controller.gridService
      var color = gridService.properties.primaryWireframeColor.toGMColor()
      var channelWidth = gridService.view.width / gridService.properties.channels
      for (var index = 0; index <= gridService.properties.channels; index++) {
        var beginX = ((index * channelWidth) - viewXOffset) * GRID_SERVICE_PIXEL_WIDTH
        var beginY = -5.0 * GRID_SERVICE_PIXEL_HEIGHT
        var endX = beginX
        var endY = (gridService.view.height + 5.0) * GRID_SERVICE_PIXEL_HEIGHT
        var scale = index >= gridService.properties.channels / 2.0
          ? index + 1
          : gridService.properties.channels - index
        GPU.render.texturedLine(beginX, beginY, endX, endY, thickness + scale, alpha, color)
      }
    }

    renderBorderChannels = function(viewXOffset, thickness, alpha, amount) {
      var gridService = this.controller.gridService
      var color = gridService.properties.primaryWireframeColor.toGMColor()
      var channelWidth = gridService.view.width / gridService.properties.channels
      for (var index = 0; index <= amount; index++) {
        var beginX = ((index * channelWidth) - viewXOffset) * GRID_SERVICE_PIXEL_WIDTH
        var beginY = -5.0 * GRID_SERVICE_PIXEL_HEIGHT
        var endX = beginX
        var endY = (gridService.view.height + 5.0) * GRID_SERVICE_PIXEL_HEIGHT  
        GPU.render.texturedLine(beginX, beginY, endX, endY, thickness, alpha, color)
      }
    }

    var gridService = this.controller.gridService
    if (!gridService.properties.renderMesh) {
      return this
    }

    var primaryWireframeThickness = gridService.properties.primaryWireframeThickness
    var accentWireframeThickness = gridService.properties.accentWireframeThickness
    if (gridService.properties.separators > 0) {
      renderSeparators(accentWireframeThickness, 1.0)
    }

    if (gridService.properties.channels > 0) {
      var channelWidth = gridService.view.width / gridService.properties.channels
      renderBorderChannels( // left
        gridService.view.x + 2.0 - (floor(gridService.view.x / channelWidth) * channelWidth),
        accentWireframeThickness, 0.75, gridService.properties.channels * 2.0
      )
      renderBorderChannels( // right
        gridService.view.x - 1.0 - (floor(gridService.view.x / channelWidth) * channelWidth),
        accentWireframeThickness, 0.75, gridService.properties.channels * 2.0
      )
      renderMainChannels( // center
        gridService.view.x - (floor(gridService.view.x / channelWidth) * channelWidth), 
        primaryWireframeThickness, 0.85
      )
    }
    return this
  }

  playerZTimer = new Timer(pi * 2, { loop: Infinity })
  ///@private
  ///@return {GridRenderer}
  renderPlayer = function() { 
    var player = this.controller.playerService.player
    if (!Core.isType(player, Player)) {
      return this
    }

    var useBlendAsZ = false
    if (useBlendAsZ) {
      shader_set(shader_gml_use_blend_as_z)
      shader_set_uniform_f(shader_get_uniform(shader_gml_use_blend_as_z, "size"), 1024.0)
      player.sprite.blend = (sin(this.playerZTimer.update().time) * 0.5 + 0.5) * 255     
      player.sprite.render(
        (player.x - this.controller.gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
        (player.y - this.controller.gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT
      )
      shader_reset()
    } else {
      player.sprite.render(
        (player.x - this.controller.gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
        (player.y - this.controller.gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT
      )
    }
    
    return this
  }

  ///@private
  ///@return {GridRenderer}
  renderShrooms = function() {
    renderAll = function(shroom, index, gridService) {
      shroom.sprite.render(
        (shroom.x - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
        (shroom.y - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT
      )
    }
    var gridService = this.controller.gridService
    this.controller.shroomService.shrooms.forEach(renderAll, gridService)

    var spawner = this.controller.shroomService.spawner
    if (Core.isType(spawner, Struct)) {
      spawner.sprite.render(
        spawner.x * GRID_SERVICE_PIXEL_WIDTH, 
        spawner.y * GRID_SERVICE_PIXEL_HEIGHT
      )
      this.controller.shroomService.spawner = null
    }

    this.controller.gridSystem.render()
      
    return this
  }

  ///@private
  ///@return {GridRenderer}
  renderBullets = function() {
    renderAll = function(bullet, index, gridService) {
      bullet.sprite.render(
        (bullet.x - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
        (bullet.y - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT
      )
    }

    this.controller.bulletService.bullets
      .forEach(renderAll, this.controller.gridService)
    return this
  }

  ///@private
  ///@return {GridRenderer}
  renderParticles = function() {
    this.controller.particleService.systems.get("main").render()
    return this
  }

  ///@private
  ///@param {GridRenderer} renderer
  renderGridSurface = function(renderer) {
    var properties = renderer.controller.gridService.properties
    if (properties.gridClearFrame) {
      properties.gridClearColor.alpha = properties.gridClearFrameAlpha
      GPU.render.clear(properties.gridClearColor)
    }

    var depths = renderer.controller.gridService.properties.depths
      
    var cameraDistance = 160 ///@todo extract parameter
    var xto = renderer.camera.x
    var yto = renderer.camera.y
    var zto = renderer.camera.z + renderer.camera.zoom
    var xfrom = xto + cameraDistance * dcos(renderer.camera.angle) * dcos(renderer.camera.pitch)
    var yfrom = yto - cameraDistance * dsin(renderer.camera.angle) * dcos(renderer.camera.pitch)
    var zfrom = zto - cameraDistance * dsin(renderer.camera.pitch)
    renderer.camera.viewMatrix = matrix_build_lookat(xfrom, yfrom, zfrom, xto, yto, zto, 0, 0, 1)
    camera_set_view_mat(renderer.camera.gmCamera, renderer.camera.viewMatrix)
    renderer.camera.projectionMatrix = matrix_build_projection_perspective_fov(-60, -1 * GuiWidth() / GuiHeight(), 1, 32000) ///@todo extract parameters
    camera_set_proj_mat(renderer.camera.gmCamera, renderer.camera.projectionMatrix)
    camera_apply(renderer.camera.gmCamera)

    var baseX = GRID_SERVICE_PIXEL_WIDTH + GRID_SERVICE_PIXEL_WIDTH * 0.5
    var baseY = GRID_SERVICE_PIXEL_HEIGHT + GRID_SERVICE_PIXEL_HEIGHT * 0.5

    matrix_set(matrix_world, matrix_build(
      baseX, baseY, depths.channelZ, 
      0, 0, 0, 
      1, 1, 1
    ))
    renderer.renderChannels()
    
    matrix_set(matrix_world, matrix_build(
      baseX, baseY, depths.separatorZ, 
      0, 0, 0, 
      1, 1, 1
    ))
    renderer.renderSeparators()

    matrix_set(matrix_world, matrix_build(
      baseX, baseY, depths.bulletZ, 
      0, 0, 0, 
      1, 1, 1
    ))
    renderer.renderBullets()

    gpu_set_alphatestenable(true)
    matrix_set(matrix_world, matrix_build(
      baseX, baseY, depths.shroomZ, 
      0, 0, 0, 
      1, 1, 1
    ))
    renderer.renderShrooms()
    gpu_set_alphatestenable(false)

    matrix_set(matrix_world, matrix_build(
      baseX, baseY, depths.particleZ, 
      0, 0, 0, 
      1, 1, 1
    ))
    renderer.renderParticles()

    matrix_set(matrix_world, matrix_build(
      baseX, baseY, depths.playerZ, 
      0, 0, 0, 
      1, 1, 1
    ))
    renderer.renderPlayer()

    matrix_set(matrix_world, matrix_build_identity())
  }

  ///@private
  ///@param {GridRenderer} renderer
  renderShaderSurface = function(renderer) {
    var properties = renderer.controller.gridService.properties
    GPU.render.clear(properties.shaderClearColor)
    renderer.controller.shaderPipeline.render(function(task, index, renderer) {
      var alpha = task.state.get("alpha")
      renderer.gridSurface.render(0, 0, alpha)

      if (!renderer.controller.gridService.properties.renderOverlay 
        || index < renderer.controller.gridService.properties.renderOverlayTreshold) {
        return
      }

      GPU.set.blendMode(BlendMode.ADD)
      renderer.gridSurface.render(0, 0, renderer.controller.gridService.properties.renderOverlayAlpha)
      GPU.reset.blendMode()
    }, renderer)
  }

  ///@private
  ///@param {GridRenderer} renderer
  renderGameSurface = function(renderer) {
    GPU.render.clear(renderer.controller.gridService.properties.gridClearColor)
    renderer.overlayRenderer.renderVideo()
    renderer.overlayRenderer.renderBackgrounds()
    renderer.gridSurface.render()
    renderer.shaderSurface.render()
    renderer.overlayRenderer.renderForegrounds()
  }

  ///@return {GridRenderer}
  update = function() {
    this.camera.update()
    this.overlayRenderer.update()
  }

  ///@return {GridRenderer}
  render = function() {
    this.gridSurface.update(GuiWidth(), GuiHeight())
      .renderOn(this.renderGridSurface, this)
    this.shaderSurface.update(GuiWidth(), GuiHeight())
      .renderOn(renderShaderSurface, this)
    this.gameSurface.update(GuiWidth(), GuiHeight())
      .renderOn(this.renderGameSurface, this)
    return this
  }

  ///@param {?Struct} [config]
  ///@return {GridRenderer}
  renderGUI = function(config = null) {
    var width = Struct.contains(config, "width") ? config.width : GuiWidth()
    var height = Struct.contains(config, "height") ? config.height : GuiHeight()
    var _x = Struct.contains(config, "x") ? config.x : 0
    var _y = Struct.contains(config, "y") ? config.y : 0
    this.gameSurface.update(width, height)
      .render(_x, _y)
    return this
  }

  free = function() {
    this.gridSurface.free()
    this.gameSurface.free()
    this.shaderSurface.free()
  }
}
