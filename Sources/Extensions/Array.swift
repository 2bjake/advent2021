import Algorithms

extension Array where Element: RandomAccessCollection, Element.Index == Int {
  // assumes that inner collections are of the same length
  public func transpose() -> [[Element.Element]] {
    guard let first = first else { return [] }
    return (0..<first.count).map(column)
  }

  public func column(at idx: Index) -> [Element.Element] {
    (0..<count).map { self[$0][idx] }
  }
}
