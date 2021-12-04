import Extensions
import Foundation

struct Board {
  private struct Space {
    let value: Int
    var isMarked = false
  }

  private var spaces: [[Space]]
  private var valueToPosition: [Int: Position]

  private(set) var score: Int?
  var hasWon: Bool { score != nil }

  init(_ source: [[Int]]) {
    spaces = source.map { $0.map { Space(value: $0) } }
    valueToPosition = spaces.allPositions.reduce(into: [:]) { result, position in
      let value = source[position]
      result[value] = position
    }
  }

  private func isRowComplete(_ row: Int) -> Bool {
    spaces.positionsInRow(row).allSatisfy { spaces[$0].isMarked }
  }

  private func isColumnComplete(_ col: Int) -> Bool {
    spaces.positionsInColumn(col).allSatisfy { spaces[$0].isMarked }
  }

  private func checkForWin(_ lastMove: Position) -> Int? {
    if isRowComplete(lastMove.row) || isColumnComplete(lastMove.col) {
      return spaces.allPositions
        .lazy
        .map { spaces[$0].isMarked ? 0 : spaces[$0].value }
        .reduce(0, +)
    }
    return nil
  }

  mutating func mark(_ value: Int) {
    guard let position = valueToPosition[value] else { return }
    spaces[position].isMarked = true
    score = checkForWin(position)
  }
}

enum Place { case first, last }

func findScoreForBoardThatWins(_ place: Place) -> Int? {
  var (numbers, boards) = parse()
  let boardCountWhenPlaceWins = place == .first ? boards.count : 1

  var remainingNumbers = ArraySlice(numbers)
  while !remainingNumbers.isEmpty {
    boards = boards.filter { !$0.hasWon }
    let number = remainingNumbers.removeFirst()
    for i in boards.indices {
      boards[i].mark(number)

      if boards.count == boardCountWhenPlaceWins, let score = boards[i].score {
        return score * number
      }
    }
  }
  return nil
}

func parse() -> (numbers: [Int], boards: [Board]) {
  let sections = input.components(separatedBy: "\n\n")
  let numbers = sections[0].split(separator: ",").map { Int($0)! }

  let boards = sections.dropFirst().map { section in
    section.split(separator: "\n").map { line in
      line.split(separator: " ").map { Int($0)! }
    }
  }.map(Board.init)
  return (numbers, boards)
}

public func partOne() {
  print(findScoreForBoardThatWins(.first)!) // 12796
}

public func partTwo() {
  print(findScoreForBoardThatWins(.last)!) // 18063
}
