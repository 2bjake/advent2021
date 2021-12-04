extension Array where Element: RandomAccessCollection, Element.Index == Int {
  // Transposes the 2D array
  // Example:
  // [
  //   [1, 2, 3],
  //   [4, 5, 6],
  //   [7, 8, 9]
  // ]
  // becomes
  // [
  //   [1, 4, 7],
  //   [2, 5, 8],
  //   [3, 6, 9]
  // ]
  //
  // Note: assumes that inner collections are of the same length
  public func transpose() -> [[Element.Element]] {
    guard let first = first else { return [] }
    return (0..<first.count).map(column)
  }

  // Gets the values at the specified column index.
  // Example: calling column(at: 1) for the given array:
  // [
  //   [1, 2, 3],
  //   [4, 5, 6],
  //   [7, 8, 9]
  // ]
  // would return [2, 5, 8]
  public func column(at idx: Index) -> [Element.Element] {
    (0..<count).map { self[$0][idx] }
  }
}
