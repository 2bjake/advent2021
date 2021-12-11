import Extensions

enum Original {
  struct Octopus {
    enum State { case charging, ready, done }
    private(set) var state = State.charging
    var energy: Int

    init(energy: Int) {
      self.energy = energy
    }

    // returns true if octopus changed state
    mutating func charge() -> Bool {
      energy += 1
      if energy == 10 {
        state = .ready
        return true
      }
      return false
    }

    mutating func flash() {
      guard state == .ready else { fatalError() }
      state = .done
    }

    // returns true if octopus changed state
    mutating func finalize() -> Bool {
      guard state != .ready else { fatalError() }
      if state == .done {
        energy = 0
        state = .charging
        return true
      }
      return false
    }
  }

  func chargeAll(at positions: [Position], in grid: inout [[Octopus]]) -> [Position] {
    var readyPositions = [Position]()
    for pos in positions {
      if grid[pos].charge() {
        readyPositions.append(pos)
      }
    }
    return readyPositions
  }

  func step(grid: inout [[Octopus]]) -> Int {
    var readyPositions = chargeAll(at: Array(grid.allPositions), in: &grid)

    while !readyPositions.isEmpty {
      let pos = readyPositions.removeLast()
      grid[pos].flash()

      let neighborPositions = grid.adjacentPositions(of: pos, includingDiagonals: true)
      readyPositions.append(contentsOf: chargeAll(at: neighborPositions, in: &grid))
    }

    return grid.allPositions.map { grid[$0].finalize() }.count { $0 }
  }

  public func partOne() {
    var grid = input.map { $0.compactMap(Int.init).map(Octopus.init) }
    var flashCount = 0
    for _ in 0..<100 {
      flashCount += step(grid: &grid)
    }
    print(flashCount) // 1755
  }

  public func partTwo() {
    var grid = input.map { $0.compactMap(Int.init).map(Octopus.init) }
    var stepCount = 1
    while step(grid: &grid) != 100 {
      stepCount += 1
    }
    print(stepCount) // 212
  }
}
