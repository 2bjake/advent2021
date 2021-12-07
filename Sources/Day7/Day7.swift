import Algorithms

let crabPositions = input
let (min, max) = crabPositions.minAndMax()!

func printBestCost(_ costForDistance: (Int) -> Int) {

  func sumCosts(to position: Int) -> Int {
    crabPositions.reduce(0) { result, crabPos in
      result + costForDistance(abs(crabPos - position))
    }
  }

  var lowestCost = sumCosts(to: min)
  for position in (min + 1)...max {
    let cost = sumCosts(to: position)
    if cost < lowestCost {
      lowestCost = cost
    }
  }
  print(lowestCost)
}

public func partOne() { // 352331
  printBestCost { $0 }
}

public func partTwo() { // 99266250
  let allCosts = (1...(max - min)).reductions(0, +)
  printBestCost { allCosts[$0] }
}
