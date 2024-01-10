///@package io.alkapivo.visu.service.grid

///@type {Number}
global.__GRID_SERVICE_PIXEL_WIDTH = 2048
#macro GRID_SERVICE_PIXEL_WIDTH global.__GRID_SERVICE_PIXEL_WIDTH

///@type {Number}
global.__GRID_SERVICE_PIXEL_HEIGHT = 2048
#macro GRID_SERVICE_PIXEL_HEIGHT global.__GRID_SERVICE_PIXEL_HEIGHT

///@type {Number}
global.__GRID_ITEM_FRUSTUM_RANGE = 3.5
#macro GRID_ITEM_FRUSTUM_RANGE global.__GRID_ITEM_FRUSTUM_RANGE


///@param {VisuController} _controller
///@param {Struct} [config]
function GridService(_controller, config = {}): Service(config) constructor {

  ///@type {VisuController}
  controller = Assert.isType(_controller, VisuController)

  ///@type {Number}
  width = Assert.isType(Struct.getDefault(config, "width", 1000000.0), Number)

  ///@type {Number}
  height = Assert.isType(Struct.getDefault(config, "height", 100.0), Number)

  ///@type {Number}
  pixelWidth = Assert.isType(Struct.getDefault(config, "pixelWidth", GRID_SERVICE_PIXEL_WIDTH), Number)

  ///@type {Number}
  pixelHeight = Assert.isType(Struct.getDefault(config, "pixelHeight", GRID_SERVICE_PIXEL_HEIGHT), Number)

  ///@type {GridView}
  view = new GridView({ 
    worldWidth: this.width, 
    worldHeight: this.height,
  })
  ///@description (set camera on middle bottom)
  this.view.x = (this.width - this.view.width) / 2.0
	this.view.y = this.height - this.view.height

  ///@type {Struct}
  properties = Struct.contains(config, "properties")
    ? Assert.isType(Struct.get(config, "properties"), GridProperties)
    : new GridProperties()
  
  ///@type {EventDispatcher}
  dispatcher = new EventDispatcher(this, new Map(String, Callable, {
    "transform-property": Callable.run(Struct.get(EVENT_DISPATCHERS, "transform-property")),
    "fade-sprite": Callable.run(Struct.get(EVENT_DISPATCHERS, "fade-sprite")),
    "fade-color": Callable.run(Struct.get(EVENT_DISPATCHERS, "fade-color")),
  }))

  ///@type {TaskExecutor}
  executor = new TaskExecutor(this)
  
  ///@private
  ///@return {GridService}
  moveGridItems = function() {
    static moveGridItem = function(gridItem, key, view) {
      gridItem.move()
      var length = Math.fetchLength(
        gridItem.x, gridItem.y,
        view.x + (view.width / 2.0), 
        view.y + (view.height / 2.0)
      )

      if (length > GRID_ITEM_FRUSTUM_RANGE) {
        gridItem.signal("kill")
      }
    }

    this.controller.bulletService.bullets.forEach(moveGridItem, this.controller.gridService.view)
    this.controller.shroomService.shrooms.forEach(moveGridItem, this.controller.gridService.view)
    var player = this.controller.playerService.player
    if (Core.isType(player, Player)) {
      player.move()
    }
    return this
  }

  ///@private
  ///@return {GridService}
  signalGridItemsCollision = function() {
    static bulletCollision = function(bullet, index, context) {
      static playerBullet = function(shroom, index, bullet) {
        if (shroom.collide(bullet)) {
          shroom.signal("bulletCollision")
          bullet.signal("shroomCollision")
        }
      }
      static shroomBullet = function(player, bullet) {
        if (player.collide(bullet)) {
          player.signal("bulletCollision")
          bullet.signal("playerCollision")
        }
      }

      switch (bullet.producer) {
        case Player:
          this.controller.shroomService.shrooms.forEach(playerBullet, bullet)
          break
        case Shroom:
          shroomBullet(context.controller.playerService.player, bullet)
          break
        default:
          Logger.warn("GridService", "Found invalid bullet producer")
          break
      }
    }

    static shroomCollision = function(shroom, index, player) {
      if (shroom.collide(player)) {
        shroom.signal("playerCollision")
        player.signal("shroomCollision")
      }
    }
    
    var player = this.controller.playerService.player
    if (Core.isType(player, Player)) {
      this.controller.bulletService.bullets.forEach(bulletCollision, this) 
      this.controller.shroomService.shrooms.forEach(shroomCollision, player)
    }
    
    return this
  }

  ///@private
  ///@return {GridService}
  updateGridItems = function() {
    this.controller.playerService.update(this)
    this.controller.shroomService.update(this)
    this.controller.bulletService.update(this)
    return this
  }

  ///@param {Event} event
  ///@return {?Promise}
  send = function(event) {
    return this.dispatcher.send(event)
  }

  ///@override
  ///@return {GridService}
  update = function() {
    this.properties.update(this)
    this.dispatcher.update()
    this.executor.update()
    this.view.setFollowTarget(Core.isType(this.controller.playerService.player, Player)
        ? this.controller.playerService.player
        : null)
      .update()
    this.moveGridItems()
      .signalGridItemsCollision()
      .updateGridItems()

    if (keyboard_check_pressed(vk_space)) {
      /*
      this.send(new Event("transform-property", {
        key: "vec2",
        container: this.properties,
        executor: this.executor,
        transformer: new Vector2Transformer({
          x: {
            value: this.properties.vec2.x,
            target: choose(1, -1) * irandom(100),
            factor: choose(1, 2),
            increase: 0,
          },
          y: {
            value: this.properties.vec2.y,
            target: choose(1, -1) * irandom(50),
            factor: choose(1, 2),
            increase: 0,
          },
        })
      }))
      */
      /*
      this.send(new Event("transform-property", {
        key: "primaryWireframeColor",
        container: this.properties,
        executor: this.executor,
        transformer: new ColorTransformer({
          value: this.properties.primaryWireframeColor.toHex(),
          target: choose("#ffccaa", "#1100bb", "#00ff5b"),
          factor: choose(0.01, 0.05, 0.1, 0.2),
        })
      }))
      */
      /*
      this.send(new Event("transform-property", {
        key: "channels",
        container: this.properties,
        executor: this.executor,
        transformer: new NumberTransformer({
          value: this.properties.channels,
          target: irandom(30),
          factor: choose(0.01, 0.05, 0.1, 0.2),
          increase: 0,
        })
      }))
      */
    }
    return this
  }
}
