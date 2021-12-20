//func checkForExplosions(in pair: Pair, depth: Int = 1) -> Bool {
//  if let left = pair.leftPair {
//    if left.isBase && depth == 4 {
//      print("exploding \(left)")
//      pair.left = .number(explode(left))
//      return true
//    } else if checkForExplosions(in: left, depth: depth + 1) {
//      return true
//    }
//  }
//
//  if let right = pair.rightPair {
//    if right.isBase && depth == 4 {
//      print("exploding \(right)")
//      pair.right = .number(explode(right))
//      return true
//    } else if checkForExplosions(in: right, depth: depth + 1) {
//      return true
//    }
//  }
//
//  return false
//}
//
//func explode(_ pair: Pair) -> Node {
//  guard let left = pair.leftNumber, let right = pair.rightNumber else { fatalError() }
//  print("neighbors before: \(left.previous?.description ?? "n") \(left) \(right) \(right.next?.description ?? "n")")
//
//  let zero = Node(value: 0, previous: left.previous, next: right.next)
//
//  if let previous = left.previous {
//    previous.value += left.value
//    previous.next = zero
//  }
//
//  if let next = right.next {
//    next.value += right.value
//    next.previous = zero
//  }
//
//  print("neighbors after: \(zero.previous?.description ?? "n") \(zero) \(zero.next?.description ?? "n")")
//  return zero
//}
//
//func checkForSplit(in pair: Pair?) -> Bool {
//  guard let pair = pair else { return false }
//
//  if let leftNumber = pair.leftNumber, leftNumber.value >= 10 {
//    pair.left = .pair(split(leftNumber))
//    return true
//  } else if let rightNumber = pair.rightNumber, rightNumber.value >= 10 {
//    pair.right = .pair(split(rightNumber))
//    return true
//  } else if checkForSplit(in: pair.leftPair) {
//    return true
//  } else {
//    return checkForSplit(in: pair.rightPair)
//  }
//}
//
//func split(_ node: Node) -> Pair {
//  print("spliting \(node)")
//  let half = Double(node.value) / 2
//  let left = Node(value: Int(half.rounded(.down)), previous: node.previous)
//  let right = Node(value: Int(half.rounded(.up)), previous: left, next: node.next)
//  left.next = right
//
//  node.previous?.next = left
//  node.next?.previous = right
//  return Pair(left: .number(left), right: .number(right))
//}
//
//func reduce(_ pair: Pair) {
//  var isReduced = false
//  while !isReduced {
//    let didExplode = checkForExplosions(in: pair)
//    if didExplode {
//      nodeCheck(for: pair)
//      print("after explosions: \(pair)")
//    }
//    //    } else {
////      print("no explosion needed")
////    }
//
//    var didSplit = false
//    if !didExplode {
//      didSplit = checkForSplit(in: pair)
//      if didSplit {
//        print("after split: \(pair)")
//        nodeCheck(for: pair)
//        //printNodesForward(pair)
//      }
////      } else {
////        print("no split needed")
////      }
//    }
//
//    isReduced = !didExplode && !didSplit
//  }
//}
//
//func printNodesForward(_ pair: Pair) {
//  var current: Node? = pair.leftMostNumber
//  print("Nodes forward: ", terminator: "")
//  while current != nil {
//    print(current!.value, terminator: " ")
//    current = current?.next
//  }
//  print()
//}
//
//func printNodesBackward(_ pair: Pair) {
//  var current: Node? = pair.rightMostNumber
//  print("Nodes forward: ", terminator: "")
//  while current != nil {
//    print(current!.value, terminator: " ")
//    current = current?.previous
//  }
//  print()
//}
//
//func nodeCheck(for pair: Pair) {
//  let str = Substring("\(pair)")
//  let newPair = Pair(str)
//
//  do {
//    var pairCur: Node? = pair.leftMostNumber
//    var newCur: Node? = newPair.leftMostNumber
//
//    while pairCur != nil && newCur != nil {
//      assert(pairCur!.value == newCur!.value)
//      pairCur = pairCur?.next
//      newCur = newCur?.next
//    }
//    assert(pairCur == nil && newCur == nil)
//  }
//
//  do {
//    var pairCur: Node? = pair.rightMostNumber
//    var newCur: Node? = newPair.rightMostNumber
//
//    while pairCur != nil && newCur != nil {
//      assert(pairCur!.value == newCur!.value)
//      pairCur = pairCur?.previous
//      newCur = newCur?.previous
//    }
//    assert(pairCur == nil && newCur == nil)
//  }
//}
//
//func magnitude(element: Element) -> Int {
//  switch element {
//    case .number(let node): return node.value
//    case .pair(let pair): return magnitude(pair: pair)
//  }
//}
//
//func magnitude(pair: Pair) -> Int {
//  magnitude(element: pair.left) * 3 + magnitude(element: pair.right) * 2
//}
//
//// the problem does not appear to be here, doing a reduce also fails
//public func test(pairs: String, expected: String) {
//  var pairs = pairs.split(separator: "\n").map(Pair.init)
//
//  let first = pairs.removeFirst()
//  let total = pairs.reduce(first) { result, pair in
//    let sum = result + pair
//    //print("after addition: \(sum)")
//    reduce(sum)
//    //print("after reduce: \(sum)")
//    return sum
//  }
//
//  print(total)
//  assert("\(total)" == expected)
//}
//
//func testMagnitude(_ str: String, _ expected: Int) {
//  assert(magnitude(pair: Pair(str[...])) == expected)
//}
//
//func magnitudes() {
//  testMagnitude("[[1,2],[[3,4],5]]", 143)
//  testMagnitude("[[[[0,7],4],[[7,8],[6,0]]],[8,1]]", 1384)
//  testMagnitude("[[[[1,1],[2,2]],[3,3]],[4,4]]", 445)
//  testMagnitude("[[[[3,0],[5,3]],[4,4]],[5,5]]", 791)
//  testMagnitude("[[[[5,0],[7,4]],[5,5]],[6,6]]", 1137)
//  testMagnitude("[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]", 3488)
//}
//
//func passing() {
//  do {
//    let pairs = """
//[1,1]
//[2,2]
//[3,3]
//[4,4]
//"""
//    let expected = "[[[[1,1],[2,2]],[3,3]],[4,4]]"
//    test(pairs: pairs, expected: expected)
//  }
//
//  do {
//    let pairs = """
//[1,1]
//[2,2]
//[3,3]
//[4,4]
//[5,5]
//"""
//    let expected = "[[[[3,0],[5,3]],[4,4]],[5,5]]"
//    test(pairs: pairs, expected: expected)
//  }
//
//  do {
//    let pairs = """
//[1,1]
//[2,2]
//[3,3]
//[4,4]
//[5,5]
//[6,6]
//"""
//    let expected = "[[[[5,0],[7,4]],[5,5]],[6,6]]"
//    test(pairs: pairs, expected: expected)
//  }
//
//  do {
//    let pairs = """
//[[[[4,3],4],4],[7,[[8,4],9]]]
//[1,1]
//"""
//    let expected = "[[[[0,7],4],[[7,8],[6,0]]],[8,1]]"
//    test(pairs: pairs, expected: expected)
//  }
//}
//
//func failing() {
//  let added = Pair("[[[[[7,0],[7,7]],[[7,7],[7,8]]],[[[7,7],[8,8]],[[7,7],[8,7]]]],[7,[5,[[3,8],[1,4]]]]]")
//  reduce(added)
//
//  let expected = "[[[[7,7],[7,8]],[[9,5],[8,7]]],[[[6,8],[0,8]],[[9,9],[9,0]]]]"
//  assert("\(added)" == "\(expected)")
//
//  //test(pairs: pairs, expected: expected)
//}
//
//func largeExample() {
//  let pairs = """
//[[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]]
//[7,[[[3,7],[4,3]],[[6,3],[8,8]]]]
//[[2,[[0,8],[3,4]]],[[[6,7],1],[7,[1,6]]]]
//[[[[2,4],7],[6,[0,5]]],[[[6,8],[2,8]],[[2,1],[4,5]]]]
//[7,[5,[[3,8],[1,4]]]]
//[[2,[2,2]],[8,[8,1]]]
//[2,9]
//[1,[[[9,3],9],[[9,0],[0,7]]]]
//[[[5,[7,4]],7],1]
//[[[[4,2],2],6],[8,7]]
//"""
//  let expected = "[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]"
//  test(pairs: pairs, expected: expected)
//}
//
//func finalExample() {
//  let pairs = """
//[[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]
//[[[5,[2,8]],4],[5,[[9,9],0]]]
//[6,[[[6,2],[5,6]],[[7,6],[4,7]]]]
//[[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]
//[[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]
//[[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]
//[[[[5,4],[7,7]],8],[[8,3],8]]
//[[9,3],[[9,9],[6,[4,9]]]]
//[[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]
//[[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]
//"""
//  let expected = "[[[[6,6],[7,6]],[[7,7],[7,0]]],[[[7,7],[7,7]],[[7,8],[9,9]]]]"
//  test(pairs: pairs, expected: expected)
//}
//
//// issue case
//public func partOne() {
//  //magnitudes()
//  //passing()
//  //failing()
//  finalExample()
//
//
////  var pairs = input.split(separator: "\n").map(Pair.init)
////
////  let first = pairs.removeFirst()
////  let total = pairs.reduce(first) { result, pair in
////    let sum = result + pair
////    reduce(sum)
////    return sum
////  }
////
////  print(magnitude(pair: total))
//}
//
//public func partTwo() {
//
//}
