import Algorithms

func bestCost(with fuelNeededTo: (Int) -> Int) -> Int {
  let (min, max) = input.minAndMax()!

  var bestCost = fuelNeededTo(min)
  for i in min+1...max {
    let cost = fuelNeededTo(i)
    if cost < bestCost {
      bestCost = cost
    }
  }
  return bestCost
}

public func partOne() {
  let cost = bestCost { position in
    input.reduce(0) { result, crabPos in
      result + abs(crabPos - position)
    }
  }
  print(cost) // 352331
}

public func partTwo() {
  let (min, max) = input.minAndMax()!
  let allCosts = (1...max-min).reductions(0) { result, value in  result + value }

  let cost = bestCost { position in
    input.reduce(0) { result, crabPos in
      result + allCosts[abs(crabPos - position)]
    }
  }
  print(cost) // 99266250
}
