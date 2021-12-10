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

extension Sequence where Element: Comparable {
  public func minMaxRange() -> ClosedRange<Element>? {
    guard let (min, max) = self.minAndMax() else { return nil }
    return min...max
  }
}

extension Sequence {
  public func compactMap<T>(_ mapping: [Element: T]) -> [T] {
    self.compactMap { mapping[$0] }
  }
}
