import Extensions

enum FlashState: Equatable {
  case charging(Int)
  case ready
  case done
}

extension FlashState {
  enum Event { case charge, flash, reset }

  @discardableResult
  mutating func process(_ event: Event) -> (before: Self, after: Self) {
    let original = self
    switch (event, self) {
      case (.charge, .charging(9)):
        self = .ready
      case (.charge, .charging(let energy)):
        self = .charging(energy + 1)
      case (.flash, .ready):
        self = .done
      case (.reset, .done):
        self = .charging(0)
      case (.flash, .charging), (.flash, .done), (.reset, .ready), (.reset, .charging):
        fatalError()
      case (.charge, .ready), (.charge, .done):
        break
    }
    return (original, self)
  }

  mutating func charge() -> Bool {
    let (before, after) = process(.charge)
    return before != .ready && after == .ready
  }

  mutating func flash() { process(.flash) }
  mutating func reset() { process(.reset) }
}

func chargeAll(at positions: [Position]? = nil, in grid: inout [[FlashState]]) -> [Position] {
  var readyPositions = [Position]()
  for pos in positions ?? Array(grid.allPositions) {
    let changed = grid[pos].charge()
    if changed { readyPositions.append(pos) }
  }
  return readyPositions
}

func step(grid: inout [[FlashState]]) -> Int {
  var readyPositions = chargeAll(in: &grid)
  var flashedPositions: Set<Position> = []

  while let pos = readyPositions.popLast() {
    grid[pos].flash()
    flashedPositions.insert(pos)

    let neighborPositions = grid.adjacentPositions(of: pos, includingDiagonals: true)
    readyPositions.append(contentsOf: chargeAll(at: neighborPositions, in: &grid))
  }

  flashedPositions.forEach { grid[$0].reset() }
  return flashedPositions.count
}

public func partOneAndTwo() {
  var grid = input.map { $0.compactMap(Int.init).map(FlashState.charging) }

  var flashCount = 0
  for _ in 0..<100 {
    flashCount += step(grid: &grid)
  }
  print(flashCount) // 1755

  var stepCount = 101
  while step(grid: &grid) != 100 {
    stepCount += 1
  }
  print(stepCount) // 212
}
