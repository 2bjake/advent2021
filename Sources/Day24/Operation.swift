enum Operation: String {
  case inp
  case add
  case mul
  case div
  case mod
  case eql
}

extension Operation {
  init?<S: StringProtocol>(_ source: S) {
    self.init(rawValue: String(source))
  }
}
