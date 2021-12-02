import Algorithms

extension Sequence {
  public func count(where predicate: (Element) throws -> Bool) rethrows -> Int {
    try self.lazy.filter(predicate).count
  }
}

extension Sequence {
  public func countAdjacentPairs(where predicate: (Element, Element) throws -> Bool) rethrows -> Int {
    try self.adjacentPairs().count(where: predicate)
  }
}

extension Sequence where Element: Comparable {
  public func countAdjacentPairsWhereIncreasing() -> Int {
    countAdjacentPairs(where: <)
  }
}
