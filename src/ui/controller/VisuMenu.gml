///@package io.alkapivo.visu.ui


///@param {String} name
///@param {String} text
///@return {Struct}
function factoryPlayerKeyboardKeyEntryConfig(name, text) {
  return {
    layout: { type: UILayoutType.VERTICAL },
    label: { 
      key: name,
      text: text,
      updateCustom: function() {
        var lastKey = keyboard_lastkey
        if (lastKey == vk_nokey || this.context.state.get("remapKey") != this.key) {          
          return
        }

        this.context.state.set("remapKey", null)
        keyboard_lastkey = vk_nokey
        if (lastKey == KeyboardKeyType.ESC || lastKey == KeyboardKeyType.ENTER) {
          return
        }
        Core.print("set key", this.key)

        var keyboard = Beans.get(BeanVisuIO).keyboards.get("player")
        keyboard.setKey(this.key, lastKey)

        Visu.settings.setValue("visu.keyboard.player.up", Struct.get(keyboard.keys, "up").gmKey)
        Visu.settings.setValue("visu.keyboard.player.down", Struct.get(keyboard.keys, "down").gmKey)
        Visu.settings.setValue("visu.keyboard.player.left", Struct.get(keyboard.keys, "left").gmKey)
        Visu.settings.setValue("visu.keyboard.player.right", Struct.get(keyboard.keys, "right").gmKey)
        Visu.settings.setValue("visu.keyboard.player.action", Struct.get(keyboard.keys, "action").gmKey)
        Visu.settings.setValue("visu.keyboard.player.bomb", Struct.get(keyboard.keys, "bomb").gmKey)
        Visu.settings.setValue("visu.keyboard.player.focus", Struct.get(keyboard.keys, "focus").gmKey)
        Visu.settings.save()
      },
      callback: new BindIntent(function() {
        if (this.context.state.get("remapKey") == this.key) {
          return
        }

        Core.print("set remapKey", this.key)
        this.context.state.set("remapKey", this.key)
        keyboard_lastkey = vk_nokey
      }),
      onMouseReleasedLeft: function() {
        Core.print("serio?")
        this.callback()
      },
    },
    preview: {
      key: name,
      text: "",
      updateCustom: function() {
        var keyCode = Struct.get(Beans.get(BeanVisuIO).keyboards.get("player").keys, this.key).gmKey
        if (KeyboardKeyType.contains(keyCode)) {
          this.label.text = KeyboardKeyType.findKey(keyCode)
        } else {
          this.label.text = chr(keyCode)
        }
        
        if (this.context.state.get("remapKey") == this.key) {
          this.label.alpha = (random(100) / 100) * 0.7
        } else {
          this.label.alpha = 1.0
        }
      },
      callback: new BindIntent(function() {
        if (this.context.state.get("remapKey") == this.key) {
          return
        }

        Core.print("set preview remapKey", this.key)
        this.context.state.set("remapKey", this.key)
        keyboard_lastkey = vk_nokey
      }),
      onMouseReleasedLeft: function() {
        Core.print("serio?2")
        this.callback()
      },
    },
  }
}


