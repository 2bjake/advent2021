class Number: CustomStringConvertible {
  var value: Int

  var description: String { "\(value)"}

  init( _ value: Int) {
    self.value = value
  }
}

indirect enum Element {
  case number(Number)
  case pair(Pair)

  init(_ value: Int) {
    self = .number(Number(value))
  }

  var number: Number? {
    guard case .number(let number) = self else { return nil }
    return number
  }

  var pair: Pair? {
    guard case .pair(let pair) = self else { return nil }
    return pair
  }
}

struct Pair {
  var left: Element
  var right: Element
}



extension Pair {
  static func +(lhs:Pair, rhs: Pair) -> Pair {
    Pair(left: .pair(lhs), right: .pair(rhs))
  }

  var leftPair: Pair? {
    guard case .pair(let pair) = left else { return nil }
    return pair
  }

  var leftNumber: Number? {
    guard case .number(let number) = left else { return nil }
    return number
  }

  var rightPair: Pair? {
    guard case .pair(let pair) = right else { return nil }
    return pair
  }

  var rightNumber: Number? {
    guard case .number(let number) = right else { return nil }
    return number
  }

  var isBase: Bool { leftNumber != nil && rightNumber != nil }
}

//func inOrderKeyPaths(for pair: Pair, path: KeyPath<Pair, Pair>) -> [KeyPath<Pair, Element>] {
//  var result = [KeyPath<Pair, Element>]()
//  if case .pair(let leftPair) = pair.left {
//    result.append(contentsOf: inOrderKeyPaths(for: leftPair, path: path.appending(path: \.leftPair))
//  }
//  return result
//}

func numberPrefix(_ source: inout Substring) -> Int? {
  let digitPrefix = source.prefix { ("0"..."9").contains($0) }
  guard !digitPrefix.isEmpty else { return nil }
  source = source.dropFirst(digitPrefix.count)
  return Int(digitPrefix)
}

extension Element {
  static func build(_ source: inout Substring) -> Element {
    if source.first == "," { source.removeFirst() }

    if let number = numberPrefix(&source) {
      return Element(number)
    } else {
      return .pair(.build(&source))
    }
  }
}

extension Pair {
  init(_ source: Substring) {
    var source = source
    self = .build(&source)
  }

  static func build(_ source: inout Substring) -> Pair {
    guard source.first == "[" else { fatalError() }
    source.removeFirst()
    let left = Element.build(&source)
    let right = Element.build(&source)
    guard source.first == "]" else { fatalError() }
    source.removeFirst()
    return Pair(left: left, right: right)
  }
}

extension Element: CustomStringConvertible {
  var description: String {
    switch self {
      case .number(let number): return "\(number.value)"
      case .pair(let pair): return "\(pair)"
    }
  }
}

extension Pair: CustomStringConvertible {
  var description: String {
    "[\(left),\(right)]"
  }
}
