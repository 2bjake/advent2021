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

func makePaper(rows: Int, cols: Int) -> [[Bool]] {
  let row = Array(repeating: false, count: cols)
  return Array(repeating: row, count: rows)
}

func parse() -> ([[Bool]], [Fold]) {
  let parts = input.components(separatedBy: "\n\n")
  let positions = parts[0].split(separator: "\n").map(Position.init)
  let folds = parts[1].split(separator: "\n").map(Fold.init)

  let rowCount = folds.first { $0.direction == .up }!.location * 2 + 1
  let colCount = folds.first { $0.direction == .left }!.location * 2 + 1

  let paper = positions.reduce(into: makePaper(rows: rowCount, cols: colCount)) { result, pos in
    result[pos] = true
  }
  return (paper, folds)
}

func foldPaper(_ paper: [[Bool]], at fold: Fold) -> [[Bool]] {
  if fold.direction == .up {
    return foldPaper(paper, upAt: fold.location)
  } else {
    return foldPaper(paper, leftAt: fold.location)
  }
}

func foldPaper(_ paper: [[Bool]], upAt foldRow: Int) -> [[Bool]] {
  var result = makePaper(rows: foldRow, cols: paper[0].count)
  let colLastIdx = paper.count - 1

  for y in 0..<foldRow {
    for x in paper[0].indices {
      result[y][x] = paper[y][x] || paper[colLastIdx - y][x]
    }
  }
  return result
}

func foldPaper(_ paper: [[Bool]], leftAt foldCol: Int) -> [[Bool]] {
  var result = makePaper(rows: paper.count, cols: foldCol)
  let rowLastIdx = paper[0].count - 1

  for y in paper.indices {
    for x in 0..<foldCol {
      result[y][x] = paper[y][x] || paper[y][rowLastIdx - x]
    }
  }
  return result
}

func makeFoldedPaper(_ foldCount: Int? = nil) -> [[Bool]] {
  let (paper, folds) = parse()

  return folds.prefix(foldCount ?? folds.count).reduce(into: paper) { result, fold in
    result = foldPaper(result, at: fold)
  }
}

public func partOne() {
  let dotCount = makeFoldedPaper(1).joined().count { $0 }
  print(dotCount) // 675
}

public func partTwo() {
  makeFoldedPaper().forEach { row in
    print(row.map { $0 ? "#" : "." }.joined()) // HZKHFEJZ
  }
}
