///@package io.alkapivo.visu.service.lyrics

///@param {?Struct} [config]
function LyricsService(config = null): Service() constructor {

  ///@type {Map<String, LyricsTemplate>}
  templates = new Map(String, LyricsTemplate)

  ///@type {EventPump}
  dispatcher = new EventPump(this, new Map(String, Callable, {
    "add": function(event) {
      Logger.debug("LyricsService", "dispatch 'add' event")

      var lines = new Array(String)
      var template = Assert.isType(this.templates.get(event.data.template), LyricsTemplate)
      GPU.set.font(event.data.font)
      template.lines.forEach(function(line, index, acc) {
        var text = String.wrapText(line, acc.width, "%NEW_LINE%")
        if (String.contains(text, "%NEW_LINE%")) {
          String.split(text, "%NEW_LINE%")
            .forEach(function(line, index, lines) {
              lines.add(line)
            }, acc.lines)
        } else {
          acc.lines.add(text)
        }
      }, {
        width: event.data.area.getWidth() * GuiWidth(),
        lines: lines
      })

      var task = new Task("lyrics-task")
        .setState({
          lyrics: {
            lines: lines,
            font: event.data.font,
            fontHeight: event.data.fontHeight,
            charSpeed: event.data.charSpeed,
            color: event.data.color,
            align: event.data.align,
            area: event.data.area,
            outline: Struct.getDefault(event.data, "outline", null),
            lineDelay: Struct.getDefault(event.data, "lineDelay", null),
            finishDelay: Struct.getDefault(event.data, "finishDelay", null),
          },
          charPointer: 0,
          linePointer: 0,
        })
        .setTimeout(event.data.timeout)
        .whenUpdate(function() { 
          var state = this.state
          if (state.linePointer == state.lyrics.lines.size()) {
            if (Optional.is(state.lyrics.finishDelay)) {
              if (state.lyrics.finishDelay.update().finished) {
                this.fullfill()
              }
            } else {
              this.fullfill()
            }
            return
          }

          if (Optional.is(state.lyrics.lineDelay) 
            && state.linePointer != 0
            && !state.lyrics.lineDelay.finished) {
            state.lyrics.lineDelay.update()
            if (!state.lyrics.lineDelay.finished) {
              return
            }
          }

          var line = state.lyrics.lines.get(state.linePointer)
          state.charPointer = state.charPointer + DeltaTime.apply(this.state.lyrics.charSpeed)
          if (state.charPointer >= String.size(line)) {
            state.charPointer = 0
            state.linePointer = state.linePointer + 1
            if (Optional.is(state.lyrics.lineDelay)) {
              state.lyrics.lineDelay.reset()
            }
            return
          }
        })
      
      this.executor.add(task)
    },
    "clear-lyrics": function(event) {
      this.templates.clear()
    },
  }))

  ///@type {TaskExecutor}
  executor = new TaskExecutor(this)
  
  ///@param {Event} event
  ///@return {?Promise}
  send = function(event) {
    return this.dispatcher.send(event)
  }

  ///@override
  ///@return {LyricsService}
  update = function() {
    this.dispatcher.update()
    this.executor.update()
    return this
  }
}
