///@package io.alkapivo.visu

///@todo missing absolute path validation
///@param {Struct} json
function VisuTrack(_path, json) constructor {

  ///@type {String}
  path = Assert.isType(FileUtil.getDirectoryFromPath(_path), String)

  ///@type {String}
  track = Assert.isType(Struct.get(json, "track"), String)
  
  ///@type {String}
  bullet = Assert.isType(Struct.get(json, "bullet"), String)
  
  ///@type {String}
  lyrics = Assert.isType(Struct.get(json, "lyrics"), String)
  
  ///@type {String}
  particle = Assert.isType(Struct.get(json, "particle"), String)
  
  ///@type {String}
  shader = Assert.isType(Struct.get(json, "shader"), String)
  
  ///@type {String}
  shroom = Assert.isType(Struct.get(json, "shroom"), String)
  
  ///@type {String}
  texture = Assert.isType(Struct.get(json, "texture"), String)

  ///@type {String}
  video = Assert.isType(Struct.get(json, "video"), String)

  ///@type {Array<String>}
  editor = new Array(String, json.editor)

  saveProject = function(manifestPath) {
    var controller = Beans.get(BeanVisuController)
    var fileService = controller.fileService
    var path = Assert.isType(FileUtil.getDirectoryFromPath(manifestPath), String)
    var manifest = {
      "model": "io.alkapivo.visu.controller.VisuTrack",
      "data": {  
        "track": this.track,
        "bullet": this.bullet,
        "lyrics": this.lyrics,
        "particle": this.particle,
        "shader": this.shader,
        "shroom": this.shroom,
        "texture": this.texture,
        "video": this.video,
        "editor": controller.editor.brushService.templates
          .keys()
          .map(function(filename) {
            return $"editor/{filename}.json"
          })
          .getContainer(),
      }
    }

    var track = controller.trackService.track.serialize()
    FileUtil.createDirectory($"{path}editor")

    var bullet = {
      "model": "Collection<io.alkapivo.visu.service.bullet.BulletTemplate>",
      "data": {},
    }
    controller.bulletService.templates
      .forEach(function(template, name, data) {
        Struct.set(data, template.name, template.serialize())
      }, bullet.data)

    var lyrics = {
      "model": "Collection<io.alkapivo.visu.service.lyrics.LyricsTemplate>",
      "data": {},
    }
    controller.lyricsService.templates
      .forEach(function(template, name, data) {
        Struct.set(data, template.name, template.serialize())
      }, lyrics.data)

    var particle = {
      "model": "Collection<io.alkapivo.core.service.particle.ParticleTemplate>",
      "data": {},
    }
    controller.particleService.templates
      .forEach(function(template, name, data) {
        Struct.set(data, template.name, template.serialize())
      }, particle.data)
    
    var shader = {
      "model": "Collection<io.alkapivo.core.service.shader.ShaderTemplate>",
      "data": {},
    }
    controller.shaderPipeline.templates
      .forEach(function(template, name, data) {
        Struct.set(data, template.name, template)
      }, shader.data)

    var shroom = {
      "model": "Collection<io.alkapivo.visu.service.shroom.ShroomTemplate>",
      "data": {},
    }
    controller.shroomService.templates
      .forEach(function(template, name, data) {
        Struct.set(data, template.name, template.serialize())
      }, shroom.data)

    var textureAcc = {
      texture: {
        "model": "Collection<io.alkapivo.core.service.texture.TextureIntent>",
        "data": {},
      },
      files: new Map(String, Struct),
    }
    controller.textureService.templates
      .forEach(function(template, name, acc) {
        var path = template.file
        var json = template.serialize()
        acc.files.set(path, json)
        Struct.set(acc.texture.data, template.name, json)
      }, textureAcc)

    var editor = {}
    controller.editor.brushService.templates
      .forEach(function(templates, type, editor) {
        Struct.set(editor, type, {
          "model": "Collection<io.alkapivo.visu.editor.api.VEBrushTemplate>",
          "data": templates.getContainer(),
        })
      }, editor)

    var sourceVideo = Assert.isType(FileUtil.get(Struct.get(controller.videoService
      .getVideo(), "path")), String)
    var video = FileUtil.getFilenameFromPath(sourceVideo)



    fileService.send(new Event("save-file-sync")
      .setData({
        path: manifestPath,
        data: String.replaceAll(JSON.stringify(manifest, { pretty: true }), "\\", ""),
    }))
    fileService.send(new Event("save-file-sync")
      .setData({
        path: $"{path}{this.track}",
        data: track,
    }))
    fileService.send(new Event("save-file-sync")
      .setData({
        path: $"{path}{this.bullet}",
        data: JSON.stringify(bullet, { pretty: true }),
    }))
    fileService.send(new Event("save-file-sync")
      .setData({
        path: $"{path}{this.lyrics}",
        data: JSON.stringify(lyrics, { pretty: true }),
    }))
    fileService.send(new Event("save-file-sync")
      .setData({
        path: $"{path}{this.particle}",
        data: JSON.stringify(particle, { pretty: true }),
    }))
    fileService.send(new Event("save-file-sync")
      .setData({
        path: $"{path}{this.shader}",
        data: JSON.stringify(shader, { pretty: true }),
    }))
    fileService.send(new Event("save-file-sync")
      .setData({
        path: $"{path}{this.shroom}",
        data: JSON.stringify(shroom, { pretty: true }),
    }))
    fileService.send(new Event("save-file-sync")
      .setData({
        path: $"{path}{this.texture}",
        data: JSON.stringify(textureAcc.texture, { pretty: true }),
    }))
    textureAcc.files.forEach(function(template, sourcePath, targetDirectory) {
      FileUtil.copyFile(sourcePath, $"{targetDirectory}{template.file}")
    }, path)

    FileUtil.copyFile(sourceVideo, $"{path}{video}")
    Struct.forEach(editor, function(data, filename, acc) {
      acc.fileService.send(new Event("save-file-sync")
        .setData({
          path: $"{acc.path}editor/{filename}.json",
          data: JSON.stringify(data, { pretty: true }),
      }))
    }, { path: path, fileService: fileService })
  }
}