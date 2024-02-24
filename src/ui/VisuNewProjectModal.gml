
///@package io.alkapivo.visu.editor.ui

///@param {Struct} [json]
function VisuNewProjectForm(json = null) constructor {

  ///@type {Store}
  store = new Store({
    "project-name": {
      type: String,
      value: Struct.getDefault(json, "name", "New project"),
    },
    "file-audio": {
      type: Optional.of(String),
      value: Struct.getDefault(json, "file-audio", ""),
    },
    "use-file-video": {
      type: Boolean,
      value: Struct.getDefault(json, "use-file-video", false),
    },
    "file-video": {
      type: Optional.of(String),
      value: Struct.getDefault(json, "file-video", ""),
    },
  })

  ///@type {Array<Struct>}
  components = new Array(Struct, [
    {
      name: "project-name",
      template: VEComponents.get("text-field-checkbox"),
      layout: VELayouts.get("text-field-checkbox"),
      config: { 
        layout: { type: UILayoutType.VERTICAL },
        label: { text: "Name" },
        field: { store: { key: "project-name" } },
      },
    },
    {
      name: "file-audio",  
      template: VEComponents.get("text-field-button-checkbox"),
      layout: VELayouts.get("text-field-button-checkbox"),
      config: { 
        layout: { type: UILayoutType.VERTICAL },
        label: { text: "Audio" },
        field: { 
          read_only: true,
          updateCustom: function() {
            var text = this.context.state.get("store").getValue("file-audio")
            if (Core.isType(text, String)) {
              this.textField.setText(FileUtil.getFilenameFromPath(text))
            } else {
              this.textField.setText("")
            }
          },
        },
        button: { 
          label: { text: "Open" },
          callback: function() {
            var path = FileUtil.getPathToOpenWithDialog({
              description: "OGG file",
              extension: "ogg",
            })
            if (!FileUtil.fileExists(path)) {
              return
            }

            this.context.state.get("store")
              .get("file-audio")
              .set(path)
          }},
      },
    },
    {
      name: "file-video",  
      template: VEComponents.get("text-field-button-checkbox"),
      layout: VELayouts.get("text-field-button-checkbox"),
      config: { 
        layout: { type: UILayoutType.VERTICAL },
        checkbox: { 
          store: { key: "use-file-video" },
          spriteOn: { name: "visu_texture_checkbox_switch_on" },
          spriteOff: { name: "visu_texture_checkbox_switch_off" },
          
        },
        label: { 
          text: "Video",
          enable: { key: "use-file-video" },
        },
        field: { 
          read_only: true,
          updateCustom: function() {
            var text = this.context.state.get("store").getValue("file-video")
            if (Core.isType(text, String)) {
              this.textField.setText(FileUtil.getFilenameFromPath(text))
            } else {
              this.textField.setText("")
            }
          },
          enable: { key: "use-file-video"},
        },
        button: { 
          label: { text: "Open" },
          enable: { key: "use-file-video"},
          callback: function() {
            var path = FileUtil.getPathToOpenWithDialog({
              description: "MP4 file",
              extension: "mp4",
            })
            if (!FileUtil.fileExists(path)) {
              return
            }

            this.context.state.get("store")
              .get("file-video")
              .set(path)
          },
        },
      },
    },
    {
      name: "button_create",
      template: VEComponents.get("button"),
      layout: VELayouts.get("button"),
      config: {
        layout: { type: UILayoutType.VERTICAL },
        backgroundColor: VETheme.color.accept,
        backgroundMargin: { top: 5, bottom: 5, left: 5, right: 5 },
        callback: function() { 
          var path = FileUtil.getPathToSaveWithDialog({ 
            description: "JSON file",
            filename: "manifest", 
            xtension: "json" 
          })
          this.context.state.get("form").save(path)
          this.context.modal.send(new Event("close"))
        },
        label: { text: "Create project" },
      },
    },
    {
      name: "button_cancel",
      template: VEComponents.get("button"),
      layout: VELayouts.get("button"),
      config: {
        layout: { type: UILayoutType.VERTICAL },
        backgroundColor: VETheme.color.deny,
        backgroundMargin: { top: 5, bottom: 5, left: 5, right: 5 },
        callback: function() { 
          this.context.modal.send(new Event("close"))
        },
        label: { text: "Cancel" },
      },
    },
  ])

  ///@return {Struct}
  serialize = function() {
    var json = {
      name: Assert.isType(this.store.getValue("project-name"), String),
      audio: Assert.isType(this.store.getValue("file-audio"), String),
    }

    if (this.store.getValue("use-file-video") 
      && Core.isType(this.store.getValue("file-video"), String)) {
      Struct.set(json, "video", this.store.getValue("file-video"))
    }

    return json
  }

  ///@param {String} manifestPath
  ///@return {VisuNewProjectForm}
  save = function(manifestPath) {
    var json = this.serialize()
    var controller = Beans.get(BeanVisuController)
    var fileService = controller.fileService

    var filename = Assert.isType(FileUtil.getFilenameFromPath(manifestPath), String)
    var path = Assert.isType(FileUtil.getDirectoryFromPath(manifestPath), String)
    var manifest = {
      "model": "io.alkapivo.visu.controller.VisuTrack",
      "data": {  
        "bpm": controller.editor.store.getValue("bpm"),
        "bullet": "bullet.json",
        "editor": [],
        "lyrics": "lyrics.json",
        "particle": "particle.json",
        "shader": "shader.json",
        "shroom": "shroom.json",
        "sound": "sound.json",
        "texture": "texture.json",
        "track": "track.json"
      }
    }

    var templates = new Map(String, any, {
      "bullet": {
        "model": "Collection<io.alkapivo.visu.service.bullet.BulletTemplate>",
        "data": {},
      },
      "lyrics": {
        "model": "Collection<io.alkapivo.visu.service.lyrics.LyricsTemplate>",
        "data": {},
      },
      "particle": {
        "model": "Collection<io.alkapivo.core.service.particle.ParticleTemplate>",
        "data": {},
      },
      "shader": {
        "model": "Collection<io.alkapivo.core.service.shader.ShaderTemplate>",
        "data": {},
      },
      "shroom": {
        "model": "Collection<io.alkapivo.visu.service.shroom.ShroomTemplate>",
        "data": {},
      },
      "sound": {
        "model": "Collection<io.alkapivo.core.service.sound.SoundIntent>",
        "data": {
          "sound_external": {
            "file": FileUtil.getFilenameFromPath(json.audio)
          }
        }
      },
      "texture": {
        "model": "Collection<io.alkapivo.core.service.texture.TextureIntent>",
        "data": {},
      },
      "track": {
        "model":"io.alkapivo.core.service.track.Track",
        "data":{
          "name": json.name,
          "audio": "sound_external",
          "channels": [
            {
              "name": "main",
              "events": []
            },
          ]
        }
      }
    })

    FileUtil.createDirectory($"{path}editor")


    var audioFilename = FileUtil.getFilenameFromPath(json.audio)
    Core.print("audio copy", json.audio, $"{path}{audioFilename}")
    FileUtil.copyFile(json.audio, $"{path}{audioFilename}")


    if (Core.isType(Struct.get(json, "video"), String)) {
      Struct.set(manifest.data, "video", FileUtil
        .getFilenameFromPath(json.video))
      var videoFilename = FileUtil.getFilenameFromPath(json.video)
      Core.print("video copy", json.video, $"{path}{videoFilename}")
      FileUtil.copyFile(json.video, $"{path}{videoFilename}")
    }


    templates.forEach(function(template, key, acc) {
      var filename = Assert.isType(Struct.get(acc.manifest.data, key), String)
      acc.fs.send(new Event("save-file-sync")
        .setData(new File({
          path: $"{acc.path}{filename}" ,
          data: String.replaceAll(JSON.stringify(template, { pretty: true }), "\\", ""),
      })))
    }, {
      fs: fileService,
      manifest: manifest,
      path: path,
    })

    
    fileService.send(new Event("save-file-sync")
      .setData(new File({
        path: $"{path}manifest.json" ,
        data: String.replaceAll(JSON.stringify(manifest, { pretty: true }), "\\", ""),
    })))

    return this
  }
}

