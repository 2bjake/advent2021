extension Dictionary where Value: Hashable {
  // calling on a dictionary with duplicate value results in a runtime error.
  public func flipWithUniqueValues() -> Dictionary<Value, Key> {
    .init(uniqueKeysWithValues: self.map { ($1, $0) })
  }
}
