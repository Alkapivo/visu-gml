///@package io.alkapivo.visu.service.grid

///@type {Number}
global.__GRID_SERVICE_PIXEL_WIDTH = 2048
#macro GRID_SERVICE_PIXEL_WIDTH global.__GRID_SERVICE_PIXEL_WIDTH


///@type {Number}
global.__GRID_SERVICE_PIXEL_HEIGHT = 2048
#macro GRID_SERVICE_PIXEL_HEIGHT global.__GRID_SERVICE_PIXEL_HEIGHT


///@type {Number}
global.__GRID_ITEM_FRUSTUM_RANGE = 8
#macro GRID_ITEM_FRUSTUM_RANGE global.__GRID_ITEM_FRUSTUM_RANGE


///@type {Number}
global.__GRID_ITEM_CHUNK_SERVICE_SIZE = 0.5
#macro GRID_ITEM_CHUNK_SERVICE_SIZE global.__GRID_ITEM_CHUNK_SERVICE_SIZE


///@param {Number} {_size}
function GridItemChunkService(_size) constructor {

  ///@type {Number}
  size = Assert.isType(_size, Number)

  ///@type {Map<String, Array<GridItem>>}
  chunks = new Map(String, Array)

  ///@param {Number} x
  ///@param {Number} y
  ///@return {String}
  getKey = function(x, y) {
    //return $"{int64(x)}_{int64(y)}"
    return string(int64(x)) + "_" + string(int64(y))
  }

  ///@param {String}
  ///@throws {AssertException}
  ///@return {Array<GridItem>}
  get = function(key) {
    //Assert.isType(key, String, "[GridItemChunkService::get(key)] argument 'key' must be a type of String")
    if (!this.chunks.contains(key)) {
      this.chunks.set(key, new Array(GridItem))
    }

    return this.chunks.get(key)
  }

  ///@param {GridItem}
  ///@throws {Exception}
  ///@return {GridItemChunkService}
  add = function(item) {
    Assert.isType(item, GridItem, "[GridItemChunkService::add(item)] argument 'item' must be a type of GridItem")
    var width = (item.mask.getWidth() * item.sprite.scaleX) / GRID_SERVICE_PIXEL_WIDTH
    var height = (item.mask.getHeight() * item.sprite.scaleY) / GRID_SERVICE_PIXEL_HEIGHT
    var position = {
      start: {
        x: int64((((item.x) - (width / 2)) / this.size)),
        y: int64((((item.y) - (height / 2)) / this.size)),
      },
      finish: {
        x: int64((((item.x) + (width / 2)) / this.size)),
        y: int64((((item.y) + (height / 2)) / this.size)),
      },
      keys: new Array(String),
    }

    for (var row = 0; row <= position.finish.y - position.start.y; row++) {
      for (var column = 0; column <= position.finish.x - position.start.x; column++) {
        var key = this.getKey(position.start.x + column, position.start.y + row)
        var chunk = this.get(key)
        if (Optional.is(chunk.findIndex(Lambda.equal, item))) {
          var message = $"GridItem with uid '{item.uid}' was already added to chunk '{key}'"
          Logger.error("GridItemChunkService::add(item)", message)
          Core.printStackTrace()
          throw new Exception(message)
        }

        chunk.add(item)
        position.keys.add(key)
      }
    }

    item.chunkPosition = position
    return this
  }

  ///@param {GridItem} item
  ///@throws {AssertException|Exception}
  ///@return {GridItemChunkService}
  remove = function(item) {
    Assert.isType(item, GridItem, "[GridItemChunkService::remove(item)] argument 'item' must be a type of GridItem")
    item.chunkPosition.keys.forEach(function(key, iterator, acc) {
      var chunk = acc.get(key)
      var index = chunk.findIndex(Lambda.equal, acc.item)
      if (!Optional.is(index)) {
        var message = $"GridItem with uid '{acc.item.uid}' wasn't found in chunk '{key}'"
        Logger.error("GridItemChunkService::remove(item)", message)
        Core.printStackTrace()
        throw new Exception(message)
      }

      chunk.remove(index)
    }, {
      get: this.get,
      item: item,
    })

    item.chunkPosition = null
    return this
  }

  ///@param {GridItem} item
  ///@throws {AssertException|Exception}
  ///@return {GridItemChunkService}
  update = function(item) {
    //Assert.isType(item.chunkPosition, Struct, "[GridItemChunkService::update(item)] 'item.chunkPosition' must be a type of Struct")
    var position = item.chunkPosition
    var width = (item.mask.getWidth() * item.sprite.scaleX) / GRID_SERVICE_PIXEL_WIDTH
    var height = (item.mask.getHeight() * item.sprite.scaleY) / GRID_SERVICE_PIXEL_HEIGHT
    var startX = int64((((item.x) - (width / 2)) / this.size))
    var startY = int64((((item.y) - (height / 2)) / this.size))
    var finishX = int64((((item.x) + (width / 2)) / this.size))
    var finishY = int64((((item.y) + (height / 2)) / this.size))
    
    if (position.start.x != startX
      || position.start.y != startY
      || position.finish.x != finishX
      || position.finish.y != finishY) {

      ///this.remove(item) without replacing chunkPosition
      var array = item.chunkPosition.keys
      var size = array.size()
      for (var idx = 0; idx < size; idx++) {
        var key = array.get(idx)
        var chunk = this.get(key)
        var index = chunk.findIndex(Lambda.equal, item)
        if (!Optional.is(index)) {
          var message = $"GridItem with uid '{item.uid}' wasn't found in chunk '{key}'"
          Logger.error("GridItemChunkService::update(item)", message)
          Core.printStackTrace()
          throw new Exception(message)
        }
        chunk.remove(index)
      }

      ///this.add(item) without replacing chunkPosition
      position.start.x = startX
      position.start.y = startY
      position.finish.x = finishX
      position.finish.y = finishY
      position.keys.clear()
      for (var row = 0; row <= position.finish.y - position.start.y; row++) {
        for (var column = 0; column <= position.finish.x - position.start.x; column++) {
          var key = this.getKey(position.start.x + column, position.start.y + row)
          var chunk = this.get(key)
          if (Optional.is(chunk.findIndex(Lambda.equal, item))) {
            var message = $"GridItem with uid '{item.uid}' was already added to chunk '{key}'"
            Logger.error("GridItemChunkService::update(item)", message)
            Core.printStackTrace()
            throw new Exception(message)
          }
  
          chunk.add(item)
          position.keys.add(key)
        }
      }
    }

    return this
  }

  ///@return {GridItemChunkService}
  clear = function() {
    this.chunks.clear()
    return this
  }
}


