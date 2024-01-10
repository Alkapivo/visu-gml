///@package io.alkapivo.visu

///@param {Struct} json
function VisuTrack(json) constructor {

  ///@type {String}
  track = Assert.isType(Struct.get(json, "track"), String)
  Assert.fileExists(this.track)
  
  ///@type {String}
  bullet = Assert.isType(Struct.get(json, "bullet"), String)
  Assert.fileExists(this.bullet)
  
  ///@type {String}
  lyrics = Assert.isType(Struct.get(json, "lyrics"), String)
  Assert.fileExists(this.lyrics)
  
  ///@type {String}
  particle = Assert.isType(Struct.get(json, "particle"), String)
  Assert.fileExists(this.particle)
  
  ///@type {String}
  shader = Assert.isType(Struct.get(json, "shader"), String)
  Assert.fileExists(this.shader)
  
  ///@type {String}
  shroom = Assert.isType(Struct.get(json, "shroom"), String)
  Assert.fileExists(this.shroom)
  
  ///@type {String}
  texture = Assert.isType(Struct.get(json, "texture"), String)
  Assert.fileExists(this.texture)

  ///@type {String}
  video = Assert.isType(Struct.get(json, "video"), String)
  Assert.fileExists(this.video)

  ///@type {Array<String>}
  editor = new Array(String, json.editor)
  this.editor.forEach(function(file) {
    Assert.fileExists(file)
  })
}