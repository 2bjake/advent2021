import Algorithms

func sum(_ lhs: Pair, _ rhs: Pair) -> Pair {
  let sum = Pair(left: lhs, right: rhs)
  sum.reduce()
  return sum
}

public func partOne() {
  var pairs = input.split(separator: "\n").map(Pair.init)
  let first = pairs.removeFirst()
  let total = pairs.reduce(first, sum)
  print(total.magnitude) // 4033
}


public func partTwo() {
  let largest = input.split(separator: "\n").combinations(ofCount: 2).map {
      max(sum(Pair($0[0]), Pair($0[1])).magnitude, sum(Pair($0[1]), Pair($0[0])).magnitude)
    }.max()!

  print(largest) // 4864
}