///@param {VisuController} _controller
///@param {Struct} [_config]
function GridService(_controller, _config = {}): Service(_config) constructor {

  ///@type {VisuController}
  controller = Assert.isType(_controller, VisuController)

  ///@type {Struct}
  config = JSON.clone(_config)

  ///@type {Number}
  width = Assert.isType(Struct.getDefault(this.config, "width", 2048.0), Number)

  ///@type {Number}
  height = Assert.isType(Struct.getDefault(this.config, "height", 2048.0), Number)

  ///@type {Number}
  pixelWidth = Assert.isType(Struct
    .getDefault(this.config, "pixelWidth", GRID_SERVICE_PIXEL_WIDTH), Number)

  ///@type {Number}
  pixelHeight = Assert.isType(Struct
    .getDefault(this.config, "pixelHeight", GRID_SERVICE_PIXEL_HEIGHT), Number)

  ///@type {GridView}
  view = new GridView({ 
    worldWidth: this.width, 
    worldHeight: this.height,
  })
  ///@description (set camera on middle bottom)
  this.view.x = (this.width - this.view.width) / 2.0
	this.view.y = this.height - (this.view.height * 2.0)

  ///@type {Struct}
  targetLocked = {
    x: this.view.x,
    y: this.view.y,
    isLockedX: false,
    isLockedY: false,
    setX: function(x) {
      this.x = x
      return this
    },
    setY: function(y) {
      this.y = y
      return this
    },
    margin: {
      top: 0.2,
      right: 0.5,
      bottom: 0.2, 
      left: 0.5,
    },
  }

  ///@type {Struct}
  properties = Optional.is(Struct.get(this.config, "properties"))
    ? new GridProperties(this.config.properties)
    : new GridProperties()

  ///@private
  ///@type {Number}
  uidPointer = int64(Core.isType(Struct.get(config, "uidPointer"), Number) 
    ? config.uidPointer 
    : 0) 

  ///@private
  ///@return {String}
  generateUID = function() {
    if (this.uidPointer >= MAX_INT_64 - 1) {
      Logger.warn("GridService", $"Reached maximum available value for uidPointer ('{MAX_INT_64}'). Reset uidPointer to '0'")
      this.uidPointer = int64(0)
    }
    this.uidPointer++
    return md5_string_utf8(string(this.uidPointer))
  }

  init = function() {
    var task = new Task("init-foreground")
      .setTimeout(3.0)
      .whenUpdate(function(executor) {
        var controller = Beans.get(BeanVisuController)
        controller.send(new Event("fade-sprite", {
          sprite: SpriteUtil.parse({ name: "texture_hechan_3" }),
          collection: controller.visuRenderer.gridRenderer.overlayRenderer.foregrounds,
          type: "Foreground",
          fadeInDuration: 0.5,
          fadeOutDuration: 0.5,
          angle: 3,
          speed: 0.25,
          blendModeSource: BlendModeExt.SRC_ALPHA,
          blendModeTarget: BlendModeExt.ONE,
          executor: executor,
        }))
        this.fullfill()
      })
    this.controller.executor.add(task)
    
    return this
  }

  ///@type {EventPump}
  dispatcher = new EventPump(this, new Map(String, Callable, {
    "transform-property": Callable.run(Struct.get(EVENT_DISPATCHERS, "transform-property")),
    "fade-sprite": Callable.run(Struct.get(EVENT_DISPATCHERS, "fade-sprite")),
    "fade-color": Callable.run(Struct.get(EVENT_DISPATCHERS, "fade-color")),
    "clear-grid": function(event) {

      this.view.x = (this.width - this.view.width) / 2.0
	    this.view.y = this.height - this.view.height
      
      this.targetLocked = {
        x: this.view.x,
        y: this.view.y,
        isLockedX: false,
        isLockedY: false,
        setX: function(x) {
          this.x = x
          return this
        },
        setY: function(y) {
          this.y = y
          return this
        },
        margin: {
          top: 0.2,
          right: 0.5,
          bottom: 0.2, 
          left: 0.5,
        },
      }

      properties = Optional.is(Struct.get(this.config, "properties"))
        ? new GridProperties(this.config.properties)
        : new GridProperties()
    },
  }))

  ///@type {TaskExecutor}
  executor = new TaskExecutor(this)

  ///@private
  ///@type {DebugTimer}
  moveGridItemsTimer = new DebugTimer("MoveGridItems")

  ///@private
  ///@type {DebugTimer}
  signalGridItemsCollisionTimer = new DebugTimer("GrdCollission")

  ///@private
  ///@type {DebugTimer}
  updatePlayerServiceTimer = new DebugTimer("PlayerService")

  ///@private
  ///@type {DebugTimer}
  updateShroomServiceTimer = new DebugTimer("ShroomService")

  ///@private
  ///@type {DebugTimer}
  updateBulletServiceTimer = new DebugTimer("BulletService")
  
  ///@private
  ///@return {GridService}
  moveGridItems = function() {
    static moveBullet = function(bullet, key, acc) {
      bullet.move()
      if (bullet.producer == Player) {
        acc.chunkService.update(bullet)
      }
      
      var view = acc.view
      var length = Math.fetchLength(
        bullet.x, bullet.y,
        view.x + (view.width / 2.0), 
        view.y + (view.height / 2.0)
      )

      if (length > GRID_ITEM_FRUSTUM_RANGE) {
        bullet.signal("kill")
      }
    }

    static moveShroom = function(shroom, key, acc) {
      shroom.move()
      acc.chunkService.update(shroom)
      
      var view = acc.view
      var length = Math.fetchLength(
        shroom.x, shroom.y,
        view.x + (view.width / 2.0), 
        view.y + (view.height / 2.0)
      )

      if (length > GRID_ITEM_FRUSTUM_RANGE) {
        shroom.signal("kill")
      }
    }

    var view = this.controller.gridService.view
    this.controller.bulletService.bullets.forEach(moveBullet, {
      view: view,
      chunkService: this.controller.bulletService.chunkService,
    })

    this.controller.shroomService.shrooms.forEach(moveShroom, {
      view: view,
      chunkService: this.controller.shroomService.chunkService,
    })

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
          shroom.signal("bulletCollision", bullet)
          shroom.signal("damage", true)
          shroom.healthPoints = clamp(shroom.healthPoints - bullet.damage, 0, 9999.9)
          bullet.signal("shroomCollision", shroom)
        }
      }
      static shroomBullet = function(player, bullet) {
        if (player.collide(bullet)) {
          player.signal("bulletCollision", bullet)
          bullet.signal("playerCollision", player)
        }
      }

      switch (bullet.producer) {
        case Player:
          bullet.chunkPosition.keys.forEach(function(key, index, acc) {
            acc.chunkService.get(key).forEach(acc.playerBullet, acc.bullet)
          }, {
            chunkService: context.controller.shroomService.chunkService,
            playerBullet: playerBullet,
            bullet: bullet,
          })
          //context.controller.shroomService.shrooms.forEach(playerBullet, bullet)
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
        player.signal("shroomCollision", shroom)
        shroom.signal("playerCollision", player)
        shroom.signal("damage", true)
        shroom.healthPoints = clamp(shroom.healthPoints - 1.0, 0, 9999.9)
      }
    }

    static shroomCollisionGodMode = function(shroom, index, player) {
      if (shroom.collide(player)) {
        player.signal("shroomCollision", shroom)
      }
    }
    
    var player = this.controller.playerService.player
    if (Core.isType(player, Player)) {
      this.controller.bulletService.bullets.forEach(bulletCollision, this) 
      this.controller.shroomService.shrooms.forEach(player.stats.godModeCooldown > 0.0 
        ? shroomCollisionGodMode : shroomCollision, player)
    }
    
    return this
  }

  ///@private
  ///@return {GridService}
  updateGridItems = function() {
    this.updatePlayerServiceTimer.start()
    this.controller.playerService.update(this)
    this.updatePlayerServiceTimer.finish()

    this.updateShroomServiceTimer.start()
    this.controller.shroomService.update(this)
    this.updateShroomServiceTimer.finish()

    this.updateBulletServiceTimer.start()
    this.controller.bulletService.update(this)
    this.updateBulletServiceTimer.finish()
    return this
  }

  ///@param {Event} event
  ///@return {?Promise}
  send = function(event) {
    return this.dispatcher.send(event)
  }

  ///@type {Struct}
  movement = {
    enable: false,
    angle: new NumberTransformer({ value: 90.0, target: 1.0, factor: 0.01, increase: 0.0 }),
    speed: new NumberTransformer({ value: 0.0, target: 1.0, factor: 0.01, increase: 0.0 }),
  }

  ///@override
  ///@return {GridService}
  update = function() {
    this.properties.update(this)
    this.dispatcher.update()
    this.executor.update()

    var player = this.controller.playerService.player
    if (this.movement.enable) {
      this.movement.angle.update()
      this.movement.speed.update()
      this.targetLocked.setX(this.targetLocked.x + Math
        .fetchCircleX(DeltaTime.apply(this.movement.speed.get()) / 500.0, this.movement.angle.get()))
      this.targetLocked.setY(this.targetLocked.y + Math
        .fetchCircleY(DeltaTime.apply(this.movement.speed.get()) / 500.0, this.movement.angle.get()))
    } else {
      if (Core.isType(player, Player)) {
        this.targetLocked.setX(player.x)
        this.targetLocked.setY(player.y)
      }

      if (this.targetLocked.isLockedX) {
        this.targetLocked.setX((this.view.width * floor(this.view.x / this.view.width)) + (this.view.width / 2))
      }
  
      if (this.targetLocked.isLockedY) {
        this.targetLocked.setY((this.view.height * floor(this.view.y / this.view.height)) + (this.view.height / 2))
      }
    }

    if (Core.isType(player, Player)) {
      player.x = clamp(player.x, 0.0, this.width)
      player.y = clamp(player.y, 0.0, this.height)
    }

    this.view
      .setFollowTarget(this.targetLocked)
      .update()
    
    this.moveGridItemsTimer.start()
    this.moveGridItems()
    this.moveGridItemsTimer.finish()

    this.signalGridItemsCollisionTimer.start()
    this.signalGridItemsCollision()
    this.signalGridItemsCollisionTimer.finish()

    this.updateGridItems()
    return this
  }

  this.init()
}
