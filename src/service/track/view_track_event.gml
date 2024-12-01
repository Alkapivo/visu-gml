///@package io.alkapivo.visu.service.track

///@static
///@type {Struct}
global.__view_track_event = {
  "brush_view_camera": function(data) {
    Core.print("Dispatch track event:", "brush_view_camera")
  },
  "brush_view_wallpaper": function(data) {
    Core.print("Dispatch track event:", "brush_view_wallpaper")
  },
  "brush_view_subtitle": function(data) {
    Core.print("Dispatch track event:", "brush_view_subtitle")
  },
  "brush_view_config": function(data) {
    Core.print("Dispatch track event:", "brush_view_config")
  },
}
#macro view_track_event global.__view_track_event
