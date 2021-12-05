import Extensions
import Foundation

extension PositionSequence {
  init<S: StringProtocol>(_ source: S) {
    let nums = source
      .replacingOccurrences(of: " -> ", with: ",")
      .split(separator: ",")
      .compactMap(Int.init)
    self.init(from: Position(nums[0], nums[1]), to: Position(nums[2], nums[3]))
  }
}

func findOverlapCount(for lines: [PositionSequence]) -> Int {
  lines
    .lazy
    .flatMap { $0 }
    .reduce(into: [:]) { dict, pos in dict[pos, default: 0] += 1 }
    .count { _, overlap in overlap > 1 }
}

public func partOne() {
  let lines = input
    .map(PositionSequence.init)
    .filter { $0.orientation != .diagonal }
  print(findOverlapCount(for: lines)) // 7436
}

public func partTwo() {
  let lines = input.map(PositionSequence.init)
  print(findOverlapCount(for: lines)) // 21104
}
