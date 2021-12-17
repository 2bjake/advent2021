extension Comparable {
  // guaranteed to return only -1, 0, or 1
  public func compare(with other: Self) -> Int {
    self > other ? 1
    : self < other ? -1
    : 0
  }
}
