///@package io.alkapivo.visu.service.grid

///@static
///@type {Map<String, Callable>}
global.__VISU_GRID_CONDITIONS = new Map(String, Callable, {
  "kill": function() {
    return function(shroom, controller) {
      return shroom.signals.kill
    }
  },
  "boolean": function() {
    return function(item, controller) {
      return Struct.get(item, this.data.field) == this.data.value
    }
  },
  "numeric": function() {
    return function(item, controller) {
      var value = Struct.get(item, this.data.field)
      switch (this.data.operator) {
        case "equal": return this.data.value == value
        case "greater": return this.data.value > value
        case "less": return this.data.value < value
        default: throw Exception($"Found unsupported operator for 'numeric': {this.data.operator}")
      }
    }
  },
  "player-landed": function() {
    return function(shroom, controller) {
      return Optional.is(shroom.signals.playerCollision) 
        && shroom.signals.playerLanded
    }
  },
  "player-leave": function() {
    return function(shroom, controller) {
      return shroom.signals.playerLeave
    }
  },
  "lifespawn": function() {
    return function(item, controller) {
      var value = this.data.value
      switch (this.data.operator) {
        case "equal": return value == item.lifespawn
        case "greater": return value > item.lifespawn
        case "less": return value < item.lifespawn
        default: throw Exception($"Found unsupported operator for 'lifespawn': {this.data.operator}")
      }
    }
  },
  "player-distance": function() {
    return function(shroom, controller) {
      var player = controller.playerService.player
      if (!Optional.is(player)) {
        return false
      }

      var length = Math.fetchLength(shroom.x, shroom.y, player.x, player.y)
      var value = this.data.length
      switch (this.data.operator) {
        case "greater": return value > length
        case "less": return value < length
        default: throw Exception($"Found unsupported operator for 'player-distance'")
      }
    }
  },
})
#macro VISU_GRID_CONDITIONS global.__VISU_GRID_CONDITIONS


///@param {Struct} json
function GridItemCondition(json) constructor {

  ///@type {String}
  type = Assert.isType(json.type, String)

  ///@type {any}
  data = Struct.getDefault(json, "data", null)

  ///@param {GridItem} item
  ///@param {VisuController} controller
  ///@return {Boolean}
  check = method(this, Assert.isType(Callable
    .run(VISU_GRID_CONDITIONS.get(this.type)), Callable))
}
