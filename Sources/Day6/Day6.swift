import DequeModule
import Extensions

// fastest solution
func solveWithArrayIndexMath(days: Int) -> Int {
  var startIndex = 0
  var fishCounts = input.reduce(into: Array(repeating: 0, count: 9)) { array, fishTimer in array[fishTimer] += 1 }
  for _ in 0..<days {
    let spawnCount = fishCounts[startIndex]
    startIndex = (1 + startIndex) % 9
    fishCounts[(6 + startIndex) % 9] += spawnCount
  }
  return fishCounts.reduce(0, +)
}

// generic soup to share algo with Array and Deque. 🙃
func solveWithMutation<R: RangeReplaceableCollection & MutableCollection>(days: Int, collectionType _: R.Type) -> Int where R.Element == Int, R.Index == Int {
  var fishCounts = input.reduce(into: R(repeating: 0, count: 9)) { array, fishTimer in array[fishTimer] += 1 }
  for _ in 0..<days {
    let spawnCount = fishCounts.removeFirst()
    fishCounts.append(spawnCount)
    fishCounts[6] += spawnCount
  }
  return fishCounts.reduce(0, +)
}

// second fastest solution
func solveWithArrayMutation(days: Int) -> Int {
  solveWithMutation(days: days, collectionType: Array<Int>.self)
}

func solveWithDequeMutation(days: Int) -> Int {
  solveWithMutation(days: days, collectionType: Deque<Int>.self)
}

func solveWithDictionary(days: Int) -> Int {
  var fishCounts = input.reduce(into: [:]) { dict, fishTimer in dict[fishTimer, default: 0] += 1 }
  for _ in 0..<days {
    for i in 0..<9 {
      fishCounts[i - 1] = fishCounts[i]
    }
    fishCounts[6, default: 0] += fishCounts[-1, default: 0]
    fishCounts[8] = fishCounts[-1]
    fishCounts[-1] = nil
  }
  return fishCounts.values.reduce(0, +)
}

func solveNaïvely(days: Int) -> Int {
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
  return fish.count
}

public func partOne() {
  assert(solveWithArrayIndexMath(days: 80) == 362639) // 362639
}

public func partTwo() {
  assert(solveWithArrayIndexMath(days: 256) == 1639854996917) // 1639854996917
}

public func partOneTimeTests() {
  timeTests(days: 80, times: 1000, runNaïveSolution: true)
}

public func partTwoTimeTests() {
  timeTests(days: 256, times: 1000)
}

func timeTests(days: Int, times: Int, runNaïveSolution: Bool = false) {
  if runNaïveSolution {
    printAvgMillisElapsed("\(days) day naïve", runTimes: times) {
      _ = solveNaïvely(days: days)
    }
  }

  printAvgMillisElapsed("\(days) day dictionary", runTimes: times) {
    _ = solveWithDictionary(days: days)
  }

  printAvgMillisElapsed("\(days) day deque", runTimes: times) {
    _ = solveWithDequeMutation(days: days)
  }

  printAvgMillisElapsed("\(days) day array mutation", runTimes: times) {
    _ = solveWithArrayMutation(days: days)
  }

  printAvgMillisElapsed("\(days) day array index math", runTimes: times) {
    _ = solveWithArrayIndexMath(days: days)
  }
}
