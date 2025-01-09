///@package io.alkapivo.visu.service.bullet

#macro TAU 6.28

///@param {String}
///@param {Struct} json
function BulletTemplate(_name, json) constructor {

  ///@type {String}
  name = Assert.isType(_name, String)

  ///@type {Struct}
  sprite = Assert.isType(Struct.get(json, "sprite"), Struct)

  ///@type {?Struct}
  mask = Struct.getIfType(json, "mask", Struct)

  ///@type {?Number}
  lifespawnMax = Struct.getIfType(json, "lifespawnMax", Number)

  ///@type {?Number}
  damage = Struct.getIfType(json, "damage", Number)

  ///@type {?Boolean}
  wiggle = Struct.getIfType(json, "wiggle", Boolean)

  ///@type {?Number}
  wiggleTime = Struct.getIfType(json, "wiggleTime", Number)

  ///@type {?Boolean}
  wiggleTimeRng = Struct.getIfType(json, "wiggleTimeRng", Boolean)

  ///@type {?Number}
  wiggleFrequency = Struct.getIfType(json, "wiggleFrequency", Number)

  ///@type {?Boolean}
  wiggleDirRng = Struct.getIfType(json, "wiggleDirRng", Boolean)

  ///@type {?Number}
  wiggleAmplitude = Struct.getIfType(json, "wiggleAmplitude", Number)

  ///@type {?Struct}
  angleOffset = Struct.getIfType(json, "angleOffset", Struct)

  ///@type {Boolean}
  angleOffsetRng = Struct.getIfType(json, "angleOffsetRng", Boolean, false)

  ///@type {Boolean}
  useAngleOffset = Struct.getIfType(json, "useAngleOffset", Boolean, false)

  ///@type {Boolean}
  changeAngleOffset = Struct.getIfType(json, "changeAngleOffset", Boolean, false)

  ///@type {?Struct}
  speedOffset = Struct.getIfType(json, "speedOffset", Struct)

  ///@type {Boolean}
  useSpeedOffset = Struct.getIfType(json, "useSpeedOffset", Boolean, false)

  ///@type {Boolean}
  changeSpeedOffset = Struct.getIfType(json, "changeSpeedOffset", Boolean, false)

  ///@type {?String}
  onDeath = Struct.getIfType(json, "onDeath", String)

  ///@type {?Number}
  onDeathAmount = Struct.getIfType(json, "onDeathAmount", Number)

  ///@type {?Number}
  onDeathAngle = Struct.getIfType(json, "onDeathAngle", Number)

  ///@type {?Boolean}
  onDeathAngleRng = Struct.getIfType(json, "onDeathAngleRng", Boolean)

  ///@type {?Number}
  onDeathAngleStep = Struct.getIfType(json, "onDeathAngleStep", Number)

  ///@type {?Number}
  onDeathRngStep = Struct.getIfType(json, "onDeathRngStep", Number)

  ///@type {?Number}
  onDeathSpeed = Struct.getIfType(json, "onDeathSpeed", Number)

  ///@type {?Boolean}
  onDeathSpeedMerge = Struct.getIfType(json, "onDeathSpeedMerge", Boolean)

  ///@type {?Number}
  onDeathRngSpeed = Struct.getIfType(json, "onDeathRngSpeed", Number)

  ///@return {Struct}
  serialize = function() {
    var json = {
      sprite: this.sprite,
      useSpeedOffset: this.useSpeedOffset,
      changeSpeedOffset: this.changeSpeedOffset,
      useAngleOffset: this.useAngleOffset,
      changeAngleOffset: this.changeAngleOffset,
    }

    if (Optional.is(this.damage)) {
      Struct.set(json, "damage", this.damage)
    }

    if (Optional.is(this.lifespawnMax)) {
      Struct.set(json, "lifespawnMax", this.lifespawnMax)
    }

    if (Optional.is(this.mask)) {
      Struct.set(json, "mask", this.mask)
    }

    if (Optional.is(this.wiggle)) {
      Struct.set(json, "wiggle", this.wiggle)
    }

    if (Optional.is(this.wiggleTime)) {
      Struct.set(json, "wiggleTime", this.wiggleTime)
    }

    if (Optional.is(this.wiggleTimeRng)) {
      Struct.set(json, "wiggleTimeRng", this.wiggleTimeRng)
    }

    if (Optional.is(this.wiggleFrequency)) {
      Struct.set(json, "wiggleFrequency", this.wiggleFrequency)
    }

    if (Optional.is(this.wiggleDirRng)) {
      Struct.set(json, "wiggleDirRng", this.wiggleDirRng)
    }

    if (Optional.is(this.wiggleAmplitude)) {
      Struct.set(json, "wiggleAmplitude", this.wiggleAmplitude)
    }

    if (Optional.is(this.angleOffset)) {
      Struct.set(json, "angleOffset", this.angleOffset)
    }

    if (Optional.is(this.angleOffsetRng)) {
      Struct.set(json, "angleOffsetRng", this.angleOffsetRng)
    }

    if (Optional.is(this.speedOffset)) {
      Struct.set(json, "speedOffset", this.speedOffset)
    }

    if (Optional.is(this.onDeath)) {
      Struct.set(json, "onDeath", this.onDeath)
    }

    if (Optional.is(this.onDeathAmount)) {
      Struct.set(json, "onDeathAmount", this.onDeathAmount)
    }

    if (Optional.is(this.onDeathAngle)) {
      Struct.set(json, "onDeathAngle", this.onDeathAngle)
    }

    if (Optional.is(this.onDeathAngleRng)) {
      Struct.set(json, "onDeathAngleRng", this.onDeathAngleRng)
    }

    if (Optional.is(this.onDeathAngleStep)) {
      Struct.set(json, "onDeathAngleStep", this.onDeathAngleStep)
    }

    if (Optional.is(this.onDeathRngStep)) {
      Struct.set(json, "onDeathRngStep", this.onDeathRngStep)
    }

    if (Optional.is(this.onDeathSpeed)) {
      Struct.set(json, "onDeathSpeed", this.onDeathSpeed)
    }

    if (Optional.is(this.onDeathSpeedMerge)) {
      Struct.set(json, "onDeathSpeedMerge", this.onDeathSpeedMerge)
    }

    if (Optional.is(this.onDeathRngSpeed)) {
      Struct.set(json, "onDeathRngSpeed", this.onDeathRngSpeed)
    }

    return JSON.clone(json)
  }
}


