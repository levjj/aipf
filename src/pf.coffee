class NodeTable
  constructor: ->
    @data = []
  get: (pt) ->
    @data[pt.x + pt.y * Game.grid.width]
  set: (pt, val) ->
    @data[pt.x + pt.y * Game.grid.width] = val

distance = (from, to) ->
  if Game.occupied[to.x][to.y] then 999999 else 1

neighbors = (x,y) ->
  result = []
  result.push x: x - 1, y: y unless x is 0
  result.push x: x + 1, y: y unless x is Game.grid.width - 1
  result.push x: x, y: y - 1 unless y is 0
  result.push x: x, y: y + 1 unless y is Game.grid.height - 1
  result

findHeapItem = (heap, pt) ->
  for n in heap.nodes
    return n if n.x is pt.x and n.y is pt.y

updateHeapItem = (heap, pt, score) ->
  item = findHeapItem heap, pt
  if item
    item.score = score
    heap.updateItem item
  else
    item = x: pt.x, y: pt.y, score: score
    heap.push item

heuristic = (from, to) ->
  Math.sqrt ((from.x - to.x) * (from.x - to.x) +
    (from.y - to.y) * (from.y - to.y))

reconstructPath = (cameFrom, current) ->
  if origin = cameFrom.get current
    path = reconstructPath cameFrom, origin
    path.push current
    path
  else
    [current]

AStar = (start, goal) ->
  closed = new NodeTable()
  score = new NodeTable()
  open = new Heap (n) -> n.score
  cameFrom = new NodeTable()

  open.push x: start.x, y: start.y, score: 0
  score.set start, 0

  while current = open.pop()
    if current.x is goal.x and current.y is goal.y
      return reconstructPath cameFrom, goal
    closed.set current, true
    gScore = score.get current
    for neighbor in neighbors current.x, current.y
      continue if closed.get neighbor.x, neighbor.y
      newScore = gScore + distance current, neighbor
      prevScore = score.get neighbor
      if !prevScore? or newScore < prevScore
        cameFrom.set neighbor, current
        score.set neighbor, newScore
        open.remove (n) -> n.x is neighbor.x and n.y is neighbor.y
        open.push
          x: neighbor.x
          y: neighbor.y
          score: newScore + heuristic neighbor, goal

window.findPath = AStar
