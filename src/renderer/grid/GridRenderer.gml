///@package com.alkapivo.visu.renderer.grid

function GridRenderer() constructor {

  ///@type {GridOverlayRenderer}
  overlayRenderer = new GridOverlayRenderer(this)

  ///@type {GridCamera}
  camera = new GridCamera()

  ///@private
  ///@type {Surface}
  gameSurface = new Surface({ width: GuiWidth(), height: GuiHeight() })

  ///@private
  ///@type {Surface}
  backgroundSurface = new Surface({ width: GuiWidth(), height: GuiHeight() })

  ///@private
  ///@type {Surface}
  gridSurface = new Surface({ width: GuiWidth(), height: GuiHeight() })

  ///@private
  ///@type {Surface}
  shaderSurface = new Surface({ 
    width: ceil(GuiWidth() / Visu.settings.getValue("visu.graphics.shader-quality", 1.0)), 
    height: ceil(GuiHeight() / Visu.settings.getValue("visu.graphics.shader-quality", 1.0)),
  })

  ///@private
  ///@type {Surface}
  shaderBackgroundSurface = new Surface({ 
    width: ceil(GuiWidth() / Visu.settings.getValue("visu.graphics.shader-quality", 1.0)), 
    height: ceil(GuiHeight() / Visu.settings.getValue("visu.graphics.shader-quality", 1.0)),
  })
  
  ///@private
  ///@type {Surface}
  shaderCombinedSurface = new Surface({ 
    width: ceil(GuiWidth() / Visu.settings.getValue("visu.graphics.shader-quality", 1.0)), 
    height: ceil(GuiHeight() / Visu.settings.getValue("visu.graphics.shader-quality", 1.0)),
  })

  ///@private
  ///@type {?GMVertexBuffer}
  vertexBuffer = null

  ///@private
  ///@type {BKTGlitchService}
  glitchService = new BKTGlitchService()

  ///@private
  ///@type {Timer}
  ///@description Z demo
  playerZTimer = new Timer(pi * 2, { loop: Infinity }) 

  ///@private
  ///@type {Struct}
  player2DCoords = { x: 0, y: 0 }

  ///@private
  ///@type {Sprite}
  playerHintPointer = Assert.isType(SpriteUtil.parse({ name: "texture_bullet" }), Sprite)

  ///@private
  ///@type {Font}
  playerHintFont = Assert.isType(FontUtil.parse({ name: "font_inter_24_regular" }), Font)

  ///@private
  ///@param {Texture}
  textureLine = new Texture(texture_grid_line_alpha)

  ///@private
  ///@type {?Number}
  channelXStart = null

  ///@private
  ///@return {GridRenderer}
  init = function() {
    application_surface_draw_enable(false)
    gpu_set_ztestenable(false)
    gpu_set_zwriteenable(false)
    gpu_set_cullmode(cull_counterclockwise)

    ///@todo is it even used?
    this.vertexBuffer = new DefaultVertexBuffer(new Array(DefaultVertex, [
      new DefaultVertex(0, 0, 0, 0, 0, 1, 0, 0, ColorUtil.WHITE, 1),
      new DefaultVertex(GRID_SERVICE_PIXEL_WIDTH, 0, 0,  0, 0, 1, 1, 0, ColorUtil.WHITE, 1),
      new DefaultVertex(GRID_SERVICE_PIXEL_WIDTH, GRID_SERVICE_PIXEL_HEIGHT, 0, 0, 0, 1, 1, 1, ColorUtil.WHITE, 1),
      new DefaultVertex(GRID_SERVICE_PIXEL_WIDTH, GRID_SERVICE_PIXEL_HEIGHT, 0, 0, 0, 1, 1, 1, ColorUtil.WHITE, 1),
      new DefaultVertex(0, GRID_SERVICE_PIXEL_HEIGHT, 0, 0, 0, 1, 0, 1, ColorUtil.WHITE, 1),
      new DefaultVertex(0, 0, 0, 0, 0, 1, 0, 0, ColorUtil.WHITE, 1)
    ])).build().buffer

    return this
  }

  ///@private
  ///@param {GridService} gridService
  ///@return {GridRenderer}
  renderSeparators = function(gridService) {
    var properties = gridService.properties
    var view = gridService.view
    if (!properties.renderGrid) || (properties.separators <= 0) {
      return this
    }

    var separators = properties.separators
    var primaryColor = properties.separatorsPrimaryColor.toGMColor()
    var primaryAlpha = properties.separatorsPrimaryAlpha
    var primaryThickness = properties.separatorsPrimaryThickness
    var secondaryColor = properties.separatorsSecondaryColor.toGMColor()
    var secondaryAlpha = properties.separatorsSecondaryAlpha
    var secondaryThickness = gridService.properties.separatorsSecondaryThickness
    var separatorHeight = (view.height * 2) / separators
    var time = gridService.properties.separatorTimer.time
    var offset = 2.0
    var separatorsSize = separators * 3
    var secondaryTreshold = separatorsSize / 3
    var duration = gridService.properties.separatorTimer.duration
    var borderRatio = clamp(1.0 - (time / duration), 0.0, 1.0)
    var size = floor(separatorsSize)
    var primaryBegin = round(secondaryTreshold)
    var primaryEnd = round(size - secondaryTreshold)
    var mode = gridService.properties.separatorsMode
    switch (mode) {
      case "SINGLE":
        for (var index = -1 * primaryBegin; index <= primaryBegin; index++) {
          var beginX = -4.0 * GRID_SERVICE_PIXEL_WIDTH
          var beginY = ((-6.0 * view.height) + (index * separatorHeight) + offset + time) * GRID_SERVICE_PIXEL_HEIGHT
          var endX = (view.width + 4.0) * GRID_SERVICE_PIXEL_WIDTH
          var endY = beginY
          var _alpha = index == (-1 * primaryBegin) ? primaryAlpha * (1.0 - borderRatio) : primaryAlpha
          if (index + 1 > primaryBegin) {
            _alpha = primaryAlpha * borderRatio
          } else if (index < 0.0) {
            _alpha = ((primaryBegin - abs(index)) / primaryBegin) * _alpha
          }

          GPU.render.texturedLineSimple(
            beginX, beginY, 
            endX, endY, 
            primaryThickness, 
            _alpha, 
            primaryColor,
            this.textureLine
          )
        }

        for (var index = primaryEnd; index <= size; index++) {
          var beginX = -4.0 * GRID_SERVICE_PIXEL_WIDTH
          var beginY = ((-6.0 * view.height) + (index * separatorHeight) + offset + time) * GRID_SERVICE_PIXEL_HEIGHT
          var endX = (view.width + 4.0) * GRID_SERVICE_PIXEL_WIDTH
          var endY = beginY
          var _alpha = index == primaryEnd ? primaryAlpha * (1.0 - borderRatio) : primaryAlpha
          if (index + 1 > size) {
            _alpha = primaryAlpha * borderRatio
          }
    
          GPU.render.texturedLineSimple(
            beginX, beginY, 
            endX, endY, 
            primaryThickness, 
            _alpha, 
            primaryColor,
            this.textureLine
          )
        }

        for (var index = primaryBegin; index <= primaryEnd; index++) {
          var beginX = -4.0 * GRID_SERVICE_PIXEL_WIDTH
          var beginY = ((-6.0 * view.height) + (index * separatorHeight) + offset + time) * GRID_SERVICE_PIXEL_HEIGHT
          var endX = (view.width + 4.0) * GRID_SERVICE_PIXEL_WIDTH
          var endY = beginY

          GPU.render.texturedLineSimple(
            beginX, beginY, 
            endX, endY, 
            primaryThickness,
            primaryAlpha, 
            primaryColor,
            this.textureLine
          )
        }
        break
      case "DUAL":
        for (var index = -1 * primaryBegin; index <= primaryBegin; index++) {
          var beginX = -4.0 * GRID_SERVICE_PIXEL_WIDTH
          var beginY = ((-6.0 * view.height) + (index * separatorHeight) + offset + time) * GRID_SERVICE_PIXEL_HEIGHT
          var endX = (view.width + 4.0) * GRID_SERVICE_PIXEL_WIDTH
          var endY = beginY
          var _alpha = index == (-1 * primaryBegin) ? secondaryAlpha * (1.0 - borderRatio) : secondaryAlpha
          if (index + 1 > primaryBegin) {
            _alpha = secondaryAlpha * borderRatio
          } else if (index < 0.0) {
            _alpha = ((primaryBegin - abs(index)) / primaryBegin) * _alpha
          }
    
          GPU.render.texturedLineSimple(
            beginX, beginY, 
            endX, endY, 
            secondaryThickness, 
            _alpha, 
            secondaryColor,
            this.textureLine
          )
        }
    
        for (var index = primaryEnd; index <= size; index++) {
          var beginX = -4.0 * GRID_SERVICE_PIXEL_WIDTH
          var beginY = ((-6 * view.height) + (index * separatorHeight) + offset + time) * GRID_SERVICE_PIXEL_HEIGHT
          var endX = (view.width + 4.0) * GRID_SERVICE_PIXEL_WIDTH
          var endY = beginY
          var _alpha = index == primaryEnd ? secondaryAlpha * (1.0 - borderRatio) : secondaryAlpha
          if (index + 1 > size) {
            _alpha = secondaryAlpha * borderRatio
          }
    
          GPU.render.texturedLineSimple(
            beginX, beginY, 
            endX, endY, 
            secondaryThickness, 
            _alpha, 
            secondaryColor,
            this.textureLine
          )
        }
    
        for (var index = primaryBegin; index <= primaryEnd; index++) {
          var beginX = -4.0 * GRID_SERVICE_PIXEL_WIDTH
          var beginY = ((-6 * view.height) + (index * separatorHeight) + offset + time) * GRID_SERVICE_PIXEL_HEIGHT
          var endX = (view.width + 4.0) * GRID_SERVICE_PIXEL_WIDTH
          var endY = beginY
          //var alpha = index == primaryBegin ? primaryAlpha * (1.0 - borderRatio) : primaryAlpha
          //if (index + 1 > primaryEnd) {
          //  alpha = primaryAlpha * borderRatio
          //}
          var alpha = primaryAlpha
    
          var thickness = index == primaryBegin ? primaryThickness * (1.0 - borderRatio) : primaryThickness
          if (index + 1 > primaryEnd) {
            thickness = primaryThickness * borderRatio
          }
    
          GPU.render.texturedLineSimple(
            beginX, beginY, 
            endX, endY, 
            thickness,//max(thickness, secondaryThickness), 
            alpha, 
            primaryColor,
            this.textureLine
          )
        }
        break
    }
   
    return this
  }

  ///@private
  ///@param {GridService} gridService
  ///@return {GridRenderer}
  renderChannels = function(gridService) {
    var properties = gridService.properties
    if (!gridService.properties.renderGrid || properties.channels <= 0) {
      return this
    }

    var primaryColor = properties.channelsPrimaryColor.toGMColor()
    var primaryAlpha = properties.channelsPrimaryAlpha
    var primaryThickness = properties.channelsPrimaryThickness
    var secondaryColor = properties.channelsSecondaryColor.toGMColor()
    var secondaryAlpha = properties.channelsSecondaryAlpha
    var secondaryThickness = properties.channelsSecondaryThickness
    var mode = properties.channelsMode
    
    var view = gridService.view
    var viewX = view.x
    var viewWidth = view.width
    var viewHeight = view.height
    var channels = properties.channels
    var channelPxWidth = (viewWidth / channels) * GRID_SERVICE_PIXEL_WIDTH
    var viewBorder = 5
    var viewCurrent = floor(viewX / viewWidth)
    var viewXOffset = viewX - viewCurrent
    var viewXStart = (viewCurrent - viewBorder) * GRID_SERVICE_PIXEL_WIDTH
    var viewXFinish = (viewCurrent + 2.0 + viewBorder) * GRID_SERVICE_PIXEL_WIDTH
    if (this.channelXStart == null) {
      this.channelXStart = viewXStart
    } else {
      if (viewXStart < this.channelXStart) {
        this.channelXStart = this.channelXStart - (channelPxWidth * ((this.channelXStart - viewXStart) div channelPxWidth))
      } else if (viewXStart > this.channelXStart) {
        this.channelXStart = this.channelXStart + (channelPxWidth * ((viewXStart - this.channelXStart) div channelPxWidth))
      }
      viewXStart = this.channelXStart
    }

    var size = (viewXFinish - viewXStart) div channelPxWidth
    var offset = floor(viewX * GRID_SERVICE_PIXEL_HEIGHT) - this.channelXStart
    var indexLeft = (floor(viewX * GRID_SERVICE_PIXEL_WIDTH) - this.channelXStart) div channelPxWidth
    var indexRight = indexLeft + floor(channels)
    var indexMiddle = indexLeft + floor(abs(indexRight - indexLeft) / 2.0)

    switch (mode) {
      case "SINGLE":
        for (var index = 0; index <= size; index++) {
          var beginX = this.channelXStart + (index * channelPxWidth) - (viewX * GRID_SERVICE_PIXEL_WIDTH)
          var beginY = -6.0 * GRID_SERVICE_PIXEL_HEIGHT
          var endX = beginX
          var endY = (viewHeight + 6.0) * GRID_SERVICE_PIXEL_HEIGHT
          if (index < indexLeft) {
            GPU.render.texturedLineSimple(beginX, beginY, endX, endY, primaryThickness, primaryAlpha * clamp((index - (channels * viewXOffset)) / (channels * viewBorder), 0.0, 1.0), primaryColor, this.textureLine)
          } else if (index > indexRight) {
            GPU.render.texturedLineSimple(beginX, beginY, endX, endY, primaryThickness, primaryAlpha * clamp((size - index + (channels * viewXOffset)) / (channels * viewBorder), 0.0, 1.0), primaryColor, this.textureLine)
          } else {
            GPU.render.texturedLineSimple(beginX, beginY, endX, endY, primaryThickness, primaryAlpha, primaryColor, this.textureLine)
          }
        }
        break
      case "DUAL":
        for (var index = 0; index <= indexLeft; index++) {
          var beginX = this.channelXStart + (index * channelPxWidth) - (viewX * GRID_SERVICE_PIXEL_WIDTH)
          var beginY = -6.0 * GRID_SERVICE_PIXEL_HEIGHT
          var endX = beginX
          var endY = (viewHeight + 6.0) * GRID_SERVICE_PIXEL_HEIGHT
          if (index == indexLeft) {
            var factor = 1.0 - ((offset - (floor(offset / channelPxWidth) * channelPxWidth)) / channelPxWidth)
            GPU.render.texturedLineSimple(beginX, beginY, endX, endY, secondaryThickness, secondaryAlpha * (1.0 - factor), secondaryColor, this.textureLine)
          } else {
            GPU.render.texturedLineSimple(beginX, beginY, endX, endY, secondaryThickness, secondaryAlpha * clamp((index - (channels * viewXOffset)) / (channels * viewBorder), 0.0, 1.0), secondaryColor, this.textureLine)
          }
        }
        
        for (var index = indexRight; index <= size; index++) {
          var beginX = this.channelXStart + (index * channelPxWidth) - (viewX * GRID_SERVICE_PIXEL_WIDTH)
          var beginY = -6.0 * GRID_SERVICE_PIXEL_HEIGHT
          var endX = beginX
          var endY = (viewHeight + 6.0) * GRID_SERVICE_PIXEL_HEIGHT
          if (index == indexRight) {
            var factor = ((offset - (floor(offset / channelPxWidth) * channelPxWidth)) / channelPxWidth)
            GPU.render.texturedLineSimple(beginX, beginY, endX, endY, secondaryThickness, secondaryAlpha * (1.0 - factor), secondaryColor, this.textureLine)
          } else {
            GPU.render.texturedLineSimple(beginX, beginY, endX, endY, secondaryThickness, secondaryAlpha * clamp((size - index + (channels * viewXOffset)) / (channels * viewBorder), 0.0, 1.0), secondaryColor, this.textureLine)
          }
        }
    
        for (var index = indexLeft; index < indexMiddle; index++) {
          var beginX = this.channelXStart + (index * channelPxWidth) - (viewX * GRID_SERVICE_PIXEL_WIDTH)
          var beginY = -6.0 * GRID_SERVICE_PIXEL_HEIGHT
          var endX = beginX
          var endY = (viewHeight + 6.0) * GRID_SERVICE_PIXEL_HEIGHT
          if (index == indexLeft && indexLeft != indexRight) {
            var factor = 1.0 - ((offset - (floor(offset / channelPxWidth) * channelPxWidth)) / channelPxWidth)
            GPU.render.texturedLineSimple(beginX, beginY, endX, endY, primaryThickness * factor, primaryAlpha, primaryColor, this.textureLine)
          } else if (index == indexRight) {
            var factor = ((offset - (floor(offset / channelPxWidth) * channelPxWidth)) / channelPxWidth)
            GPU.render.texturedLineSimple(beginX, beginY, endX, endY, primaryThickness * factor, primaryAlpha, primaryColor, this.textureLine)
          } else {
            GPU.render.texturedLineSimple(beginX, beginY, endX, endY, primaryThickness, primaryAlpha, primaryColor, this.textureLine)
          }
        }
    
        for (var index = indexRight; index >= indexMiddle; index--) {
          var beginX = this.channelXStart + (index * channelPxWidth) - (viewX * GRID_SERVICE_PIXEL_WIDTH)
          var beginY = -6.0 * GRID_SERVICE_PIXEL_HEIGHT
          var endX = beginX
          var endY = (viewHeight + 6.0) * GRID_SERVICE_PIXEL_HEIGHT
          if (index == indexLeft && indexLeft != indexRight) {
            var factor = 1.0 - ((offset - (floor(offset / channelPxWidth) * channelPxWidth)) / channelPxWidth)
            GPU.render.texturedLineSimple(beginX, beginY, endX, endY, primaryThickness * factor, primaryAlpha, primaryColor, this.textureLine)
          } else if (index == indexRight) {
            var factor = ((offset - (floor(offset / channelPxWidth) * channelPxWidth)) / channelPxWidth)
            GPU.render.texturedLineSimple(beginX, beginY, endX, endY, primaryThickness * factor, primaryAlpha, primaryColor, this.textureLine)
          } else {
            GPU.render.texturedLineSimple(beginX, beginY, endX, endY, primaryThickness, primaryAlpha, primaryColor, this.textureLine)
          }
        }
        break
    }

    return this
  }

  ///@private
  ///@param {GridService} gridService
  ///@return {GridRenderer}
  renderBorders = function(gridService) {
    static renderTop = function(gridService) {
      if (!gridService.targetLocked.isLockedY) {
        return
      }

      var view = gridService.view
      var height = gridService.properties.borderVerticalLength
      var beginX = -3.0 * GRID_SERVICE_PIXEL_WIDTH
      var anchorY = view.y//(view.height * floor(view.y / view.height))
      var beginY = GRID_SERVICE_PIXEL_HEIGHT * (clamp(anchorY - height + (view.height / 2.0), 0.0, view.worldHeight) - view.y)
      var endX = (3.0 + view.width) * GRID_SERVICE_PIXEL_WIDTH
      var endY = beginY
      GPU.render.texturedLineSimple(
        beginX, beginY, endX, endY, 
        gridService.properties.borderVerticalThickness, 
        gridService.properties.borderVerticalAlpha,
        gridService.properties.borderVerticalColor.toGMColor(),
        this.textureLine
      )
    }

    static renderBottom = function(gridService) {
      var view = gridService.view
      var height = gridService.properties.borderVerticalLength
      var anchorY = view.y//view.height * floor(view.y / view.height)
      var beginX = GRID_SERVICE_PIXEL_WIDTH * -3.0
      var beginY = GRID_SERVICE_PIXEL_HEIGHT * (gridService.targetLocked.isLockedY
        ? clamp(anchorY + height + (view.height / 2.0), 0.0, view.worldHeight) - view.y
        : clamp(view.worldHeight - view.y, 0.0, view.worldHeight))
      var endX = GRID_SERVICE_PIXEL_WIDTH * (view.width + 3.0)
      var endY = beginY
      GPU.render.texturedLineSimple(
        beginX, beginY, endX, endY, 
        gridService.properties.borderVerticalThickness, 
        gridService.properties.borderVerticalAlpha,
        gridService.properties.borderVerticalColor.toGMColor(),
        this.textureLine
      )
    }

    static renderRight = function(gridService) {
      var view = gridService.view
      var beginX = (0.5 + gridService.properties.borderHorizontalLength) * GRID_SERVICE_PIXEL_WIDTH
      var beginY = -3.0 * GRID_SERVICE_PIXEL_HEIGHT
      var endX = beginX
      var endY = (5.0 + view.height) * GRID_SERVICE_PIXEL_HEIGHT

      GPU.render.texturedLineSimple(
        beginX, beginY, endX, endY, 
        gridService.properties.borderHorizontalThickness, 
        gridService.properties.borderHorizontalAlpha,
        gridService.properties.borderHorizontalColor.toGMColor(),
        this.textureLine
      )
    }

    static renderLeft = function(gridService) {
      var view = gridService.view
      var beginX = (0.5 - gridService.properties.borderHorizontalLength) * GRID_SERVICE_PIXEL_WIDTH
      var beginY = -3.0 * GRID_SERVICE_PIXEL_HEIGHT
      var endX = beginX
      var endY = (5.0 + view.height) * GRID_SERVICE_PIXEL_HEIGHT
      
      GPU.render.texturedLineSimple(
        beginX, beginY, endX, endY, 
        gridService.properties.borderHorizontalThickness, 
        gridService.properties.borderHorizontalAlpha,
        gridService.properties.borderHorizontalColor.toGMColor(),
        this.textureLine
      )
    }
    
    if (!gridService.properties.renderGrid) {
      return this
    }

    renderTop(gridService)
    renderBottom(gridService)
    renderLeft(gridService)
    renderRight(gridService)

    return this
  }

  ///@private
  ///@param {GridService} gridService
  ///@param {PlayerService} playerService
  ///@param {Number} baseX
  ///@param {Number} baseY
  ///@return {GridRenderer}
  renderPlayer = function(gridService, playerService, baseX, baseY) { 
    var player = playerService.player
    if (!gridService.properties.renderPlayer
      || !Core.isType(player, Player)) {
      this.player2DCoords.x = null
      this.player2DCoords.y = null
      return this
    }

    var useBlendAsZ = false
    if (useBlendAsZ) {
      shader_set(shader_gml_use_blend_as_z)
      shader_set_uniform_f(shader_get_uniform(shader_gml_use_blend_as_z, "size"), 1024.0)
      var _x = (player.x - (player.sprite.texture.width / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) + ((player.sprite.texture.offsetX * player.sprite.scaleX) / GRID_SERVICE_PIXEL_WIDTH)  - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH
      var _y = (player.y - (player.sprite.texture.height / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) + ((player.sprite.texture.offsetY * player.sprite.scaleY) / GRID_SERVICE_PIXEL_HEIGHT)  - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT
      var blend = player.sprite.getBlend()
      var alpha = player.sprite.getAlpha()
      var angle = player.sprite.getAngle()
      player.sprite
        .setBlend((sin(this.playerZTimer.update().time) * 0.5 + 0.5) * 255     )
        .setAlpha(alpha * ((cos(player.stats.godModeCooldown * 15.0) + 2.0) / 3.0) * player.fadeIn)
        .setAngle(angle - 90.0)
        .render(_x, _y)
        .setBlend(blend)
        .setAlpha(alpha)
        .setAngle(angle)
      shader_reset()
    } else {
      var _x = (player.x - ((player.sprite.texture.width * player.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) + ((player.sprite.texture.offsetX * player.sprite.scaleX) / GRID_SERVICE_PIXEL_WIDTH) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
      var _y = (player.y - ((player.sprite.texture.height * player.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) + ((player.sprite.texture.offsetY * player.sprite.scaleY) / GRID_SERVICE_PIXEL_HEIGHT) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT
      var alpha = player.sprite.getAlpha()
      var angle = player.sprite.getAngle()
      player.sprite
        .setAlpha(alpha * ((cos(player.stats.godModeCooldown * 15.0) + 2.0) / 3.0) * player.fadeIn)
        .setAngle(angle - 90.0)
        .render(_x, _y)
        .setAlpha(alpha)
        .setAngle(angle)
      this.player2DCoords = Math.project3DCoordsOn2D(_x + baseX, _y + baseY, gridService.properties.depths.playerZ, this.camera.viewMatrix, this.camera.projectionMatrix, this.gridSurface.width, this.gridSurface.height)
    }
    
    return this
  }

  ///@private
  ///@param {GridService} gridService
  ///@param {BulletService} bulletService
  ///@return {GridRenderer}
  renderShrooms = function(gridService, shroomService) {
    static renderShroom = function(shroom, index, gridService) {
      var alpha = shroom.sprite.getAlpha()
      shroom.sprite
        .setAlpha(alpha * shroom.fadeIn)
        .render(
          (shroom.x - ((shroom.sprite.texture.width * shroom.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) + ((shroom.sprite.texture.offsetX * shroom.sprite.scaleX) / GRID_SERVICE_PIXEL_WIDTH)  - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
          (shroom.y - ((shroom.sprite.texture.height * shroom.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) + ((shroom.sprite.texture.offsetY * shroom.sprite.scaleY) / GRID_SERVICE_PIXEL_HEIGHT) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT
        )
        .setAlpha(alpha)
    }

    if (!gridService.properties.renderElements 
      || !gridService.properties.renderShrooms) {
      return this
    }

    shroomService.shrooms.forEach(renderShroom, gridService)
    return this
  }

  ///@private
  ///@param {GridService} gridService
  ///@param {ShroomService} shroomService
  ///@return {GridRenderer}
  renderSpawners = function(gridService, shroomService) {
    var spawner = shroomService.spawner
    if (Core.isType(spawner, Struct)) {
      spawner.sprite.render(
        (spawner.x * GRID_SERVICE_PIXEL_WIDTH) - ((spawner.sprite.getWidth() * spawner.sprite.getScaleX()) / 2.0), 
        (spawner.y * GRID_SERVICE_PIXEL_HEIGHT) - ((spawner.sprite.getHeight() * spawner.sprite.getScaleY()) / 2.0)
      )

      shroomService.spawner.timeout--
      if (shroomService.spawner.timeout <= 0) {
        shroomService.spawner = null
      }
    }

    var spawnerEvent = shroomService.spawnerEvent
    if (Core.isType(spawnerEvent, Struct)) {
      spawnerEvent.sprite.render(
        (spawnerEvent.x * GRID_SERVICE_PIXEL_WIDTH) - ((spawnerEvent.sprite.getWidth() * spawnerEvent.sprite.getScaleX()) / 2.0), 
        (spawnerEvent.y * GRID_SERVICE_PIXEL_HEIGHT) - ((spawnerEvent.sprite.getHeight() * spawnerEvent.sprite.getScaleY()) / 2.0)
      )

      shroomService.spawnerEvent.timeout--
      if (shroomService.spawnerEvent.timeout <= 0) {
        shroomService.spawnerEvent = null
      }
    }

    // Render particleArea
    var particleArea = shroomService.particleArea
    if (Core.isType(particleArea, Struct)) {
      particleArea.topLeft.sprite.render(
        particleArea.topLeft.x * GRID_SERVICE_PIXEL_WIDTH,
        particleArea.topLeft.y * GRID_SERVICE_PIXEL_HEIGHT,
      )
      particleArea.topRight.sprite.render(
        particleArea.topRight.x * GRID_SERVICE_PIXEL_WIDTH,
        particleArea.topRight.y * GRID_SERVICE_PIXEL_HEIGHT,
      )
      particleArea.bottomLeft.sprite.render(
        particleArea.bottomLeft.x * GRID_SERVICE_PIXEL_WIDTH,
        particleArea.bottomLeft.y * GRID_SERVICE_PIXEL_HEIGHT,
      )
      particleArea.bottomRight.sprite.render(
        particleArea.bottomRight.x * GRID_SERVICE_PIXEL_WIDTH,
        particleArea.bottomRight.y * GRID_SERVICE_PIXEL_HEIGHT,
      )

      shroomService.particleArea.timeout--
      if (shroomService.particleArea.timeout <= 0) {
        shroomService.particleArea = null
      }
    }

    var particleAreaEvent = shroomService.particleAreaEvent
    if (Core.isType(particleAreaEvent, Struct)) {
      particleAreaEvent.topLeft.sprite.render(
        particleAreaEvent.topLeft.x * GRID_SERVICE_PIXEL_WIDTH,
        particleAreaEvent.topLeft.y * GRID_SERVICE_PIXEL_HEIGHT,
      )
      particleAreaEvent.topRight.sprite.render(
        particleAreaEvent.topRight.x * GRID_SERVICE_PIXEL_WIDTH,
        particleAreaEvent.topRight.y * GRID_SERVICE_PIXEL_HEIGHT,
      )
      particleAreaEvent.bottomLeft.sprite.render(
        particleAreaEvent.bottomLeft.x * GRID_SERVICE_PIXEL_WIDTH,
        particleAreaEvent.bottomLeft.y * GRID_SERVICE_PIXEL_HEIGHT,
      )
      particleAreaEvent.bottomRight.sprite.render(
        particleAreaEvent.bottomRight.x * GRID_SERVICE_PIXEL_WIDTH,
        particleAreaEvent.bottomRight.y * GRID_SERVICE_PIXEL_HEIGHT,
      )

      shroomService.particleAreaEvent.timeout--
      if (shroomService.particleAreaEvent.timeout <= 0) {
        shroomService.particleAreaEvent = null
      }
    }

    // Render playerBorder
    var playerBorder = shroomService.playerBorder
    if (Core.isType(playerBorder, Struct)) {
      playerBorder.topLeft.sprite.render(
        playerBorder.topLeft.x * GRID_SERVICE_PIXEL_WIDTH,
        playerBorder.topLeft.y * GRID_SERVICE_PIXEL_HEIGHT,
      )
      playerBorder.topRight.sprite.render(
        playerBorder.topRight.x * GRID_SERVICE_PIXEL_WIDTH,
        playerBorder.topRight.y * GRID_SERVICE_PIXEL_HEIGHT,
      )
      playerBorder.bottomLeft.sprite.render(
        playerBorder.bottomLeft.x * GRID_SERVICE_PIXEL_WIDTH,
        playerBorder.bottomLeft.y * GRID_SERVICE_PIXEL_HEIGHT,
      )
      playerBorder.bottomRight.sprite.render(
        playerBorder.bottomRight.x * GRID_SERVICE_PIXEL_WIDTH,
        playerBorder.bottomRight.y * GRID_SERVICE_PIXEL_HEIGHT,
      )

      shroomService.playerBorder.timeout--
      if (shroomService.playerBorder.timeout <= 0) {
        shroomService.playerBorder = null
      }
    }

    var playerBorderEvent = shroomService.playerBorderEvent
    if (Core.isType(playerBorderEvent, Struct)) {
      playerBorderEvent.topLeft.sprite.render(
        playerBorderEvent.topLeft.x * GRID_SERVICE_PIXEL_WIDTH,
        playerBorderEvent.topLeft.y * GRID_SERVICE_PIXEL_HEIGHT,
      )
      playerBorderEvent.topRight.sprite.render(
        playerBorderEvent.topRight.x * GRID_SERVICE_PIXEL_WIDTH,
        playerBorderEvent.topRight.y * GRID_SERVICE_PIXEL_HEIGHT,
      )
      playerBorderEvent.bottomLeft.sprite.render(
        playerBorderEvent.bottomLeft.x * GRID_SERVICE_PIXEL_WIDTH,
        playerBorderEvent.bottomLeft.y * GRID_SERVICE_PIXEL_HEIGHT,
      )
      playerBorderEvent.bottomRight.sprite.render(
        playerBorderEvent.bottomRight.x * GRID_SERVICE_PIXEL_WIDTH,
        playerBorderEvent.bottomRight.y * GRID_SERVICE_PIXEL_HEIGHT,
      )

      shroomService.playerBorderEvent.timeout--
      if (shroomService.playerBorderEvent.timeout <= 0) {
        shroomService.playerBorderEvent = null
      }
    }
  }

  ///@private
  ///@param {GridService} gridService
  ///@param {BulletService} bulletService
  ///@return {GridRenderer}
  renderBullets = function(gridService, bulletService) {
    static renderBullet = function(bullet, index, gridService) {
      bullet.sprite
        .setAngle(bullet.angle - 90.0)
        .render(
          (bullet.x - ((bullet.sprite.texture.width * bullet.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) + ((bullet.sprite.texture.offsetX * bullet.sprite.scaleX) / GRID_SERVICE_PIXEL_WIDTH) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
          (bullet.y - ((bullet.sprite.texture.height * bullet.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) + ((bullet.sprite.texture.offsetY * bullet.sprite.scaleY) / GRID_SERVICE_PIXEL_HEIGHT) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT
        )
    }
    
    if (!gridService.properties.renderElements
        || !gridService.properties.renderBullets) {
      return this
    }

    bulletService.bullets.forEach(renderBullet, gridService)
    return this
  }

  ///@private
  ///@param {GridService} gridService
  ///@param {CoinService} coinService
  ///@return {GridRenderer}
  renderCoins = function(gridService, coinService) {
    static renderCoin = function(coin, index, gridService) {
      coin.sprite
        .render(
          (coin.x - ((coin.sprite.texture.width * coin.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) + ((coin.sprite.texture.offsetX * coin.sprite.scaleX) / GRID_SERVICE_PIXEL_WIDTH) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
          (coin.y - ((coin.sprite.texture.height * coin.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) + ((coin.sprite.texture.offsetY * coin.sprite.scaleY) / GRID_SERVICE_PIXEL_HEIGHT) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT
        )
    }
    
    if (!gridService.properties.renderElements
        || !gridService.properties.renderCoins) {
      return this
    }

    coinService.coins.forEach(renderCoin, gridService)
    return this
  }
  
  ///@private
  ///@param {GridService} gridService
  ///@param {PlayerService} playerService
  ///@param {Number} baseX
  ///@param {Number} baseY
  ///@return {GridRenderer}
  debugRenderPlayer = function(gridService, playerService, baseX, baseY) { 
    var player = playerService.player
    if (!gridService.properties.renderPlayer
      || !Core.isType(player, Player)) {
      this.player2DCoords.x = null
      this.player2DCoords.y = null
      return this
    }

    var useBlendAsZ = false
    if (useBlendAsZ) {
      var _x = (player.x - (player.sprite.texture.width / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) + ((player.sprite.texture.offsetX * player.sprite.scaleX) / GRID_SERVICE_PIXEL_WIDTH)  - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH
      var _y = (player.y - (player.sprite.texture.height / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) + ((player.sprite.texture.offsetY * player.sprite.scaleY) / GRID_SERVICE_PIXEL_HEIGHT)  - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT
      var blend = player.sprite.getBlend()
      var alpha = player.sprite.getAlpha()
      var angle = player.sprite.getAngle()
      shader_set(shader_gml_use_blend_as_z)
      shader_set_uniform_f(shader_get_uniform(shader_gml_use_blend_as_z, "size"), 1024.0)
        player.sprite
          .setBlend((sin(this.playerZTimer.update().time) * 0.5 + 0.5) * 255)
          .setAlpha(alpha * ((cos(player.stats.godModeCooldown * 15.0) + 2.0) / 3.0))
          .setAngle(angle - 90)
          .render(_x, _y)
          .setBlend(blend)
          .setAlpha(alpha)
          .setAngle(angle)
        
        GPU.render.rectangle(
          (player.x - ((player.mask.getWidth() * player.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
          (player.y - ((player.mask.getHeight() * player.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT,
          (player.x + ((player.mask.getWidth() * player.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
          (player.y + ((player.mask.getHeight() * player.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT,
          false, 
          c_lime
        )
      shader_reset()
    } else {
      var _x = (player.x - ((player.sprite.texture.width * player.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) + ((player.sprite.texture.offsetX * player.sprite.scaleX) / GRID_SERVICE_PIXEL_WIDTH) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
      var _y = (player.y - ((player.sprite.texture.height * player.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) + ((player.sprite.texture.offsetY * player.sprite.scaleY) / GRID_SERVICE_PIXEL_HEIGHT) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT
      var alpha = player.sprite.getAlpha()
      var angle = player.sprite.getAngle()
      player.sprite
        .setAlpha(alpha * ((cos(player.stats.godModeCooldown * 15.0) + 2.0) / 3.0))
        .setAngle(angle - 90.0)
        .render(_x, _y)
        .setAlpha(alpha)
        .setAngle(angle)
      this.player2DCoords = Math.project3DCoordsOn2D(_x + baseX, _y + baseY, gridService.properties.depths.playerZ, this.camera.viewMatrix, this.camera.projectionMatrix, this.gridSurface.width, this.gridSurface.height)
      
      GPU.render.rectangle(
        (player.x - ((player.mask.getWidth() * player.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
        (player.y - ((player.mask.getHeight() * player.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT,
        (player.x + ((player.mask.getWidth() * player.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
        (player.y + ((player.mask.getHeight() * player.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT,
        false, 
        c_lime
      )
      
    }
    
    return this
  }
  
  ///@private
  ///@param {GridService} gridService
  ///@param {BulletService} bulletService
  ///@return {GridRenderer}
  debugRenderShrooms = function(gridService, shroomService) {
    static debugRenderShroom = function(shroom, index, gridService) {
      var alpha = shroom.sprite.getAlpha()
      shroom.sprite
        .setAlpha(alpha * shroom.fadeIn)
        .render(
          (shroom.x - ((shroom.sprite.texture.width * shroom.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) + ((shroom.sprite.texture.offsetX * shroom.sprite.scaleX) / GRID_SERVICE_PIXEL_WIDTH)  - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
          (shroom.y - ((shroom.sprite.texture.height * shroom.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) + ((shroom.sprite.texture.offsetY * shroom.sprite.scaleY) / GRID_SERVICE_PIXEL_HEIGHT) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT
        )
        .setAlpha(alpha)
    }
    static debugRenderShroomMask = function(shroom, index, gridService) {
      GPU.render.rectangle(
        (shroom.x - ((shroom.mask.getWidth() * shroom.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
        (shroom.y - ((shroom.mask.getHeight() * shroom.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT,
        (shroom.x + ((shroom.mask.getWidth() * shroom.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
        (shroom.y + ((shroom.mask.getHeight() * shroom.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT,
        false, 
        c_red
      )
    }

    if (!gridService.properties.renderElements 
      || !gridService.properties.renderShrooms) {
      return this
    }

    shroomService.shrooms.forEach(debugRenderShroom, gridService)
    shroomService.shrooms.forEach(debugRenderShroomMask, gridService)
    return this
  }

  ///@private
  ///@param {GridService} gridService
  ///@param {BulletService} bulletService
  ///@return {GridRenderer}
  debugRenderBullets = function(gridService, bulletService) {
    static debugRenderBullet = function(bullet, index, gridService) {
      bullet.sprite
        .setAngle(bullet.angle)
        .render(
          (bullet.x - ((bullet.sprite.texture.width * bullet.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) + ((bullet.sprite.texture.offsetX * bullet.sprite.scaleX) / GRID_SERVICE_PIXEL_WIDTH) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
          (bullet.y - ((bullet.sprite.texture.height * bullet.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) + ((bullet.sprite.texture.offsetY * bullet.sprite.scaleY) / GRID_SERVICE_PIXEL_HEIGHT) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT
        )
    }
    static debugRenderBulletMask = function(bullet, index, gridService) {
      GPU.render.rectangle(
        (bullet.x - ((bullet.mask.getWidth() * bullet.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
        (bullet.y - ((bullet.mask.getHeight() * bullet.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT,
        (bullet.x + ((bullet.mask.getWidth() * bullet.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
        (bullet.y + ((bullet.mask.getHeight() * bullet.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT,
        false, 
        c_blue
      )
    }
    
    if (!gridService.properties.renderElements
        || !gridService.properties.renderBullets) {
      return this
    }

    bulletService.bullets.forEach(debugRenderBullet, gridService)
    bulletService.bullets.forEach(debugRenderBulletMask, gridService)
    return this
  }

    ///@private
  ///@param {GridService} gridService
  ///@param {CoinService} coinService
  ///@return {GridRenderer}
  debugRenderCoins = function(gridService, coinService) {
    static debugRenderCoin = function(coin, index, gridService) {
      coin.sprite.render(
        (coin.x - ((coin.sprite.texture.width * coin.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) + ((coin.sprite.texture.offsetX * coin.sprite.scaleX) / GRID_SERVICE_PIXEL_WIDTH) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
        (coin.y - ((coin.sprite.texture.height * coin.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) + ((coin.sprite.texture.offsetY * coin.sprite.scaleY) / GRID_SERVICE_PIXEL_HEIGHT) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT
      )
    }
    static debugRenderCoinMask = function(coin, index, gridService) {
      GPU.render.rectangle(
        (coin.x - ((coin.mask.getWidth() * coin.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
        (coin.y - ((coin.mask.getHeight() * coin.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT,
        (coin.x + ((coin.mask.getWidth() * coin.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
        (coin.y + ((coin.mask.getHeight() * coin.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT,
        false, 
        c_orange
      )
    }
    
    if (!gridService.properties.renderElements
        || !gridService.properties.renderCoins) {
      return this
    }

    coinService.coins.forEach(debugRenderCoin, gridService)
    coinService.coins.forEach(debugRenderCoinMask, gridService)
    return this
  }

  ///@private
  ///@param {GridService} gridService
  ///@param {ParticleService} particleService
  ///@return {GridRenderer}
  renderParticles = function(gridService, particleService) {
    if (!gridService.properties.renderParticles) {
      return this
    }

    particleService.systems.get("main").render()
    return this
  }

  ///@private
  ///@param {GridService} gridService
  ///@param {UILayout} layout
  ///@return {GridRenderer}
  renderBackground = function(gridService, layout) {
    var properties = gridService.properties
    if (!properties.renderBackground) {
      return this
    }

    this.backgroundSurface.render()
    var shaderPipeline = Beans.get(BeanVisuController).shaderBackgroundPipeline
    if (properties.renderBackgroundShaders 
      && Visu.settings.getValue("visu.graphics.bkg-shaders")
      && shaderPipeline.executor.tasks.size() > 0) {

      this.shaderBackgroundSurface
        .renderStretched(layout.width(), layout.height())
    }

    return this
  }

  ///@private
  ///@param {GridService} gridService
  ///@param {UILayout} layout
  ///@return {GridRenderer}
  renderForeground = function(gridService, layout) {
    var properties = gridService.properties
    if (!properties.renderForeground) {
      return this
    }

    this.overlayRenderer.renderForegrounds(layout.width(), layout.height())

    return this
  }
  
  ///@private
  ///@param {UILayout} layout
  ///@return {GridRenderer}
  renderBackgroundSurface = function(layout) {
    var properties = Beans.get(BeanVisuController).gridService.properties
    var width = layout.width()
    var height = layout.height()
    GPU.render.clear(ColorUtil.BLACK_TRANSPARENT)
    if (properties.renderVideo) {
      this.overlayRenderer.renderVideo(width, height) 
    }

    if (properties.renderBackground) {
      this.overlayRenderer.renderBackgrounds(width, height)
    }

    return this
  }

  ///@private
  ///@param {UILayout} layout
  ///@return {GridRenderer}
  renderGridSurface = function(layout) {
    var controller = Beans.get(BeanVisuController)
    var gridService = controller.gridService
    var properties = gridService.properties
    var bulletService = controller.bulletService
    var playerService = controller.playerService
    var shroomService = controller.shroomService
    var coinService = controller.coinService
    var particleService = controller.particleService
    var width = layout.width()
    var height = layout.height()
    var debugMode = Visu.settings.getValue("visu.debug.render-entities-mask", false)
    var _renderPlayer = this.renderPlayer
    var _renderShrooms = this.renderShrooms
    var _renderBullets = this.renderBullets
    var _renderCoins = this.renderCoins
    if (debugMode) {
      _renderPlayer = this.debugRenderPlayer
      _renderShrooms = this.debugRenderShrooms
      _renderBullets = this.debugRenderBullets
      _renderCoins = this.debugRenderCoins
    }
    
    if (properties.gridClearFrame) {
      GPU.render.clear(properties.gridClearColor)
    } else {
      GPU.set.blendMode(BlendMode.SUBTRACT)
        .render.fillColor(
          width,
          height,
          properties.gridClearColor.toGMColor(),
          properties.gridClearFrameAlpha
        )
        .reset.blendMode()
    }

    var depths = properties.depths
    var camera = this.camera
    var cameraAngle = camera.angle
    var cameraPitch = camera.pitch
    var xto = camera.x
    var yto = camera.y
    var zto = camera.z + camera.zoom
    var xfrom = xto + dcos(cameraAngle) * dcos(cameraPitch)
    var yfrom = yto - dsin(cameraAngle) * dcos(cameraPitch)
    var zfrom = zto - dsin(cameraPitch)
    var baseX = GRID_SERVICE_PIXEL_WIDTH + GRID_SERVICE_PIXEL_WIDTH * 0.5
    var baseY = GRID_SERVICE_PIXEL_HEIGHT + GRID_SERVICE_PIXEL_HEIGHT * 0.5
    camera.viewMatrix = matrix_build_lookat(
      xfrom, yfrom, zfrom, 
      xto, yto, zto, 
      0, 0, 1
    )
    ///@todo extract parameters
    camera.projectionMatrix = matrix_build_projection_perspective_fov(
      -60, 
      -1 * (width / height), 
      1, 
      32000 
    ) 
    camera_set_view_mat(camera.gmCamera, camera.viewMatrix)
    camera_set_proj_mat(camera.gmCamera, camera.projectionMatrix)
    camera_apply(camera.gmCamera)

    matrix_set(matrix_world, matrix_build(
      baseX, baseY, depths.channelZ, 
      0, 0, 0, 
      1, 1, 1
    ))
    this.renderChannels(gridService)

    matrix_set(matrix_world, matrix_build(
      baseX, baseY, depths.separatorZ, 
      0, 0, 0, 
      1, 1, 1
    ))
    this.renderSeparators(gridService)

    if (Visu.settings.getValue("visu.graphics.particle")) {
      matrix_set(matrix_world, matrix_build(
        baseX, baseY, depths.particleZ, 
        0, 0, 0, 
        1, 1, 1
      ))
      this.renderParticles(gridService, particleService)
    }

    matrix_set(matrix_world, matrix_build(
      baseX, baseY, depths.coinZ, 
      0, 0, 0, 
      1, 1, 1
    ))
    _renderCoins(gridService, coinService)

    gpu_set_alphatestenable(true)
    matrix_set(matrix_world, matrix_build(
      baseX, baseY, depths.shroomZ, 
      0, 0, 0, 
      1, 1, 1
    ))
    _renderShrooms(gridService, shroomService)

    //var x2d = (baseX + MouseUtil.getMouseX()) 
    //var y2d = (baseY + MouseUtil.getMouseY())
    //var coords3d = Math.project2DCoordsOn3D(x2d, y2d, camera.viewMatrix, camera.projectionMatrix, width, height)
    //Core.print("xy2d", x2d, y2d, "xyz3d", coords3d)
    //matrix_set(matrix_world, matrix_build(
    //  coords3d[0], coords3d[1], coords3d[2],
    //  0, 0, 0, 
    //  1, 1, 1
    //))
    //draw_sprite(texture_baron, 0, x2d, y2d)
    /*
    shroomService.chunkService.chunks.forEach(function(chunk, key, view) {
      var arr = String.split(key, "_")
      var xx = ((real(arr.get(0)) * GRID_ITEM_CHUNK_SERVICE_SIZE) - view.x) * GRID_SERVICE_PIXEL_WIDTH
      var yy = ((real(arr.get(1)) * GRID_ITEM_CHUNK_SERVICE_SIZE) - view.y) * GRID_SERVICE_PIXEL_HEIGHT
      draw_sprite_ext(
        texture_white, 
        0.0, 
        xx,
        yy, 
        ((GRID_SERVICE_PIXEL_WIDTH * GRID_ITEM_CHUNK_SERVICE_SIZE) / 64) * 0.9,
        ((GRID_SERVICE_PIXEL_HEIGHT * GRID_ITEM_CHUNK_SERVICE_SIZE) / 64) * 0.9,
        0.0,
        chunk.size() > 0 ? c_red : c_white,
        0.4
      )
    }, gridService.view)
    bulletService.chunkService.chunks.forEach(function(chunk, key, view) {
      var arr = String.split(key, "_")
      var xx = ((real(arr.get(0)) * GRID_ITEM_CHUNK_SERVICE_SIZE) - view.x) * GRID_SERVICE_PIXEL_WIDTH
      var yy = ((real(arr.get(1)) * GRID_ITEM_CHUNK_SERVICE_SIZE) - view.y) * GRID_SERVICE_PIXEL_HEIGHT
      draw_sprite_ext(
        texture_white, 
        0.0, 
        xx + 128, 
        yy + 128, 
        ((GRID_SERVICE_PIXEL_WIDTH * GRID_ITEM_CHUNK_SERVICE_SIZE) / 64) * 0.75,
        ((GRID_SERVICE_PIXEL_HEIGHT * GRID_ITEM_CHUNK_SERVICE_SIZE) / 64) * 0.75,
        0.0,
        chunk.size() > 0 ? c_lime : c_white,
        0.4
      )
    }, gridService.view)
    */
    
    this.renderSpawners(gridService, shroomService)
    gpu_set_alphatestenable(false)

    matrix_set(matrix_world, matrix_build(
      baseX, baseY, depths.bulletZ, 
      0, 0, 0, 
      1, 1, 1
    ))
    _renderBullets(gridService, bulletService)
    
    matrix_set(matrix_world, matrix_build(
      baseX, baseY, depths.playerZ, 
      0, 0, 0, 
      1, 1, 1
    ))
    this.renderBorders(gridService)
    _renderPlayer(gridService, playerService, baseX, baseY)

    matrix_set(matrix_world, matrix_build_identity())

    return this
  }

  ///@private
  ///@param {UILayout} layout
  ///@return {GridRenderer}
  renderShaderSurface = function(layout) {
    static renderGridShader = function(task, index, gridRenderer) {
      gridRenderer.gridSurface.renderStretched(
        gridRenderer.shaderSurface.width, 
        gridRenderer.shaderSurface.height, 
        0, 
        0,
        task.state.getDefault("alpha", 1.0)
      )
    }

    var controller = Beans.get(BeanVisuController)
    var properties = controller.gridService.properties
    if (!properties.renderGridShaders 
      || !Visu.settings.getValue("visu.graphics.main-shaders")) {
      
      return this
    }

    var width = this.shaderSurface.width
    var height = this.shaderSurface.height

    if (properties.shaderClearFrame) {
      GPU.render.clear(properties.shaderClearColor)
    } else {
      GPU.set.blendMode(BlendMode.SUBTRACT)
        .render.fillColor(
          width,
          height,
          properties.shaderClearColor.toGMColor(),
          properties.shaderClearFrameAlpha
        )
        .reset.blendMode()
    }

    var size = controller.shaderPipeline
      .setWidth(width)
      .setHeight(height)
      .render(renderGridShader, this).executor.tasks
      .size()

    ///@description Render support-grid
    if (properties.renderSupportGrid 
      && size >= properties.renderSupportGridTreshold) {

      //GPU.set.blendMode(BlendMode.ADD)
      this.gridSurface.renderStretched(width, height, 0, 0, properties.renderSupportGridAlpha)
      //GPU.reset.blendMode()
    }

    return this
  }

  ///@private
  ///@param {UILayout} layout
  ///@return {GridRenderer}
  renderShaderBackgroundSurface = function(layout) {
    static renderBackgroundShader = function(task, index, gridRenderer) {
      gridRenderer.backgroundSurface.renderStretched(
        gridRenderer.shaderSurface.width, 
        gridRenderer.shaderSurface.height, 
        0, 
        0,
        task.state.getDefault("alpha", 1.0)
      )
    }
    
    var controller = Beans.get(BeanVisuController)
    var properties = controller.gridService.properties
    if (!properties.renderBackgroundShaders 
        || !Visu.settings.getValue("visu.graphics.bkg-shaders")) {
      return this
    }

    var width = this.shaderSurface.width
    var height = this.shaderSurface.height
    draw_clear_alpha(c_white, 0.0)

    controller.shaderBackgroundPipeline
      .setWidth(width)
      .setHeight(height)
      .render(renderBackgroundShader, this)

    return this
  }

  blendModes = {
    source: BlendModeExt.ZERO,
    target: BlendModeExt.ZERO,
    equation: BlendEquation.ADD,
    blendModesExt: BlendModeExt.keys(),
    blendEquation: BlendEquation.keys(),
    sourceKey: new DebugNumericKeyboardValue({
      name: "sourceKey",
      value: 0,
      factor: 1,
      minValue: 0,
      maxValue: 10,
      keyIncrement: ord("T"),
      keyDecrement: ord("G"),
      pressed: true,
    }),
    targetKey: new DebugNumericKeyboardValue({
      name: "targetKey",
      value: 0,
      factor: 1,
      minValue: 0,
      maxValue: 10,
      keyIncrement: ord("Y"),
      keyDecrement: ord("H"),
      pressed: true,
    }),
    equationKey: new DebugNumericKeyboardValue({
      name: "equationKey",
      value: 0,
      factor: 1,
      minValue: 0,
      maxValue: 4,
      keyIncrement: ord("U"),
      keyDecrement: ord("J"),
      pressed: true,
    }),
    update: function() {
      var sourceIndex = this.sourceKey.update().value
      var targetIndex = this.targetKey.update().value
      var equationIndex = this.equationKey.update().value

      var source = BlendModeExt.get(this.blendModesExt.get(sourceIndex))
      var target = BlendModeExt.get(this.blendModesExt.get(targetIndex))
      var equation = BlendEquation.get(this.blendEquation.get(equationIndex))

      if (source != this.source 
          || target != this.target 
          || equation != this.equation) {
        Core.print(
          $"# {irandom(99) + 99}|", 
          "Source:", this.blendModesExt.get(sourceIndex), 
          "Target:", this.blendModesExt.get(targetIndex), 
          "Equation:", this.blendEquation.get(equationIndex)
        )
      }

      this.source = source
      this.target = target
      this.equation = equation
      /*
      GPU.set.blendModeExt(this.blendModes.source, this.blendModes.target)
      GPU.set.blendEquation(this.blendModes.equation)

      GPU.reset.blendMode()
      GPU.reset.blendEquation()
      */
    }
  }

  ///@private
  ///@param {UILayout} layout
  ///@return {GridRenderer}
  renderGameSurface = function(layout) {
    var gridService = Beans.get(BeanVisuController).gridService
    GPU.render.clear(gridService.properties.clearColor)
    this.renderBackground(gridService, layout) 
    this.gridSurface.render()
    this.shaderSurface.renderStretched(layout.width(), layout.height())
    this.renderForeground(gridService, layout)

    return this
  }

  ///@private
  ///@param {UILayout} layout
  ///@return {GridRenderer}
  renderShaderCombinedSurface = function(layout) {
    static renderCombinedShader = function(task, index, gridRenderer) {
      gridRenderer.gameSurface.renderStretched(
        gridRenderer.shaderCombinedSurface.width, 
        gridRenderer.shaderCombinedSurface.height, 
        0, 
        0,
        task.state.getDefault("alpha", 1.0)
      )
    }
    
    var controller = Beans.get(BeanVisuController)
    var properties = controller.gridService.properties
    if (!properties.renderCombinedShaders
      || !Visu.settings.getValue("visu.graphics.combined-shaders")) {
      return this
    }

    var width = this.shaderCombinedSurface.width
    var height = this.shaderCombinedSurface.height
    draw_clear_alpha(c_white, 0.0)

    controller.shaderCombinedPipeline
      .setWidth(width)
      .setHeight(height)
      .render(renderCombinedShader, this)

    return this
  }

  ///@private
  ///@param {UILayout} layout
  ///@return {GridRenderer}
  renderGlitch = function(layout) {
    var width = layout.width()
    var height = layout.height()
    var _x = layout.x()
    var _y = layout.y()
    var controller = Beans.get(BeanVisuController)
    var properties = controller.gridService.properties
    this.gameSurface.update(width, height).render(_x, _y)

    if (!properties.renderCombinedShaders 
        || !Visu.settings.getValue("visu.graphics.combined-shaders")
        || controller.shaderCombinedPipeline.executor.tasks.size() == 0) {
      return this
    }

    this.shaderCombinedSurface.renderStretched(width, height, _x, _y)
    return this
  }

  ///@private
  ///@param {PlayerService} playerService
  ///@param {UILayout} layout
  ///@return {GrindRenderer}
  renderPlayerHint = function(playerService, layout) {
    var width = layout.width()
    var height = layout.height()
    if ((this.player2DCoords.x != null && this.player2DCoords.y != null) 
      && (this.player2DCoords.x < 0 
        || this.player2DCoords.x > width 
        || this.player2DCoords.y < 0 
        || this.player2DCoords.y > height)) {

      var configX = layout.x()
      var configY = layout.y()
      var player = playerService.player
      var _x = clamp(this.player2DCoords.x, player.sprite.getWidth() - player.sprite.texture.offsetX, width - player.sprite.getWidth() + player.sprite.texture.offsetX)
      var _y = clamp(this.player2DCoords.y, player.sprite.getHeight() - player.sprite.texture.offsetY, height - player.sprite.getHeight() + player.sprite.texture.offsetY)
      var alpha = player.sprite.getAlpha()
      player.sprite
        .setAlpha(alpha * 0.5)
        .render(configX + _x, configY + _y)
        .setAlpha(alpha)

      var angle = Math.fetchPointsAngle(_x, _y, this.player2DCoords.x, this.player2DCoords.y)
      this.playerHintPointer
        .setAngle(angle)
        .setAlpha(0.8)
        .render(
          configX + _x + Math.fetchCircleX(player.sprite.getWidth() / 3, angle),
          configY + _y + Math.fetchCircleY(player.sprite.getHeight() / 3, angle)
        )
      
      var length = round(Math.fetchLength(_x, _y, this.player2DCoords.x, this.player2DCoords.y))
      GPU.render.text(
        configX + _x,
        configY + _y,
        string(length),
        c_white,
        c_black,
        1.0,
        this.playerHintFont, 
        HAlign.CENTER,
        VAlign.CENTER
      )
    }

    return this
  }

  ///@return {GridRenderer}
  clear = function() {
    this.camera = new GridCamera()
    this.overlayRenderer.clear()
    return this
  }

  ///@param {UILayout} layout
  ///@return {GridRenderer}
  update = function(layout) {
    //this.blendModes.update()
    this.camera.update(layout)
    this.overlayRenderer.update()
    this.glitchService.update(layout.width(), layout.height())
    
    return this
  }

  ///@param {UILayout} layout
  ///@return {GridRenderer}
  render = function(layout) {
    var width = layout.width()
    var height = layout.height()
    var shaderQuality = Visu.settings.getValue("visu.graphics.shader-quality", 1.0)
    this.backgroundSurface
      .update(width, height)
      .renderOn(this.renderBackgroundSurface, layout)
    this.gridSurface
      .update(width, height)
      .renderOn(this.renderGridSurface, layout)
    this.shaderBackgroundSurface
      .update(ceil(width * shaderQuality), ceil(height * shaderQuality))
      .renderOn(this.renderShaderBackgroundSurface, layout)
    this.shaderSurface
      .update(ceil(width * shaderQuality), ceil(height * shaderQuality))
      .renderOn(this.renderShaderSurface, layout)
    this.gameSurface
      .update(width, height)
      .renderOn(this.renderGameSurface, layout)
    this.shaderCombinedSurface
      .update(ceil(width * shaderQuality), ceil(height * shaderQuality))
      .renderOn(this.renderShaderCombinedSurface, layout)

    return this
  }

  ///@param {UILayout} layout
  ///@return {GridRenderer}
  renderGUI = function(layout) {
    if (Visu.settings.getValue("visu.debug.render-surfaces")) {
      draw_clear_alpha(c_fuchsia, 1.0)
      this.backgroundSurface.renderStretched(GuiWidth() / 2.0, GuiHeight() / 2.0, 0.0, 0.0)
      this.gridSurface.renderStretched(GuiWidth() / 2.0, GuiHeight() / 2.0, GuiWidth() / 2.0, 0.0)
      this.shaderBackgroundSurface.renderStretched(GuiWidth() / 2.0, GuiHeight() / 2.0, 0.0, GuiHeight() / 2.0)
      this.shaderSurface.renderStretched(GuiWidth() / 2.0, GuiHeight() / 2.0, GuiWidth() / 2.0, GuiHeight() / 2.0)
      return this
    }

    var playerService = Beans.get(BeanVisuController).playerService
    if (Visu.settings.getValue("visu.graphics.bkt-glitch")) {
      this.glitchService.renderOn(this.renderGlitch, layout)
    } else {
      this.renderGlitch(layout)
    }

    if (Visu.settings.getValue("visu.interface.player-hint")) {
      this.renderPlayerHint(playerService, layout)
    }
    return this
  }

  ///@return {GridRenderer}
  free = function() {
    this.backgroundSurface.free()
    this.gridSurface.free()
    this.gameSurface.free()
    this.shaderSurface.free()
    this.shaderBackgroundSurface.free()
    this.shaderCombinedSurface.free()
    return this
  }

  this.init()
}

