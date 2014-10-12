window.Game =

  grid:
    width: 24
    height: 16
    tile:
      width: 16
      height: 16

  width: -> @grid.width * @grid.tile.width

  height: -> @grid.height * @grid.tile.height

  placeTile: (x,y,c) ->
    Crafty.e '2D, Canvas, Color'
      .attr
        x: x * @grid.tile.width
        y: y * @grid.tile.height
        w: @grid.tile.width
        h: @grid.tile.height
      .color "rgb(20, #{c}, 40)"

  # Initialize and start our game
  start: ->
    # Start crafty and set a background color so that we can see it's working
    Crafty.init @width(), @height()
    Crafty.background 'rgb(249, 223, 125)'

    for x in [0...@grid.width]
      for y in [0...@grid.height]
        at_edge = x is 0 or x is (@grid.width - 1) or
          y is 0 or y is (@grid.height - 1)
        if at_edge
          @placeTile x, y, 125
        else if Math.random() < 0.1
          @placeTile x, y, 185

