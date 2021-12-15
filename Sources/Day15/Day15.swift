import Extensions
let grid = input.map { $0.compactMap(Int.init) }

func risk(at position: Position) -> Int {
  let (downShift, normalizedRow) = position.row.quotientAndRemainder(dividingBy: grid.numberOfRows)
  let (rightShift, normalizedCol) = position.col.quotientAndRemainder(dividingBy: grid.numberOfColumns)
  let normalizedPos = Position(normalizedRow, normalizedCol)
  let adjustment = rightShift + downShift

  return (grid[normalizedPos] - 1 + adjustment) % 9 + 1
}

func lowestRiskToExit(repeating: Int = 1) -> Int {
  let startPos = grid.firstPosition

  let rowCount = grid.numberOfRows * repeating
  let colCount = grid.numberOfColumns * repeating

  let endPos = Position(rowCount - 1, colCount - 1)

  func adjacentPositions(of pos: Position) -> [Position] {
    pos.adjacentPositions().filter {
      (0..<rowCount).contains($0.row) &&
      (0..<colCount).contains($0.col)
    }
  }

  var queue = PositionRiskQueue()
  queue.insertOrUpdate(position: startPos, withRisk: 0)
  while let currentPos = queue.popLowestRisk(), currentPos != endPos {
    for neighborPos in adjacentPositions(of: currentPos) {
      let newDistance = queue.risk(at: currentPos)! + risk(at: neighborPos)
      if newDistance < (queue.risk(at: neighborPos) ?? .max) {
        queue.insertOrUpdate(position: neighborPos, withRisk: newDistance)
      }
    }
  }
  return queue.risk(at: endPos)!
}

public func partOne() {
  assert(lowestRiskToExit() == 698) // 698
}

public func partTwo() {
  assert(lowestRiskToExit(repeating: 5) == 3022) // 3022
}
