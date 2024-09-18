///@package io.alkapivo.visu.service.bullet

///@param {String}
///@param {Struct} json
function BulletTemplate(_name, json) constructor {

  ///@type {String}
  name = Assert.isType(_name, String)

  ///@type {Struct}
  sprite = Assert.isType(Struct.get(json, "sprite"), Struct)

  ///@type {?Struct}
  mask = Struct.contains(json, "mask")
    ? Assert.isType(json.mask, Struct)
    : null

  ///@type {?Number}
  damage = Core.isType(Struct.get(json, "damage"), Number) 
    ? json.damage 
    : null

  ///@type {?Struct}
  speedTransformer = Core.isType(Struct.get(json, "speedTransformer"), Struct) 
    ? json.speedTransformer
    : null

  ///@type {?Struct}
  angleTransformer = Core.isType(Struct.get(json, "angleTransformer"), Struct)
    ? json.angleTransformer
    : null

  ///@type {?Struct}
  swingAmount = Core.isType(Struct.get(json, "swingAmount"), Struct)
    ? json.swingAmount
    : null

  ///@type {?Struct}
  swingSize = Core.isType(Struct.get(json, "swingSize"), Struct)
    ? json.swingSize
    : null

  ///@return {Struct}
  serialize = function() {
    var json = {
      sprite: this.sprite,
    }

    if (Optional.is(this.mask)) {
      Struct.set(json, "mask", this.mask)
    }

    if (Optional.is(this.damage)) {
      Struct.set(json, "damage", this.damage)
    }

    if (Optional.is(this.speedTransformer)) {
      Struct.set(json, "speedTransformer", this.speedTransformer)
    }

    if (Optional.is(this.angleTransformer)) {
      Struct.set(json, "angleTransformer", this.angleTransformer)
    }

    if (Optional.is(this.swingSize)) {
      Struct.set(json, "swingSize", this.swingSize)
    }

    if (Optional.is(this.swingAmount)) {
      Struct.set(json, "swingAmount", this.swingAmount)
    }

    return JSON.clone(json)
  }
}


///@param {BulletTemplate} template
function Bullet(template): GridItem(template) constructor {

  ///@type {Player|Shroom}
  producer = template.producer
  Assert.isTrue(this.producer == Player || this.producer == Shroom)

  ///@type {Number}
  damage = Core.isType(Struct.get(template, "damage"), Number) 
    ? template.damage 
    : 1

  ///@type {?Struct}
  speedTransformer = Core.isType(Struct.get(template, "speedTransformer"), Struct) 
    ? new NumberTransformer(template.speedTransformer)
    : null
    
  ///@type {?NumberTransformer}
  angleTransformer = Core.isType(Struct.get(template, "angleTransformer"), Struct) 
    ? new NumberTransformer(template.angleTransformer)
    : null

  ///@type {?NumberTransformer}
  swingAmount = Core.isType(Struct.get(template, "swingAmount"), Struct) 
    ? new NumberTransformer(template.swingAmount)
    : null
  
  ///@type {?NumberTransformer}
  swingSize = Core.isType(Struct.get(template, "swingSize"), Struct) 
    ? new NumberTransformer(template.swingSize)
    : null

  ///@type {Timer}
  swingTimer = new Timer(pi * 2, { loop: Infinity })

  ///@private
  ///@type {Number}
  lifespawnMax = 30
  
  ///@param {VisuController} controller
  ///@return {Bullet}
  static update = function(controller) {
    if (this.speedTransformer != null) {
      this.speed = this.speed + (this.speedTransformer.update().value / 1000.0)
    }
    
    if (this.angleTransformer != null) {
      this.angle = Math.normalizeAngle(this.angle 
        + this.angleTransformer.update().value)
    }
    
    if (this.swingAmount != null) {
      this.swingTimer.amount = this.swingAmount.update().value
    }

    if (this.swingSize != null) {
      this.angle = Math.normalizeAngle(this.angle
        + (sin(this.swingTimer.update().time) 
        * this.swingSize.update().value))
    }
    
    this.lifespawn += DeltaTime.apply(FRAME_MS)
    if (this.lifespawn >= this.lifespawnMax
      || Optional.is(this.signals.shroomCollision)
      || Optional.is(this.signals.playerCollision)) {
      this.signal("kill")
    }

    if (this.fadeIn < 1.0) {
      this.fadeIn = clamp(this.fadeIn + this.fadeInFactor, 0.0, 1.0)
    }
    
    return this
  }

  /* 
  ///@param {VisuController} controller
  ///@return {Bullet}
  static update = function(controller) {
    if (Optional.is(this.gameMode)) {
      gameMode.update(this, controller)
    }

    if (this.fadeIn < 1.0) {
      this.fadeIn = clamp(this.fadeIn + this.fadeInFactor, 0.0, 1.0)
    }
    
    return this
  }

  this.gameModes
    .set(GameMode.RACING, BulletRacingGameMode(Struct
      .getDefault(Struct.get(template, "gameModes"), "racing", {})))
    .set(GameMode.BULLETHELL, BulletBulletHellGameMode(Struct
      .getDefault(Struct.get(template, "gameModes"), "bulletHell", {})))
    .set(GameMode.PLATFORMER, BulletPlatformerGameMode(Struct
      .getDefault(Struct.get(template, "gameModes"), "platformer", {})))
  */
}
