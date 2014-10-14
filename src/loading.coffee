Loading =
  show: ->
    Crafty.e '2D, DOM, Text'
      .text 'Loading...'
      .attr x: 0, y: Game.height() / 2 - 24, w: Game.width()
      .css
        'font-size': '24px'
        'font-family': 'Arial'
        'color': 'white'
        'text-align': 'center'

    # Load our sprite map image
    setTimeout @onLoad, 3000

  onLoad: -> Crafty.scene 'Game'

Crafty.scene 'Loading', -> Loading.show()
