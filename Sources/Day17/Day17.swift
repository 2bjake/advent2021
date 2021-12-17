import Extensions

enum ShotResult: Equatable {
  case miss
  case hit(maxHeight: Int)
}

func evaluateShot(xVelocity: Int, yVelocity: Int, xTarget: ClosedRange<Int>, yTarget: ClosedRange<Int>) -> ShotResult {
  var xVelocity = xVelocity
  var yVelocity = yVelocity

  var xPos = 0
  var yPos = 0
  var maxYPos = 0

  while yPos >= yTarget.lowerBound {
    if xTarget.contains(xPos) && yTarget.contains(yPos) {
      return .hit(maxHeight: maxYPos)
    }

    xPos += xVelocity
    yPos += yVelocity
    maxYPos = max(yPos, maxYPos)

    xVelocity -= xVelocity.signum()
    yVelocity -= 1
  }
  return .miss
}

func triangularNumber(for sum: Int) -> Int {
  Int(((8 * sum + 1).squareRoot() - 1) / 2)
}

func findSolutionStats(xTarget: ClosedRange<Int>, yTarget: ClosedRange<Int>) -> (hitCount: Int, maxHeight: Int){
  var maxHeight = 0
  var hitCount = 0

  let minX = triangularNumber(for: xTarget.lowerBound)
  let maxX = xTarget.upperBound

  let minY = yTarget.lowerBound
  let maxY = -yTarget.lowerBound

  for x in minX...maxX {
    for y in minY...maxY {
      let result = evaluateShot(xVelocity: x, yVelocity: y, xTarget: xTarget, yTarget: yTarget)
      if case let .hit(height) = result {
        hitCount += 1
        if height > maxHeight {
          maxHeight = height
        }
      }
    }
  }
  return (hitCount, maxHeight)
}

public func partOneAndTwo() {
  let stats = findSolutionStats(xTarget: 117...164, yTarget: -140 ... -89)
  print("Max height: \(stats.maxHeight)") // 9730
  print("Total hits: \(stats.hitCount)") // 4110
}
