///@package io.alkapivo.visu.service.lyrics

///@param {?Struct} [config]
function LyricsService(config = null): Service() constructor {

  ///@type {Map<String, LyricsTemplate>}
  templates = new Map(String, LyricsTemplate)

  ///@type {EventDispatcher}
  dispatcher = new EventDispatcher(this, new Map(String, Callable, {
    "add": function(event) {
      Logger.debug("LyricsService", "dispatch 'add' event")
    },
  }))

  ///@type {TaskExecutor}
  executor = new TaskExecutor(this)

  ///@override
  ///@return {LyricsService}
  static update = function() {
    this.dispatcher.update()
    this.executor.update()
    return this
  }
}

