///@package io.alkapivo.visu.service.player

///@type {Struct}
global.__PLAYER_GAME_MODES = {
  "bulletHell": function(config) {
    return new PlayerGameModeBulletHell(config)
  },
  "platformer": function(config) {
    return new PlayerGameModePlatformer(config)
  }
}
#macro PLAYER_GAME_MODES global.__PLAYER_GAME_MODES


///@param {Struct} [json]
function PlayerMovement(json = {}) constructor {
  
  ///@type {Number}
  speed = Assert.isType(Struct.getDefault(json, "speed", 0), Number)
  
  ///@type {Number}
  speedMax = Assert.isType(Struct.getDefault(json, "speedMax", 2.1 * 0.01), Number)
  
  ///@type {Number}
  acceleration = Assert.isType(Struct.getDefault(json, "acceleration", 3.2 * 0.0006), Number)
  
  ///@type {Number}
  friction = Assert.isType(Struct.getDefault(json, "friction", 3.1 * 0.0003), Number)
}


///@interface
///@param {Struct} [json]
function PlayerGameMode(json = {}) constructor {

  ///@type {Number}
  x = Assert.isType(new PlayerMovement(Struct.contains(json, "x") ? json.x : {}), PlayerMovement)
  
  ///@type {Number}
  y = Assert.isType(new PlayerMovement(Struct.contains(json, "y") ? json.y : {}), PlayerMovement)

  ///@override
  ///@param {Player} player
  ///@param {VisuController} controller
  update = method(this, function(player, controller) { })
}


///@param {Struct} [json]
function PlayerGameModeBulletHell(json = {}): PlayerGameMode(json) constructor {

  ///@override
  ///@param {Player} player
  ///@param {VisuController} controller
  update = method(this, function(player, controller) {
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
    
    var newX = calcSpeed(this.x, player, player.keyboard.keys.left.on, 
      player.keyboard.keys.right.on)
    var newY = calcSpeed(this.y, player, player.keyboard.keys.up.on, 
      player.keyboard.keys.down.on)
    /*
    player.angle = Math.fetchAngle(player.x, player.y, 
      player.x + newX, player.y + newY)
    player.speed = Math.fetchLength(player.x, player.y, 
      player.x + newX, player.y + newY)
    */
    player.x += newX
    player.y += newY
  })
}

function PlayerGameModePlatformer(json): PlayerGameMode() constructor {

  ///@override
  ///@param {Player} player
  ///@param {VisuController} controller
  update = method(this, function(player, controller) { })
}

