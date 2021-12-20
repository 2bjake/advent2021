import Foundation

class Pair: Element {
  var left: Element
  var right: Element

  var leftMostNode: Node { left.leftMostNode }
  var rightMostNode: Node { right.rightMostNode }
  var magnitude: Int { left.magnitude * 3 + right.magnitude * 2}

  init(left: Element, right: Element) {
    let endOfLeft = left.rightMostNode
    let beginningOfRight = right.leftMostNode

    endOfLeft.next = beginningOfRight
    beginningOfRight.previous = endOfLeft
    self.left = left
    self.right = right
  }
}

extension Pair {

}

extension Pair {
  convenience init(_ source: Substring) {
    var source = source
    let pair = Self.build(&source, previousNode: nil)
    self.init(left: pair.left, right: pair.right)
  }

  static func build(_ source: inout Substring, previousNode: Node?) -> Pair {
    guard source.first == "[" else { fatalError() }
    source.removeFirst()
    let left = buildElement(&source, previousNode: previousNode)
    previousNode?.next = left.leftMostNode

    let right = buildElement(&source, previousNode: left.rightMostNode)
    left.rightMostNode.next = right.leftMostNode

    guard source.first == "]" else { fatalError() }
    source.removeFirst()
    return Pair(left: left, right: right)
  }
}

extension Pair {
  func checkForExplosions(depth: Int = 1) -> Bool {
    if let leftPair = left as? Pair {
      if depth == 4 {
        left = leftPair.explode()
        return true
      } else if leftPair.checkForExplosions(depth: depth + 1) {
        return true
      }
    }

    if let rightPair = right as? Pair {
      if depth == 4 {
        right = rightPair.explode()
        return true
      } else if rightPair.checkForExplosions(depth: depth + 1) {
        return true
      }
    }
    return false
  }

  func explode() -> Node {
    guard let leftNode = left as? Node, let rightNode = right as? Node else { fatalError() }
    let zero = Node(value: 0, previous: leftNode.previous, next: rightNode.next)

    if let previous = leftNode.previous {
      previous.value += leftNode.value
      previous.next = zero
    }

    if let next = rightNode.next {
      next.value += rightNode.value
      next.previous = zero
    }
    return zero
  }

  func checkForSplit() -> Bool {
    if let leftNode = left as? Node, leftNode.value >= 10 {
      left = leftNode.split()
      return true
    } else if let leftPair = left as? Pair, leftPair.checkForSplit() {
      return true
    } else if let rightPair = right as? Pair, rightPair.checkForSplit() {
      return true
    } else if let rightNode = right as? Node, rightNode.value >= 10 {
      right = rightNode.split()
      return true
    } else {
      return false
    }
  }

  func reduce() {
    var isReduced = false
    while !isReduced {
      if "\(self)".range(of: "20") != nil {
        print(self)
      }
      let didExplode = checkForExplosions()

      var didSplit = false
      if !didExplode {
        didSplit = checkForSplit()
      }
      isReduced = !didExplode && !didSplit
    }
  }
}

extension Pair: CustomStringConvertible {
  var description: String {
    "[\(left),\(right)]"
  }
}