///@param {?Struct} [_config]
function VisuMenu(_config = null) constructor {

  ///@type {?Struct}
  config = Optional.is(_config) ? Assert.isType(_config, Struct) : null

  ///@type {Map<String, Containers>}
  containers = new Map(String, UI)

  ///@type {?Callable}
  back = null

  ///@type {?String}
  remapKey = null

  ///@param {?Struct} [_config]
  ///@return {Event}
  factoryOpenMainMenuEvent = function(_config = null) {
    var config = Struct.appendUnique(
      _config,
      {
        back: this.factoryOpenMainMenuEvent, 
      }
    )

    var event = new Event("open").setData({
      back: null,
      layout: Beans.get(BeanVisuController).visuRenderer.layout,
      title: {
        name: "main-menu_title",
        template: VisuComponents.get("menu-title"),
        layout: VisuLayouts.get("menu-title"),
        config: {
          label: { 
            text: "visu-project",
          },
        },
      },
      content: new Array(Struct, [
        {
          name: "main-menu_menu-button-entry_play",
          template: VisuComponents.get("menu-button-entry"),
          layout: VisuLayouts.get("menu-button-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Select track",
              callback: new BindIntent(function() {
                var menu = Beans.get(BeanVisuController).menu
                menu.send(menu.factoryOpenSelectTrackMenuEvent(this.callbackData))
              }),
              callbackData: config,
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
          }
        },
        {
          name: "main-menu_menu-button-entry_settings",
          template: VisuComponents.get("menu-button-entry"),
          layout: VisuLayouts.get("menu-button-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Settings",
              callback: new BindIntent(function() {
                var menu = Beans.get(BeanVisuController).menu
                menu.send(menu.factoryOpenSettingsMenuEvent(this.callbackData))
              }),
              callbackData: config,
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
          }
        }
      ])
    })

    if (Beans.get(BeanVisuController).trackService.isTrackLoaded()) {
      event.data.content.add({
        name: "main-menu_menu-button-entry_resume",
        template: VisuComponents.get("menu-button-entry"),
        layout: VisuLayouts.get("menu-button-entry"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Resume",
            callback: new BindIntent(function() {
              Beans.get(BeanVisuController).fsm.dispatcher.send(new Event("transition", { name: "play" }))
            }),
            callbackData: config,
            onMouseReleasedLeft: function() {
              this.callback()
            },
          },
        }
      }, 0)
    }

    if (Core.getRuntimeType() != RuntimeType.GXGAMES) {
      event.data.content.add({
        name: "main-menu_menu-button-entry_quit",
        template: VisuComponents.get("menu-button-entry"),
        layout: VisuLayouts.get("menu-button-entry"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Quit",
            callback: new BindIntent(function() {
              game_end()
            }),
            callbackData: config,
            onMouseReleasedLeft: function() {
              this.callback()
            },
          },
        }
      })
    }

    return event
  }

  ///@param {?Struct} [_config]
  ///@return {Event}
  factoryOpenSelectTrackMenuEvent = function(_config = null) {
    var config = Struct.appendUnique(
      _config,
      {
        back: this.factoryOpenMainMenuEvent, 
      }
    )

    var event = new Event("open").setData({
      back: config.back,
      layout: Beans.get(BeanVisuController).visuRenderer.layout,
      title: {
        name: "select-track_title",
        template: VisuComponents.get("menu-title"),
        layout: VisuLayouts.get("menu-title"),
        config: {
          label: { 
            text: "kedy_selma\nJust To Create Someting",
          },
        },
      },
      content: new Array(Struct, Core.getRuntimeType() == RuntimeType.GXGAMES
        ? [
          {
            name: "select-track_menu-button-entry_kedy-selma_just-to-create-something",
            template: VisuComponents.get("menu-button-entry"),
            layout: VisuLayouts.get("menu-button-entry"),
            config: {
              layout: { type: UILayoutType.VERTICAL },
              label: { 
                text: "4. Just To Create Something",
                callback: new BindIntent(function() {
                  Beans.get(BeanVisuController).send(new Event("load", {
                    manifest: "track/kedy_selma/2024-Just-To-Create-Something/4-Just-To-Create-Something/manifest.visu",
                    autoplay: true,
                  }))
                }),
                onMouseReleasedLeft: function() {
                  this.callback()
                },
              },
            }
          },
          {
            name: "select-track_menu-button-entry_back",
            template: VisuComponents.get("menu-button-entry"),
            layout: VisuLayouts.get("menu-button-entry"),
            config: {
              layout: { type: UILayoutType.VERTICAL },
              label: { 
                text: "Back",
                callback: new BindIntent(function() {
                  Beans.get(BeanVisuController).menu.send(Callable.run(this.callbackData))
                }),
                callbackData: config.back,
                onMouseReleasedLeft: function() {
                  this.callback()
                },
              },
            }
          }
        ]
        : [
          {
            name: "select-track_menu-button-entry_kedy-selma_wake-up-before-you-forget-how-to",
            template: VisuComponents.get("menu-button-entry"),
            layout: VisuLayouts.get("menu-button-entry"),
            config: {
              layout: { type: UILayoutType.VERTICAL },
              label: { 
                text: "1. Wake Up Before You Forget How To",
                callback: new BindIntent(function() {
                  Beans.get(BeanVisuController).send(new Event("load", {
                    manifest: "track/kedy_selma/2024-Just-To-Create-Something/1-Wake-Up-Before-You-Forget-How-To/manifest.visu",
                    autoplay: true,
                  }))
                }),
                onMouseReleasedLeft: function() {
                  this.callback()
                },
              },
            }
          },
          {
            name: "select-track_menu-button-entry_kedy-selma_you-will-live-and-you-will-be-happy",
            template: VisuComponents.get("menu-button-entry"),
            layout: VisuLayouts.get("menu-button-entry"),
            config: {
              layout: { type: UILayoutType.VERTICAL },
              label: { 
                text: "2. You Will Live and You Will Be Happy",
                callback: new BindIntent(function() {
                  Beans.get(BeanVisuController).send(new Event("load", {
                    manifest: "track/kedy_selma/2024-Just-To-Create-Something/2-You-Will-Live-and-You-Will-Be-Happy/manifest.visu",
                    autoplay: true,
                  }))
                }),
                onMouseReleasedLeft: function() {
                  this.callback()
                },
              },
            }
          },
          {
            name: "select-track_menu-button-entry_kedy-selma_what-kills-you",
            template: VisuComponents.get("menu-button-entry"),
            layout: VisuLayouts.get("menu-button-entry"),
            config: {
              layout: { type: UILayoutType.VERTICAL },
              label: { 
                text: "3. What Kills You",
                callback: new BindIntent(function() {
                  Beans.get(BeanVisuController).send(new Event("load", {
                    manifest: "track/kedy_selma/2024-Just-To-Create-Something/3-What-Kills-You/manifest.visu",
                    autoplay: true,
                  }))
                }),
                onMouseReleasedLeft: function() {
                  this.callback()
                },
              },
            }
          },
          {
            name: "select-track_menu-button-entry_kedy-selma_just-to-create-something",
            template: VisuComponents.get("menu-button-entry"),
            layout: VisuLayouts.get("menu-button-entry"),
            config: {
              layout: { type: UILayoutType.VERTICAL },
              label: { 
                text: "4. Just To Create Something",
                callback: new BindIntent(function() {
                  Beans.get(BeanVisuController).send(new Event("load", {
                    manifest: "track/kedy_selma/2024-Just-To-Create-Something/4-Just-To-Create-Something/manifest.visu",
                    autoplay: true,
                  }))
                }),
                onMouseReleasedLeft: function() {
                  this.callback()
                },
              },
            }
          },
          {
            name: "select-track_menu-button-entry_kedy-selma_lost_media.mp3",
            template: VisuComponents.get("menu-button-entry"),
            layout: VisuLayouts.get("menu-button-entry"),
            config: {
              layout: { type: UILayoutType.VERTICAL },
              label: { 
                text: "5. Lost_Media.mp3",
                callback: new BindIntent(function() {
                  Beans.get(BeanVisuController).send(new Event("load", {
                    manifest: "track/kedy_selma/2024-Just-To-Create-Something/5-Lost_Media.mp3/manifest.visu",
                    autoplay: true,
                  }))
                }),
                onMouseReleasedLeft: function() {
                  this.callback()
                },
              },
            }
          },
          {
            name: "select-track_menu-button-entry_kedy-selma_one-sky-feat-rayiko",
            template: VisuComponents.get("menu-button-entry"),
            layout: VisuLayouts.get("menu-button-entry"),
            config: {
              layout: { type: UILayoutType.VERTICAL },
              label: { 
                text: "6. One Sky (feat. Rayiko)",
                callback: new BindIntent(function() {
                  Beans.get(BeanVisuController).send(new Event("load", {
                    manifest: "track/kedy_selma/2024-Just-To-Create-Something/6-One-Sky-feat-Rayiko/manifest.visu",
                    autoplay: true,
                  }))
                }),
                onMouseReleasedLeft: function() {
                  this.callback()
                },
              },
            }
          },
          {
            name: "select-track_menu-button-entry_kedy-selma_interlude-lore",
            template: VisuComponents.get("menu-button-entry"),
            layout: VisuLayouts.get("menu-button-entry"),
            config: {
              layout: { type: UILayoutType.VERTICAL },
              label: { 
                text: "7. Interlude:Lore",
                callback: new BindIntent(function() {
                  Beans.get(BeanVisuController).send(new Event("load", {
                    manifest: "track/kedy_selma/2024-Just-To-Create-Something/7-Interlude-Lore/manifest.visu",
                    autoplay: true,
                  }))
                }),
                onMouseReleasedLeft: function() {
                  this.callback()
                },
              },
            }
          },
          {
            name: "select-track_menu-button-entry_kedy-selma_everything-will-end",
            template: VisuComponents.get("menu-button-entry"),
            layout: VisuLayouts.get("menu-button-entry"),
            config: {
              layout: { type: UILayoutType.VERTICAL },
              label: { 
                text: "8. Everything Will End",
                callback: new BindIntent(function() {
                  Beans.get(BeanVisuController).send(new Event("load", {
                    manifest: "track/kedy_selma/2024-Just-To-Create-Something/8-Everything-Will-End/manifest.visu",
                    autoplay: true,
                  }))
                }),
                onMouseReleasedLeft: function() {
                  this.callback()
                },
              },
            }
          },
          {
            name: "select-track_menu-button-entry_kedy-selma_there-is-no-point-only-reasons",
            template: VisuComponents.get("menu-button-entry"),
            layout: VisuLayouts.get("menu-button-entry"),
            config: {
              layout: { type: UILayoutType.VERTICAL },
              label: { 
                text: "9. There Is No Point, Only Reasons",
                callback: new BindIntent(function() {
                  Beans.get(BeanVisuController).send(new Event("load", {
                    manifest: "track/kedy_selma/2024-Just-To-Create-Something/9-There-Is-No-Point-Only-Reasons/manifest.visu",
                    autoplay: true,
                  }))
                }),
                onMouseReleasedLeft: function() {
                  this.callback()
                },
              },
            }
          },
          {
            name: "select-track_menu-button-entry_back",
            template: VisuComponents.get("menu-button-entry"),
            layout: VisuLayouts.get("menu-button-entry"),
            config: {
              layout: { type: UILayoutType.VERTICAL },
              label: { 
                text: "Back",
                callback: new BindIntent(function() {
                  Beans.get(BeanVisuController).menu.send(Callable.run(this.callbackData))
                }),
                callbackData: config.back,
                onMouseReleasedLeft: function() {
                  this.callback()
                },
              },
            }
          }
        ]
      )
    })

    return event
  }

  ///@param {?Struct} [_config]
  ///@return {Event}
  factoryOpenSettingsMenuEvent = function(_config = null) {
    var config = Struct.appendUnique(
      _config,
      {
        back: this.factoryOpenMainMenuEvent, 
      }
    )

    var event = new Event("open").setData({
      back: config.back,
      layout: Beans.get(BeanVisuController).visuRenderer.layout,
      title: {
        name: "settings_title",
        template: VisuComponents.get("menu-title"),
        layout: VisuLayouts.get("menu-title"),
        config: {
          label: { 
            text: "Settings",
          },
        },
      },
      content: new Array(Struct, [
        {
          name: "settings_menu-spin-select-entry_ost-volume",
          template: VisuComponents.get("menu-spin-select-entry"),
          layout: VisuLayouts.get("menu-spin-select-entry"),
          config: { 
            layout: { type: UILayoutType.VERTICAL },
            label: { text: "OST volume" },
            previous: { 
              callback: function() {
                var value = clamp(Visu.settings.getValue("visu.audio.ost.volume") - 0.1, 0.0, 1.0)
                Visu.settings.setValue("visu.audio.ost.volume", value).save()
              },
            },
            preview: {
              label: {
                text: string(int64(round(Visu.settings.getValue("visu.audio.ost.volume") * 10)))
              },
              updateCustom: function() {
                var value = round(Visu.settings.getValue("visu.audio.ost.volume") * 10)
                this.label.text = string(int64(value))
              },
            },
            next: { 
              callback: function() {
                var value = clamp(Visu.settings.getValue("visu.audio.ost.volume") + 0.1, 0.0, 1.0)
                Visu.settings.setValue("visu.audio.ost.volume", value).save()
              },
            },
          },
        },
        {
          name: "settings_menu-spin-select-entry_sfx-volume",
          template: VisuComponents.get("menu-spin-select-entry"),
          layout: VisuLayouts.get("menu-spin-select-entry"),
          config: { 
            layout: { type: UILayoutType.VERTICAL },
            label: { text: "SFX volume" },
            previous: { 
              callback: function() {
                var value = clamp(Visu.settings.getValue("visu.audio.sfx.volume") - 0.1, 0.0, 1.0)
                Visu.settings.setValue("visu.audio.sfx.volume", value).save()
              },
            },
            preview: {
              label: {
                text: string(int64(round(Visu.settings.getValue("visu.audio.sfx.volume") * 10)))
              },
              updateCustom: function() {
                var value = round(Visu.settings.getValue("visu.audio.sfx.volume") * 10)
                this.label.text = string(int64(value))
              },
            },
            next: { 
              callback: function() {
                var value = clamp(Visu.settings.getValue("visu.audio.sfx.volume") + 0.1, 0.0, 1.0)
                Visu.settings.setValue("visu.audio.sfx.volume", value).save()
              },
            },
          },
        },
        {
          name: "settings_menu-spin-select-entry_shader-quality",
          template: VisuComponents.get("menu-spin-select-entry"),
          layout: VisuLayouts.get("menu-spin-select-entry"),
          config: { 
            layout: { type: UILayoutType.VERTICAL },
            label: { text: "Shaders quality" },
            previous: { 
              callback: function() {
                var value = clamp(Visu.settings.getValue("visu.shader.quality") - 0.1, 0.2, 1.0)
                Visu.settings.setValue("visu.shader.quality", value).save()
              },
            },
            preview: {
              label: {
                text: string(int64(round(Visu.settings.getValue("visu.shader.quality") * 10)))
              },
              updateCustom: function() {
                var value = round(Visu.settings.getValue("visu.shader.quality") * 10)
                this.label.text = string(int64(value))

                var editor = Beans.get(BeanVisuEditorController)
                if (Optional.is(editor)) {
                  editor.store.get("shader-quality").set(Visu.settings.getValue("visu.shader.quality"))
                }
                
              },
            },
            next: { 
              callback: function() {
                var value = clamp(Visu.settings.getValue("visu.shader.quality") + 0.1, 0.2, 1.0)
                Visu.settings.setValue("visu.shader.quality", value).save()
              },
            },
          },
        },
        {
          name: "settings_menu-button-entry_fullscreen",
          template: VisuComponents.get("menu-button-entry"),
          layout: VisuLayouts.get("menu-button-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Fullscreen",
              callback: new BindIntent(function() {
                var controller = Beans.get(BeanVisuController)
                var fullscreen = controller.displayService.getFullscreen()
                controller.displayService.setFullscreen(!fullscreen)
              }),
              callbackData: config.back,
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
          }
        },
        {
          name: $"settings_menu-keyboard-key-entry_up",
          template: VisuComponents.get("menu-keyboard-key-entry"),
          layout: VisuLayouts.get("menu-keyboard-key-entry"),
          config: factoryPlayerKeyboardKeyEntryConfig("up", "Up"),
        },
        {
          name: $"settings_menu-keyboard-key-entry_down",
          template: VisuComponents.get("menu-keyboard-key-entry"),
          layout: VisuLayouts.get("menu-keyboard-key-entry"),
          config: factoryPlayerKeyboardKeyEntryConfig("down", "Down"),
        },
        {
          name: $"settings_menu-keyboard-key-entry_left",
          template: VisuComponents.get("menu-keyboard-key-entry"),
          layout: VisuLayouts.get("menu-keyboard-key-entry"),
          config: factoryPlayerKeyboardKeyEntryConfig("left", "Left"),
        },
        {
          name: $"settings_menu-keyboard-key-entry_right",
          template: VisuComponents.get("menu-keyboard-key-entry"),
          layout: VisuLayouts.get("menu-keyboard-key-entry"),
          config: factoryPlayerKeyboardKeyEntryConfig("right", "Right"),
        },
        {
          name: $"settings_menu-keyboard-key-entry_action",
          template: VisuComponents.get("menu-keyboard-key-entry"),
          layout: VisuLayouts.get("menu-keyboard-key-entry"),
          config: factoryPlayerKeyboardKeyEntryConfig("action", "Shoot"),
        },
        {
          name: $"settings_menu-keyboard-key-entry_bomb",
          template: VisuComponents.get("menu-keyboard-key-entry"),
          layout: VisuLayouts.get("menu-keyboard-key-entry"),
          config: factoryPlayerKeyboardKeyEntryConfig("bomb", "Use bomb"),
        },
        {
          name: $"settings_menu-keyboard-key-entry_focus",
          template: VisuComponents.get("menu-keyboard-key-entry"),
          layout: VisuLayouts.get("menu-keyboard-key-entry"),
          config: factoryPlayerKeyboardKeyEntryConfig("focus", "Focus mode"),
        },
        {
          name: "settings_menu-button-entry_back",
          template: VisuComponents.get("menu-button-entry"),
          layout: VisuLayouts.get("menu-button-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Back",
              callback: new BindIntent(function() {
                Beans.get(BeanVisuController).menu.send(Callable.run(this.callbackData))
              }),
              callbackData: config.back,
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
          }
        }
      ])
    })

    return event
  }

  ///@private
  ///@param {UIlayout} parent
  ///@return {UILayout}
  factoryLayout = function(parent) {
    return new UILayout(
      {
        name: "visu-menu",
        x: function() { return this.context.x() + (this.context.width() - this.width()) / 2.0 },
        y: function() { return this.context.y() },
        width: function() { return max(this.context.width() * 0.33, 480) },
        height: function() { return this.context.height() },
        nodes: {
          "visu-menu.title": {
            name: "visu-menu.title",
            x: function() { return this.context.x() },
            y: function() { return this.context.y() },
            width: function() { return this.context.width() },
            height: function() { return 200 },
          },
          "visu-menu.content": {
            name: "visu-menu.content",
            x: function() { return this.context.x() },
            y: function() { return Struct.get(this.context.nodes, "visu-menu.title").bottom() },
            width: function() { return this.context.width() },
            height: function() { return this.context.height() 
              - Struct.get(this.context.nodes, "visu-menu.title").height()
              - Struct.get(this.context.nodes, "visu-menu.footer").height() },
          },
          "visu-menu.footer": {
            name: "visu-menu.footer",
            x: function() { return this.context.x() },
            y: function() { return Struct.get(this.context.nodes, "visu-menu.content").bottom() },
            width: function() { return this.context.width() },
            height: function() { return 100 },
          },
        }
      },
      parent
    )
  }

  ///@private
  ///@param {Struct} title
  ///@param {Array<Struct>} content
  ///@param {?UIlayout} [parent]
  ///@return {Map<String, UI>}
  factoryContainers = function(title, content, parent = null) {
    var factoryTitle = function(name, controller, layout, title) {
      return new UI({
        name: name,
        controller: controller,
        layout: layout,
        state: new Map(String, any, {
          "background-alpha": 0.8,
          "background-color": ColorUtil.fromHex(VETheme.color.dark).toGMColor(),
          "title": title,
        }),
        updateArea: Callable
          .run(UIUtil.updateAreaTemplates
          .get("applyLayout")),
        render: Callable
          .run(UIUtil.renderTemplates
          .get("renderDefault")),
        onInit: function() {
          this.items.clear()
          this.addUIComponents(new Array(UIComponent, [ 
            new UIComponent(this.state.get("title"))
          ]),
          new UILayout({
            area: this.area,
            width: function() { return this.area.getWidth() },
            height: function() { return this.area.getHeight() },
          }))
        },
      })
    }

    var factoryContent = function(name, controller, layout, content) {
      return new UI({
        name: name,
        controller: controller,
        layout: layout,
        selectedIndex: 0,
        state: new Map(String, any, {
          "background-alpha": 0.5,
          "background-color": ColorUtil.fromHex(VETheme.color.dark).toGMColor(),
          "content": content,
          "isKeyboardEvent": true,
          "remapKey": null,
          "remapKeyRestored": 2,
        }),
        scrollbarY: { align: HAlign.RIGHT },
        updateArea: Callable
          .run(UIUtil.updateAreaTemplates
          .get("scrollableY")),
        updateVerticalSelectedIndex: new BindIntent(Callable
          .run(UIUtil.templates
          .get("updateVerticalSelectedIndex"))),
        updateCustom: function() {
          this.controller.remapKey = this.state.get("remapKey")
          if (Optional.is(this.controller.remapKey)) {
            this.state.set("remapKeyRestored", 2)
            return
          } 

          var remapKeyRestored = this.state.get("remapKeyRestored")
          if (remapKeyRestored > 0) {
            this.state.set("remapKeyRestored", remapKeyRestored - 1)
            return
          }

          if (keyboard_check_released(vk_up)) {
            var pointer = Struct.inject(this, "selectedIndex", 0)
            if (!Core.isType(pointer, Number)) {
              pointer = 0
            } else {
              pointer = clamp(
                (pointer == 0 ? this.collection.size() - 1 : pointer - 1), 
                0, 
                (this.collection.size() -1 >= 0 ? this.collection.size() - 1 : 0)
              )
            }

            this.state.set("isKeyboardEvent", true)
            Struct.set(this, "selectedIndex", pointer)

            this.collection.components.forEach(function(component, iterator, pointer) {
              if (component.index == pointer) {
                component.items.forEach(function(item) {
                  item.backgroundColor = Struct.contains(item, "colorHoverOver") 
                    ? ColorUtil.fromHex(item.colorHoverOver).toGMColor()
                    : item.backgroundColor
                })
              } else {
                component.items.forEach(function(item) {
                  item.backgroundColor = Struct.contains(item, "colorHoverOut") 
                    ? ColorUtil.fromHex(item.colorHoverOut).toGMColor()
                    : item.backgroundColor
                })
              }
            }, pointer)
          }

          if (keyboard_check_released(vk_down)) {
            var pointer = Struct.inject(this, "selectedIndex", 0)
            if (!Core.isType(pointer, Number)) {
              pointer = 0
            } else {
              pointer = clamp(
                (pointer == this.collection.size() - 1 ? 0 : pointer + 1), 
                0, 
                (this.collection.size() - 1 >= 0 ? this.collection.size() - 1 : 0)
              )
            }
            
            this.state.set("isKeyboardEvent", true)
            Struct.set(this, "selectedIndex", pointer)
            
            this.collection.components.forEach(function(component, iterator, pointer) {
              if (component.index == pointer) {
                component.items.forEach(function(item) {
                  item.backgroundColor = Struct.contains(item, "colorHoverOver") 
                    ? ColorUtil.fromHex(item.colorHoverOver).toGMColor()
                    : item.backgroundColor
                })
              } else {
                component.items.forEach(function(item) {
                  item.backgroundColor = Struct.contains(item, "colorHoverOut") 
                    ? ColorUtil.fromHex(item.colorHoverOut).toGMColor()
                    : item.backgroundColor
                })
              }
            }, pointer)
          }

          if (keyboard_check_released(vk_left)) {
            var component = this.collection.findByIndex(Struct.inject(this, "selectedIndex", 0))
            if (Optional.is(component)) {
              Core.print("component name", component.name)
              var type = null
              if (String.contains(component.name, "menu-button-entry")) {
                type = "menu-button-entry"
              } else if (String.contains(component.name, "menu-spin-select-entry")) {
                type = "menu-spin-select-entry"
              }

              switch (type) {
                case "menu-button-entry":
                  break
                case "menu-spin-select-entry":
                  var previous = component.items.find(function(item, index, name) { 
                    return String.contains(item.name, name) && Core.isType(Struct.get(item, "callback"), Callable)
                  }, "previous")
                  
                  if (Optional.is(previous)) {
                    previous.callback()
                  }
                  break
              }
            }
          }

          if (keyboard_check_released(vk_right)) {
            var component = this.collection.findByIndex(Struct.inject(this, "selectedIndex", 0))
            if (Optional.is(component)) {
              Core.print("component name", component.name)
              var type = null
              if (String.contains(component.name, "menu-button-entry")) {
                type = "menu-button-entry"
              } else if (String.contains(component.name, "menu-spin-select-entry")) {
                type = "menu-spin-select-entry"
              }

              switch (type) {
                case "menu-button-entry":
                  break
                case "menu-spin-select-entry":
                  var next = component.items.find(function(item, index, name) { 
                    return String.contains(item.name, name) && Core.isType(Struct.get(item, "callback"), Callable)
                  }, "next")
                  
                  if (Optional.is(next)) {
                    next.callback()
                  }
                  break
              }
            }
          }
          
          if (keyboard_check_released(vk_enter)) {
            var component = this.collection.findByIndex(Struct.inject(this, "selectedIndex", 0))
            if (Optional.is(component)) {
              Core.print("component name", component.name)
              var type = null
              if (String.contains(component.name, "menu-button-entry")) {
                type = "menu-button-entry"
              } else if (String.contains(component.name, "menu-spin-select-entry")) {
                type = "menu-spin-select-entry"
              } else if (String.contains(component.name, "menu-keyboard-key-entry")) {
                type = "menu-keyboard-key-entry"
              }

              switch (type) {
                case "menu-button-entry":
                  var label = component.items.find(function(item, index, name) { 
                    return String.contains(item.name, name) && Core.isType(Struct.get(item, "callback"), Callable)
                  }, "label")

                  if (Optional.is(label)) {
                    label.callback()
                  }
                  break
                case "menu-spin-select-entry":
                  Core.print("do nth")
                  break
                case "menu-keyboard-key-entry":
                  var label = component.items.find(function(item, index, name) { 
                    return String.contains(item.name, name) && Core.isType(Struct.get(item, "callback"), Callable)
                  }, "label")

                  if (Optional.is(label)) {
                    label.callback()
                  }
                  break
              }
            }
          }

          var component = this.collection.findByIndex(Struct.get(this, "selectedIndex"))
          if (Optional.is(component)) {
            component.items.forEach(function(item, index, context) {
              // horizontal offset
              var itemX = item.area.getX()
              var itemWidth = item.area.getWidth()
              var offsetX = abs(context.offset.x)
              var areaWidth = context.area.getWidth()
              if ((itemX < offsetX && itemX + itemWidth < offsetX) 
                || (itemX > offsetX + areaWidth && itemX + itemWidth > offsetX + areaWidth)) {
                  context.offset.x = -1 * itemX
              }

              // vertical offset
              var itemY = item.area.getY()
              var itemHeight = item.area.getHeight()
              var offsetY = abs(context.offset.y)
              var areaHeight = context.area.getHeight()
              if ((itemY < offsetY || itemY + itemHeight < offsetY) 
							  || (itemY > offsetY + areaHeight || itemY + itemHeight > offsetY + areaHeight)) {
                  context.offset.y = -1 * itemY
              }
            }, this)
          }
        },
        renderItem: Callable
          .run(UIUtil.renderTemplates
          .get("renderItemDefaultScrollable")),
        renderDefaultScrollable: new BindIntent(Callable
          .run(UIUtil.renderTemplates
          .get("renderDefaultScrollableBlend"))),
        render: function() {
          this.updateVerticalSelectedIndex(VISU_MENU_ENTRY_HEIGHT)
          this.renderDefaultScrollable()
        },
        onMousePressedLeft: Callable
          .run(UIUtil.mouseEventTemplates
          .get("onMouseScrollbarY")),
        onMouseWheelUp: Callable
          .run(UIUtil.mouseEventTemplates
          .get("scrollableOnMouseWheelUpY")),
        onMouseWheelDown: Callable
          .run(UIUtil.mouseEventTemplates
          .get("scrollableOnMouseWheelDownY")),
        onInit: function() {
          this.collection = new UICollection(this, { layout: this.layout })
          this.state.get("content").forEach(function(template, index, context) {
            context.collection.add(new UIComponent(template))
          }, this)

          if (this.state.get("content").size() > 0) {
            Struct.set(this, "selectedIndex", 0)
            this.state.set("isKeyboardEvent", true)
            this.collection.components.forEach(function(component, iterator, pointer) {
              if (component.index == pointer) {
                component.items.forEach(function(item) {
                  item.backgroundColor = Struct.contains(item, "colorHoverOver") 
                    ? ColorUtil.fromHex(item.colorHoverOver).toGMColor()
                    : item.backgroundColor
                })
              } else {
                component.items.forEach(function(item) {
                  item.backgroundColor = Struct.contains(item, "colorHoverOut") 
                    ? ColorUtil.fromHex(item.colorHoverOut).toGMColor()
                    : item.backgroundColor
                })
              }
            }, Struct.inject(this, "selectedIndex", 0))
          }

          this.scrollbarY.render = method(this.scrollbarY, function() { })
        },
      })
    }
    
    this.layout = this.factoryLayout(parent)
    this.containers
      .clear()
      .set(
        "container_visu-menu.title", 
        factoryTitle(
          "container_visu-menu.title",
          this,
          Struct.get(this.layout.nodes, "visu-menu.title"),
          title
        ))
      .set(
        "container_visu-menu.content", 
        factoryContent(
          "container_visu-menu.content",
          this,
          Struct.get(this.layout.nodes, "visu-menu.content"),
          content
        ))
      .set(
        "container_visu-menu.footer", 
        factoryTitle(
          "container_visu-menu.footer",
          this,
          Struct.get(this.layout.nodes, "visu-menu.footer"),
          {
            name: "visu-menu.footer",
            template: VisuComponents.get("menu-title"),
            layout: VisuLayouts.get("menu-title"),
            config: {
              label: { 
                text: "Alkapivo 2024",
                font: "font_kodeo_mono_12_bold",
              },
            },
          }
        ))

    return this.containers
  }
  
  ///@private
  ///@type {EventPump}
  dispatcher = new EventPump(this, new Map(String, Callable, {
    "open": function(event) {
      var editor = Beans.get(BeanVisuEditorController)
      if (Optional.is(editor) && editor.renderUI) {
        return
      }
      
      this.dispatcher.execute(new Event("close"))
      this.containers = this.factoryContainers(
        event.data.title, 
        event.data.content, 
        event.data.layout
      )
      this.back = Core.isType(Struct.get(event.data, "back"), Callable) 
        ? event.data.back 
        : null

      this.containers.forEach(function(container, key, uiService) {
        uiService.send(new Event("add", {
          container: container,
          replace: true,
        }))
      }, Beans.get(BeanVisuController).uiService)
    },
    "close": function(event) {
      this.back = null
      this.containers.forEach(function (container, key, uiService) {
        uiService.send(new Event("remove", { 
          name: key, 
          quiet: true,
        }))
      }, Beans.get(BeanVisuController).uiService).clear()
    },
    "back": function(event) {
      if (Optional.is(this.back)) {
        this.dispatcher.execute(this.back())
        return
      }
      this.dispatcher.execute(new Event("close"))
    },
  }))

  ///@param {Event} event
  ///@return {?Promise}
  send = function(event) {
    return this.dispatcher.send(event)
  }

  ///@return {VETrackControl}
  update = function() { 
    this.dispatcher.update()
    return this
  }
}
