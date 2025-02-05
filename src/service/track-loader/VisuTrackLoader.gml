///@package io.alkapivo.visu

///@param {VisuController} _controller
function VisuTrackLoader(_controller): Service() constructor {

  ///@type {VisuController}
  controller = Assert.isType(_controller, VisuController)
  
  ///@todo extract to generic 
  ///@type {Struct}
  utils = {
    addTask: function(task, executor) {
      executor.add(task)
      return Assert.isType(task.promise, Promise)
    },
    filterPromise: function(promise, name) {
      if (!promise.isReady()) {
        return false
      }

      if (promise.status != PromiseStatus.FULLFILLED) { 
        throw new Exception($"Found rejected promise: {name}")
      }
      return true
    },
    mapPromiseToTask: function(promise) {
      return Assert.isType(promise.response, Task)
    },
    wasmSounds: new Map(String, String, {
      "Just-To-Create-Something.ogg": "sound_kedy_selma_just_to_create_something",
      "Passion.ogg": "sound_kedy_selma_passion",
      "digitalshadowfinalunmixed.ogg": "sound_zoogies_digitalshadow",
      "Schnoopy-Destination-Unknown.ogg": "sound_schnoopy_destination_unknown",
    }),
  }

  ///@type {FSM}
  fsm = new FSM(this, {
    initialState: { name: "idle" },
    displayName: "VisuTrackLoader",
    states: {
      "idle": {
        actions: {
          onStart: function(fsm, fsmState, data) {
            var editor = Beans.get(BeanVisuEditorController)
            if (Core.isType(editor, VisuEditorController)) {
              editor.send(new Event("open"))
            }
            
            if (Core.isType(data, String)) {
              Logger.info("VisuTrackLoader", $"message: '{data}'")
            }
          },
        },
        transitions: { 
          "idle": null,
          "parse-manifest": null,
        },
      },
      "parse-manifest": {
        actions: {
          onStart: function(fsm, fsmState, path) {
            var controller = Beans.get(BeanVisuController)
            controller.displayService.setCaption(game_display_name)
            controller.brushService.clearTemplates()
            controller.visuRenderer.gridRenderer.clear()
            var editor = Beans.get(BeanVisuEditorController)
            if (Core.isType(editor, VisuEditorController)) {
              editor.popupQueue.dispatcher.execute(new Event("clear"))
              editor.dispatcher.execute(new Event("close"))
            }

            controller.trackService.dispatcher.execute(new Event("close-track"))
            controller.videoService.dispatcher.execute(new Event("close-video"))
            
            controller.gridService.dispatcher.execute(new Event("clear-grid"))
            controller.gridService.executor.tasks.forEach(TaskUtil.fullfill).clear()
            controller.gridService.init()
            
            controller.playerService.dispatcher.execute(new Event("clear-player"))
            controller.shroomService.dispatcher.execute(new Event("clear-shrooms")).execute(new Event("reset-templates"))
            controller.bulletService.dispatcher.execute(new Event("clear-bullets")).execute(new Event("reset-templates"))
            controller.coinService.dispatcher.execute(new Event("clear-coins")).execute(new Event("reset-templates"))
            controller.subtitleService.dispatcher.execute(new Event("clear-subtitle")).execute(new Event("reset-templates"))
            
            controller.particleService.dispatcher.execute(new Event("clear-particles")).execute(new Event("reset-templates"))
            controller.shaderPipeline.dispatcher.execute(new Event("clear-shaders")).execute(new Event("reset-templates"))
            controller.shaderBackgroundPipeline.dispatcher.execute(new Event("clear-shaders")).execute(new Event("reset-templates"))
            controller.shaderCombinedPipeline.dispatcher.execute(new Event("clear-shaders")).execute(new Event("reset-templates"))
            Beans.get(BeanTextureService).dispatcher.execute(new Event("free"))

            fsmState.state.set("promise", Beans.get(BeanFileService).send(
              new Event("fetch-file")
                .setData({ path: path })
                .setPromise(new Promise()
                  .whenSuccess(function(result) {
                    var callback = this.setResponse
                    JSON.parserTask(result.data, { 
                      callback: function(prototype, json, key, acc) {
                        acc.callback(new prototype(acc.path, json))
                      }, 
                      acc: {
                        callback: callback,
                        path: result.path,
                      },
                    }).update()
                    
                    var editor = Beans.get(BeanVisuEditorController)
                    if (Core.isType(editor, VisuEditorController)) {
                      var item = editor.store.get("bpm")
                      item.set(this.response.bpm)
  
                      item = editor.store.get("bpm-count")
                      item.set(this.response.bpmCount)

                      item = editor.store.get("bpm-sub")
                      item.set(this.response.bpmSub)
                    }
                    
                    return {
                      path: Assert.isType(FileUtil.getDirectoryFromPath(result.path), String),
                      manifest: Assert.isType(this.response, VisuTrack),
                    }
                  })
                )
            ))
          },
        },
        update: function(fsm) {
          try {
            var promise = this.state.get("promise")
            if (!promise.isReady()) {
              return
            }
            
            fsm.dispatcher.send(new Event("transition", {
              name: "create-parser-tasks",
              data: {
                path: Assert.isType(promise.response.path, String),
                manifest: Assert.isType(promise.response.manifest, VisuTrack),
              },
            }))
          } catch (exception) {
            var message = $"'parse-manifest' fatal error: {exception.message}"
            Beans.get(BeanVisuController).send(new Event("spawn-popup", { message: message }))
            Logger.error("VisuTrackLoader", message)
            fsm.dispatcher.send(new Event("transition", { name: "idle" }))
          }
        },
        transitions: { 
          "idle": null, 
          "create-parser-tasks": null,
        },
      },
      "create-parser-tasks": {
        actions: {
          onStart: function(fsm, fsmState, data) {
            var controller = fsm.context.controller
            controller.track = data.manifest
            var promises = new Map(String, Promise, {
              "texture": Beans.get(BeanFileService).send(
                new Event("fetch-file")
                  .setData({ path: $"{data.path}{data.manifest.texture}" })
                  .setPromise(new Promise()
                    .setState({ 
                      callback: function(prototype, json, iterator, acc) {
                        //Logger.debug("VisuTrackLoader", $"Load texture '{json.name}'")
                        acc.promises.forEach(function(promise, key) {
                          if (promise.status == PromiseStatus.REJECTED) {
                            throw new Exception($"Found rejected load-texture promise for key '{key}'")
                          }
                        })

                        var textureIntent = Assert.isType(new prototype(json), TextureIntent)
                        textureIntent.file = FileUtil.get($"{acc.path}{textureIntent.file}")
                        var promise = new Promise()
                        acc.service.send(new Event("load-texture")
                          .setData(textureIntent)
                          .setPromise(promise))
                        acc.promises.add(promise, textureIntent.name)
                      },
                      acc: {
                        service: Beans.get(BeanTextureService),
                        promises: new Map(String, Promise),
                        path: controller.track.path,
                      },
                      steps: 2,
                    })
                    .whenSuccess(function(result) {
                      return Assert.isType(JSON.parserTask(result.data, this.state), Task)
                    }))
              ),
              "sound": Beans.get(BeanFileService).send(
                new Event("fetch-file")
                  .setData({ path: $"{data.path}{data.manifest.sound}" })
                  .setPromise(new Promise()
                    .setState({ 
                      callback: function(prototype, json, key, acc) {
                        //Logger.debug("VisuTrackLoader", $"Load sound intent '{key}'")
                        var soundIntent = new prototype(json)
                        var soundService = acc.soundService
                        if (Core.getRuntimeType() == RuntimeType.GXGAMES) {
                          Assert.isTrue(audio_group_is_loaded(audiogroup_visu_wasm), 
                            "'audiogroup_visu_wasm' must be loaded")
                          var sound = Assert.isType(SoundUtil
                            .fetchGMSound(acc.wasmSounds.get(soundIntent.file)), GMSound, 
                            $"Couldn't find sound for wasm target, {soundIntent.file}")
                          soundService.sounds.add(sound, key)
                          return
                        }

                        var path = FileUtil.get($"{acc.path}{soundIntent.file}")
                        Assert.fileExists(path)
                        Assert.isFalse(soundService.sounds.contains(key), "GMSound already loaded")

                        var stream = audio_create_stream(path)
                        soundService.sounds.add(stream, key)
                        soundService.intents.add(soundIntent, key)
                      },
                      acc: {
                        soundService: Beans.get(BeanSoundService),
                        path: controller.track.path,
                        wasmSounds: fsm.context.utils.wasmSounds,
                      },
                      steps: 1,
                    })
                    .whenSuccess(function(result) {
                      return Assert.isType(JSON.parserTask(result.data, this.state), Task)
                    }))
              ),
              "shader": Beans.get(BeanFileService).send(
                new Event("fetch-file")
                  .setData({ path: $"{data.path}{data.manifest.shader}" })
                  .setPromise(new Promise()
                    .setState({ 
                      callback: function(prototype, json, key, acc) {
                        //Logger.debug("VisuTrackLoader", $"Load shader template '{key}'")
                        acc.set(key, new prototype(key, json))
                      },
                      acc: controller.shaderPipeline.templates,
                      steps: MAGIC_NUMBER_TASK,
                    })
                    .whenSuccess(function(result) {
                      return Assert.isType(JSON.parserTask(result.data, this.state), Task)
                    }))
              ),
              "track": Beans.get(BeanFileService).send(
                new Event("fetch-file")
                  .setData({ path: $"{data.path}{data.manifest.track}" })
                  .setPromise(new Promise()
                    .setState({ 
                      callback: function(prototype, json, key, acc) {
                        var name = Struct.get(json, "name")
                        //Logger.debug("VisuTrackLoader", $"Load track '{name}'")
                        acc.trackService.openTrack(new prototype(json, { 
                          handlers: acc.trackService.handlers,
                        }))
                      },
                      acc: { trackService: controller.trackService },
                    })
                    .whenSuccess(function(result) {
                      return Assert.isType(JSON.parserTask(result.data, this.state), Task)
                    }))
              ),
              "bullet": Beans.get(BeanFileService).send(
                new Event("fetch-file")
                  .setData({ path: $"{data.path}{data.manifest.bullet}" })
                  .setPromise(new Promise()
                    .setState({ 
                      callback: function(prototype, json, key, acc) {
                        //Logger.debug("VisuTrackLoader", $"Load bullet template '{key}'")
                        acc.set(key, new prototype(key, json))
                      },
                      acc: controller.bulletService.templates,
                      steps: MAGIC_NUMBER_TASK,
                    })
                    .whenSuccess(function(result) {
                      return Assert.isType(JSON.parserTask(result.data, this.state), Task)
                    }))
              ),
              "coin": Beans.get(BeanFileService).send(
                new Event("fetch-file")
                  .setData({ path: $"{data.path}{data.manifest.coin}" })
                  .setPromise(new Promise()
                    .setState({ 
                      callback: function(prototype, json, key, acc) {
                        //Logger.debug("VisuTrackLoader", $"Load coin template '{key}'")
                        acc.set(key, new prototype(key, json))
                      },
                      acc: controller.coinService.templates,
                      steps: MAGIC_NUMBER_TASK,
                    })
                    .whenSuccess(function(result) {
                      return Assert.isType(JSON.parserTask(result.data, this.state), Task)
                    }))
              ),
              "subtitle": Beans.get(BeanFileService).send(
                new Event("fetch-file")
                  .setData({ path: $"{data.path}{data.manifest.subtitle}" })
                  .setPromise(new Promise()
                    .setState({ 
                      callback: function(prototype, json, key, acc) {
                        //Logger.debug("VisuTrackLoader", $"Load subtitle template '{key}'")
                        acc.set(key, new prototype(key, json))
                      },
                      acc: controller.subtitleService.templates,
                      steps: MAGIC_NUMBER_TASK,
                    })
                    .whenSuccess(function(result) {
                      return Assert.isType(JSON.parserTask(result.data, this.state), Task)
                    }))
              ),
              "shroom": Beans.get(BeanFileService).send(
                new Event("fetch-file")
                  .setData({ path: $"{data.path}{data.manifest.shroom}" })
                  .setPromise(new Promise()
                    .setState({ 
                      callback: function(prototype, json, key, acc) {
                        //Logger.debug("VisuTrackLoader", $"Load shroom template '{key}'")
                        acc.set(key, new prototype(key, json))
                      },
                      acc: controller.shroomService.templates,
                      steps: MAGIC_NUMBER_TASK,
                    })
                    .whenSuccess(function(result) {
                      return Assert.isType(JSON.parserTask(result.data, this.state), Task)
                    }))
              ),
              "particle": Beans.get(BeanFileService).send(
                new Event("fetch-file")
                  .setData({ path: $"{data.path}{data.manifest.particle}" })
                  .setPromise(new Promise()
                    .setState({ 
                      callback: function(prototype, json, key, acc) {
                        //Logger.debug("VisuTrackLoader", $"Load particle template '{key}'")
                        acc.set(key, new prototype(key, json))
                      },
                      acc: controller.particleService.templates,
                      steps: MAGIC_NUMBER_TASK,
                    })
                    .whenSuccess(function(result) {
                      return Assert.isType(JSON.parserTask(result.data, this.state), Task)
                    }))
              ),
            })

            if (Core.isType(Struct.get(data.manifest, "video"), String)) {
              fsmState.state.set("video", new Event("open-video", {
                video: {
                  name: $"{data.manifest.video}",
                  path: $"{data.path}{data.manifest.video}",
                  timestamp: 0.0,
                  volume: 0,
                  loop: true,
                }
              }))
            }

            if (Core.getRuntimeType() == RuntimeType.GXGAMES) {
              var audioGroupTask = new Task("load-audio-group")
                .setPromise(new Promise())
                .setTimeout(10.0)
                .setState({
                  isLoading: false
                })
                .whenUpdate(function() {
                  if (!this.state.isLoading) {
                    this.state.isLoading = Beans.get(BeanSoundService)
                      .loadAudioGroup(audiogroup_visu_wasm)
                  } else if (audio_group_is_loaded(audiogroup_visu_wasm)) {
                    this.fullfill()
                  }
                })
              controller.executor.add(audioGroupTask)
              fsmState.state.set("audio-group", audioGroupTask.promise)
            }
            
            data.manifest.editor.forEach(function(file, index, acc) { 
              var promise = Beans.get(BeanFileService).send(
                new Event("fetch-file")
                  .setData({ path: $"{acc.data.path}{file}" })
                  .setPromise(new Promise()
                    .setState({ 
                      callback: function(prototype, json, index, acc) {
                        //Logger.debug("VisuTrackLoader", $"Load brush '{json.name}'")
                        acc.saveTemplate(new prototype(json))
                      },
                      acc: {
                        saveTemplate: Beans.get(BeanVisuController).brushService.saveTemplate,
                        file: file,
                      },
                      steps: MAGIC_NUMBER_TASK,
                    })
                    .whenSuccess(function(result) {
                      return Assert.isType(JSON.parserTask(result.data, this.state), Task)
                    }))
              )
              acc.promises.add(promise, file)
            }, { data: data, promises: promises })
          
            fsmState.state.set("promises", promises)
          },
        },
        update: function(fsm) {
          try {
            var promises = this.state.get("promises")
            var filtered = promises.filter(fsm.context.utils.filterPromise)
            if (filtered.size() != promises.size()) {
              return
            }

            if (Core.getRuntimeType() == RuntimeType.GXGAMES) {
              var audioGroupPromise = this.state.get("audio-group")
              if (audioGroupPromise.status == PromiseStatus.PENDING) {
                return
              }

              Assert.isTrue(audioGroupPromise.status == PromiseStatus.FULLFILLED)
            }

            fsm.dispatcher.send(new Event("transition", {
              name: "parse-primary-assets",
              data: {
                video: this.state.get("video"),
                tasks: filtered.map(fsm.context.utils.mapPromiseToTask, null, String, Task),
              }
            }))
          } catch (exception) {
            var message = $"'create-parser-tasks' fatal error: {exception.message}",
            Beans.get(BeanVisuController).send(new Event("spawn-popup", { message: message }))
            Logger.error("VisuTrackLoader", message)
            fsm.dispatcher.send(new Event("transition", { name: "idle" }))
          }
        },
        transitions: {
          "idle": null, 
          "parse-primary-assets": null,
        },
      },
      "parse-primary-assets": {
        actions: {
          onStart: function(fsm, fsmState, acc) { 
            var addTask = fsm.context.utils.addTask
            var executor = fsm.context.executor
            var video = acc.video
            var tasks = acc.tasks
            fsmState.state
              .set("video", video)
              .set("tasks", tasks)
              .set("parsePrimaryCooldown", new Timer(0.5))
              .set("promises", new Map(String, Promise, {
                "texture": addTask(tasks.get("texture"), executor),
                "sound": addTask(tasks.get("sound"), executor),
                "shader": addTask(tasks.get("shader"), executor),
              }))
          },
        },
        update: function(fsm) {
          try {
            var promises = this.state.get("promises")
            var filtered = promises.filter(fsm.context.utils.filterPromise)
            if (filtered.size() != promises.size()) {
              return
            }

            var texturePromises = this.state.get("tasks").get("texture").state.get("acc").promises
            var filteredTextures = texturePromises.filter(fsm.context.utils.filterPromise)
            if (filteredTextures.size() != texturePromises.size()) {
              return
            }

            if (!this.state.get("parsePrimaryCooldown").update().finished) {
              return
            }

            fsm.dispatcher.send(new Event("transition", {
              name: "parse-video",
              data: {
                video: this.state.get("video"),
                tasks: Assert.isType(this.state.get("tasks"), Map),
              }
            }))
          } catch (exception) {
            var message = $"'parse-primary-assets' fatal error: {exception.message}"
            Beans.get(BeanVisuController).send(new Event("spawn-popup", { message: message }))
            Logger.error("VisuTrackLoader", message)
            fsm.dispatcher.send(new Event("transition", { name: "idle" }))
          }
        },
        transitions: {
          "idle": null,
          "parse-video": null,
          "parse-secondary-assets": null,
        },
      },
      "parse-video": {
        actions: {
          onStart: function(fsm, fsmState, acc) { 
            var addTask = fsm.context.utils.addTask
            var executor = fsm.context.executor
            var promises = new Map(String, Promise)
            fsmState.state.set("tasks", acc.tasks).set("promises", promises)
            if (Core.isType(acc.video, Event)) {
              fsmState.state
                .get("promises")
                .set("video", Beans.get(BeanVisuController).videoService.send(acc.video))
            }
          },
        },
        update: function(fsm) {
          try {
            var promises = this.state.get("promises")
            var filtered = promises.filter(fsm.context.utils.filterPromise)
            if (filtered.size() != promises.size()) {
              return
            }

            fsm.dispatcher.send(new Event("transition", { 
              name: "parse-secondary-assets",
              data: Assert.isType(this.state.get("tasks"), Map)
            }))
          } catch (exception) {
            var message = $"'parse-video' fatal error: {exception.message}"
            Beans.get(BeanVisuController).send(new Event("spawn-popup", { message: message }))
            Logger.error("VisuTrackLoader", message)
            fsm.dispatcher.send(new Event("transition", { name: "idle" }))
          }
        },
        transitions: {
          "idle": null, 
          "parse-secondary-assets": null,
        },
      },
      "parse-secondary-assets": {
        actions: {
          onStart: function(fsm, fsmState, tasks) { 
            var addTask = fsm.context.utils.addTask
            var executor = fsm.context.executor
            var promises = new Map(String, Promise, {
              "bullet": addTask(tasks.get("bullet"), executor),
              "coin": addTask(tasks.get("coin"), executor),
              "subtitle": addTask(tasks.get("subtitle"), executor),
              "particle": addTask(tasks.get("particle"), executor),
              "shroom": addTask(tasks.get("shroom"), executor),
              "track": addTask(tasks.get("track"), executor),
            })

            tasks.forEach(function(task, key, acc) { 
              if (String.contains(key, ".json")) {
                acc.promises.add(acc.addTask(task, acc.executor), key)
              }
            }, { addTask: addTask, executor: executor, promises: promises })
            
            fsmState.state.set("tasks", tasks).set("promises", promises)
          },
        },
        update: function(fsm) {
          try {
            var promises = this.state.get("promises")
            var filtered = promises.filter(fsm.context.utils.filterPromise)
            if (filtered.size() != promises.size()) {
              return
            }

            var audio = Assert.isType(fsm.context.controller.trackService.track.audio, Sound)
            var attempts = this.state.inject("attempts", GAME_FPS * 5) - DeltaTime.apply(1)
            Assert.isTrue(attempts >= 0.0)
            this.state.set("attempts", attempts)
            audio.rewind(0.0)
            if (audio.getPosition() != 0.0) {
              return
            }

            audio.pause()
            fsm.dispatcher.send(new Event("transition", { name: "cooldown" }))
          } catch (exception) {
            var message = $"'parse-secondary-assets' fatal error: {exception.message}"
            Beans.get(BeanVisuController).send(new Event("spawn-popup", { message: message }))
            Logger.error("VisuTrackLoader", message)
            fsm.dispatcher.send(new Event("transition", { name: "idle" }))
          }
        },
        transitions: {
          "idle": null, 
          "cooldown": null,
        },
      },
      "cooldown": {
        actions: {
          onStart: function(fsm, fsmState) {
            fsmState.state.set("cooldown-timer", new Timer(1.0))

            var controller = Beans.get(BeanVisuController)
            controller.executor.tasks.forEach(function(task) {
              if (task.name != "fade-color" && task.name != "fade-sprite") {
                return
              }
      
              if (task.state.get("stage") == "fade-out") {
                task.fullfill()
                return
              }
              
              task.state.set("stage", "fade-out")
            })

            var gridService = controller.gridService
            var properties = gridService.properties
            gridService.send(new Event("transform-property", {
              key: "channelsPrimaryAlpha",
              container: properties,
              executor: gridService.executor,
              transformer: new NumberTransformer({
                value: properties.channelsPrimaryAlpha,
                target: 0.0,
                factor: 0.01,
                increase: 0.0,
              })
            }))
            
            gridService.send(new Event("transform-property", {
              key: "channelsSecondaryAlpha",
              container: properties,
              executor: gridService.executor,
              transformer: new NumberTransformer({
                value: properties.channelsSecondaryAlpha,
                target: 0.0,
                factor: 0.01,
                increase: 0.0,
              })
            }))
            
            gridService.send(new Event("transform-property", {
              key: "separatorsPrimaryAlpha",
              container: properties,
              executor: gridService.executor,
              transformer: new NumberTransformer({
                value: properties.separatorsPrimaryAlpha,
                target: 0.0,
                factor: 0.01,
                increase: 0.0,
              })
            }))
            
            gridService.send(new Event("transform-property", {
              key: "separatorsSecondaryAlpha",
              container: properties,
              executor: gridService.executor,
              transformer: new NumberTransformer({
                value: properties.separatorsSecondaryAlpha,
                target: 0.0,
                factor: 0.01,
                increase: 0.0,
              })
            }))
          },
        },
        update: function(fsm) {
          try {
            var timer = this.state.get("cooldown-timer")
            var editorIO = Beans.get(BeanVisuEditorIO)
            if (timer.update().finished) {
              fsm.dispatcher.send(new Event("transition", { name: "loaded" }))
            } else if (Optional.is(editorIO) && editorIO.keyboard.keys.renderUI.pressed) {
              fsm.dispatcher.send(new Event("transition", { name: "loaded" }))

              var controller = Beans.get(BeanVisuController)
              var editor = Beans.get(BeanVisuEditorController)
              if (Optional.is(editor)) {
                editor.renderUI = !editor.renderUI
                var fsmState = controller.fsm.currentState
                if (editor.renderUI && Optional.is(fsmState) && fsmState.name == "load") {
                  fsmState.state.set("autoplay", false)
                }
              }
            }
          } catch (exception) {
            var message = $"'cooldown' fatal error: {exception.message}"
            Beans.get(BeanVisuController).send(new Event("spawn-popup", { message: message }))
            Logger.error("VisuTrackLoader", message)
            fsm.dispatcher.send(new Event("transition", { name: "idle" }))
          }
        },
        transitions: {
          "idle": null,
          "loaded": null,
        },
      },
      "loaded": {
        actions: {
          onStart: function(fsm, fsmState, tasks) { 
            var controller = Beans.get(BeanVisuController)
            controller.displayService.setCaption($"{game_display_name} | {fsm.context.controller.trackService.track.name} | {fsm.context.controller.track.path}")
            controller.gridService.avgTime.reset()

            var editor = Beans.get(BeanVisuEditorController)
            if (Core.isType(editor, VisuEditorController)) {
              editor.send(new Event("open"))
            }

            controller.send(new Event("spawn-popup", 
              { message: $"Project '{Beans.get(BeanVisuController).trackService.track.name}' loaded successfully" }))
          }
        },
        transitions: {
          "idle": null,
          "parse-manifest": null,
        },
      }
    }
  })

  ///@private
  ///@type {TaskExecutor}
  executor = new TaskExecutor(this, { catchException: false })

  ///@return {FSM}
  update = function() {
    try {
      this.fsm.update()
    } catch (exception) {
      var message = $"VisuTrackLoader FSM fatal error: {exception.message}"
      Beans.get(BeanVisuController).send(new Event("spawn-popup", { message: message }))
      Logger.error("VisuController", message)
    }

    try {
      this.executor.update()
    } catch (exception) {
      this.executor.tasks.clear()
      var message = $"VisuTrackLoader executor fatal error: {exception.message}"
      Beans.get(BeanVisuController).send(new Event("spawn-popup", { message: message }))
      Logger.error("VisuController", message)
      this.fsm.dispatcher.send(new Event("transition", { name: "idle" }))
    }
    return this
  }
}