public extension Sequence {
  func count(where predicate: (Element) throws -> Bool) rethrows -> Int {
    try self.lazy.filter(predicate).count
  }
}
