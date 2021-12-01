import Algorithms

public extension Array {
  func countAdjacentPairs(where predicate: (Element, Element) throws -> Bool) rethrows -> Int {
    try self.adjacentPairs().count(where: predicate)
  }
}

public extension Array where Element: Comparable {
  func countAdjacentPairsWhereIncreasing() -> Int {
    countAdjacentPairs(where: <)
  }
}
