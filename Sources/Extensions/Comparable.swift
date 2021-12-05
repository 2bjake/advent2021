extension Comparable {
  func compare(with other: Self) -> Int {
    self > other ? 1
    : self < other ? -1
    : 0
  }
}
