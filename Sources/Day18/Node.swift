class Node: Element {
  var value: Int
  var previous: Node? = nil
  var next: Node? = nil

  var leftMostNode: Node { self }
  var rightMostNode: Node { self }
  var magnitude: Int { value }

  internal init(value: Int, previous: Node? = nil, next: Node? = nil) {
    self.value = value
    self.previous = previous
    self.next = next
  }
}

extension Node {
  func split() -> Pair {
    let half = Double(value) / 2
    let left = Node(value: Int(half.rounded(.down)), previous: previous)
    let right = Node(value: Int(half.rounded(.up)), previous: left, next: next)
    left.next = right

    previous?.next = left
    next?.previous = right
    return Pair(left: left, right: right)
  }
}

extension Node: CustomStringConvertible {
  var description: String { "\(value)" }
}
