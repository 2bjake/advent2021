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
  public mutating func advance(toward: Self) {
    guard self != toward else { return }
    if self > toward {
      self -= 1
    } else if self < toward {
      self += 1
    }
  }
}
