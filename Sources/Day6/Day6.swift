import Extensions

func solveFaster(days: Int) {
  var fishCounts = input.reduce(into: Array(repeating: 0, count: 9)) { array, fishTimer in array[fishTimer] += 1 }
  for _ in 0..<days {
    let spawnCount = fishCounts.removeFirst()
    fishCounts.append(spawnCount)
    fishCounts[6] += spawnCount
  }

  let totalFish = fishCounts.reduce(0, +)
  print(totalFish)
}

func solveFast(days: Int) {
  var fishCounts = input.reduce(into: [:]) { dict, fishTimer in dict[fishTimer, default: 0] += 1 }
  for _ in 0..<days {
    for i in 0..<9 {
      fishCounts[i - 1] = fishCounts[i]
    }
    fishCounts[6, default: 0] += fishCounts[-1, default: 0]
    fishCounts[8] = fishCounts[-1]
    fishCounts[-1] = nil
  }

  let totalFish = fishCounts.values.reduce(0, +)
  print(totalFish)
}

func solveSlow(days: Int) {
  var fish = input
  for _ in 0..<days {
    var fishToAdd = 0
    for i in fish.indices {
      fish[i] -= 1
      if fish[i] == -1 {
        fish[i] = 6
        fishToAdd += 1
      }
    }
    fish.append(contentsOf: Array(repeating: 8, count: fishToAdd))
  }
  print(fish.count)
}

public func partOne() { // 362639
  printMillisecondsElapsed {
    solveSlow(days: 80)
  }
  printMillisecondsElapsed {
    solveFast(days: 80)
  }
  printMillisecondsElapsed {
    solveFaster(days: 80)
  }
}

public func partTwo() { // 1639854996917
  printMillisecondsElapsed {
    solveFast(days: 256)
  }
  printMillisecondsElapsed {
    solveFaster(days: 256)
  }
}
