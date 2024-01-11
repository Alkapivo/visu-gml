///@package io.alkapivo.visu.service.grid

///@param {Struct} [config]
function GridProperties(config = {}) constructor {

  ///@type {Number}
  speed = Assert.isType(Struct
    .getDefault(config, "properties.speed", (FRAME_MS / 4) * 1000), Number)

  ///@type {Number}
  channels = Assert.isType(Struct
    .getDefault(config, "properties.channels", 3), Number)
  
  ///@type {Number}
  separators = Assert.isType(Struct
    .getDefault(config, "properties.separators", 10), Number)

  ///@type {Color}
  primaryWireframeColor = Assert.isType(ColorUtil.fromHex(Struct
    .getDefault(config, "properties.primaryWireframeColor", "#023ef2")), Color)
  
  ///@type {Color}
  accentWireframeColor = Assert.isType(ColorUtil.fromHex(Struct
    .getDefault(config, "properties.accentWireframeColor", "#4c47cc")), Color)

  ///@type {Color}
  backgroundColor = Assert.isType(ColorUtil.fromHex(Struct
    .getDefault(config, "properties.backgroundColor", "#ffffff")), Color)

  ///@type {Color}
  loopColor1 = Assert.isType(ColorUtil.fromHex(Struct
    .getDefault(config, "properties.loopColor1", "#4c47cc")), Color)

  ///@type {Color}
  loopColor2 = Assert.isType(ColorUtil.fromHex(Struct
    .getDefault(config, "properties.loopColor2", "#023ef2")), Color)

  ///@type {Color}
  loopColor3 = Assert.isType(ColorUtil.fromHex(Struct
    .getDefault(config, "properties.loopColor3", "#4c47cc")), Color)

  ///@type {Color}
  loopColor4 = Assert.isType(ColorUtil.fromHex(Struct
    .getDefault(config, "properties.loopColor4", "#023ef2")), Color)

  ///@type {Number}
  primaryWireframeThickness = Assert.isType(Struct
    .getDefault(config, "properties.primaryWireframeThickness", 4), Number)

  ///@type {Number}
  accentWireframeThickness = Assert.isType(Struct
    .getDefault(config, "properties.accentWireframeThickness", 3), Number)

  ///@type {Number}
  wireframeOpacity = Assert.isType(Struct.getDefault(config, "properties.wireframeOpacity", 0.9), Number)

  ///@type {Boolean}
  loopColors = Assert.isType(Struct
    .getDefault(config, "properties.loopColors", false), Boolean)
  
  ///@type {Boolean}
  renderMesh = Assert.isType(Struct
    .getDefault(config, "properties.renderMesh", true), Boolean)
  
  ///@type {Boolean}
  renderElements = Assert.isType(Struct
    .getDefault(config, "properties.renderElements", true), Boolean)

  ///@type {Number}
  renderOverlay = Assert.isType(Struct
    .getDefault(config, "properties.renderOverlay", true), Boolean)

  ///@type {Number}
  renderOverlayTreshold = Assert.isType(Struct
    .getDefault(config, "properties.renderOverlayTreshold", 2), Number)

  ///@type {Number}
  renderOverlayAlpha = Assert.isType(Struct
    .getDefault(config, "properties.renderOverlayAlpha", 0.33), Number)

  ///@type {Color}
  clearColor = Assert.isType(ColorUtil.fromHex(Struct
    .getDefault(config, "properties.clearColor", "#00000000")), Color)

  ///@type {Boolean}
  clearFrame = Assert.isType(Struct
    .getDefault(config, "properties.clearFrame", true), Boolean)

  ///@type {Number}
  clearFrameAlpha = Assert.isType(Struct
    .getDefault(config, "properties.clearFrameAlpha", 0.0), Number)
    
  ///@type {Color}
  gridClearColor = Assert.isType(ColorUtil.fromHex(Struct
    .getDefault(config, "properties.gridClearColor", "#00000000")), Color)

  ///@type {Boolean}
  gridClearFrame = Assert.isType(Struct
    .getDefault(config, "properties.gridClearFrame", true), Boolean)

  ///@type {Number}
  gridClearFrameAlpha = Assert.isType(Struct
    .getDefault(config, "properties.gridClearFrameAlpha", 0.0), Number)

  ///@type {Color}
  shaderClearColor = Assert.isType(ColorUtil.fromHex(Struct
    .getDefault(config, "properties.shaderClearColor", "#00000000")), Color)

  ///@type {Boolean}
  shaderClearFrame = Assert.isType(Struct
    .getDefault(config, "properties.shaderClearFrame", true), Boolean)

  ///@type {Number}
  shaderClearFrameAlpha = Assert.isType(Struct
    .getDefault(config, "properties.shaderClearFrameAlpha", 0.0), Number)



  ///@type {Struct}
  depths = {
    channelZ: 1,
    separatorZ: 2,
    bulletZ: 2048,
    shroomZ: 2049,
    particleZ: 1024,
    playerZ: 2051,
  }
  
  ///@private
  ///@type {Timer}
  separatorTimer = new Timer(FRAME_MS, { amount: this.speed / 1000, loop: Infinity })

  ///@param {GridService} gridService
  ///@return {GridProperties}
  static update = function(gridService) {
    this.separatorTimer.amount = this.speed / 1000
    this.separatorTimer.duration = ((gridService.view.height * 2) / this.separators)
    this.separatorTimer.update()

    this.clearColor.alpha = this.clearFrameAlpha
    this.gridClearColor.alpha = this.gridClearFrameAlpha
    this.shaderClearColor.alpha = this.shaderClearFrameAlpha
    return this
  }
}