///@param {VisuController} _controller
///@param {?Struct} [_config]
function VisuNewProjectModal(_controller, _config = null) constructor {

  ///@type {VisuController}
  controller = Assert.isType(_controller, VisuController)

  ///@type {UIService}
  uiService = Assert.isType(this.controller.uiService, UIService)

  ///@type {?Struct}
  config = Optional.is(_config) ? Assert.isType(_config, Struct) : null

  ///@type {Store}
  store = new Store({
    "form": {
      type: Optional.of(VisuNewProjectForm),
      value: null,
    },
  })

  ///@private
  ///@param {UIlayout} parent
  ///@return {UILayout}
  factoryLayout = function(parent) {
    return new UILayout(
      {
        name: "visu-new-project-modal",
        x: function() { return (this.context.width() - this.width()) / 2 },
        y: function() { return (this.context.height() - this.height()) / 2 },
        width: function() { return 480 },
        height: function() { return 360 },
      },
      parent
    )
  }

  ///@private
  ///@param {?UIlayout} [parent]
  ///@return {Map<String, UI>}
  factoryContainers = function(parent = null) {
    var modal = this
    var layout = this.factoryLayout(parent)
    return new Map(String, UI, {
      "visu-new-project-modal": new UI({
        name: "visu-new-project-modal",
        state: new Map(String, any, {
          "background-color": ColorUtil.fromHex(VETheme.color.primary).toGMColor(),
        }),
        modal: modal,
        layout: layout,
        updateArea: Callable.run(UIUtil.updateAreaTemplates.get("scrollableY")),
        renderItem: Callable.run(UIUtil.renderTemplates.get("renderItemDefaultScrollable")),
        render: Callable.run(UIUtil.renderTemplates.get("renderDefaultScrollable")),
        onInit: function() {
          var container = this
          this.collection = new UICollection(this, { layout: container.layout })
          this.items.forEach(function(item) { item.free() }).clear() ///@todo replace with remove lambda
          this.collection.components.clear() ///@todo replace with remove lambda
          this.state.set("form", null)
          this.state.set("store", null)
          this.updateArea()

          var form = new VisuNewProjectForm()
          this.state.set("form", form)
          this.state.set("store", form.store)
          this.addUIComponents(form.components
            .map(function(component) {
              return new UIComponent(component)
            }),
            new UILayout({
              area: container.area,
              width: function() { return this.area.getWidth() },
            })
          )
          this.modal.store.get("form").set(form)
        },
      }),
    })
  }

  ///@type {EventPump}
  dispatcher = new EventPump(this, new Map(String, Callable, {
    "open": function(event) {
      this.containers = this.factoryContainers(event.data.layout)
      containers.forEach(function(container, key, uiService) {
        uiService.send(new Event("add", {
          container: container,
          replace: true,
        }))
      }, this.uiService)
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

  ///@return {VETrackControl}
  update = function() { 
    this.dispatcher.update()
    return this
  }
}