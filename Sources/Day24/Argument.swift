enum Argument {
  case variable(Identifier)
  case value(Int)
  case none

  var isValue: Bool {
    if case .value = self { return true }
    return false
  }
}

extension Argument {
  init<S: StringProtocol>(_ source: S) {
    if let id = Identifier(rawValue: source.first!) {
      self = .variable(id)
    } else {
      self = .value(Int(source)!)
    }
  }
}

extension Argument: CustomStringConvertible {
  var description: String {
    switch self {
      case .value(let value): return "\(value)"
      case .variable(let variable): return "\(variable)"
      case .none: return "none"
    }
  }
}
