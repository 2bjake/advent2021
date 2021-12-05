import Extensions
import Foundation

struct Line {
  var start: Position
  var end: Position

  enum Orientation { case horizontal, vertical, diagonal }
  var orientation: Orientation {
    start.row == end.row ? .horizontal
    : start.col == end.col ? .vertical
    : .diagonal
  }

  var positions: [Position] {
    var result = [start]
    var prev = start
    while let next = prev.advanced(toward: end)  {
      result.append(next)
      prev = next
    }
    return result
  }
}

extension Line {
  //2,2 -> 2,1
  init<S: StringProtocol>(_ source: S) {
    let nums = source
      .replacingOccurrences(of: " -> ", with: ",")
      .split(separator: ",")
      .compactMap(Int.init)
    self.init(start: Position(nums[0], nums[1]), end: Position(nums[2], nums[3]))
  }
}

func findOverlapCount(for lines: [Line]) -> Int {
  lines
    .lazy
    .flatMap(\.positions)
    .reduce(into: [:]) { dict, pos in dict[pos, default: 0] += 1 }
    .count { _, overlap in overlap > 1 }
}

public func partOne() {
  let lines = input
    .map(Line.init)
    .filter { $0.orientation != .diagonal }
  print(findOverlapCount(for: lines)) // 7436
}

public func partTwo() {
  let lines = input.map(Line.init)
  print(findOverlapCount(for: lines)) // 21104
}
