import Algorithms

public func countDepthIncreases(in depths: [Int]) -> Int {
  depths
    .adjacentPairs()
    .reduce(0) { count, pair in
      pair.0 < pair.1 ? count + 1 : count
    }
}

public func partOne() {
  print(countDepthIncreases(in: input)) // 1655
}

public func partTwo() {
  let depthSums = input
    .windows(ofCount: 3)
    .map { $0.reduce(0, +) }

  print(countDepthIncreases(in: depthSums)) // 1683
}
