protocol Element {
  var leftMostNode: Node { get }
  var rightMostNode: Node { get }
  var magnitude: Int { get }
}

func numberPrefix(_ source: inout Substring) -> Int? {
  let digitPrefix = source.prefix { ("0"..."9").contains($0) }
  guard !digitPrefix.isEmpty else { return nil }
  source = source.dropFirst(digitPrefix.count)
  return Int(digitPrefix)
}

func buildElement(_ source: inout Substring, previousNode: Node?) -> Element {
  if source.first == "," { source.removeFirst() }

  if let number = numberPrefix(&source) {
    let node = Node(value: number, previous: previousNode)
    previousNode?.next = node
    return node
  } else {
    return Pair.build(&source, previousNode: previousNode)
  }
}
