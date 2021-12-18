
//func printDeepPairs(in pair: Pair, depth: Int = 1, lastLeftNumber: Number? = nil) -> Number? {
//  var lastLeftNumber = pair.leftNumber
//  if let leftPair = pair.leftPair {
//    let newLastLeft = printDeepPairs(in: leftPair, depth: depth + 1)
//    if newLastLeft != nil { lastLeftNumber = newLastLeft }
//  }
//
//  if depth >= 3 {
//    if let leftPair = pair.leftPair { print("\(lastLeftNumber) \(leftPair)") }
//    if let rightPair = pair.rightPair { print("\(lastLeftNumber) \(rightPair)") }
//  }
//
//  if let rightPair = pair.rightPair {
//    printDeepPairs(in: rightPair, depth: depth + 1, lastLeftNumber: lastLeftNumber)
//  }
//  return lastLeftNumber
//}

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

func printLastLeft(_ pair: Pair, lastLeft: Number?) -> Number? {
  var newLastLeft = printLastLeft(pair.left, lastLeft: lastLeft) ?? lastLeft
  //print("Pair found, last left is: \(lastLeft?.description ?? "none")")

  newLastLeft = printLastLeft(pair.right, lastLeft: newLastLeft) ?? newLastLeft
  return newLastLeft
}

func printLastLeft(_ element: Element, lastLeft: Number?) -> Number? {
  switch element {
    case .pair(let pair):
      return printLastLeft(pair, lastLeft: lastLeft) ?? lastLeft
    case .number(let number):
      print ("lastLeft: \(lastLeft) for number: \(number)")
      return number
  }
}

func printDeepPair(_ pair: Pair, lastLeft: Number?, depth: Int) -> Number? {
  var newLastLeft = lastLeft
  if depth >= 3 && pair.left.pair?.isBase == true {
    print("[\(pair.leftPair!.leftNumber!),\(pair.leftPair!.rightNumber!)] has depth \(depth + 1) with lastLeft \(newLastLeft?.description ?? "none")")
    newLastLeft = pair.leftPair!.rightNumber
  } else {
    newLastLeft = printDeepPair(pair.left, lastLeft: lastLeft, depth: depth + 1) ?? lastLeft
  }

  if depth >= 3 && pair.right.pair?.isBase == true {
    print("[\(pair.rightPair!.leftNumber!),\(pair.rightPair!.rightNumber!)] has depth \(depth + 1) with lastLeft \(newLastLeft?.description ?? "none")")
    newLastLeft = pair.rightPair!.rightNumber
  } else {
    newLastLeft = printDeepPair(pair.right, lastLeft: newLastLeft, depth: depth + 1) ?? newLastLeft
  }
  return newLastLeft
}

func printDeepPair(_ element: Element, lastLeft: Number?, depth: Int) -> Number? {
  switch element {
    case .pair(let pair):
      return printDeepPair(pair, lastLeft: lastLeft, depth: depth) ?? lastLeft
    case .number(let number):
      return number
  }
}

public func partOne() {
  let samples = """
[1,2]
[[1,2],3]
[9,[8,7]]
[[1,9],[8,5]]
[[[[1,2],[3,4]],[[5,6],[7,8]]],9]
[[[9,[3,8]],[[0,9],6]],[[[3,7],[4,9]],3]]
[[[[1,3],[5,3]],[[1,3],[8,7]]],[[[4,9],[6,9]],[[8,2],[7,3]]]]
""".split(separator: "\n").map(Pair.init)

//  for sample in samples {
//    printLastLeft(sample, lastLeft: nil)
//    print()
//  }

  printDeepPair(Pair("[[[[1,2],[3,4]],[[5,6],[7,8]]],9]"), lastLeft: nil, depth: 1)
}

public func partTwo() {

}
