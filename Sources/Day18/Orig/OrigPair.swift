//
//class Node {
//  var value: Int
//  var previous: Node?
//  var next: Node?
//
//  init(value: Int, previous: Node? = nil, next: Node? = nil) {
//    self.value = value
//    self.previous = previous
//    self.next = next
//  }
//}
//
//indirect enum Element {
//  case number(Node)
//  case pair(Pair)
//
//  var number: Node? {
//    guard case .number(let number) = self else { return nil }
//    return number
//  }
//
//  var pair: Pair? {
//    guard case .pair(let pair) = self else { return nil }
//    return pair
//  }
//
//  var leftMostNumber: Node {
//    switch self {
//      case .number(let node): return node
//      case .pair(let pair): return pair.leftMostNumber
//    }
//  }
//
//  var rightMostNumber: Node {
//    switch self {
//      case .number(let node): return node
//      case .pair(let pair): return pair.rightMostNumber
//    }
//  }
//}
//
//class Pair {
//  var left: Element
//  var right: Element
//
//  // TODO: this doesn't hook up the nodes at all
//  init(left: Element, right: Element) {
//    let endOfLeft = left.rightMostNumber
//    let beginningOfRight = right.leftMostNumber
//
//    endOfLeft.next = beginningOfRight
//    beginningOfRight.previous = endOfLeft
//    self.left = left
//    self.right = right
//  }
//}
//
//extension Pair {
//  static func +(lhs:Pair, rhs: Pair) -> Pair {
//    Pair(left: .pair(lhs), right: .pair(rhs))
//  }
//
//  var leftMostNumber: Node {
//    var currentElement = self.left
//    while case .pair(let pair) = currentElement {
//      currentElement = pair.left
//    }
//    return currentElement.number!
//  }
//
//  var rightMostNumber: Node {
//    var currentElement = self.right
//    while case .pair(let pair) = currentElement {
//      currentElement = pair.right
//    }
//    return currentElement.number!
//  }
//
//  var leftPair: Pair? {
//    guard case .pair(let pair) = left else { return nil }
//    return pair
//  }
//
//  var leftNumber: Node? {
//    guard case .number(let number) = left else { return nil }
//    return number
//  }
//
//  var rightPair: Pair? {
//    guard case .pair(let pair) = right else { return nil }
//    return pair
//  }
//
//  var rightNumber: Node? {
//    guard case .number(let number) = right else { return nil }
//    return number
//  }
//
//  var isBase: Bool { leftNumber != nil && rightNumber != nil }
//}
//
//func numberPrefix(_ source: inout Substring) -> Int? {
//  let digitPrefix = source.prefix { ("0"..."9").contains($0) }
//  guard !digitPrefix.isEmpty else { return nil }
//  source = source.dropFirst(digitPrefix.count)
//  return Int(digitPrefix)
//}
//
//extension Element {
//  static func build(_ source: inout Substring, previousNode: Node?) -> Element {
//    if source.first == "," { source.removeFirst() }
//
//    if let number = numberPrefix(&source) {
//      let node = Node(value: number, previous: previousNode)
//      previousNode?.next = node
//      return .number(node)
//    } else {
//      return .pair(.build(&source, previousNode: previousNode))
//    }
//  }
//}
//
//extension Pair {
//  convenience init(_ source: Substring) {
//    var source = source
//    let pair = Self.build(&source, previousNode: nil)
//    self.init(left: pair.left, right: pair.right)
//  }
//
//  static func build(_ source: inout Substring, previousNode: Node?) -> Pair {
//    guard source.first == "[" else { fatalError() }
//    source.removeFirst()
//    let left = Element.build(&source, previousNode: previousNode)
//    previousNode?.next = left.leftMostNumber
//
//    let right = Element.build(&source, previousNode: left.rightMostNumber)
//    left.rightMostNumber.next = right.leftMostNumber
//
//    guard source.first == "]" else { fatalError() }
//    source.removeFirst()
//    return Pair(left: left, right: right)
//  }
//}
//
//extension Element: CustomStringConvertible {
//  var description: String {
//    switch self {
//      case .number(let number): return "\(number.value)"
//      case .pair(let pair): return "\(pair)"
//    }
//  }
//}
//
//extension Pair: CustomStringConvertible {
//  var description: String {
//    "[\(left),\(right)]"
//  }
//}
//
//extension Node: CustomStringConvertible {
//  var description: String { "\(value)" }
//}
