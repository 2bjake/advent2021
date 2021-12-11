import Extensions

enum State {
  case charging(Int)
  case ready
  case done
}

enum Event {
  case charge
  case flash
  case finish
}

extension State {
  @discardableResult
  mutating func process(_ event: Event) -> Bool {
    let original = self
    switch (event, self) {
      case (.charge, .charging(9)):
        self = .ready
      case (.charge, .charging(let energy)):
        self = .charging(energy + 1)
      case (.flash, .ready):
        self = .done
      case (.finish, .done):
        self = .charging(0)
      case (.flash, .charging), (.flash, .done), (.finish, .ready):
        fatalError()
      case (.finish, .charging), (.charge, .ready), (.charge, .done):
        break
    }
    return didChangeState(from: original)
  }

  func didChangeState(from other: Self) -> Bool {
    switch (self, other) {
      case (.charging, .charging), (.ready, .ready), (.done, .done): return false
      default: return true
    }
  }
}

extension State {
  mutating func charge() -> Bool { process(.charge) }
  mutating func flash() { process(.flash) }
  mutating func finish() -> Bool { process(.finish) }
}

func chargeAll(at positions: [Position]? = nil, in grid: inout [[State]]) -> [Position] {
  var readyPositions = [Position]()
  for pos in positions ?? Array(grid.allPositions) {
    let changed = grid[pos].charge()
    if changed { readyPositions.append(pos) }
  }
  return readyPositions
}

func step(grid: inout [[State]]) -> Int {
  var readyPositions = chargeAll(in: &grid)

  while !readyPositions.isEmpty {
    let pos = readyPositions.removeLast()
    grid[pos].flash()

    let neighborPositions = grid.adjacentPositions(of: pos, includingDiagonals: true)
    readyPositions.append(contentsOf: chargeAll(at: neighborPositions, in: &grid))
  }

  var flashCount = 0
  for pos in grid.allPositions {
    let changed = grid[pos].finish()
    flashCount += changed ? 1 : 0
  }
  return flashCount
}

public func partOneAndTwo() {
  var grid = input.map { $0.compactMap(Int.init).map(State.charging) }

  // part one
  var flashCount = 0
  for _ in 0..<100 {
    flashCount += step(grid: &grid)
  }
  print(flashCount) // 1755

  // part two
  var stepCount = 101
  while step(grid: &grid) != 100 {
    stepCount += 1
  }
  print(stepCount) // 212
}
