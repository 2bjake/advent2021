import Algorithms

public extension Array {
  func countWhereAdjacentPairs(are predicate: (Element, Element) throws -> Bool) rethrows -> Int {
    try self
      .adjacentPairs()
      .reduce(0) { count, pair in
        try predicate(pair.0, pair.1) ? count + 1 : count
      }
  }
}

public extension Array where Element: Comparable {
  func countWhereAdjacentPairsAreIncreasing() -> Int {
    countWhereAdjacentPairs { $0 < $1 }
  }
}
