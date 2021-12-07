import Algorithms
import Extensions

let positionRange = input.minMaxRange()!

func bestCost(_ costForDistance: @escaping (Int) -> Int) -> Int {
  positionRange.lazy.map { position in
    input.reduce(0) { result, crabPos in
      result + costForDistance(abs(crabPos - position))
    }
  }.min()!
}

public func partOne() { // 352331
  print(bestCost { $0 })
}

public func partTwo() { // 99266250
  let allCosts = (1...positionRange.count).reductions(0, +)
  print(bestCost { allCosts[$0] })
}
