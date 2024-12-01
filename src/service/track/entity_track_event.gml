show_debug_message("co kurwa?")
///@type {Struct}
global.__entity_track_event = {
  "brush_entity_shroom": function(data) {
    var controller = Beans.get(BeanVisuController)
    var shroom = {
      template: Struct.get(data, "en-shr_template"),
      speed: abs(Struct.get(data, "en-shr_spd")
        + (Struct.get(data, "en-shr_use-spd-rng")
          ? (random(Struct.get(data, "en-shr_spd-rng") / 2.0)
            * choose(1.0, -1.0))
          : 0.0)),
      angle: Math.normalizeAngle(Struct.get(data, "en-shr_dir")
        + (Struct.get(data, "en-shr_use-dir-rng")
          ? (random(Struct.get(data, "en-shr_dir-rng") / 2.0)
          * choose(1.0, -1.0))
        : 0.0)),
      spawnX: Struct.get(data, "en-shr_x")
        * (SHROOM_SPAWN_CHANNEL_SIZE / SHROOM_SPAWN_CHANNEL_AMOUNT)
        + 0.5
        + (Struct.get(data, "en-shr_use-rng-x")
          ? (random(Struct.get(data, "en-shr_rng-x") / 2.0)
            * (SHROOM_SPAWN_CHANNEL_SIZE / SHROOM_SPAWN_CHANNEL_AMOUNT)
            * choose(1.0, -1.0))
          : 0.0),
      snapH: Struct.getDefault(data, "en-shr_snap-x", false),
      spawnY: Struct.get(data, "en-shr_y")
        * (SHROOM_SPAWN_ROW_SIZE / SHROOM_SPAWN_ROW_AMOUNT)
        - 0.5
        + (Struct.get(data, "en-shr_use-rng-y")
          ? (random(Struct.get(data, "en-shr_rng-y") / 2.0)
            * (SHROOM_SPAWN_ROW_SIZE / SHROOM_SPAWN_ROW_AMOUNT)
            * choose(1.0, -1.0))
          : 0.0),
      snapV: Struct.getDefault(data, "en-shr_snap-y", false),
    }

    controller.shroomService.send(new Event("spawn-shroom", shroom))

    ///@ecs
    /*
    var controller = Beans.get(BeanVisuController)
    controller.gridECS.add(new GridEntity({
      type: GridEntityType.ENEMY,
      position: { 
        x: controller.gridService.view.x
          + (Struct.get(data, "en-shr_x") 
            * (SHROOM_SPAWN_CHANNEL_SIZE / SHROOM_SPAWN_CHANNEL_AMOUNT) 
            + 0.5),
        y: controller.gridService.view.y
          + (Struct.get(data, "en-shr_y") 
            * (SHROOM_SPAWN_ROW_SIZE / SHROOM_SPAWN_ROW_AMOUNT) 
            - 0.5),
      },
      velocity: { 
        speed: Struct.get(data, "en-shr_spd") / 1000, 
        angle: Struct.get(data, "en-shr_dir"),
      },
      renderSprite: { name: "texture_baron" },
    }))
    */
  },
  "brush_entity_coin": function(data) {
    var controller = Beans.get(BeanVisuController)
    var view = controller.gridService.view
    var viewX = Struct.getDefault(data, "en-coin_snap-x", false)
      ? floor(view.x / (view.width / 2.0)) * (view.width / 2.0)
      : view.x
    var viewY = Struct.getDefault(data, "en-coin_snap-y", false)
      ? floor(view.y / (view.height / 2.0)) * (view.height / 2.0)
      : view.y
    
    var coin = {
      template: Struct.get(data, "en-coin_template"),
      x: viewX + Struct.get(data, "en-coin_x")
        * (SHROOM_SPAWN_CHANNEL_SIZE / SHROOM_SPAWN_CHANNEL_AMOUNT)
        + 0.5
        + (Struct.get(data, "en-coin_use-rng-x")
          ? (random(Struct.get(data, "en-coin_rng-x") / 2.0)
            * (SHROOM_SPAWN_CHANNEL_SIZE / SHROOM_SPAWN_CHANNEL_AMOUNT)
            * choose(1.0, -1.0))
          : 0.0),
      y: viewY + Struct.get(data, "en-coin_y")
        * (SHROOM_SPAWN_ROW_SIZE / SHROOM_SPAWN_ROW_AMOUNT)
        - 0.5
        + (Struct.get(data, "en-coin_use-rng-y")
          ? (random(Struct.get(data, "en-coin_rng-y") / 2.0)
            * (SHROOM_SPAWN_ROW_SIZE / SHROOM_SPAWN_ROW_AMOUNT)
            * choose(1.0, -1.0))
          : 0.0),
    }
    
    controller.coinService.send(new Event("spawn-coin", coin))
  },
  "brush_entity_player": function(data) {
    var controller = Beans.get(BeanVisuController)
    var json = {
      sprite: Struct.get(data, "en-pl_texture")
    }

    if (Struct.get(data, "en-pl_use-mask")) {
      Struct.set(json, "mask", Struct.get(data, "en-pl_mask"))
    }

    if (Struct.getIfType(data, "en-pl_reset-pos", Boolean, false)) {
      Struct.set(json, "reset-position", Struct.get(data, "en-pl_reset-pos"))
    }

    if (Struct.get(data, "en-pl_use-stats")) {
      Struct.set(json, "stats", Struct.get(data, "en-pl_stats"))
    }

    if (Struct.get(data, "en-pl_use-racing")) {
      Struct.set(json, "racing", Struct
        .get(data, "en-pl_racing"))
    }

    if (Struct.get(data, "en-pl_use-bullethell")) {
      Struct.set(json, "bulletHell", Struct
        .get(data, "en-pl_bullethell"))
    }

    if (Struct.get(data, "en-pl_use-platformer")) {
      Struct.set(json, "platformer", Struct
        .get(data, "en-pl_platformer"))
    }

    controller.playerService.send(new Event("spawn-player", json))
  },
  "brush_entity_config": function(data) {
    Core.print("Dispatch track event:", "brush_entity_config")
  },
}
#macro entity_track_event global.__entity_track_event
