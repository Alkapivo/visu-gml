///@package io.alkapivo.visu

///@enum
function _GameMode(): Enum() constructor {
  IDLE = "idle"
  BULLETHELL = "bulletHell"
  PLATFORMER = "platformer"
}
global.__GameMode = new _GameMode()
#macro GameMode global.__GameMode


#macro BeanVisuController "visuController"
///@param {String} layerName
function VisuController(layerName) constructor {

  ///@type {DisplayService}
  displayService = new DisplayService(this)

  ///@type {FileService}
  fileService = new FileService(this)

  ///@type {ShaderPipeline}
  shaderPipeline = new ShaderPipeline()

  ///@type {ShaderPipeline}
  shaderBackgroundPipeline = new ShaderPipeline(shaderPipeline)

  ///@type {ParticleService}
  particleService = new ParticleService(this, { layerName: layerName })

  ///@type {TrackService}
  trackService = new TrackService(this)

  ///@type {PlayerService}
  playerService = new PlayerService(this)

	///@type {ShroomService}
  shroomService = new ShroomService(this)

	///@type {BulletService}
  bulletService = new BulletService(this)

  ///@type {GridService}
  gridService = new GridService(this)

  ///@type {GridRenderer}
  gridRenderer = new GridRenderer(this)

  ///@type {VideoService}
  videoService = new VideoService(this)

  ///@type {LyricsService}
  lyricsService = new LyricsService(this)

  ///@type {LyricsRenderer}
  lyricsRenderer = new LyricsRenderer(this)

  ///@type {UIService}
  uiService = new UIService(this)

  ///@type {VisuEditor}
  editor = new VisuEditor(this)

  ///@type {GridSystem}
  //gridSystem = new GridSystem(this)

  ////@type {Gamemode}
  gameMode = GameMode.PLATFORMER

  ///@type {Keyboard}
  keyboard = new Keyboard({ load: "L" })

  ///@type {Mouse}
  mouse = new Mouse({ 
    left: MouseButtonType.LEFT,
    right: MouseButtonType.RIGHT,
    wheelUp: MouseButtonType.WHEEL_UP,
    wheelDown: MouseButtonType.WHEEL_DOWN,
  })

  ///@type {VisuTrackLoader}
  loader = new VisuTrackLoader(this)

  ///@type {Boolean}
  enableUIContainerServiceRendering = true

  ///@type {FSM}
  fsm = new FSM(this, {
    initialState: { 
      name: "idle",
      data: new Event("load", {
        manifest: FileUtil.get(String
          .join("", working_directory, Assert.isType(Core
          .getProperty("visu.file.manifest", "manifest.json"), String))),
        autoplay: Assert.isType(Core.getProperty("visu.autoplay", false), Boolean),
      })
    },
    states: {
      "idle": {
        actions: {
          onStart: function(fsm, fsmState, data) {
            if (Core.isType(data, Event)) {
              fsm.context.send(data)
            }
          },
        },
        update: function(fsm) {
          if (fsm.context.keyboard.keys.load.pressed) {
            fsm.context.send(new Event("load", {
              manifest: $"{working_directory}manifest.json",
              autoplay: true
            }))
          }
        },
        transitions: GMArray.toStruct([ "load", "play", "pause", "quit" ]),
      },
      "load": {
        actions: {
          onStart: function(fsm, fsmState, data) {
            fsmState.state.set("autoplay", data.autoplay)
            fsm.context.loader.fsm.dispatcher.send(new Event("transition", {
              name: "parse-manifest",
              data: data.manifest,
            }))
            
            audio_stop_all()
            VideoUtil.runGC()
            Beans.get(BeanSoundService).free()
            Beans.get(BeanTextureService).free()
          },
        },
        update: function(fsm) {
          try {
            var loaderState = fsm.context.loader.fsm.getStateName()
            Assert.areEqual(loaderState != null && loaderState != "idle", true, $"Invalid loader state: {loaderState}")
            if (loaderState == "loaded") {
              fsm.dispatcher.send(new Event("transition", {
                name: this.state.get("autoplay") ? "play" : "pause",
              }))
            }
          } catch (exception) {
            Logger.error("VisuController::FSM", $"'load' fatal error: {exception.message}")
            fsm.dispatcher.send(new Event("transition", { name: "idle" }))
            fsm.context.loader.fsm.dispatcher.send(new Event("transition", { 
              name: "idle",
              data: $"'load' fatal error: {exception.message}"
            }))
          }
        },
        transitions: GMArray.toStruct([ "idle", "play", "pause" ]),
      },
      "play": {
        actions: {
          onStart: function(fsm, fsmState, data) {
            fsmState.state.set("promises", new Map(String, Promise, {
              "player": fsm.context.playerService.send(new Event("spawn-player")),
              "video": fsm.context.videoService.send(new Event("resume-video")),
            }))
          },
        },
        update: function(fsm) {
          try {
            if (this.state.get("promises-resolved") != "success") {
              var promises = this.state.get("promises")
              var filtered = promises.filter(fsm.context.loader.utils.filterPromise)
              if (filtered.size() != promises.size()) {
                return
              }

              if (!promises.contains("track")) {
                promises.set("track", fsm.context.trackService.send(new Event("resume-track")))
                return
              }

              this.state.set("promises-resolved", "success")
              return
            }

            //Assert.isType(fsm.context.playerService.player, Player)
            //Assert.areEqual(fsm.context.videoService.getVideo().getStatus(), VideoStatus.PLAYING)
            //Assert.areEqual(fsm.context.trackService.track.getStatus(), TrackStatus.PLAYING)
          } catch (exception) {
            Logger.error("VisuController::FSM", $"'play': {exception.message}")
            fsm.dispatcher.send(new Event("transition", {
              name: "idle",
              data: $"'play' fatal error: {exception.message}",
            }))
          }
        },
        transitions: GMArray.toStruct([ "idle", "load", "pause", "rewind", "quit" ]),
      },
      "pause": {
        actions: {
          onStart: function(fsm, fsmState, data) {
            fsmState.state.set("promises", new Map(String, Promise, {
              "video": fsm.context.videoService.send(new Event("pause-video")),
              "track": fsm.context.trackService.send(new Event("pause-track")),
            }))
          },
        },
        update: function(fsm) {
          try {
            if (this.state.get("promises-resolved") != "success") {
              var promises = this.state.get("promises")
              var filtered = promises.filter(fsm.context.loader.utils.filterPromise)
              if (filtered.size() != promises.size()) {
                return
              }
              this.state.set("promises-resolved", "success")
            }

            //Assert.areEqual(fsm.context.videoService.video.getStatus(), VideoStatus.PAUSED)
            //Assert.areEqual(fsm.context.trackService.track.getStatus(), TrackStatus.PAUSED)
          } catch (exception) {
            Logger.error("VisuController", $"{exception.message}")
            fsm.dispatcher.send(new Event("transition", {
              name: "idle",
              data: $"'pause' fatal error: {exception.message}",
            }))
          }
        },
        transitions: GMArray.toStruct([ "idle", "load", "play", "rewind", "quit" ]),
      },
      "rewind": {
        actions: {
          onStart: function(fsm, fsmState, data) {
            fsmState.state
              .set("resume", data.resume)
              .set("data", data)
              .set("promises", new Map(String, Promise, {
                "pause-track": fsm.context.trackService.send(new Event("pause-track")),
                "rewind-video": fsm.context.videoService.send(new Event("rewind-video", data)),
              }))
          },
        },
        update: function(fsm) {
          try {
            if (this.state.get("promises-resolved") != "success") {
              var promises = this.state.get("promises")
              ///@description gml bug answered by videoServiceAttempts "feature"
              try {
                var filtered = promises.filter(fsm.context.loader.utils.filterPromise)
                if (filtered.size() != promises.size()) {
                  return
                }
              } catch (exception) {
                promises.forEach(function(promise, name) {
                  if (name != "rewind-video" && promise.status == PromiseStatus.REJECTED) {
                    throw new Exception($"non-video promise failed: '{name}'")
                  }
                })

                var data = this.state.get("data")
                var videoServiceAttempts = Struct.get(data, "videoServiceAttempts")
                if (!Core.isType(videoServiceAttempts, Number) 
                  || videoServiceAttempts == 0) {
                  throw new Exception($"video promise failed. 'videoServiceAttempts' value: {videoServiceAttempts}")
                }
                data.videoServiceAttempts = videoServiceAttempts - 1
                Logger.debug("VisuController", $"videoServiceAttempts value: {data.videoServiceAttempts}")
                promises.set("rewind-video", fsm.context.videoService.send(new Event("rewind-video", data)))
                return
              }

              if (!promises.contains("rewind-track")) {
                promises.set("rewind-track", fsm.context.trackService.send(new Event(
                  "rewind-track", this.state.get("data"))))
                return
              }

              this.state.set("promises-resolved", "success")
              fsm.context.send(new Event(this.state.get("resume") ? "play" : "pause"))
              return
            }
          } catch (exception) {
            Logger.error("VisuController", $"{exception.message}")
            fsm.dispatcher.send(new Event("transition", {
              name: this.state.get("resume") ? "play" : "pause",
              data: $"'rewind' fatal error: {exception.message}",
            }))
          }
        },
        transitions: GMArray.toStruct([ "idle", "play", "pause", "quit" ]),
      },
      "quit": {
        actions: {
          onStart: function(fsm, fsmState, data) { 
            fsm.context.free()
            game_end()
          }
        },
      },
    },
  })

  ///@type {VisuModal}
  exitModal = new VisuModal(this, {
    message: { text: "Changes you made may not be saved." },
    accept: {
      text: "Leave",
      callback: function() {
        game_end()
      }
    },
    deny: {
      text: "Cancel",
      callback: function() {
        this.context.modal.send(new Event("close"))
      }
    }
  })

  ///@type {EventPump}
  dispatcher = new EventPump(this, new Map(String, Callable, {
    "change-gamemode": function(event) {
      this.gameMode = Assert.isEnum(event.data, GameMode)
    },
    "load": function(event) {
      this.fsm.dispatcher.send(new Event("transition", { 
        name: "load", 
        data: event.data
      }))
    },
    "play": function(event) {
      /*
      if (this.fsm.getStateName() != "pause") {
        return
      }
      */
      this.fsm.dispatcher.send(new Event("transition", { name: "play" }))
    },
    "pause": function(event) {
      /*
      if (this.fsm.getStateName() != "play") {
        return
      }
      */
      this.fsm.dispatcher.send(new Event("transition", { name: "pause" }))
    },
    "rewind": function(event) {
      var fsmEvent = new Event("transition", { 
        name: "rewind", 
        data: {
          resume: this.fsm.getStateName() == "play",
          timestamp: Assert.isType(event.data.timestamp, Number),
          videoServiceAttempts: Struct.getDefault(event.data, "videoServiceAttempts", 5),
        }
      })
      
      if (Core.isType(event.promise, Promise)) {
        fsmEvent.setPromise(event.promise)
        event.setPromise(null)
      }
      this.fsm.dispatcher.send(fsmEvent)
    },
    "quit": function(event) {
      this.fsm.dispatcher.send(new Event("transition", { name: "quit" }))
    },
  }))

  ///@type {TaskExecutor}
  executor = new TaskExecutor(this)

  ///@param {Event}
  ///@return {?Promise}
  send = function(event) {
    return this.dispatcher.send(event)
  }

  ///@private
  init = function() {
    var fullscreen = Assert.isType(Core.getProperty("visu.fullscreen", false), Boolean)
    this.displayService
      .resize(
        Assert.isType(Core.getProperty("visu.window.width", 1280), Number),
        Assert.isType(Core.getProperty("visu.window.height", 720), Number)
      )
      .setFullscreen(fullscreen)

    show_debug_overlay(Assert.isType(Core.getProperty("visu.debug-overlay", false), Boolean))
    window_set_cursor(cr_none)
    cursor_sprite = texture_bazyl_cursor
  }

  ///@private
  ///@return {VisuController}
  updateIO = function() {
    this.keyboard.update()
    this.mouse.update()
    if (this.mouse.buttons.left.pressed) {
      this.uiService.send(new Event("MousePressedLeft", { 
        x: MouseUtil.getMouseX(), 
        y: MouseUtil.getMouseY(),
      }))
    }

    if (this.mouse.buttons.left.released) {
      this.uiService.send(new Event("MouseReleasedLeft", { 
        x: MouseUtil.getMouseX(), 
        y: MouseUtil.getMouseY(),
      }))
    }

    if (this.mouse.buttons.left.drag) {
      this.uiService.send(new Event("MouseDragLeft", { 
        x: MouseUtil.getMouseX(), 
        y: MouseUtil.getMouseY(),
      }))
    }

    if (this.mouse.buttons.left.drop) {
      this.uiService.send(new Event("MouseDropLeft", { 
        x: MouseUtil.getMouseX(), 
        y: MouseUtil.getMouseY(),
      }))
    }

    if (this.mouse.buttons.right.pressed) {
      this.uiService.send(new Event("MousePressedRight", { 
        x: MouseUtil.getMouseX(), 
        y: MouseUtil.getMouseY(),
      }))
    }
    
    if (this.mouse.buttons.wheelUp.on) {  
      this.uiService.send(new Event("MouseWheelUp", { 
        x: MouseUtil.getMouseX(), 
        y: MouseUtil.getMouseY(),
      }))
    }
    
    if (this.mouse.buttons.wheelDown.on) {  
      this.uiService.send(new Event("MouseWheelDown", {
        x: MouseUtil.getMouseX(),
        y: MouseUtil.getMouseY(),
      }))
    }

    if (MouseUtil.hasMoved()) {  
      this.uiService.send(new Event("MouseHoverOver", {
        x: MouseUtil.getMouseX(),
        y: MouseUtil.getMouseY(),
      }))
    }

    return this
  }

  ///@private
  ///@return {VisuController}
  updateDisplay = function() {
    if (keyboard_check_pressed(vk_f11)) {
      var fullscreen = this.displayService.getFullscreen()
      Logger.debug("VisuController", String.join("Set fullscreen to ",
        fullscreen ? "'false'" : "'true'", "."))
      this.displayService.setFullscreen(!fullscreen)
    }

    return this
  }

  ///@private
  ///@return {VisuController}
  updateCursor = function() {
    cursor_sprite = keyboard_check(vk_control) 
      ? texture_bazyl_cursor 
      : texture_baron_cursor
    return this
  }

  ///@private
  ///@return {VisuController}
  updateExitModal = function() {
    if (keyboard_check_pressed(vk_escape)) {
      this.exitModal.send(new Event("open").setData({
        layout: new UILayout({
          name: "display",
          x: function() { return 0 },
          y: function() { return 0 },
          width: function() { return GuiWidth() },
          height: function() { return GuiHeight() },
        }),
      }))
    }
    this.exitModal.update()

    return this
  }
  
  ///@return {VisuController}
  update = function() {
    this.updateIO().updateDisplay().updateCursor().updateExitModal()
    this.fsm.update()
    this.loader.update()

    this.displayService.update()
    this.fileService.update()
    this.dispatcher.update()
    this.executor.update()
    this.uiService.update()
	  this.particleService.update()
	  this.shaderPipeline.update()
    this.shaderBackgroundPipeline.update()
	  this.trackService.update()
	  this.gridService.update()
    this.lyricsService.update()
	  this.gridRenderer.update()
    this.videoService.update()
    this.editor.update()
    //this.gridSystem.update()



    return this
  }

  ///@return {VisuController}
  onSceneEnter = function() {
    Logger.info("VisuController", "onSceneEnter")
    return this
  }

  ///@return {VisuController}
  onSceneLeave = function() {
    Logger.info("VisuController", "onSceneLeave")
    return this
  }

  ///@return {VisuController}
  onNetworkEvent = function() {
    try {
      var json = json_encode(async_load)
      var event = JSON.parse(json)
      var message = buffer_read(event.buffer, buffer_string)
      Core.print("[onNetworkEvent] event:", event)
      Core.print("[onNetworkEvent] message:", message)
    } catch (exception) {
      Logger.error("[VisuController::onNetworkEvent]", exception.message)	
    }

    return this
  }

  ///@return {VisuController}
  render = function() {
    gpu_set_alphatestenable(true)
    this.gridRenderer.render()
    //this.gridSystem.render()
    return this
  }

  ///@return {VisuController}
  renderGUI = function() {
    if (keyboard_check_pressed(vk_f2)) {
      this.enableUIContainerServiceRendering = !this.enableUIContainerServiceRendering
    }

    this.gridRenderer.renderGUI()
    this.lyricsRenderer.renderGUI()
    if (this.enableUIContainerServiceRendering) {
      this.uiService.render()
      var loaderState = Beans.get(BeanVisuController).loader.fsm.getStateName()
      if (loaderState != "idle" && loaderState != "loaded") {
        var color = c_fuchsia
        var alpha = 0.33
        var label = new UILabel({
          align: { v: VAlign.CENTER, h: HAlign.CENTER },
          font: "font_inter_24_regular",
          text: $"LOADING:\n{string(irandom(1000) + 1000)}\n{loaderState}",
          color: "#ffffff",
          outline: true,
          outlineColor: "#000000",
        })
        
        label.render(GuiWidth() / 2.0, GuiHeight() / 2.0)
        GPU.render.rectangle(0, 0, GuiWidth(), GuiHeight(), 
          false, color, color, color, color, alpha)
      }
    }
    
    MouseUtil.renderSprite()
    //this.editor.render()
    return this
  }

  ///@return {VisuController}
  free = function() {
    Struct.toMap(this)
      .filter(function(value) {
        if (!Core.isType(value, Struct)
          || !Struct.contains(value, "free")
          || !Core.isType(Struct.get(value, "free"), Callable)) {
          return false
        }
        return true
      })
      .forEach(function(struct, key, context) {
        try {
          Logger.debug("VisuController", $"Free '{key}'")
          Callable.run(Struct.get(struct, "free"))
          var ref = ref_create(context, key)
          delete ref
        } catch (exception) {
          Logger.error("VisuController", $"Unable to free '{key}'. {exception.message}")
        }
      }, this)
    
    return this
  }

  this.init()
}

