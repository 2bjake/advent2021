import Extensions

func findLowPositions(in grid: [[Int]]) -> [Position] {
  grid.allPositions
    .filter {
      let height = grid[$0]
      let neighborHeights = grid.adjacentElements(of: $0)
      return neighborHeights.allSatisfy { $0 > height }
    }
}

public func partOne() {
  let grid = input.map { $0.map { Int.init($0)! } }

  let sum = findLowPositions(in: grid)
    .map { grid[$0] + 1 }
    .reduce(0, +)
  print(sum) // 631
}

func measureBasin(at position: Position, in grid: [[Int]]) -> Int {
  var basinPositions: Set = [position]
  var frontier = [position]

  while !frontier.isEmpty {
    let currentPosition = frontier.removeLast()
    let currentHeight = grid[currentPosition]

    for neighborPosition in grid.adjacentPositions(of: currentPosition) where !neighborPosition.isIn(basinPositions) {
      let neighborHeight = grid[neighborPosition]
      if neighborHeight > currentHeight && neighborHeight < 9 {
        basinPositions.insert(neighborPosition)
        frontier.append(neighborPosition)
      }
    }
  }
  return basinPositions.count
}

public func partTwo() {
  let grid = input.map { $0.map { Int.init($0)! } }
  let result = findLowPositions(in: grid)
    .map { measureBasin(at: $0, in: grid) }
    .max(count: 3)
    .reduce(1, *)

  print(result) // 821560
}
