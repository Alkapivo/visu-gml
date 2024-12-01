///@package io.alkapivo.visu.service.track

///@static
///@type {Struct}
global.__grid_track_event = {
  "brush_grid_area": function(data) {
    Core.print("Dispatch track event:", "brush_grid_area")
  },
  "brush_grid_column": function(data) {
    Core.print("Dispatch track event:", "brush_grid_column")
  },
  "brush_grid_row": function(data) {
    Core.print("Dispatch track event:", "brush_grid_row")
  },
  "brush_grid_config": function(data) {
    Core.print("Dispatch track event:", "brush_grid_config")
  },
}
#macro grid_track_event global.__grid_track_event
