window.Game =

  grid:
    width: 24
    height: 16
    tile:
      width: 16
      height: 16

  width: -> @grid.width * @grid.tile.width

  height: -> @grid.height * @grid.tile.height

  start: ->
    Crafty.init @width(), @height()
    Crafty.background 'rgb(249, 223, 125)'

    for x in [0...@grid.width]
      for y in [0...@grid.height]
        at_edge = x is 0 or x is (@grid.width - 1) or
          y is 0 or y is (@grid.height - 1)
        if at_edge
          Crafty.e('Tree').at x, y
        else if Math.random() < 0.1
          Crafty.e('Bush').at x, y

    Crafty.e('PlayerCharacter').at 1, 1
