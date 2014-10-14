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

Crafty.c 'Object',
  init: ->
    @requires '2D, Canvas, Color, Grid'

Crafty.c 'Tree',
  init: ->
    @requires 'Object, Solid'
    @color 'rgb(20,75,40)'

Crafty.c 'Bush',
  init: ->
    @requires 'Object, Solid'
    @color 'rgb(60,135,60)'

Crafty.c 'Village',
  init: ->
    @requires 'Object'
    @color 'rgb(170,125,40)'

  visit: (char) ->
    @destroy()
    Crafty.trigger 'VillagesVisited', this

Crafty.c 'PlayerCharacter',
  init: ->
    @requires 'Object, Fourway, Collision'
      .fourway 2
      .onHit 'Solid', @stopMovement
      .onHit 'AICharacter', @stopMovement
      .onHit 'Village', @visitVillage
    @color 'rgb(205,205,205'

  visitVillage: (collision) ->
    village = collision[0].obj
    village.visit this

  stopMovement: (collision) ->
    @_speed = 0
    if @_movement
      @x -= @_movement.x
      @y -= @_movement.y

Crafty.c 'AICharacter',
  _speed: 1

  init: ->
    @requires 'Object, Collision'
      .onHit 'Village', @visitVillage
    @color 'rgb(255,205,205)'
    @_path = []
    @bind 'EnterFrame', =>
      @aiPlan() if @_path.length is 0
      @aiStep() if @_path.length > 0
    @bind 'VillagesVisited', (village) =>
      @_path = [] if @_goal is village

  aiPlan: ->
    @_goal = Crafty('Village').get 0
    return unless @_goal
    from = x: 0 | (@x / @w), y: 0 | (@y / @h)
    to = x: 0 | (@_goal.x / @w), y: 0 | (@_goal.y / @h)
    @_path = findPath(from, to).map (n) => x: n.x * @w, y: n.y * @h

  aiStep: ->
    if @_path[0].x < @x
      @x -= @_speed
    else if @_path[0].x > @x
      @x += @_speed
    else if @_path[0].y < @y
      @y -= @_speed
    else if @_path[0].y > @y
      @y += @_speed
    else
      @_path.shift()
      @aiStep() if @_path.length > 0

  visitVillage: (collision) ->
    village = collision[0].obj
    village.visit this
