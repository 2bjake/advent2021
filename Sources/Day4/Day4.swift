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

  private func checkForWin(_ lastMove: Position) -> Int? {
    // TODO: make this sane to read
    let isRowComplete = !spaces.positionsInRow(lastMove.row).contains { !spaces[$0].isMarked }
    let isColComplete = !spaces.positionsInColumn(lastMove.col).contains { !spaces[$0].isMarked }
    if isRowComplete || isColComplete {
      return spaces.allPositions
        .lazy
        .map { spaces[$0].isMarked ? 0 : spaces[$0].value }
        .reduce(0, +)
    } else {
      return nil
    }
  }

  mutating func mark(_ value: Int) {
    guard let position = valueToPosition[value] else { return }
    spaces[position].isMarked = true
    score = checkForWin(position)
  }
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

public func partOne() {
  let winningScore = findScoreForBoardThatWins(.first)
  print(winningScore!) // 12796
}

public func partTwo() {
  let losingScore = findScoreForBoardThatWins(.last)
  print(losingScore!) // 18063
}
