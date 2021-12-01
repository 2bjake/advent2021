import Algorithms

public extension Array {
  func countAdjacentPairs(where predicate: (Element, Element) throws -> Bool) rethrows -> Int {
    try self
      .adjacentPairs()
      .reduce(0) { count, pair in
        try predicate(pair.0, pair.1) ? count + 1 : count
      }
  }
}

public extension Array where Element: Comparable {
  func countAdjacentPairsWhereIncreasing() -> Int {
    countAdjacentPairs(where: <)
  }
}
