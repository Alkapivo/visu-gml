///@package io.alkapivo.visu.service.lyrics

///@param {String} _name
///@param {Struct} json
function LyricsTemplate(_name, json) constructor {

  ///@type {String}
  name = Assert.isType(_name, String)

  ///@type {Array<String>}
  lines = Struct.contains(json, "lines")
    ? new Array(String, GMArray
      .map(json.lines, function(line) {
        return Assert.isType(line, String)
      }))
    : new Array(String)

  ///@return {Struct}
  serialize = function() {
    return {
      lines: this.lines.getContainer()
    }
  }
}



///@param {Struct} json
function Lyrics(json) constructor {

  ///@type {Array<String>}
  lines = Assert.isType(json.lines, Array).validate(String)

  ///@return {Lyrics}
  static update = function() {
    return this
  }
}