/*

  ///@type {Socket}
  socket = new Socket({
    host: "localhost",
    port: 8082,
    type: SocketType.WS,
  })

  randomShader = function() {
    if (keyboard_check_pressed(vk_space)) {
      var keys = this.shaderPipeline.templates.keys()
      var index = irandom(keys.size() - 1)
      var key = keys.get(index)
      
      Core.print("Shader key:", key)

      shaderPipeline.dispatcher.send(new Event("spawn-shader", {
        name: key,
        duration: 7.0
      }))
    }
  }

  testSurface = new Surface({ width: 512, height: 512 })
  blendModes = [ 
    bm_zero, 
    bm_one, 
    bm_src_colour, 
    bm_inv_src_colour, 
    bm_src_alpha, 
    bm_inv_src_alpha, 
    bm_dest_alpha, 
    bm_inv_dest_alpha, 
    bm_dest_colour, 
    bm_inv_dest_colour, 
    bm_src_alpha_sat
  ]
  blendSrcPtr = 4
  blendDestPtr = 5
  testBlendModes = function() {
    if (keyboard_check_pressed(ord("I"))) {
      this.blendSrcPtr = clamp(this.blendSrcPtr + 1, 0, GMArray.size(this.blendModes) - 1)
      Core.print("BlendSrcPtr+:", this.blendSrcPtr)
    }

    if (keyboard_check_pressed(ord("K"))) {
      this.blendSrcPtr = clamp(this.blendSrcPtr - 1, 0, GMArray.size(this.blendModes) - 1)
      Core.print("BlendSrcPtr-:", this.blendSrcPtr)
    }

    if (keyboard_check_pressed(ord("O"))) {
      this.blendDestPtr = clamp(this.blendDestPtr + 1, 0, GMArray.size(this.blendModes) - 1)
      Core.print("BlendDestPtr+:", this.blendDestPtr)
    }
    
    if (keyboard_check_pressed(ord("L"))) {
      this.blendDestPtr = clamp(this.blendDestPtr - 1, 0, GMArray.size(this.blendModes) - 1)
      Core.print("BlendDestPtr-:", this.blendDestPtr)
    }
    

    //draw_sprite(texture_test_transparent, 0, 0, 0)
    //draw_sprite(texture_baron, 0, 0, 0)
    //draw_sprite(texture_baron, 0, 256, 0)
    draw_sprite(texture_baron, 0, window_mouse_get_x(), window_mouse_get_y())
    /*
    draw_sprite(texture_test_transparent, 0, 512, 0)
    this.testSurface.update()
      .renderOn(function(context) {
        GPU.render.clear(ColorUtil.BLACK_TRANSPARENT)
        gpu_set_blendmode_ext(context.blendModes[context.blendSrcPtr], context.blendModes[context.blendDestPtr])
        draw_sprite(texture_baron, 0, 0, 0)
        draw_sprite(texture_baron, 0, 256, 0)
        draw_sprite(texture_baron, 0, window_mouse_get_x(), window_mouse_get_y())
        gpu_set_blendmode(bm_normal)
      }, this)
    this.testSurface.render(512, 0)
  }

///////////////////////
    if (keyboard_check_pressed(vk_space)) {
      var fadeSpriteEvent = new Event("fade-sprite", {
        sprite: SpriteUtil.parse({ name: "texture_particle_default" }),
        collection: this.gridRenderer.overlayRenderer.foregrounds,
      })
      this.send(fadeSpriteEvent)
    }
    if (keyboard_check_pressed(vk_control)) {
      var fadeSpriteEvent = new Event("fade-sprite", {
        sprite: 
        ({ name: "texture_test" }),
        collection: this.gridRenderer.overlayRenderer.foregrounds,
      })
      this.send(fadeSpriteEvent)
    }
    if (keyboard_check_pressed(vk_space)) {
      this.videoService.send(new Event("pause-video"))
    }

    if (keyboard_check_pressed(vk_control)) {
      this.videoService.send(new Event("resume-video"))
    }

    if (keyboard_check_pressed(vk_control)) {
      this.socket.send("ws test message " + string(random(1000)))
    }

    if (keyboard_check_pressed(vk_space)) {
      var event = this.particleService.factoryEventSpawnParticleEmitter({
        beginX: mouse_x,
        beginY: mouse_y,
        endX: mouse_x,
        endY: mouse_y,
      })
      this.particleService.send(event)
    }
*/
