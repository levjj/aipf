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
      .onHit 'Solid', @stopMovement
      .onHit 'Village', @visitVillage
    @color 'rgb(20,75,40)'

  stopMovement: (collision) ->
    @_speed = 0
    if @_movement
      @x -= @_movement.x
      @y -= @_movement.y

  visitVillage: (collision) ->
    villlage = collision[0].obj
    villlage.collect()

Crafty.c 'Village',
  init: ->
    @requires 'Actor, Color'
    @color 'rgb(170,125,40)'

  collect: ->
    @destroy()
    Crafty.trigger 'VillagesVisited', this
