///@package io.alkapivo.visu.editor.ui

global.__todo_bpm = 120

///@param {VisuEditor} _editor
function VETimeline(_editor) constructor {

  ///@type {VisuEditor}
  editor = Assert.isType(_editor, VisuEditor)
  
  ///@type {UIService}
  uiService = Assert.isType(this.editor.uiService, UIService)
  
  ///@type {Map<String, Containers>}
  containers = new Map(String, UI)

  ///@private
  ///@param {Struct} context
  ///@return {ChunkService}
  factoryChunkService = function() {
    return new ChunkService(this, {
      step: 10,
      fetchKey: function(timestamp) {
        var from = timestamp div this.step * this.step
        var to = from + this.step
        var key = $"{from}-{to}"
        return key
      },
      factoryChunk: function(key) {
        return new Chunk(this, {
          key: key,
          type: UIItem,
          data:  new Map(String, UIItem),
          add: function(item) {
            this.data.add(item, item.name)
            return this
          },
          get: function(name) {
            return this.data.get(name)
          },
          size: function() {
            return this.data.size()
          },
          contains: function(name) {
            return this.data.contains(name)
          },
          remove: function(name) {
            this.data.remove(name)
            return this
          },
          forEach: function(callback, acc = null) {
            this.data.forEach(callback, acc)
            return this
          },
          filter: function(callback, acc = null) {
            return this.data.filter(callback, acc)
          },
          find: function(callback, acc = null) {
            return this.data.find(callback, acc)
          },
        })
      },
      activeChunks: new Collection({
        chunks: new Map(String, Chunk),
        size: function() {
          var acc = {
            size: 0,
          }

          this.chunks.forEach(function(chunk, key, acc) {
            acc.size += chunk.size()
          }, acc)

          return acc.size
        },
        find: function(callback, acc) {
          var keys = this.chunks.keys()
          var size = this.chunks.size()
          for (var index = 0; index < size; index++) {
            var item = this.chunks.get(keys.get(index)).find(callback, acc)
            if (Core.isType(item, UIItem)) {
              return item
            }
          }
        }, 
        generateKey: function(timestamp) {
          var key = this.service.fetchKey(timestamp)
          return this.service.fetch(key).data.generateKey()
        },
        get: function(name) {
          var chunks = this.service.chunks
          var keys = chunks.keys()
          var size = chunks.size()
          for (var index = 0; index < size; index++) {
            var chunk = chunks.get(keys.get(index))
            if (!chunk.contains(name)) {
              continue
            }
            return chunk.get(name)
          }
        },
        add: function(item, name) {
          var timestamp = item.state.get("timestamp")
          var key = this.service.fetchKey(timestamp)
          this.service.fetch(key).add(item, name)
        },
        remove: function(name) {
          var chunks = this.service.chunks
          var chunk = null
          var keys = chunks.keys()
          var size = chunks.size()
          for (var index = 0; index < size; index++) {
            var _chunk = chunks.get(keys.get(index))
            if (!_chunk.contains(name)) {
              continue
            }
            chunk = _chunk
            break
          }

          if (!Core.isType(chunk, Chunk)) {
            return
          }
          chunk.remove(name)
        },
        forEach: function(callback, acc) {
          var keys = this.chunks.keys()
          var size = this.chunks.size()
          for (var index = 0; index < size; index++) {
            this.chunks.get(keys.get(index)).forEach(callback, acc)
          }
        },
      }),
      update: function(timestamp) {
        var step = this.step
        var keyPast = this.fetchKey(clamp(timestamp - step, 0, timestamp))
        var keyPresent = this.fetchKey(timestamp)
        var keyFuture = this.fetchKey(timestamp + step)
        if (!this.activeChunks.chunks.contains(keyPast)
          || !this.activeChunks.chunks.contains(keyPresent)
          || !this.activeChunks.chunks.contains(keyFuture)) {
          
          Logger.debug("TrackEditor::ChunkService", $"New keys: keyPast: {keyPast}, keyPresent: {keyPresent}, keyFuture: {keyFuture}")
          this.activeChunks.chunks.clear()
            .set(keyPast, this.fetch(keyPast))
            .set(keyPresent, this.fetch(keyPresent))
            .set(keyFuture, this.fetch(keyFuture))
        }
        return this
      },
    })
  }
  
  ///@private
  ///@param {UIlayout} parent
  ///@return {UILayout}
  factoryLayout = function(parent) {
    return new UILayout(
      {
        name: "timeline",
        nodes: {
          background: {},
          form: {
            name: "timeline.form",
            minWidth: 200,
            maxWidth: 320,
            percentageWidth: 0.2,
            width: function() { return clamp(
              max(this.percentageWidth * this.context.context.context.width(), 
              this.minWidth), this.minWidth, this.maxWidth) },
            height: function() { return 32 },
            x: function() { return 0 },
            
          },
          ruler: {
            name: "timeline.ruler",
            width: function() { return this.context.width() 
              - this.context.nodes.form.width() },
            height: function() { return this.context.nodes.form.height() },
            x: function() { return this.context.nodes.form.width() },
          },
          channels: {
            name: "timeline.channels",
            margin: { left: 10, right: 0 },
            width: function() { return this.context.nodes.form.width() 
              - this.margin.left - this.margin.right },
            height: function() { return this.context.height() 
              - this.context.nodes.form.height() },
            x: function() { return this.context.x() + this.margin.left },
            y: function() { return this.context.nodes.ruler.bottom() },
          },
          events: {
            name: "timeline.events",
            width: function() { return this.context.width() 
              - this.context.nodes.channels.width()
              - this.context.nodes.channels.margin.left
              - this.context.nodes.channels.margin.right },
            height: function() { return this.context.height() 
              - this.context.nodes.ruler.height() },
            x: function() { return this.context.nodes.channels.right() },
            y: function() { return this.context.nodes.ruler.bottom() },
          }
        }
      }, 
      parent
    )
  }

  ///@private
  ///@param {UIlayout} parent
  ///@return {Map<String, UI>}
  factoryContainers = function(parent) {
    var controller = this
    var layout = this.factoryLayout(parent)
    return new Map(String, UI, {
      "_ve-timeline-background": new UI({
        name: "_ve-timeline-background",
        state: new Map(String, any, {
          "background-alpha": 1.0,
          "background-color": ColorUtil.fromHex(VETheme.color.dark).toGMColor(),

        }),
        timer: new Timer(FRAME_MS * 4, { loop: Infinity, randomize: true }),
        layout: layout.nodes.background,
        updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
        render: Callable.run(UIUtil.renderTemplates.get("renderDefault")),
      }),
      "ve-timeline-form": new UI({
        name: "ve-timeline-form",
        state: new Map(String, any, {
          "background-color": ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
          "store": controller.editor.store,
        }),
        timer: new Timer(FRAME_MS * 4, { loop: Infinity, randomize: true }),
        controller: controller,
        layout: layout.nodes.form,
        timeline: controller,
        updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
        render: Callable.run(UIUtil.renderTemplates.get("renderDefault")),
        onInit: function() {
          this.addUIComponents(
            new Array(Struct, [
              new UIComponent({
                name: "ve-timeline-form",  
                template: VEComponents.get("text-field-button"),
                layout: VELayouts.get("text-field-button"),
                config: { 
                  layout: { type: UILayoutType.VERTICAL },
                  label: { text: "Name" },
                  field: { store: { key: "new-channel-name" } },
                  button: { 
                    label: { text: "Add" },
                    callback: function() {
                      this.context.controller.containers
                        .get("ve-timeline-channels")
                        .addChannel(this.context.state
                          .get("store")
                          .getValue("new-channel-name"))
                    }},
                },
              }),
            ]),
            new UILayout({
              area: this.area,
              width: function() { return this.area.getWidth() },
            })
          )
        }
      }),
      "ve-timeline-channels": new UI({
        name: "ve-timeline-channels",
        state: new Map(String, any, {
          "background-color": ColorUtil.fromHex(VETheme.color.dark).toGMColor(),
          "store": controller.editor.store,
        }),
        //timer: new Timer(FRAME_MS * 2, { loop: Infinity, randomize: true }),
        controller: controller,
        layout: layout.nodes.channels,
        updateArea: Callable.run(UIUtil.updateAreaTemplates.get("scrollableY")),
        render: Callable.run(UIUtil.renderTemplates.get("renderDefaultScrollable")),
        _onMouseWheelUp: new BindIntent(Callable.run(UIUtil.mouseEventTemplates.get("scrollableOnMouseWheelUpY"))),
        _onMouseWheelDown: new BindIntent(Callable.run(UIUtil.mouseEventTemplates.get("scrollableOnMouseWheelDownY"))),
        onMouseWheelUp: function(event) {
          this._onMouseWheelUp(event)
          this.controller.containers.get("ve-timeline-events").offset.y = this.offset.y
        },
        onMouseWheelDown: function(event) {
          this._onMouseWheelDown(event)
          this.controller.containers.get("ve-timeline-events").offset.y = this.offset.y
        },
        onInit: function() {
          this.collection = new UICollection(this, { layout: this.layout })
          var sorted = new Map(Number, String)
          var context = this
          this.controller.editor.trackService.track.channels
            .forEach(function(channel, name, sorted) {
              sorted.set(channel.index, name)
            }, sorted)

          IntStream.forEach(0, sorted.size(), function(item, index, acc) {
            acc.context.addChannel(acc.sorted.get(item))
          }, { sorted: sorted, context: context })
        },

        ///@param {String} name
        addChannel: new BindIntent(function(name) {
          Assert.isType(this.controller.editor.trackService.track
            .addChannel(name).channels.get(name), TrackChannel)
          this.collection.add(new UIComponent({
            name: name,
            template: VEComponents.get("channel-entry"),
            layout: VELayouts.get("channel-entry"),
            config: {
              label: { text: name },
              button: { 
                sprite: {
                  name: "texture_ve_icon_trash",
                  blend: VETheme.color.textShadow,
                },
                removeUIItemfromUICollection: new BindIntent(Callable.run(
                  UIUtil.templates.get("removeUIItemfromUICollection"))
                ),
                callback: function() {
                  this.context.removeChannel(this.component.name)
                  this.removeUIItemfromUICollection()
                },
              },
            },
          }))
        }),

        ///@param {String} name
        removeChannel: new BindIntent(function(name) {
          // remove event and channel from ui and trackservice
          var eventsContainer = this.controller.containers
            .get("ve-timeline-events")
          eventsContainer.state.get("chunkService")
            .filter(function(item, key, channel) {
              return item.state.get("channel") == channel
            }, name)
            .forEach(function(item, key, container) {
              container.removeEvent(item.state.get("channel"), key)
            }, eventsContainer)

          this.controller.editor.trackService.track
            .removeChannel(name)
        }),
      }),
      "ve-timeline-events": new UI({
        name: "ve-timeline-events",
        state: new Map(String, any, {
          "background-color": ColorUtil.fromHex(VETheme.color.dark).toGMColor(),
          "store": controller.editor.store,
          "chunkService": controller.factoryChunkService(),
          "viewSize": 10,
          "speed": 2.0,
          "position": 0,
          "amount": 0,
          "time": null,
          "lines-alpha": 1.0,
          "lines-thickness": 0.2,
          "lines-color": ColorUtil.fromHex(VETheme.color.accent).toGMColor(),
          "initialized": false
        }),
        //timer: new Timer(FRAME_MS * 2, { loop: Infinity, randomize: true }),
        controller: controller,
        layout: layout.nodes.events,
        updateArea: Callable.run(UIUtil.updateAreaTemplates.get("scrollableY")),
        updateCustom: function() {

          var track = this.controller.editor.trackService.track
          if (Core.isType(track, Track)) {
            this.state.set("amount", track.channels.size())
          }

          ///@todo refactor
          var time = this.state.get("time") == null 
            ? this.controller.editor.trackService.time
            : this.state.get("time")
          this.state.set("time", null)
          var chunkService = this.state.get("chunkService")
          this.items = chunkService.update(time).activeChunks

          ///@todo refactor
          var spd = this.area.getWidth() / this.state.get("viewSize")
          var position = spd * time
          if (this.state.get("speed") != spd) {
            chunkService.forEach(function(item, key, container) {
              var timestamp = item.state.get("timestamp")
              var xx = container.getXFromTimestamp(timestamp)
              item.area.setX(xx)
            }, this)
          }
          this.state.set("speed", spd)
          this.state.set("position", position)

          ///@todo refactor
          var ruler = this.controller.containers.get("ve-timeline-ruler")
          if (Core.isType(ruler, UI)) {
            this.offset.x = -1 * ruler.state.get("camera")
          }

          ///@todo refactor
          if (this.state.get("initialized") == false) {
            this.state.set("initialized", true)
            this.controller.editor.trackService.track.channels
              .forEach(function(channel, name, container) {
                channel.events.forEach(function(event, index, acc) {
                  ///@description do not use addEvent as TrackEvent already exists
                  var uiItem = acc.container.factoryEventUIItem(acc.channel.name, event)
                  acc.container.add(uiItem, uiItem.name)
                }, { channel: channel, container: container })
              }, this)
          }
        },
        fetchViewHeight: function() {
          return 32 * this.state.get("amount")
        },
        lastIndex: 0,
        renderClipboard: new BindIntent(function() {
          var trackEvent = MouseUtil.getClipboard()
          if (!Core.isType(trackEvent, TrackEvent)) {
            return
          }
          
          var index = this.getChannelIndexFromMouseY(MouseUtil.getMouseY())
          if (!Optional.is(index)) {
            index = this.lastIndex
          }
          this.lastIndex = index

          var icon = Struct.get(trackEvent.data, "icon")
          if (!Core.isType(icon, Struct)) {
            return
          }

          var timestamp = this.getTimestampFromMouseX(MouseUtil.getMouseX())
          if (keyboard_check(vk_control)) {
            var bpm = global.__todo_bpm
            timestamp = floor(timestamp / (60 / bpm)) * (60 / bpm)
          }

          var previousX = this.getXFromTimestamp(trackEvent.timestamp)
          var nextX = this.getXFromTimestamp(timestamp)
          var eventY = index * 32
          var line = new TexturedLine({ 
            thickness: 2.0,
            alpha: 0.5,
            blend: timestamp - trackEvent.timestamp > 0 ? "#00FF00" : "#FF0000",
          })
          
          var label = new UILabel({
            text: $"{(timestamp - trackEvent.timestamp > 0 ? "+" : "-")} {String.formatTimestampMilisecond(abs(timestamp - trackEvent.timestamp))}",
            font: "font_inter_10_regular",
            color: VETheme.color.textFocus,
            align: { v: VAlign.CENTER, h: HAlign.CENTER },
            outline: true,
            outlineColor: "#000000"
          })

          //render previous
          SpriteUtil.parse(icon)
            .setAlpha(0.3)
            .scaleToFillStretched(32, 32)
            .render(
              this.offset.x + previousX,
              this.offset.y + eventY
            )

          //render line
          line.render(
            this.offset.x + previousX + 16,
            this.offset.y + eventY + 16,
            this.offset.x + nextX + 16,
            this.offset.y + eventY + 16 
          )

          //render next
          SpriteUtil.parse(icon)
            .setAlpha(0.8)
            .scaleToFillStretched(32, 32)
            .render(
              this.offset.x + nextX,
              this.offset.y + eventY
            )

          //render timestamp
          label.render(
            16 + this.offset.x + min(previousX, nextX) + (abs(previousX - nextX) / 2),
            16 + this.offset.y + eventY
          )
        }),
        selectedSprite: SpriteUtil.parse({ name: "texture_selected_event" }),
        renderSurface: function() {
          // background
          var color = this.state.get("background-color")
          GPU.render.clear(Core.isType(color, GMColor) 
            ? ColorUtil.fromGMColor(color) 
            : ColorUtil.BLACK_TRANSPARENT)
          
          // items
          var areaX = this.area.x
          var areaY = this.area.y
          this.area.x = this.offset.x
          this.area.y = this.offset.y
          this.items.forEach(this.renderItem)
          this.area.x = areaX
          this.area.y = areaY

          // lines
          ///@todo low performance
          IntStream.forEach(0, this.state.get("amount") + 1, function(item, index, context) {
            var thickness = context.state.get("lines-thickness")
            var alpha = context.state.get("lines-alpha")
            var color = context.state.get("lines-color")

            var beginX = 0
            var beginY = (context.offset.y mod 32) + (index * 32)
            var endX = context.area.getWidth()
            var endY = beginY
            GPU.render.texturedLine(
              beginX, beginY, 
              endX, endY, 
              thickness, 
              alpha,
              color
            )
          }, this)

          ///@todo low performance
          var bpm = global.__todo_bpm
          var bpmWidth = ((this.area.getWidth() / this.state.get("viewSize")) * 60) / bpm
          var bpmSize = ceil(this.area.getWidth() / bpmWidth)
          IntStream.forEach(0, bpmSize, function(iterator, index, context) {
            var thickness = context.state.get("lines-thickness")
            var alpha = context.state.get("lines-alpha")
            var color = context.state.get("lines-color")

            var bpm = global.__todo_bpm
            var bpmWidth = ((context.area.getWidth() / context.state.get("viewSize")) * 60) / bpm
            var bpmSize = ceil(context.area.getWidth() / bpmWidth)
            
            var beginX = (iterator * bpmWidth) + abs(context.offset.x) mod bpmWidth
            var beginY = 0
            var endX = beginX
            var endY = clamp(context.state.get("amount") * 32, 0, context.area.getHeight())
            GPU.render.texturedLine(
              round(beginX), round(beginY), 
              round(endX), round(endY), 
              thickness, 
              alpha,
              color
            )
          }, this)

          this.renderClipboard()

          var selectedItem = this.controller.editor.store.getValue("selected-event")
          if (Optional.is(selectedItem)) {
            var xx = this.getXFromTimestamp(selectedItem.data.timestamp) + this.offset.x
            var yy = this.getYFromChannelName(selectedItem.channel) + this.offset.y
            this.selectedSprite.render(xx, yy)
          }
        },
        render: Callable.run(UIUtil.renderTemplates.get("renderDefaultScrollable")),
        onInit: function() {
          this.scrollbarY = null
        },
        _onMouseWheelUp: new BindIntent(Callable.run(UIUtil.mouseEventTemplates.get("scrollableOnMouseWheelUpY"))),
        _onMouseWheelDown: new BindIntent(Callable.run(UIUtil.mouseEventTemplates.get("scrollableOnMouseWheelDownY"))),
        onMouseWheelUp: function(event) {
          this._onMouseWheelUp(event)
          this.controller.containers.get("ve-timeline-channels").offset.y = this.offset.y
        },
        onMouseWheelDown: function(event) {
          this._onMouseWheelDown(event)
          this.controller.containers.get("ve-timeline-channels").offset.y = this.offset.y
        },
        onMouseDropLeft: function(event) {
          var trackEvent = MouseUtil.getClipboard()
          MouseUtil.clearClipboard()
          if (!Core.isType(trackEvent, TrackEvent)) {
            return
          }

          var channel = this.getChannelNameFromMouseY(event.data.y)
          if (!keyboard_check(vk_shift)) {
            this.removeEvent(channel, trackEvent.eventName)
          }

          trackEvent = trackEvent.serialize()
          trackEvent.timestamp = this.getTimestampFromMouseX(event.data.x)
          if (keyboard_check(vk_control)) {
            var bpm = global.__todo_bpm
            trackEvent.timestamp = floor(trackEvent.timestamp / (60 / bpm)) * (60 / bpm)
          }

          channel = this.getChannelNameFromMouseY(event.data.y)
          if (!Optional.is(channel)) {
            var size = this.controller.containers
              .get("ve-timeline-channels").collection
              .size()

            channel = this.controller.containers
              .get("ve-timeline-channels").collection
              .findKeyByIndex(size - 1)
            if (!Optional.is(channel)) {
              return
            }
          }

          var uiItem = this.addEvent(channel, new TrackEvent(trackEvent))

          ///@description select
          Beans.get(BeanVisuController).editor.store
            .get("selected-event")
            .set({
              name: uiItem.name,
              channel: channel,
              data: trackEvent,
            })
        },
        onMouseReleasedLeft: function(event) {
          try {

            ///@description deselect
            var store = this.controller.editor.store
            if (Optional.is(store.getValue("selected-event"))) {
              store.get("selected-event").set(null)
            }

            var trackEvent = this.factoryTrackEventFromEvent(event)
            var channel = this.getChannelNameFromMouseY(event.data.y)
            var uiItem = this.addEvent(channel, trackEvent)

            ///@description select
            Beans.get(BeanVisuController).editor.store
              .get("selected-event")
              .set({
                name: uiItem.name,
                channel: channel,
                data: trackEvent,
              })
          } catch (exception) {
            Logger.error("VETimeline", $"onMouseReleasedLeft exception: {exception.message}")
          }
        },
    
        ///@param {Number} timestamp
        ///@return {Number}
        getXFromTimestamp: new BindIntent(function(timestamp) {
          return (this.area.getWidth() / this.state.get("viewSize")) * timestamp
        }),

        ///@param {String} channel
        ///@return {Number}
        getYFromChannelName: new BindIntent(function(channel) {
          return this.controller.containers
            .get("ve-timeline-channels").collection
            .get(channel).index * 32 
        }),

        ///@param {Number} mouseX
        ///@return {Number}
        getTimestampFromMouseX: new BindIntent(function(mouseX) {
          return (mouseX - this.area.getX() - this.offset.x) 
            / (this.area.getWidth() / this.state.get("viewSize"))
        }),

        ///@param {Number} mouseY
        ///@return {?String}
        getChannelNameFromMouseY: new BindIntent(function(mouseY) {
          var channelName = this.controller.containers
            .get("ve-timeline-channels").collection
            .findKeyByIndex((mouseY - this.area.getY() - this.offset.y) div 32)
          return Optional.is(channelName) ? channelName : null
        }),

        ///@param {Number} mouseY
        ///@return {Number}
        getChannelIndexFromMouseY: new BindIntent(function(mouseY) {
          var channel = this.controller.containers
            .get("ve-timeline-channels").collection
            .findByIndex((mouseY - this.area.getY() - this.offset.y) div 32)
          return Optional.is(channel) ? channel.index : null
        }),

        ///@param {Number} timestamp
        ///@param {VEBrushTemplate} template
        ///@return {TrackEvent}
        factoryTrackEventFromBrushTemplate: new BindIntent(function(timestamp, template) {
          return new TrackEvent({
            "timestamp": timestamp,
            "callable": template.type,
            "data": Struct.appendUnique(
              {
                "icon": {
                  name: template.texture,
                  blend: template.color,
                },
              }, 
              template.properties
            ),
          })
        }),

        ///@param {Event} event
        ///@return {TrackEvent}
        factoryTrackEventFromEvent: new BindIntent(function(event) {
          var timestamp = this.getTimestampFromMouseX(event.data.x)
          if (keyboard_check(vk_control)) {
            var bpm = global.__todo_bpm
            timestamp = floor(timestamp / (60 / bpm)) * (60 / bpm)
          }
          
          return this.factoryTrackEventFromBrushTemplate(
            timestamp,
            this.controller.editor.brushToolbar.store
              .getValue("brush")
              .toTemplate())
        }),

        ///@param {String} channelName
        ///@param {TrackEvent} event
        ///@return {UIItem}
        factoryEventUIItem: new BindIntent(function(channelName, event) { 
          var _x = this.getXFromTimestamp(event.timestamp) 
          var key = this.items.generateKey(event.timestamp * (1 + random(100000)))
          var name = $"channel_{channelName}_event_{key}"
          var component = this.controller.containers
            .get("ve-timeline-channels").collection
            .get(channelName)

          return UIButton(
            name,
            {
              area: { x: _x, width: 32, height: 32 },
              state: new Map(String, any, {
                "timestamp": event.timestamp,
                "event": event,
                "channel": channelName,
              }),
              component: component,
              sprite: event.data.icon,
              updateArea: function() {
                this.area.setY(this.component.index * this.area.getHeight())
              },
              onMouseDragLeft: function(event) {
                var channelName = this.context.getChannelNameFromMouseY(event.data.y)
                if (!Optional.is(channelName)) {
                  return
                }
                
                var trackEvent = this.state.get("event")
                if (!Core.isType(trackEvent, TrackEvent)) {
                  return
                }
                Struct.set(trackEvent, "eventName", this.name)
                MouseUtil.setClipboard(trackEvent)
              },
              onMouseReleasedLeft: function(event) {
                var context = this
                var trackEvent = this.state.get("event")
                var channel = this.state.get("channel")
                if (!Core.isType(trackEvent, TrackEvent)
                  || !Core.isType(channel, String)) {
                  return
                }
                
                Beans.get(BeanVisuController).editor.store
                  .get("selected-event")
                  .set({
                    name: context.name,
                    channel: channel,
                    data: trackEvent,
                  })
              },
              onMousePressedRight: function(event) {
                var channelName = this.context.getChannelNameFromMouseY(event.data.y)
                if (!Optional.is(channelName)) {
                  return
                }
                this.context.removeEvent(channelName, this.name)

                Beans.get(BeanVisuController).editor.store
                  .get("selected-event")
                  .set(null)
              },
            }
          )
        }),

        ///@param {String} channelName
        ///@param {TrackEvent} event
        ///@return {?UIItem}
        addEvent: new BindIntent(function(channelName, event) {
          if (!Core.isType(event, TrackEvent)) {
            return null
          }

          var track = this.controller.editor.trackService.track
          var uiItem = this.factoryEventUIItem(channelName, event)
          track.addEvent(channelName, event)
          this.add(uiItem, uiItem.name)
          return uiItem
        }),

        ///@param {String} channel
        ///@param {String} name
        removeEvent: new BindIntent(function(channelName, name) {
          var editor = this.controller.editor
          var uiItem = this.items.get(name)
          var event = uiItem.state.get("event")
          if (!Core.isType(uiItem, UIItem)
            || !Core.isType(event, TrackEvent)) {
            return
          }
          editor.trackService.track.removeEvent(channelName, event)
          this.remove(uiItem.name)
          
          ///@description deselect
          var selectedEvent = editor.store.getValue("selected-event")
          if (Core.isType(selectedEvent, Struct)
            && name == selectedEvent.name) {
            editor.store.get("selected-event").set(null)
          }
        }),

        ///@param {String} channel
        ///@param {TrackEvent} event
        ///@param {String} name
        ///@return {?UIItem}
        updateEvent: new BindIntent(function(channelName, event, name) {
          //var chunkService = this.state.get("chunkService")   
          var uiItem = this.items.get(name)
          this.remove(name)
          
          uiItem = this.factoryEventUIItem(channelName, event)
          this.add(uiItem, uiItem.name)
          if (Optional.is(uiItem.updateArea)) {
            uiItem.updateArea()
          }
          return uiItem
        }), 
      }),
      "ve-timeline-ruler": new UI({
        name: "ve-timeline-ruler",
        state: new Map(String, any, {
          "background-color": ColorUtil.fromHex(VETheme.color.dark).toGMColor(),
          "store": controller.editor.store,
          "viewSize": 10,
          "stepSize": 2,
          "speed": 2.0,
          "position": 0,
          "camera": 0,
          "time": null,
          "mouseX": null,
          "mouseXSensitivity": 30,
        }),
        //timer: new Timer(FRAME_MS * 2, { loop: Infinity, randomize: true }),
        controller: controller,
        layout: layout.nodes.ruler,
        updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
        updateCustom: function() {
          var trackService = this.controller.editor.trackService
          var width = this.area.getWidth()
          var viewSize = this.state.get("viewSize")
          var spd = width / viewSize
          var time = this.state.get("time")
          var mouseX = this.state.get("mouseX")
          var duration = trackService.duration
          if (mouseX != null) {
            var _time = (MouseUtil.getMouseX() - mouseX) / this.state.get("mouseXSensitivity")
            time = time == null
              ? clamp(trackService.time - _time, 0, duration)
              : clamp(time - _time, 0, duration)
            this.state.set("mouseXTime", time)
          }
          
          var position = time == null ? spd * trackService.time : spd * time
          var camera = this.state.get("camera")
          var maxWidth = spd * duration
          if (position > camera + width) || (position < camera) {
            camera = clamp(position - width / 2, 0, maxWidth - width)
          }
          this.state.set("camera", camera)
          this.state.set("position", position)
          this.state.set("speed", spd)
          this.state.set("time", null)
          this.offset.x = -1 * camera
        },
        renderSurface: function() {
          var bkgColor = this.state.get("background-color")
          GPU.render.clear(Core.isType(bkgColor, GMColor) 
            ? ColorUtil.fromGMColor(bkgColor) 
            : ColorUtil.BLACK_TRANSPARENT)

          var _x = this.area.x
          var _y = this.area.y
          var width = this.area.getWidth()
          var viewSize = this.state.get("viewSize")
          var stepSize = this.state.get("stepSize")
          var spd = this.state.get("speed")
          var position = this.state.get("position")
          var camera = this.state.get("camera")
          var timestamp = camera div spd
          var beginX = (timestamp * spd) - camera
          var beginY = 0
          var color = ColorUtil.fromHex(VETheme.color.accent).toGMColor()
          var textColor = ColorUtil.fromHex(VETheme.color.textFocus).toGMColor()
          var height = this.area.getHeight()
          draw_set_font(font_inter_10_regular)
          draw_set_halign(HAlign.LEFT)
          draw_set_valign(VAlign.TOP)
          for (var index = 0; index < viewSize; index++) {
            var label = String.formatTimestamp(timestamp + (index * stepSize))
            draw_line_color(
              beginX + (spd * index * stepSize),
              beginY,
              beginX + (spd * index * stepSize),
              beginY + height,
              color, color
            )

            draw_line_color(
              beginX + (spd * (index + (stepSize / 2.0))),
              beginY,
              beginX + (spd * (index + (stepSize / 2.0))),
              beginY + (height / 2),
              color, color
            )
            
            draw_text_color(
              beginX + (spd * index * stepSize) + 4, 
              beginY + 2, 
              label, 
              textColor, textColor, textColor, textColor, 
              1.0
            )
          }
        },
        renderDefaultScrollable: new BindIntent(Callable.run(UIUtil.renderTemplates
          .get("renderDefaultScrollable"))),
        render: function() {
          this.renderDefaultScrollable()
          var position = this.state.get("position")
          var camera = this.state.get("camera")
          var _x = this.area.getX() + (position - camera)
          var _y = this.area.getY()
          draw_sprite_ext(texture_button, 0, _x, _y, 0.01, 5.0, 0.0, c_red, 1.0)
        },
        onMouseDragLeft: function(event) {
          var context = this
          this.state.set("mouseX", event.data.x)
          MouseUtil.setClipboard(new Promise()
            .setState({
              context: context,
              callback: context.releaseMouseX,
            })
            .whenSuccess(function() {
              Callable.run(Struct.get(this.state, "callback"))
            })
          )
        },
        releaseMouseX: new BindIntent(function() {
          var timestamp = this.state.get("mouseXTime")
          this.state.set("mouseX", null)
          this.state.set("mouseXTime", null)
          return this.controller.editor.controller.send(new Event("rewind", { 
            timestamp: timestamp,
          }))
        }),
      }),
    })
  }

  ///@type {EventPump}
  dispatcher = new EventPump(this, new Map(String, Callable, {
    "open": function(event) {
      var context = this
      this.containers = this.factoryContainers(event.data.layout)
      IntStream.forEach(0, this.containers.size(), function(iterator, index, acc) {
        acc.uiService.send(new Event("add", {
          container: acc.containers.get(acc.keys[iterator]),
          replace: true,
        }))
      }, {
        keys: GMArray.sort(context.containers.keys().getContainer()),
        containers: context.containers,
        uiService: context.uiService,
      })
    },
    "close": function(event) {
      var context = this
      this.containers.forEach(function (container, key, uiService) {
        uiService.send(new Event("remove", { 
          name: key, 
          quiet: true,
        }))
      }, this.uiService).clear()
    },
  }))

  ///@param {Event} event
  ///@return {?Promise}
  send = function(event) {
    return this.dispatcher.send(event)
  }

  ///@return {VETimeline}
  update = function() { 
    this.dispatcher.update()
    return this
  }
}
