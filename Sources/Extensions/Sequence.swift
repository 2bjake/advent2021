import Algorithms

public extension Sequence {
  func count(where predicate: (Element) throws -> Bool) rethrows -> Int {
    try self.lazy.filter(predicate).count
  }
}

public extension Sequence {
  func countAdjacentPairs(where predicate: (Element, Element) throws -> Bool) rethrows -> Int {
    try self.adjacentPairs().count(where: predicate)
  }
}

public extension Sequence where Element: Comparable {
  func countAdjacentPairsWhereIncreasing() -> Int {
    countAdjacentPairs(where: <)
  }
}
