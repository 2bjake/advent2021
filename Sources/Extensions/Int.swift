extension Int {
  public init?(_ source: Character) {
    self.init(String(source), radix: 10)
  }

  public init?(_ source: Character, radix: Int = 10) {
    self.init(String(source), radix: radix)
  }
}

extension Int {
  public init?(_ source: Substring) {
    self.init(String(source), radix: 10)
  }

  public init?(_ source: Substring, radix: Int = 10) {
    self.init(String(source), radix: radix)
  }
}

extension Int {
  // Increments or decrements toward the specified value.
  // If self == toward, no change is made.
  public mutating func advance(toward: Self) {
    self -= self.compare(with: toward)
  }
}

extension Int {
  public func squareRoot() -> Double {
    Double(self).squareRoot()
  }
}
