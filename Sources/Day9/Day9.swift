import Extensions

func findLowPositions(in grid: [[Int]]) -> [Position] {
  grid.allPositions
    .filter {
      let neighbors = grid.adjacentElements(of: $0)
      let element = grid[$0]
      return neighbors.allSatisfy { $0 > element }
    }
}

public func partOne() {
  let grid = input.map { $0.map { Int.init($0)! } }

  let sum = findLowPositions(in: grid)
    .reduce(0) { result, position in
      return result + 1 + grid[position]
    }
  print(sum) // 631
}

func measureBasin(at position: Position, in grid: [[Int]]) -> Int {
  var basinPositions: Set = [position]
  var frontier = [position]

  while !frontier.isEmpty {
    let currentPosition = frontier.removeLast()
    let currentHeight = grid[currentPosition]
    for neighborPosition in grid.adjacentPositions(of: currentPosition) {
      let neighborHeight = grid[neighborPosition]
      guard !basinPositions.contains(neighborPosition) && neighborHeight != 9 else { continue }
      if neighborHeight > currentHeight {
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
    .lazy
    .map { measureBasin(at: $0, in: grid) }
    .max(count: 3)
    .reduce(1, *)

  print(result) // 821560
}
