extension Int {
  public init?(_ source: Character, radix: Int = 10) {
    self.init(String(source), radix: radix)
  }
}
