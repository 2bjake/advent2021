func passing() {
  do {
    let pairs = """
[1,1]
[2,2]
[3,3]
[4,4]
"""
    let expected = "[[[[1,1],[2,2]],[3,3]],[4,4]]"
    test(pairs: pairs, expected: expected)
  }

  do {
    let pairs = """
[1,1]
[2,2]
[3,3]
[4,4]
[5,5]
"""
    let expected = "[[[[3,0],[5,3]],[4,4]],[5,5]]"
    test(pairs: pairs, expected: expected)
  }

  do {
    let pairs = """
[1,1]
[2,2]
[3,3]
[4,4]
[5,5]
[6,6]
"""
    let expected = "[[[[5,0],[7,4]],[5,5]],[6,6]]"
    test(pairs: pairs, expected: expected)
  }

  do {
    let pairs = """
[[[[4,3],4],4],[7,[[8,4],9]]]
[1,1]
"""
    let expected = "[[[[0,7],4],[[7,8],[6,0]]],[8,1]]"
    test(pairs: pairs, expected: expected)
  }
}

func failing() {
  let added = Pair("[[[[[7,0],[7,7]],[[7,7],[7,8]]],[[[7,7],[8,8]],[[7,7],[8,7]]]],[7,[5,[[3,8],[1,4]]]]]")
  added.reduce()

  let expected = "[[[[7,7],[7,8]],[[9,5],[8,7]]],[[[6,8],[0,8]],[[9,9],[9,0]]]]"
  print(expected)
  print(added)
  assert("\(added)" == "\(expected)")
}

func test(pairs: String, expected: String) {
  var pairs = pairs.split(separator: "\n").map(Pair.init)

  let first = pairs.removeFirst()
  let total = pairs.reduce(first) { result, pair in
    let sum = Pair(left: result, right: pair)
    sum.reduce()
    return sum
  }

  print(total)
  assert("\(total)" == expected)
}

func largeExample() {
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

func finalExample() {
  let pairs = """
[[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]
[[[5,[2,8]],4],[5,[[9,9],0]]]
[6,[[[6,2],[5,6]],[[7,6],[4,7]]]]
[[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]
[[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]
[[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]
[[[[5,4],[7,7]],8],[[8,3],8]]
[[9,3],[[9,9],[6,[4,9]]]]
[[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]
[[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]
"""
  let expected = "[[[[6,6],[7,6]],[[7,7],[7,0]]],[[[7,7],[7,7]],[[7,8],[9,9]]]]"
  test(pairs: pairs, expected: expected)
}

public func partOne() {
  var pairs = input.split(separator: "\n").map(Pair.init)

  let first = pairs.removeFirst()
  let total = pairs.reduce(first) { result, pair in
    let sum = Pair(left: result, right: pair)
    sum.reduce()
    return sum
  }

  print(total.magnitude)
}


public func partTwo() {

}
