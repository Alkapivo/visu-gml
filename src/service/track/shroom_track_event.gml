///@package io.alkapivo.visu.service.track

///@static
///@type {Map<String, Callable>}
global.__shroom_track_event = new Map(String, Callable, {
  "brush_shroom_spawn": function(data) {
    ///@description composition
    var shroom = {
      template: Struct.get(data, "shroom-spawn_template"),
      spawnX: Struct.get(data, "shroom-spawn_spawn-x"),
      spawnY: Struct.get(data, "shroom-spawn_spawn-y"),
      angle: Struct.get(data, "shroom-spawn_angle"),
      speed: Struct.get(data, "shroom-spawn_speed"),
    }
    Beans.get(BeanVisuController).shroomService
      .send(new Event("spawn-shroom", shroom))
  
    ///@description ecs
    /*
    var controller = Beans.get(BeanVisuController)
    controller.gridSystem.add(new GridEntity({
      type: GridEntityType.ENEMY,
      position: { 
        x: controller.gridService.view.x + Struct.get(data, "shroom-spawn_spawn-x"), 
        y: controller.gridService.view.y + Struct.get(data, "shroom-spawn_spawn-y"),
      },
      velocity: { 
        speed: Struct.get(data, "shroom-spawn_speed") / 1000, 
        angle: Struct.get(data, "shroom-spawn_angle"),
      },
      renderSprite: { name: "texture_baron" },
    }))
    */
  },
  "brush_shroom_clear": function(data) {
    Core.print("todo:", "brush_shroom_clear", "event")
  },
  "brush_shroom_config": function(data) {
    Core.print("todo:", "brush_shroom_config", "event")
  },
})
#macro shroom_track_event global.__shroom_track_event