///@param {BulletTemplate} template
function Bullet(template): GridItem(template) constructor {

  ///@type {Player|Shroom}
  producer = template.producer
  Assert.isTrue(this.producer == Player || this.producer == Shroom)

  ///@private
  ///@type {Number}
  lifespawnMax = Core.isType(Struct.get(template, "lifespawnMax"), Number)
    ? template.lifespawnMax
    : 15.0
  
  ///@type {Number}
  damage = Core.isType(Struct.get(template, "damage"), Number) 
    ? template.damage 
    : 1.0

  ///@type {Boolean}
  wiggle = Struct.getIfType(template, "wiggle", Boolean, false)

  ///@type {Number}
  wiggleTime = Struct.getIfType(template, "wiggleTime", Number, 0.0)

  ///@type {Boolean}
  wiggleTimeRng = Struct.getIfType(template, "wiggleTimeRng", Boolean, false)

  ///@type {?Number}
  wiggleFrequency = Struct.getIfType(template, "wiggleFrequency", Number, FRAME_MS)

  ///@type {?Boolean}
  wiggleDirRng = Struct.getIfType(template, "wiggleDirRng", Boolean, false)

  ///@type {?Number}
  wiggleAmplitude = Struct.getIfType(template, "wiggleAmplitude", Number, 0.0)

  this.wiggleTime = this.wiggleTimeRng 
    ? random(this.wiggleTime) 
    : this.wiggleTime
  this.wiggleFrequency = this.wiggleDirRng
    ? choose(1, -1) * this.wiggleFrequency
    : this.wiggleFrequency


  if (Optional.is(Struct.get(template, "angleOffset"))) {
    if (!template.useAngleOffset) {
      Struct.set(template.angleOffset, "value", this.angle)
    }

    if (!template.changeAngleOffset) {
      Struct.set(template.angleOffset, "target", template.angleOffset.value)
      Struct.set(template.angleOffset, "factor", abs(template.angleOffset.value))
      Struct.set(template.angleOffset, "increase", 0.0)
    }
  }

  ///@type {?NumberTransformer}
  angleOffset = Optional.is(Struct.getIfType(template, "angleOffset", Struct))
    ? new NumberTransformer(template.angleOffset)
    : null

  ///@type {Boolean}
  angleOffsetRng = Struct.getIfType(template, "angleOffsetRng", Boolean, false)

  ///@param {Number}
  angleOffsetDir = this.angleOffsetRng ? choose(1, -1) : 1


  if (Optional.is(Struct.get(template, "speedOffset"))) {
    if (!template.useSpeedOffset) {
      Struct.set(template.speedOffset, "value", this.speed * 1000.0)
    }

    if (!template.changeSpeedOffset) {
      Struct.set(template.speedOffset, "target", template.speedOffset.value)
      Struct.set(template.speedOffset, "factor", abs(template.speedOffset.value))
      Struct.set(template.speedOffset, "increase", 0.0)
    }
  }

  ///@type {?NumberTransformer}
  speedOffset = Optional.is(Struct.get(template, "speedOffset"))
    ? new NumberTransformer(template.speedOffset)
    : null

  ///@type {?String}
  onDeath = Struct.getIfType(template, "onDeath", String)

  ///@type {?Number}
  onDeathAmount = Struct.getIfType(template, "onDeathAmount", Number)

  ///@type {?Number}
  onDeathAngle = Struct.getIfType(template, "onDeathAngle", Number)

  ///@type {?Boolean}
  onDeathAngleRng = Struct.getIfType(template, "onDeathAngleRng", Boolean)

  ///@type {?Number}
  onDeathAngleStep = Struct.getIfType(template, "onDeathAngleStep", Number)

  ///@type {?Number}
  onDeathRngStep = Struct.getIfType(template, "onDeathRngStep", Number)

  ///@type {?Number}
  onDeathSpeed = Struct.getIfType(template, "onDeathSpeed", Number)

  ///@type {?Boolean}
  onDeathSpeedMerge = Struct.getIfType(template, "onDeathSpeedMerge", Boolean)

  ///@type {?Number}
  onDeathRngSpeed = Struct.getIfType(template, "onDeathRngSpeed", Number)

  ///@param {Number}
  startAngle = this.angle

  ///@param {Number}
  startSpeed = this.speed

  ///@param {VisuController} controller
  ///@return {Bullet}
  static update = function(controller) {
    var componentAngle = 0.0
    var componentSpeed = 0.0

    if (this.wiggle) {
      this.wiggleTime += DeltaTime.apply(this.wiggleFrequency * FRAME_MS)
      if (this.wiggleTime > TAU) {
        this.wiggleTime -= TAU
      } else if (this.wiggleTime < 0.0) {
        this.wiggleTime += TAU
      }
      componentAngle += sin(this.wiggleTime) * this.wiggleAmplitude
    }

    if (this.angleOffset != null) {
      componentAngle += this.angleOffsetDir * this.angleOffset.update().value
    }

    this.angle = this.startAngle + componentAngle

    if (this.speedOffset != null) {
      componentSpeed = this.speedOffset.update().value / 1000.0
    }

    this.speed = abs(this.startSpeed + componentSpeed)
    
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