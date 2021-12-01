import Algorithms
import Extensions

public func partOne() {
  print(input.countWhereAdjacentPairsAreIncreasing()) // 1655
}

public func partTwo() {
  let count = input
    .windows(ofCount: 3)
    .map { $0.reduce(0, +) }
    .countWhereAdjacentPairsAreIncreasing()

  print(count) // 1683
}
