///@package io.alkapivo.visu.service.coin

function CoinService(config = {}): Service() constructor {

  ///@type {Array<Bullet>}
  coins = new Array(Bullet)

  ///@type {Map<String, CoinTemplate>}
  templates = new Map(String, CoinTemplate)
  
  ///@type {Stack<Number>}
  gc = new Stack(Number)

  ///@type {EventPump}
  dispatcher = new EventPump(this, new Map(String, Callable, {

  }))

  ///@param {Event} event
  ///@return {?Promise}
  send = function(event) {
    return this.dispatcher.send(event)
  }

  
  ///@override
  ///@return {CoinService}
  update = function() { 
    return this
  } 
}