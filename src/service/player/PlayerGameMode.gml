///@package io.alkapivo.visu.service.player

///@param {Struct} json
///@return {GridItemGameMode}
function PlayerIdleGameMode(json) {
  return new GridItemGameMode(Struct.append(json, {

    ///@param {Callable}
    type: PlayerIdleGameMode,

  }))
}


///@param {Struct} json
///@return {GridItemGameMode}
function PlayerBulletHellGameMode(json) {
  return new GridItemGameMode(Struct.append(json, {

    ///@type {Callable}
    type: PlayerBulletHellGameMode,

    ///@type {GridItemMovement}
    x: new GridItemMovement(Struct.getDefault(json, "x", { })),
    
    ///@type {GridItemMovement}
    y: new GridItemMovement(Struct.getDefault(json, "y", { })),

    ///@type {Timer}
    cooldown: new Timer(Struct.getDefault(json, "cooldown", FRAME_MS * 8), { loop: Infinity }),

    ///@override
    ///@param {Player} player
    ///@param {VisuController} controller
    update: function(player, controller) {
      static calcSpeed = function(config, player, keyA, keyB) {
        config.speed = keyA || keyB
          ? (config.speed + (keyA ? -1 : 1) 
            * DeltaTime.apply(config.acceleration))
          : (abs(config.speed) - config.friction >= 0
            ? config.speed - sign(config.speed) 
              * DeltaTime.apply(config.friction) : 0)
        config.speed = sign(config.speed) * clamp(abs(config.speed), 0, config.speedMax)
        return config.speed
      }
      
      var keys = player.keyboard.keys
      player.x = player.x + calcSpeed(this.x, player, keys.left.on, keys.right.on)
      player.y = player.y + calcSpeed(this.y, player, keys.up.on, keys.down.on)

      if (keys.action.on && this.cooldown.finished) {
        this.cooldown.update()
        controller.bulletService.send(new Event("spawn-bullet", {
          x: player.x,
          y: player.y,
          angle: 90,
          speed: 10,
          producer: Player,
          template: "bullet_default",
        }))
      } else if (!this.cooldown.finished) {
        this.cooldown.update()
      }
    },
  }))
}


///@param {Struct} json
///@return {GridItemGameMode}
function PlayerPlatformerGameMode(json) {

  return new GridItemGameMode(Struct.append(json, {

    ///@param {Callable}
    type: PlayerPlatformerGameMode,

    ///@param {GridItemMovement}
    x: new GridItemMovement(Struct.getDefault(json, "x", { })),

    ///@param {GridItemMovement}
    y: new GridItemMovement(Struct.getDefault(json, "y", { })),

    ///@type {Number}
    jumpSize: Struct.contains(json, "jumpSize")
      ? Assert.isType(json.jumpSize, Number)
      : 0.1,

    ///@type {?Shroom}
    shroomLanded: null,

    ///@type {Boolean}
    doubleJumped: false,

    ///@override
    ///@param {Player} player
    ///@param {VisuController} controller
    update: function(player, controller) {
      static calcSpeed = function(config, player, keyA, keyB) {
        config.speed = keyA || keyB
          ? (config.speed + (keyA ? -1 : 1) 
            * DeltaTime.apply(config.acceleration))
          : (abs(config.speed) - config.friction >= 0
            ? config.speed - sign(config.speed) 
              * DeltaTime.apply(config.friction) : 0)
        config.speed = sign(config.speed) * clamp(abs(config.speed), 0, config.speedMax)
        return config.speed
      }

      var gridService = controller.gridService
      var view = gridService.view
      var keys = player.keyboard.keys    
      player.x = player.x + calcSpeed(this.x, player, keys.left.on, keys.right.on)

      var shroomCollision = player.signals.shroomCollision
      if (!Optional.is(shroomCollision)) {
        if (keys.up.pressed && player.y == gridService.height) {
          this.y.speed = -1 * this.jumpSize
        }

        if (Optional.is(this.shroomLanded)) {
          this.shroomLanded.signal("playerLeave")
          this.shroomLanded = null
        }

        if (this.doubleJumped && player.y == gridService.height) {
          this.doubleJumped = false
        }

        if (!this.doubleJumped && player.y != gridService.height) {
          if (keys.up.pressed) {
            this.y.speed = -1 * this.jumpSize
            this.doubleJumped = true
          }
        }

        player.y = player.y + calcSpeed(this.y, player, false, true)
      } else {
        if (keys.up.pressed && this.y.speed > 0) {
          this.y.speed = -1 * this.jumpSize
        }

        if (!this.doubleJumped && !Optional.is(this.shroomLanded)) {
          if (keys.up.pressed) {
            this.y.speed = -1 * this.jumpSize
            this.doubleJumped = true
          }
        }

        if (this.y.speed < 0.0) {
          player.y = player.y + calcSpeed(this.y, player, false, true)
        } else {
          if (!Optional.is(this.shroomLanded)) {
            this.shroomLanded = shroomCollision
            this.shroomLanded.signal("playerLanded")
            this.doubleJumped = false

            if (keys.down.pressed) {
              shroomCollision.signal("kill")
              this.y.speed = 0.0
            }
          } else {
            player.x = player.x + (((this.shroomLanded.angle > 270.0 && this.shroomLanded.angle < 90) ? -1 : 1) 
              * Math.fetchCircleX(DeltaTime.apply(this.shroomLanded.speed), this.shroomLanded.angle))
            player.y = player.y + (((this.shroomLanded.angle > 180.0 && this.shroomLanded.angle < 0) ? -1 : 1) 
              * Math.fetchCircleY(DeltaTime.apply(this.shroomLanded.speed), this.shroomLanded.angle))

            if (keys.down.pressed) {
              this.shroomLanded.signal("kill")
              this.y.speed = 0.0
            }
          } 
        }
      }

      // ground
      player.y = clamp(player.y, 0.0, gridService.height)
      if (player.y == 0.0 || player.y == gridService.height) {
        this.y.speed = 0.0
        if (Optional.is(this.shroomLanded)) {
          this.shroomLanded.signal("playerLeave")
          this.shroomLanded = null
          this.doubleJumped = false
        }
      }
    },
  }))
}


///@static
///@type {Map<String, Callable>}
global.__PLAYER_GAME_MODES = new Map(String, any)
  .set(GameMode.IDLE, PlayerIdleGameMode)
  .set(GameMode.BULLETHELL, PlayerBulletHellGameMode)
  .set(GameMode.PLATFORMER, PlayerPlatformerGameMode)
#macro PLAYER_GAME_MODES global.__PLAYER_GAME_MODES
PLAYER_GAME_MODES.valueType = Callable


