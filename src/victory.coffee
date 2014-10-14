Victory =
  show: (scene) ->
    Crafty.e '2D, DOM, Text'
      .attr x: 0, y: Game.height() / 2 - 24, w: Game.width()
      .text 'Victory!'
      .css
        'font-size': '24px'
        'font-family': 'Arial'
        'color': 'white'
        'text-align': 'center'

    scene.bind 'KeyDown', @restartGame

  restartGame: ->
    Crafty.scene 'Game'

  hide: (scene) ->
    scene.unbind 'KeyDown', @restartGame

Crafty.scene 'Victory', (-> Victory.show this), (-> Victory.hide this)
