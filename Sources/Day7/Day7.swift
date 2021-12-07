import Algorithms
import Extensions

let (minPos, maxPos) = crabPositions.minAndMax()!

func bestCost(_ costForDistance: (Int) -> Int) -> Int {
  (minPos...maxPos)
    .map { position in
      crabPositions.reduce(0) { result, crabPos in
        result + costForDistance(abs(crabPos - position))
      }
    }.min()!
}

public func partOne() { // 352331
  print(bestCost { $0 })
}

public func partTwo() { // 99266250
  let allCosts = (1...(maxPos - minPos)).reductions(0, +)
  print(bestCost { allCosts[$0] })
}
