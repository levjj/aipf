window.Game =

  grid:
    width: 24
    height: 16
    tile:
      width: 16
      height: 16

  width: -> @grid.width * @grid.tile.width

  height: -> @grid.height * @grid.tile.height

  initGrid: ->
    @occupied = []
    for x in [0...@grid.width]
      @occupied[x] = []
      for y in [0...@grid.height]
        @occupied[x][y] = false

  initPlayer: ->
    @player = Crafty.e('PlayerCharacter').at 1, 1
    @occupied[1][1] = true

  generateObjects: ->
    for x in [0...@grid.width]
      for y in [0...@grid.height]
        continue if @occupied[x][y]
        at_edge = x is 0 or x is (@grid.width - 1) or
          y is 0 or y is (@grid.height - 1)
        if at_edge
          Crafty.e('Tree').at x, y
          @occupied[x][y] = true
        else if Math.random() < 0.1
          Crafty.e('Bush').at x, y
          @occupied[x][y] = true
        else if Math.random() < 0.02 and Crafty('Village').length < 5
          Crafty.e('Village').at x, y
          @occupied[x][y] = true

  checkVictory: ->
    if Crafty('Village').length is 0
      Crafty.scene 'Victory'

  start: (scene) ->
    @initGrid()
    @initPlayer()
    @generateObjects()
    scene.bind 'VillagesVisited', @checkVictory

  stop: (scene) ->
    scene.unbind 'VillagesVisited', @checkVictory

Crafty.scene 'Game', (-> Game.start this), (-> Game.stop this)
