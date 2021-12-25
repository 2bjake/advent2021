import Algorithms
import Extensions

let grid = input.map { Array($0) }

var eastPositions = Set<Position>()
var southPositions = Set<Position>()

func isEmpty(_ pos: Position) -> Bool {
  !eastPositions.contains(pos) && !southPositions.contains(pos)
}

func move(_ positions: Set<Position>, _ direction: Direction) -> (hasMoved: Bool, newPositions: Set<Position>) {
  var hasMoved = false
  var newPositions = Set<Position>()
  for pos in positions {
    let newPos = grid.wrap(pos.moved(direction))
    if isEmpty(newPos) {
      newPositions.insert(newPos)
      hasMoved = true
    } else {
      newPositions.insert(pos)
    }
  }
  return (hasMoved, newPositions)
}

public func partOne() {
  for pos in grid.allPositions {
    if grid[pos] == "v" {
      southPositions.insert(pos)
    } else if grid[pos] == ">" {
      eastPositions.insert(pos)
    }
  }

  var hasMoved = false
  var stepCount = 0

  repeat {
    stepCount += 1

    let eastResult = move(eastPositions, .right)
    eastPositions = eastResult.newPositions

    let southResult = move(southPositions, .down)
    southPositions = southResult.newPositions

    hasMoved = eastResult.hasMoved || southResult.hasMoved
  } while hasMoved

  print(stepCount) // 389
}

public func partTwo() {

}
