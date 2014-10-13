Crafty.c 'Grid',
  init: ->
    @attr
      w: Game.grid.tile.width
      h: Game.grid.tile.height

  location: ->
    x: @x / @w
    y: @y / @h

  at: (x,y) ->
    @attr
      x: x * @w
      y: y * @h

Crafty.c 'Actor',
  init: ->
    @requires '2D, Canvas, Grid'

Crafty.c 'Tree',
  init: ->
    @requires 'Actor, Color, Solid'
    @color 'rgb(20,125,40)'

Crafty.c 'Bush',
  init: ->
    @requires 'Actor, Color, Solid'
    @color 'rgb(20,185,40)'

Crafty.c 'PlayerCharacter',
  init: ->
    @requires 'Actor, Fourway, Color, Collision'
      .fourway 2
      .stopOnSolids()
    @color 'rgb(20,75,40)'

  stopOnSolids: ->
    @onHit 'Solid', @stopMovement

  stopMovement: (collision) ->
    @_speed = 0
    if @_movement
      @x -= @_movement.x
      @y -= @_movement.y
