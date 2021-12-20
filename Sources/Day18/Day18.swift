func inOrderPrint(_ pair: Pair) {
  inOrderPrint(pair.left)
  inOrderPrint(pair.right)
}

func inOrderPrint(_ element: Element) {
  switch element {
    case .pair(let pair):
      inOrderPrint(pair)
    case .number(let number):
      print(number)
  }
}

//func checkForExplosions(in pair: Pair, depth: Int = 1) {
//  if let left = pair.leftPair {
//    if left.isBase && depth >= 4 {
//      pair.left = .number(explode(left))
//    } else {
//      checkForExplosions(in: left, depth: depth + 1)
//    }
//  }
//
//  if let right = pair.rightPair {
//    if right.isBase && depth >= 4 {
//      pair.right = .number(explode(right))
//    } else {
//      checkForExplosions(in: right, depth: depth + 1)
//    }
//  }
//}

func checkForExplosions(in pair: Pair, depth: Int = 1) -> Bool {
  if let left = pair.leftPair {
    if left.isBase && depth >= 4 {
      pair.left = .number(explode(left))
      return true
    } else if checkForExplosions(in: left, depth: depth + 1) {
      return true
    }
  }

  if let right = pair.rightPair {
    if right.isBase && depth >= 4 {
      pair.right = .number(explode(right))
      return true
    } else if checkForExplosions(in: right, depth: depth + 1) {
      return true
    }
  }

  return false
}

func explode(_ pair: Pair) -> Node {
  guard let left = pair.leftNumber, let right = pair.rightNumber else { fatalError() }

  let zero = Node(value: 0, previous: left.previous, next: right.next)

  if let previous = left.previous {
    previous.value += left.value
    previous.next = zero
  }

  if let next = right.next {
    next.value += right.value
    next.previous = zero
  }

  return zero
}

func checkForSplit(in pair: Pair?) -> Bool {
  guard let pair = pair else { return false }

  if let leftNumber = pair.leftNumber, leftNumber.value >= 10 {
    pair.left = .pair(split(leftNumber))
    return true
  } else if let rightNumber = pair.rightNumber, rightNumber.value >= 10 {
    pair.right = .pair(split(rightNumber))
    return true
  } else if checkForSplit(in: pair.leftPair) {
    return true
  } else {
    return checkForSplit(in: pair.rightPair)
  }
}

func split(_ node: Node) -> Pair {
  let half = Double(node.value) / 2
  let left = Node(value: Int(half.rounded(.down)), previous: node.previous)
  let right = Node(value: Int(half.rounded(.up)), previous: left, next: node.next)
  left.next = right

  node.previous?.next = left
  node.next?.previous = right
  return Pair(left: .number(left), right: .number(right))
}

func reduce(_ pair: Pair) {
  var isReduced = false
  while !isReduced {
    let didExplode = checkForExplosions(in: pair)
    if didExplode {
    print("after explosions: \(pair)")
    } else {
      print("no explosion needed")
    }

    var didSplit = false
    if !didExplode {
      didSplit = checkForSplit(in: pair)
      if didSplit {
        print("after split: \(pair)")
      } else {
        print("no split needed")
      }
    }

    isReduced = !didExplode && !didSplit
  }
}

public func test(pairs: String, expected: String) {
  var pairs = pairs.split(separator: "\n").map(Pair.init)

    let first = pairs.removeFirst()
    let total = pairs.reduce(first) { result, pair in
      let sum = result + pair
      print("after addition: \(sum)")
      reduce(sum)
      print("after reduce: \(sum)")
      return sum
    }
    assert("\(total)" == expected)
}

// issue case
func fails() {
  let pairs = """
[[[[7,0],[7,7]],[[7,7],[7,8]]],[[[7,7],[8,8]],[[7,7],[8,7]]]]
[7,[5,[[3,8],[1,4]]]]
"""

  let expected = "[[[[7,7],[7,8]],[[9,5],[8,7]]],[[[6,8],[0,8]],[[9,9],[9,0]]]]"

  test(pairs: pairs, expected: expected)
}

public func partOne() {
  let pairs = """
[[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]]
[7,[[[3,7],[4,3]],[[6,3],[8,8]]]]
[[2,[[0,8],[3,4]]],[[[6,7],1],[7,[1,6]]]]
[[[[2,4],7],[6,[0,5]]],[[[6,8],[2,8]],[[2,1],[4,5]]]]
[7,[5,[[3,8],[1,4]]]]
[[2,[2,2]],[8,[8,1]]]
[2,9]
[1,[[[9,3],9],[[9,0],[0,7]]]]
[[[5,[7,4]],7],1]
[[[[4,2],2],6],[8,7]]
"""
  let expected = "[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]"
  test(pairs: pairs, expected: expected)
}

//public func partOne() {
//  var samplePairs = """
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
//""".split(separator: "\n").map(Pair.init)
//
//  let first = samplePairs.removeFirst()
//  let total = samplePairs.reduce(first) { result, pair in
//    let sum = result + pair
//    reduce(sum)
//    print(sum)
//    return sum
//  }
//  print(total) // [[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]
//}

//public func partOne() {
//  let pair = Pair("[[[[[4,3],4],4],[7,[[8,4],9]]],[1,1]]")
//
//  var isReduced = false
//
//  while !isReduced {
//    checkForExplosions(in: pair)
//    let didSplit = checkForSplit(in: pair)
//    isReduced = !didSplit
//  }
//  print(pair)
//}

public func partTwo() {

}
