import Foundation
import Extensions

extension Position {
  init(_ source: Substring) {
    let parts = source.split(separator: ",")
    self.init(Int(parts[0])!, Int(parts[1])!)
  }
}

struct Fold {
  enum Direction { case left, up }
  let direction: Direction
  let location: Int

  init(_ source: Substring) {
    let parts = source.split(separator: "=")
    self.direction = parts[0].last == "x" ? .left : .up
    self.location = Int(parts[1])!
  }
}

func parse() -> ([[Bool]], [Fold]) {
  let parts = input.components(separatedBy: "\n\n")
  let positions = parts[0].split(separator: "\n").map(Position.init)
  let folds = parts[1].split(separator: "\n").map(Fold.init)

  let rowCount = folds.first { $0.direction == .up }!.location * 2 + 1
  let colCount = folds.first { $0.direction == .left }!.location * 2 + 1

  let grid: [[Bool]] = positions.reduce(into: makeGrid(rowCount: rowCount, colCount: colCount)) { result, pos in
    result[pos] = true
  }



  return (grid, folds)
}

func makeGrid(rowCount: Int, colCount: Int) -> [[Bool]] {
  let row = Array(repeating: false, count: colCount)
  return Array(repeating: row, count: rowCount)
}

func foldPaper(_ paper: [[Bool]], at fold: Fold) -> [[Bool]] {
  if fold.direction == .up {
    return foldPaper(paper, upAt: fold.location)
  } else {
    return foldPaper(paper, leftAt: fold.location)
  }
}

func foldPaper(_ grid: [[Bool]], upAt foldRow: Int) -> [[Bool]] {
  var result = makeGrid(rowCount: foldRow, colCount: grid[0].count)

  let colLastIdx = grid.count - 1

  for y in 0..<foldRow {
    for x in grid[0].indices {
      result[y][x] = grid[y][x] || grid[colLastIdx - y][x]
    }
  }
  return result
}

func foldPaper(_ grid: [[Bool]], leftAt foldCol: Int) -> [[Bool]] {
  var result = makeGrid(rowCount: grid.count, colCount: foldCol)

  let rowLastIdx = grid[0].count - 1

  for y in grid.indices {
    for x in 0..<foldCol {
      result[y][x] = grid[y][x] || grid[y][rowLastIdx - x]
    }
  }
  return result
}


public func partOne() {
  let (paper, folds) = parse()
  let folded = foldPaper(paper, at: folds.first!)
  let dotCount = folded.allPositions.count { folded[$0] }
  print(dotCount) // 675
}

func printRow(_ row: [Bool]) {
  row.forEach { print($0 ? "#" : ".", terminator: "") }
  print()
}

public func partTwo() {
  let (paper, folds) = parse()
  var folded = paper
  for fold in folds {
    folded = foldPaper(folded, at: fold)
  }

  folded.forEach(printRow)
}
