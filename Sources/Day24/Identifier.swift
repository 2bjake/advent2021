enum Identifier: Character, CaseIterable {
  case w = "w"
  case x = "x"
  case y = "y"
  case z = "z"
}

extension Identifier {
  init?<S: StringProtocol>(_ source: S) {
    self.init(rawValue: source.first!)
  }
}
