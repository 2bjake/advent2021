import Extensions
import SwiftPriorityQueue

let riskGrid = input.map { $0.compactMap(Int.init) }

func value(at position: Position) -> Int {
  let (downShift, normalizedRow) = position.row.quotientAndRemainder(dividingBy: riskGrid.numberOfRows)
  let (rightShift, normalizedCol) = position.col.quotientAndRemainder(dividingBy: riskGrid.numberOfColumns)
  let normalizedPos = Position(normalizedRow, normalizedCol)
  let adjustment = rightShift + downShift

  return (riskGrid[normalizedPos] - 1 + adjustment) % 9 + 1
}

struct PositionPriority: Comparable {
  let position: Position
  let cost: Int

  static func < (lhs: Self, rhs: Self) -> Bool {
    lhs.cost < rhs.cost
  }
}

func lowestRiskToEnd(repeating: Int = 1) -> Int {
  let startPos = riskGrid.firstPosition

  let rowCount = riskGrid.numberOfRows * repeating
  let colCount = riskGrid.numberOfColumns * repeating

  let endPos = Position(rowCount - 1, colCount - 1)

  func adjacentPositions(of pos: Position) -> [Position] {
    pos.adjacentPositions().filter {
      (0..<rowCount).contains($0.row) &&
      (0..<colCount).contains($0.col)
    }
  }

  var distance = [startPos: 0]

  var queue = PriorityQueue<PositionPriority>(ascending: true)
  queue.push(.init(position: startPos, cost: 0))


  while let posPriority = queue.pop() {
    let currentPos = posPriority.position
    guard currentPos != endPos else { break }

    for neighborPos in adjacentPositions(of: currentPos) {
      let newDistance = distance[currentPos]! + value(at: neighborPos)
      if newDistance < distance[neighborPos, default: .max] {
        if let oldDistance = distance[neighborPos] {
          queue.remove(.init(position: neighborPos, cost: oldDistance))
        }
        distance[neighborPos] = newDistance
        queue.push(.init(position: neighborPos, cost: distance[neighborPos]!))
      }
    }
  }

  return distance[endPos]!
}

public func partOne() {
  assert(lowestRiskToEnd() == 698) // 698
}

public func partTwo() {
  assert(lowestRiskToEnd(repeating: 5) == 3022) // 3022
}
