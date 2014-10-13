Crafty.scene 'Victory', (->
  Crafty.e '2D, DOM, Text'
    .attr x: 0, y: 0
    .text 'Victory!'

  @restartGame = @bind 'KeyDown', ->
    Crafty.scene 'Game'
  ), -> @unbind 'KeyDown', @restartGame
