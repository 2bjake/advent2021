import Algorithms
import Extensions

public func partOne() {
  assert(input.countAdjacentPairsWhereIncreasing() == 1655) // 1655
}

public func partTwo() {
  let count = input
    .windows(ofCount: 3)
    .map { $0.reduce(0, +) }
    .countAdjacentPairsWhereIncreasing()

  assert(count == 1683) // 1683
}

public func partTwoRajatStyle() {
  let count = input
    .windows(ofCount: 3)
    .countAdjacentPairs { $0.first! < $1.last! }
  print(count) // 1683
}
