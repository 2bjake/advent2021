import Algorithms
import Extensions

public func partOne() {
  print(input.countAdjacentPairsWhereIncreasing()) // 1655
}

public func partTwo() {
  let count = input
    .windows(ofCount: 3)
    .map { $0.reduce(0, +) }
    .countAdjacentPairsWhereIncreasing()

  print(count) // 1683
}
