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

func countOverlaps(in positions: [PositionSequence]) -> Int {
  positions
    .joined()
    .reduce(into: [:]) { dict, pos in dict[pos, default: 0] += 1 }
    .count { _, overlap in overlap > 1 }
}

public func partOne() {
  let positions = input
    .map(PositionSequence.init)
    .filter { $0.orientation != .diagonal }
  assert(countOverlaps(in: positions) == 7436) // 7436
}

public func partTwo() {
  let positions = input.map(PositionSequence.init)
  assert(countOverlaps(in: positions) == 21104) // 21104
}
