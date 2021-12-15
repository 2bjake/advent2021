import Algorithms
import Extensions
import SwiftPriorityQueue

let riskGrid = input.map { $0.compactMap(Int.init) }

func value(at position: Position) -> Int {
  let (rightShift, normalizedRow) = position.row.quotientAndRemainder(dividingBy: riskGrid[0].count)
  let (downShift, normalizedCol) = position.col.quotientAndRemainder(dividingBy: riskGrid.count)
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

func riskToEnd() -> Int {
  let start = riskGrid.firstPosition
  var distance = [start: 0]

  var queue = PriorityQueue<PositionPriority>(ascending: true)
  queue.push(.init(position: start, cost: 0))


  while let posPriority = queue.pop() {
    let currentPos = posPriority.position
    if currentPos == riskGrid.lastPosition {
      break
    }

    for neighborPos in riskGrid.adjacentPositions(of: currentPos) {
      let temp = distance[currentPos]! + riskGrid[neighborPos]
      if temp < distance[neighborPos, default: .max] {
        if let oldDistance = distance[neighborPos] {
          queue.remove(.init(position: neighborPos, cost: oldDistance))
        }
        distance[neighborPos] = temp
        queue.push(.init(position: neighborPos, cost: distance[neighborPos]!))
      }
    }
  }

  return distance[riskGrid.lastPosition]!
}

func bigAdjacentPositions(of pos: Position) -> [Position] {
  [pos.moved(.up), pos.moved(.down), pos.moved(.left), pos.moved(.right)].filter {
    $0.row <= riskGrid[0].count * 5 - 1 &&
    $0.col <= riskGrid.count * 5 - 1 &&
    $0.row >= 0 &&
    $0.col >= 0
  }
}

func riskToEndBig() -> Int {
  let startPos = riskGrid.firstPosition
  let endPos = Position(riskGrid[0].count * 5 - 1, riskGrid.count * 5 - 1)

  var distance = [startPos: 0]

  var queue = PriorityQueue<PositionPriority>(ascending: true)
  queue.push(.init(position: startPos, cost: 0))


  while let posPriority = queue.pop() {
    let currentPos = posPriority.position
    guard currentPos != endPos else { break }

    for neighborPos in bigAdjacentPositions(of: currentPos) {
      let temp = distance[currentPos]! + value(at: neighborPos)
      if temp < distance[neighborPos, default: .max] {
        if let oldDistance = distance[neighborPos] {
          queue.remove(.init(position: neighborPos, cost: oldDistance))
        }
        distance[neighborPos] = temp
        queue.push(.init(position: neighborPos, cost: distance[neighborPos]!))
      }
    }
  }

  return distance[endPos]!
}

public func partOne() {
  print(riskToEnd()) // 698
}

public func partTwo() {
  print(riskToEndBig()) // 3022
}

